<?php
/** @var array $data */

$dualRangeClasses = [
    'dual-range',
    $data['className'] ?? ''
];
?>

<div class="<?= implode(' ', $dualRangeClasses) ?>" <?= buildAttrs($data['attributes'] ?? []) ?>>
    <div class="dual-range__input-group">
        <div class="dual-range__input-wrapper">
            <?php App\Layout\Components\UI\Core\TextInput\Layout::drawInput(
                className: 'range-slider__input js--min-input',
                labelText: 'От',
                labelPos: \App\Layout\Components\UI\Core\TextInput\TextInputLabelPos::Standard,
                size: \App\Layout\Components\UI\Core\TextInput\TextInputSize::Small,
                reset: false,
                id: 'min-input',
                attributes: [
                    'type' => 'number',
                    'placeholder' => $data['min'] ?? '',
                    'min' => $data['min'] ?? '',
                    'max' => $data['max'] ?? '',
                    'name' => $data['nameMin'] ?? '',
                ] + ($data['minNow'] != null ? ['value' => $data['minNow']] : []),
            ); ?>
        </div>
        <div class="dual-range__input-wrapper">
            <?php App\Layout\Components\UI\Core\TextInput\Layout::drawInput(
                className: 'range-slider__input js--max-input',
                labelText: 'До',
                labelPos: \App\Layout\Components\UI\Core\TextInput\TextInputLabelPos::Standard,
                size: \App\Layout\Components\UI\Core\TextInput\TextInputSize::Small,
                reset: false,
                id: 'max-input',
                attributes: [
                    'type' => 'number',
                    'placeholder' => $data['max'] ?? '',
                    'min' => $data['min'] ?? '',
                    'max' => $data['max'] ?? '',
                    'name' => $data['nameMax'] ?? '',
                ] + ($data['maxNow'] != null ? ['value' => $data['maxNow']] : []),
            ); ?>
        </div>
    </div>

    <div class="dual-range__range-slider">
        <div class="dual-range__slider-track"></div>

        <div class="dual-range__slider-handle min-handle"
             role="slider"
             aria-label="Minimum value"
             aria-valuemin="<?= $data['min'] ?? '' ?>"
             aria-valuemax="<?= $data['max'] ?? '' ?>"
             aria-valuenow="<?= $data['minNow'] ?? '' ?>"
             tabindex="0">
        </div>
        <div class="dual-range__slider-handle max-handle"
             role="slider"
             aria-label="Maximum value"
             aria-valuemin="<?= $data['min'] ?? '' ?>"
             aria-valuemax="<?= $data['max'] ?? '' ?>"
             aria-valuenow="<?= $data['maxNow'] ?? '' ?>"
             tabindex="0">
        </div>
    </div>
</div>