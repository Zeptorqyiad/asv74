<?php
/** @var array $data */

$var = $data['values'];
$i = $data['id'];
?>

<div class="table">
    <h4 class="table__title"><?= $data['title'] ?></h4>

    <div class="table__wrap">
        <table class="table__content">
            <tbody class="table__body">
            <?php foreach (array_filter($data['data'], static fn($p) => isset($var[$p->{$i}]) && $var[$p->{$i}] !== '') as $p): ?>
                <tr class="table__row">
                    <th class="table__cell table__cell--header"><?= $p->name ?></th>
                    <td class="table__cell"><?= $var[$p->{$i}] ?></td>
                </tr>
            <?php endforeach; ?>
            </tbody>
        </table>
    </div>
</div>
