<?php
/**
 * Author: Jay Annadurai
 * Date: 19 May 2024
 * File: nav.class.php
 * Project: DriftveilLabs
 * Description: Class to Navigate Directories within a Php Application
 * Requires: Needs to be instantiated within the Config.class.php or before other file inclusions
 */

class Nav {

    // Roots of the Project
    private static string $root_name;
    private static string $root_dir;

    // Associative Array Representation of the Project Directory Structure
    private static array $directory_structure = [];

    // Vectorized Associative Array of Shorthand Paths for Navigation
    private static array $vectorized_directory_structure = [];

    // Array of Dirs to Ignore during a Directory Scan
    private static array $ignore_dirs = ["composer"];

    /**
     * Builds the Navigation Class
     * @param string $root_directory_name Name of the project's root directory
     * @param bool $debug Default: True | Debugs Navigation Directory Information
     * @returns void Initializes Navigation Class
     * @throws Exception on issue
     */
    public static function initialize(string $root_directory_name, bool $debug = True): void
    {
        // Bind the Root Directory Name from the Argument
        // Originally Established in the Configuration File
        self::$root_name = $root_directory_name;

        // Acquire the Path of the Root Directory
        self::$root_dir = self::find_root_directory(self::$root_name);

        // Build the Project Directory Structure
        self::$directory_structure = self::get_directory_structure();

        // Build the Shorthand/Vectorized Directory Structure
        self::$vectorized_directory_structure = self::vectorize_structure(self::$directory_structure,'','/');

        // Debug: Print the Directory Structures
        $debug? self::print_navigation() : null;
    }

    /**
     * Recursively scan the entire root directory and build an associative array representation
     * @param string $dir Directory to Scan
     * @return array Associative array representation of the directory structure
     */
    public static function scan_directory(string $dir, int $depth = 0): array {
        $result = [];

        // Get all items in the directory
        $items = scandir($dir);

        // Iterate through the Items within the Directory
        foreach ($items as $item) {
            // Ignore the special '.' and '..' Hidden Items
            if ($item !== '.' && $item !== '..') {
                // Assemble the Path to the Directory
                $path = $dir . DIRECTORY_SEPARATOR . $item;

                // If the item is an ignored directory, skip it
                if (is_dir($path) && in_array($item, self::$ignore_dirs)){
                    $result[$item] = "Ignored";
                }

                // If the item is a directory, recursively scan it unless it's an ignored directory
                else if (is_dir($path) ) {
                    $result[$item] = self::scan_directory($path,$depth+1);
                }

                // Else if the item is a file, add it to the array
                else {
                    $result[$item] = $path;
                }
            }
        }

        // Return the associative array representation of the directory structure
        return $result;
    }

    /**
     * Recursively vectorize a nested associative array such that
     * d["source"]["application"]["config.class.php"] -> d["source/application/config.class.php"]
     * @param array $nested_array Nested associative array
     * @param string $prefix Current prefix for keys
     * @param string $separator Separator between Items, Default is DIRECTORY_SEPARATOR
     * @return array Flattened associative array
     */
    public static function vectorize_structure(array $nested_array, string $prefix = '',string $separator = DIRECTORY_SEPARATOR): array {
        $result = [];

        // Iterate through the keys
        foreach ($nested_array as $key => $value) {
            // Generate the New Key
            $new_key = $prefix === '' ? $key : $prefix . $separator . $key;

            // Recursively Call the Flatten Function if it is a Directory
            if (is_array($value)) {
                $result = array_merge($result, self::vectorize_structure($value, $new_key, $separator));
            } else {
                $result[$new_key] = $value;
            }
        }

        // Return the Vectorized Array
        return $result;
    }

    /**
     * Find the root directory by navigating up the directory tree.
     * @param string $root_dir_name Name of the root directory to find
     * @return string Path to the root directory
     * @throws Exception if root directory not found
     */
    private static function find_root_directory(string $root_dir_name): string {
        $current_dir = __DIR__;

        // Navigate up the directory tree until the root directory is found
        while (basename($current_dir) !== $root_dir_name) {
            $current_dir = dirname($current_dir);

            // Error Handler - Root Directory not found
            if ($current_dir === '/' || $current_dir === '\\' || $current_dir === '.' || $current_dir === '') {
                throw new Exception("Root directory $root_dir_name not found.");
            }
        }

        // Return the path to the root directory
        return $current_dir;
    }

    /**
     * Get the directory structure.
     * @return array Associative array representation of the directory structure
     */
    public static function get_directory_structure(): array {
        return self::scan_directory(self::$root_dir);
    }

    /**
     * Signature Static Function
     * Allows one file to target another as if calling it from the root directory
     * @param string $path to the Target File from the Root
     * @return string Absolute Path to the Target File
    */
    public static function to(string $path): string
    {
        try {
            if (!in_array($path,array_keys(self::$vectorized_directory_structure))){
                throw new Exception("$path from Root does not lead to an existing file.");
            }
        }

        catch (Exception $e){
            //TODO: Advanced Exception Handling
            echo $e->getMessage();
        }

        // Return the Absolute Path to the Item
        return self::$vectorized_directory_structure[$path];
    }

    /**
     * Debug Only! Prints the navigation structure as a pretty HTML string onto the page
     * @return void Prints the project structure to HTML
     */
    private static function print_navigation(): void
    {
        ?>
        <h1> Directory Structure </h1>
        <hr>
        <h2> Directory Tree Structure </h2>
        <pre> <?= json_encode(self::$directory_structure, JSON_PRETTY_PRINT) ?></pre>
        <hr>
        <h2> Directory Vectorized Structure </h2>
        <pre> <?= json_encode(self::$vectorized_directory_structure, JSON_PRETTY_PRINT) ?></pre>
        <hr>
        <?php
    }
}