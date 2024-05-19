<?php
/**
 * Author: Jay Annadurai
 * Date: 18 May 2024
 * File: config.class.php
 * Project: DriftveilLabs
 * Description: Imports Project Configuration Information and Sets Appropriate Settings
 */


//Instantiate the Config Class with the Config JSON
//Config will set up project settings such as BASE_URL on instantiation
$c = new Config("../../config/");

//Config Class to Return Root Directory
class Config {

    // Names of Configuration Files
    private static string $shared_config = "config.json";
    private static string $user_config = "user.json";
    // Initialize the Configuration Settings Arrays
    public array $metadata = [];
    private array $settings = [];

    /**
     * Loads a JSON configuration file
     * @param string $path Path to the configuration JSON file
     * @return array Decoded JSON as an associative array
     * @throws Exception on file errors
     */
    private static function load_config(string $path): array {
        // Error Handler - JSON File Path not found
        if (!file_exists($path)) {
            throw new Exception("Configuration JSON file $path not found.");
        }

        // Error Handler - File Path does not Lead to a JSON
        if (pathinfo($path, PATHINFO_EXTENSION) !== 'json') {
            throw new Exception("File $path is not a JSON file.");
        }

        // Import the Config JSON and convert it into an associative array
        $config_json = file_get_contents($path);
        $config_aa = json_decode($config_json, true);
        // Discard the Metadata from the JSON
        $config_aa = $config_aa['data'];

        // Error Handler - Poor JSON
        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new Exception("Error decoding JSON from file $path: " . json_last_error_msg());
        }

        // Return the decoded associative array
        return $config_aa;
    }

    /**
     * Extends values of base array with values of a target array if they have the same keys
     * @param array $base_array Extensible Base Array
     * @param array $target_array Target Array with New Information
     * @param bool $keep_new_pairs Default: False | Keep or Discard New Key-Value pairs of the Target Array
     * @return array $base_array Extended Base Array with all new Key-Value Pairs
     */
    private static function extend_array(array $base_array, array $target_array, bool $keep_new_pairs = false): array {

        // Iterate through Target Array
        foreach ($target_array as $key => $value) {

            // Check if the Target Array Key exists in the Base Array
            if (array_key_exists($key, $base_array)) {

                // If the Value of the Target array and the Value of the Base Array is also an array
                if (is_array($value) && is_array($base_array[$key])) {

                    // Recursively apply the function
                    $base_array[$key] = self::extend_array($base_array[$key], $value, $keep_new_pairs);
                }

                // Otherwise, Write the New Value
                else {
                    $base_array[$key] = $value;
                }

            }

            // If the Keep New Pairs flag is enabled, add the new key-value pairs from the Target Array
            elseif ($keep_new_pairs) {
                $base_array[$key] = $value;
            }
        }

        // Return the Modified Base Array
        return $base_array;
    }

    /**
     * Import the Configuration JSONs to set the Project Settings
     * Note, will merge any and all configuration JSONs to get a master config JSON
     * @param string $path_to_config_dir Path to the Configuration Settings Directory
     * @throws Exception on config file errors
     */
    public function __construct(string $path_to_config_dir) {

        // Temporary Config Data carrier
        $config_data = [];

        // Import the Configs
        foreach ([self::$shared_config,self::$user_config] as $config) {
            // Get the Path to the Config JSON
            $config_path = $path_to_config_dir . $config;
            // Import the File
            $config = self::load_config($config_path);
            // Bind the Settings from the Associative Array
            $config_data = self::extend_array($config_data, $config, true);
        }

        // Bind the Information
        $this->settings = $config_data['config'];
        $this->metadata = $config_data['project'];

        // Debug: Print Settings
        $this->print_settings();

        // Shorthand the Project Settings
        $s = $this->settings;

        // Error Reporting Level: 0 to turn off all error reporting; E_ALL to report all
        error_reporting(constant($s['error_reporting_level']));
        // Set Local Timezone to EDT | UTC -4:00
        date_default_timezone_set($s['timezone']);
        // Define the Project BASE_URL
        define("BASE_URL",$s['base_url']);

        // Require the Autoloader
        //require_once $s['autoloader'];


    }

    /**
     * Debug Only! Prints the configuration settings as a pretty HTML string onto the page
     * @return void Prints the Configuration Settings to HTML
     */
    private function print_settings(): void
    {
        ?>
            <h1> Configuration Settings </h1>
            <hr>
            <h2> Project Metadata </h2>
            <pre> <?= json_encode($this->metadata, JSON_PRETTY_PRINT) ?></pre>
            <hr>
            <h2> Project Configuration </h2>
            <pre> <?= json_encode($this->settings, JSON_PRETTY_PRINT) ?></pre>
            <hr>
        <?php
    }

} //End of Config Class


?>