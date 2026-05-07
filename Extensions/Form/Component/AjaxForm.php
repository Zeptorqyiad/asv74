<?php

namespace App\Extensions\Form\Component;

use Simflex\Core\ComponentBase;
use Simflex\Core\Core;
use Simflex\Core\Time;

class AjaxForm extends ComponentBase
{
    protected $errors = [];

    protected $formData = [];

    /**
     * Main method to handle form submission and response.
     */
    protected function content()
    {
        // Set the content type to JSON for all responses
        header('Content-Type: application/json; charset=utf-8');

        // Ensure the request method is POST to prevent processing of unintended requests
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            exit(json_encode(['success' => false, 'errors' => ['Invalid request method.']], JSON_THROW_ON_ERROR));
        }

//        if (!ReCaptcha::checkResponse()) {
//            return json_encode(['success' => false, 'errors' => ['captcha' => 'Captcha validation failed']]);
//        }

        // Extract form data from $_POST and populate $formData
        $this->formData = [
            'placement' => $_POST['placement'] ?? '',
            'modalTitle' => $_POST['modal_title'] ?? '',
            'name' => $_POST['name'] ?? '',
            'email' => strtolower($_POST['email'] ?? ''),
            'phone' => $_POST['phone'] ?? '',
            'message' => $_POST['message'] ?? '',
            'fromUrl' => $_POST['from_url'] ?? '',
            'fromTitle' => $_POST['from_title'] ?? '',
            'date' => Time::create()->asMySQL()
        ];

        // Validate required fields
//        if (empty($this->formData['name']) || empty($this->formData['email']) || empty($this->formData['phone'])) {
//            $this->errors[] = 'Name, email, and phone are required.';
//            exit(json_encode(['success' => false, 'errors' => $this->errors], JSON_THROW_ON_ERROR));
//        }

        if (empty($this->formData['phone'])) {
            $this->errors[] = 'Phone are required.';
            exit(json_encode(['success' => false, 'errors' => $this->errors], JSON_THROW_ON_ERROR));
        }

        // Validate email format
//        if (!filter_var($this->formData['email'], FILTER_VALIDATE_EMAIL)) {
//            $this->errors[] = 'Invalid email format.';
//            exit(json_encode(['success' => false, 'errors' => $this->errors], JSON_THROW_ON_ERROR));
//        }

        // Attempt to send email and Telegram message, capturing success status
        $mailSuccess = $this->sendEmail();
        $telegramSuccess = $this->sendTelegramMessage();

        // Return final response with success status and any accumulated errors
        exit(json_encode([
            'success' => $mailSuccess && $telegramSuccess,
            'errors' => $this->errors
        ], JSON_THROW_ON_ERROR));
    }

    /**
     * Sends an email with the form data to the configured recipient.
     * @return bool True if the email was sent successfully, false otherwise.
     */
    protected function sendEmail(): bool
    {
        // Initialize MailAssist with recipient email and subject
        $m = new MailAssist(Core::siteParam('form_email'), 'Новая заявка с сайта');

        // Construct the HTML email body with form data
        $html = <<<HTML
<p><b>Страница: </b> <a href="{$this->formData['fromUrl']}">{$this->formData['fromTitle']}</a></p>
<p></p>
<p><b>Расположение формы: </b> {$this->formData['placement']}</p>
HTML;

        if($this->formData['modalTitle']) {
            $html .= <<<HTML
<p><b>Заголовок попапа: </b> {$this->formData['modalTitle']}</p>
HTML;
        }

        $html .= <<<HTML
<p></p>
<p><b>Имя: </b> {$this->formData['name']}</p>
<p><b>E-mail: </b> {$this->formData['email']}</p>
<p><b>Телефон: </b> {$this->formData['phone']}</p>
<p></p>
<p><b>Сообщение: </b> {$this->formData['message']}</p>
HTML;

        // Set the email content and attempt to send
        $m->content($html);
        if (!$m->send()) {
            $this->errors[] = 'Email sending failed.';
            return false;
        }
        return true;
    }

    /**
     * Sends a Telegram message with the form data to the configured chat.
     * @return bool True if the message was sent successfully, false otherwise.
     */
    protected function sendTelegramMessage(): bool
    {
        // Construct the message with properly escaped special characters
        $md = <<<MD
**НОВАЯ ЗАЯВКА**

**Страница: ** [{$this->escapeMarkdown($this->formData['fromTitle'])}]({$this->escapeMarkdown($this->formData['fromUrl'])})

**Расположение формы: ** {$this->escapeMarkdown($this->formData['placement'])}

MD;

        if($this->formData['modalTitle']) {
            $md .= <<<MD
**Заголовок попапа: ** {$this->escapeMarkdown($this->formData['modalTitle'])}

MD;
        }

        $md .= <<<MD

**Имя: ** {$this->escapeMarkdown($this->formData['name'])}
**E\-mail: ** {$this->escapeMarkdown($this->formData['email'])}
**Телефон: ** {$this->escapeMarkdown($this->formData['phone'])}

**Сообщение: ** {$this->escapeMarkdown($this->formData['message'])}
MD;

        // Initialize cURL for Telegram API request
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, 'https://api.telegram.org/bot' . Core::siteParam('form_tg_token') . '/sendMessage');
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query([
            'chat_id' => Core::siteParam('form_tg_chat_id'),
            'parse_mode' => 'MarkdownV2',
            'text' => $md
        ]));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        // Execute request and check for errors
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $curlError = curl_error($ch);
        curl_close($ch);

        // Handle cURL or HTTP errors
        if ($httpCode != 200 || $response === false) {
            $this->errors[] = 'Telegram sending failed: ' . ($curlError ?: 'HTTP ' . $httpCode);
            return false;
        }

        // Decode Telegram API response and check for success
        $result = json_decode($response, true, 512, JSON_THROW_ON_ERROR);
        if (!$result['ok']) {
            $this->errors[] = 'Telegram API error: ' . ($result['description'] ?? 'Unknown error');
            return false;
        }

        return true;
    }

    /**
     * Escapes special characters in a string for safe use in Telegram MarkdownV2.
     * @param string $text The text to escape.
     * @return string The escaped text.
     */
    protected function escapeMarkdown(string $text): string
    {
        return str_replace(
            ['_', '*', '[', ']', '(', ')', '~', '`', '>', '#', '+', '-', '=', '|', '{', '}', '.', '!'],
            ['\\_', '\\*', '\\[', '\\]', '\\(', '\\)', '\\~', '\\`', '\\>', '\\#', '\\+', '\\-', '\\=', '\\|', '\\{', '\\}', '\\.', '\\!'],
            $text
        );
    }
}