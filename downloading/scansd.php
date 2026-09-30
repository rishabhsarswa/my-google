<?php
function scanAllFiles($dir) {
    // Check if the path is a valid directory
    if (!is_dir($dir)) {
        return;
    }

    // Scan everything inside the directory
    $items = scandir($dir);

    foreach ($items as $item) {
        // Ignore the current (.) and parent (..) directory markers
        if ($item === '.' || $item === '..') {
            continue;
        }

        // Build the full path
        $path = $dir . DIRECTORY_SEPARATOR . $item;

        if (is_dir($path)) {
            // If it's a directory, drill down into it (recursion)
            scanAllFiles($path);
        } else {
            // If it's a file, print its path
            echo $path . PHP_EOL;
        }
    }
}

// Execute the function
$startFolder = './sdcard';
scanAllFiles($startFolder);
