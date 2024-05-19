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
    private string $root_name;
    private string $root_dir;

    // Associative Array Representation of the Project Directory Structure
    private static array $directory_structure = [];

    // Associative Array of Shorthand Paths for Navigation
    public static array $to = [];

    // Array of Dirs to Ignore during a Directory Scan
    private static array $ignore_dirs = ["composer"];

    /**
     * Builds the Navigation Class
     * @param string $root_directory_name Name of the project's root directory
     * @throws Exception on issue
     */
    public function __construct(string $root_directory_name) {
        // Bind the Root Directory Name from the Argument
        // Originally Established in the Configuration File
        $this->root_name = $root_directory_name;

        // Acquire the Path of the Root Directory
        $this->root_dir = $this->find_root_directory($this->root_name);

        // Build the Project Directory Structure
        self::$directory_structure = $this->get_directory_structure();

        // Build the Shorthand/Vectorized Directory Structure
        self::$to = self::vectorize_structure(self::$directory_structure,'','/');

        // Debug: Print the Directory Structures
        $this->print_navigation();
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
    private function find_root_directory(string $root_dir_name): string {
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
     * Get the root directory path.
     * @return string Root directory path
     */
    public function get_root_dir_path(): string {
        return $this->root_dir;
    }

    /**
     * Get the directory structure.
     * @return array Associative array representation of the directory structure
     */
    public function get_directory_structure(): array {
        return self::scan_directory($this->root_dir);
    }

    /**
     * Static Function to Retrieve the Directory Tree
     * Unlike get_directory_structure, this does not scan
     * @return array Associative array representation of the directory structure
    */
    public function to(): array
    {
        return self::$directory_structure;
    }

    /**
     * Debug Only! Prints the navigation structure as a pretty HTML string onto the page
     * @return void Prints the project structure to HTML
     */
    private function print_navigation(): void
    {
        ?>
        <h1> Directory Structure </h1>
        <hr>
        <h2> Directory Tree Structure </h2>
        <pre> <?= json_encode(self::$directory_structure, JSON_PRETTY_PRINT) ?></pre>
        <hr>
        <h2> Directory Vectorized Structure </h2>
        <pre> <?= json_encode(self::$to, JSON_PRETTY_PRINT) ?></pre>
        <hr>
        <?php
    }
}