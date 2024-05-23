<?php
if ($_FILES && $_FILES["file"]["error"]== UPLOAD_ERR_OK) {
    $name = $_FILES["file"]["name"];
    move_uploaded_file($_FILES["file"]["tmp_name"], $name);

    $image = imagecreatefrompng($name);

    if (!empty($_POST['rotRight'])) {
        $colorWhite = imageColorAllocate($image, 255, 255, 255);
        $image = imagerotate($image, 90, $colorWhite);
    }
    if (!empty($_POST['rotLeft'])) {
        $colorWhite = imageColorAllocate($image, 255, 255, 255);
        $image = imagerotate($image, -90, $colorWhite);
    }

    if (!empty($_POST['mirHor'])) {
        imageflip($image, IMG_FLIP_HORIZONTAL);
    }
    if (!empty($_POST['mirVer'])) {
        imageflip($image, IMG_FLIP_VERTICAL);
    }

    if (!empty($_POST['inverse'])) {
        imagefilter($image, IMG_FILTER_NEGATE);
    }

    if (!empty($_POST['gray'])) {
        imagefilter($image, IMG_FILTER_GRAYSCALE);
    }
    header('Content-Type: image/png');
    imagepng($image);
    imagedestroy($image);
}

