<?php
/**
 * Author: Jay Annadurai
 * Date: 18 May 2024
 * File: database.class.php
 * Project: DriftveilLabs
 * Description: Connects to the db
 */

class Database {

    // Stores the MySQLi Connection
    private static ?mysqli $connection = null;

    /**
     * Connects the Application to the Database
     * @param array $db_config Associative array containing database configuration parameters.
     * Must be in the form:
     * [
     *   "host"=> "localhost",
     *   "database"=> "db",
     *   "username"=> "user",
     *   "password"=> "pass",
     *   "port"=> 3306,
     * ]
     * @param bool $debug Default: True | Debugs Database Connection Information
     * @return void
     * @throws Exception if connection fails
     */
    public static function connect(array $db_config, bool $debug = True) {

        try {

            // Check for a previous connection to prevent duplicate creation
            if (self::$connection !== null && get_class(self::$connection) === "mysqli") {
                // Throw an Exception as there is a new database connection being formed
                throw new Exception("There is already a database connection! A new one cannot be made.");
            }

            // Validator for Associative Array Inputs
            /**
             * @param array $target_array Array to Validate
             * @param string...$keys Keys to check for within the Array
             * @return bool on conditional success of validation
             * @throws Exception on validation error
             */
            function validate_array_keys($target_array,...$keys): bool
            {
                // Ensure that the Keys Exist in the Array
                foreach ($keys as $key) {
                    if (!array_key_exists($key, $target_array)) {
                        throw new Exception("Missing One or More Required Keys: $key");
                        return false;
                    }
                }

                // Return True if Validation is Successful
                return true;
            }

            // Ensure the Configuration Array has the Correct Keys for Database Settings
            validate_array_keys($db_config,"host","database","username","password","port");


            // Establish the Connection to the Database
            // Suppress any Connection Errors
            self::$connection = new mysqli(
                $db_config['host'],
                $db_config['username'],
                $db_config['password'],
                $db_config['database'],
                $db_config['port']
            );

            // Error Handler - Connection Error
            if (self::$connection->connect_error) {
                throw new Exception("Connection failed: " . self::$connection->connect_error);
            }

        }

        // Catch the Exceptions
        // TODO: Provide more specific Exception Handling
        catch (Exception $e) {
            echo $e->getMessage();
            exit;
        }


        // Debug: Execute a Test Query and Print Results
        if($debug === True) {
            $test_sql = "SELECT * FROM `pokemon`";
            self::print_results(self::q($test_sql),"Test Query");
        }

    }

    /**
     * Query function that executes a query and if enabled returns the results of an executed query as an associative array
     * @param string $query_SQL SQL Query in String form to execute on the Database
     * @param boolean $return_results Default: True | Return Results as an Associative Array
     * @param boolean $empty_OK Default: False | Allow Empty Result Set
     * @return array|void Associative Array or Empty Results
     * @throws Exception if there is an issue with the query or results
     */
    public static function q(string $query_SQL, bool $return_results = true, bool $empty_OK = true): ?array
    {

        // Declare Array to Hold Potential Results
        $results = null;

        // Exception Handling
        try {

            // Ensure there is a Database Connection
            if (self::$connection === null || get_class(self::$connection) !== "mysqli") {
                // Throw an Exception as there is no database connection
                throw new Exception("Database connection has not been established. Use `Database::connect` to connect!");
            }

            echo "<script>";
            echo "console.log(".json_encode($query_SQL).");";
            echo "</script>";


            // Retrieve the $query_SQL argument and execute the query
            $query = self::$connection->query($query_SQL);

            // If the Query fails throw new DatabaseException
            if (!$query) {
                // There was an exception with the Query
                //TODO: Redefine Exception Class and Have the SQL as a Parameter
                throw new Exception("Query failed");

            }

            // If the Return Results Argument is True
            // Execute Code to Return Results
            if ($return_results) {

                // Use MYSQLI_ASSOC to store all fetched rows into $results
                $results = $query->fetch_all(MYSQLI_ASSOC);

                // If the Result Set is completely Empty
                if (!isset($results)) {
                    // TODO: Advanced Exception Handling
                    throw new Exception("Empty Results");
                }

                if (sizeof($results) == 1) {
                    // Return the First Result
                    return $results[0];
                }

                //if the results are false or if the array has no fetched elements
                if (sizeof($results) == 0) {

                    //If it's okay to have an empty results array
                    if ($empty_OK) {
                        //Throw a warning since it's okay but perhaps problematic
                        // TODO: Advanced Exception Handling
                        //throw new Exception("No results found!");
                    }

                    // Else the lack of results wasn't expected
                    else {
                        // TODO: Advanced Exception Handling
                        throw new Exception("No results found!");
                    }

                }

            } //End of if($return_results)

        } //End of try statement

        // Catch Any Exception and Move to Error Page
        catch (Exception $e) {

            echo $e->getMessage();
            exit;

        } //End of Catch Statement

        // Return the fetched results associative array
        if ($return_results) {
            return $results;
        }

        // Otherwise return True to indicate a successful query
        else {
            return true;
        }

        //End Query

    } //end of Query 'q' function

    /**
     * Debug Only! Prints the Results as a pretty HTML string onto the page
     * @param array $results_array Array of Query Results
     * @param string $query_title Title to Display to the Page
     * @return void Prints the Results Array to HTML
     */
    public static function print_results(array $results_array, string $query_title = "Query Results"): void
    {
        ?>
        <h2> <?= $query_title ?></h2>
        <hr>
        <pre> <?= json_encode($results_array, JSON_PRETTY_PRINT) ?></pre>
        <hr>
        <?php
    }
}