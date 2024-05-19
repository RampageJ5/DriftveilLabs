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

        // Shorthand the Project Settings
        $s = $this->settings;

        // Error Reporting Level: 0 to turn off all error reporting; E_ALL to report all
        error_reporting($s['error_reporting_level']);
        // Set Local Timezone to EDT | UTC -4:00
        date_default_timezone_set($s['timezone']);
        // Define the Project BASE_URL
        define("BASE_URL",$s['base_url']);

        // Require the Autoloader
        require_once $s['autoloader'];
    }

//    /**
//     * @var string BaseURL of the Application, Crucial for Dispatcher
//     */
//    public string $baseURL;
//    public static string $baseURLJay = 'http://localhost/Informatics/Projects/I211/Projects/G2-I211/Final%20Project/Root';
//    public static string $baseURLStandard = 'http://localhost/G2-I211/Final%20Project/Root';
//
//    /** Generate a Config Object that establishes project settings on construction
//     * @param string $baseURL BaseURL of the Application, 'http://localhost/.../Root'
//     * @param int $errorReportingLevel Default is 'E_ALL' | Defines Magnitude of Errors to Report
//     * @param string $timeZone Default is Indy: 'America/Indiana/Indianapolis' | Defines Timezone when Fetching Time and Date
//     * @param string $pathAutoload Path to Composer's Vendor Autoload.php from Root | Autoload.php fetches All Required Classes
//     */
//    public function __construct(string $baseURL, int $errorReportingLevel = E_ALL, string $timeZone = 'America/Indiana/Indianapolis', string $pathAutoload = 'vendor/autoload.php')
//    {
//        //Require Composer's Autoload.php
//        //To Update, Use the Terminal to Navigate to the Project Root Directory and use the 'composer dumpautoload -o' command
//        require_once self::root(true).$pathAutoload;
//
//        //Error Reporting Level: 0 to turn off all error reporting; E_ALL to report all
//        error_reporting($errorReportingLevel);
//        //Set Local Timezone to EDT | UTC -4:00
//        date_default_timezone_set($timeZone);
//        //Define the Project BASE_URL
//        define("BASE_URL",$baseURL);
//        //Bind the BaseURL
//        $this->baseURL = $baseURL;
//    }
//
//    /**
//     * @var array $authors Names of the Authors of the Application
//     */
//    public static array $authors = [
//        'Jay Annadurai',
//        'Jenna Horrall',
//    ];
//
//    /**
//     * @var string $applicationTitle
//     */
//    public static string $applicationTitle = 'Accessible Archive';
//
//    /** Method to Inject
//     * @return void Injects HTML Comments with Appropriate Name
//     */
//    public static function copyright(): void
//    {

//
//    /**
//     * @var int Number of Folders Relative to Root |
//     * I.e: 0 is Root, 1 is Folder Directly in Root
//     */
//    protected static int $levelsBelowRoot = 1;
//
//    /** Method that Returns the Root Directory
//     * @param boolean $enableTrailingSlash Return with Trailing '/'
//     * @return string of Root Directory
//     */
//    public static function root(bool $enableTrailingSlash = false): string
//    {
//        //Levels is relative to where the Config File is Compared to Root
//        //Level of 1 is if Config is Already in the Root Folder
//        $levelsToRoot = self::$levelsBelowRoot+1;
//
//        //Return the $levelsToRoot Directory above the directory of the Config File
//        $dir = dirname(__FILE__,$levelsToRoot);
//
//        //Return With or Without Trailing Slash
//        return $enableTrailingSlash? $dir.'/' : $dir;
//
//    }

}//End of Config Class

//// Debug the Configuration JSON
//echo '<pre>';
//echo json_encode($c, JSON_PRETTY_PRINT);
//echo '</pre>';

?>

