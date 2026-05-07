<?php

namespace App\Extensions\Icons;

use Simflex\Core\Log;

class Icon
{
    public static function generate(): void
    {
        $svg = '<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">';
        foreach (\App\Extensions\Icons\Models\Icon::all() as $icon) {
            $scanned = sscanf($icon->viewbox, '%d %d %d %d');
            $count = count($scanned);
            if ($count == 4) {
                $viewBox = implode(' ', $scanned);
            } elseif ($count == 2) {
                $viewBox = implode(' ', [0, 0, $scanned[0], $scanned[1]]);
            } elseif ($count == 1) {
                $viewBox = implode(' ', [0, 0, $scanned[0], $scanned[0]]);
            } else {
                Log::warning('Skipped icon {icon} - invalid view box value', ['icon' => $icon->icon]);
                continue;
            }

            $svg .= '<symbol id="' . $icon->icon . '" viewBox="' . $viewBox . '">' . $icon->content . '</symbol>';
        }

        $svg .= '</svg>';
        file_put_contents(SF_ROOT_PATH . '/uf/icons.svg', $svg);
    }

    /**
     * Render icon into HTML
     * @param string $id Icon ID
     * @param string $className Optional class name
     * @return string SVG HTML
     */
    public static function render(string $id, string $className = ''): string
    {
        // generate the file if somehow it is not there yet
        if (!is_file(SF_ROOT_PATH . '/uf/icons.svg')) {
            static::generate();
        }

        return sprintf(
            '<svg class="%s" aria-hidden="true"><use href="/uf/icons.svg#%s"></use></svg>',
            htmlspecialchars($className),
            htmlspecialchars($id)
        );
    }
}