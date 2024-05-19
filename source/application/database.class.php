<?php
/**
 * Author: Jay Annadurai
 * Date: 18 May 2024
 * File: database.class.php
 * Project: DriftveilLabs
 * Description: Connects to the db
 */

class Database {

    // Binds a Previous Connection
    private static ?Database $instance = null;
    // Stores the MySQLi Connection
    private mysqli $connection;

    /**
     * Public constructor to singularly establish a database connection
     * @param array $db_config Associative array containing database configuration parameters.
     * Must be in the form:
     * [
     *   "host"=> "localhost",
     *   "database"=> "db",
     *   "username"=> "user",
     *   "password"=> "pass",
     *   "port"=> 3306,
     * ]
     * @throws Exception if connection fails
     */
    public function __construct(array $db_config = []) {

        try {
            // If no configuration information is provided
            if($db_config === []) {
                // Check for a previous Instance Static Variable Exists
                // Instance Data must be of type Database
                if (self::$instance !== null && get_class(self::$instance) === self::class) {
                    // Return Existing Instance Instead
                    return self::$instance;
                } // If the Config Array is Empty without a previous instance, throw an Exception
                else {
                    throw new Exception("Database Configuration not provided! Ensure configuration is correct.");
                }
            }

            // Check for a previous Instance Static Variable to prevent duplicate creation
            if (self::$instance !== null && get_class(self::$instance) === self::class) {
                // Throw an Exception as there is a new database connection being formed
                throw new Exception("There is already a database instance! A new one cannot be made");
            }

            // Establish the Connection to the Database
            // Suppress any Connection Errors
            $this->connection = new mysqli(
                $db_config['host'],
                $db_config['username'],
                $db_config['password'],
                $db_config['database'],
                $db_config['port']
            );

            // Error Handler - Connection Error
            if ($this->connection->connect_error) {
                throw new Exception("Connection failed: " . $this->connection->connect_error);
            }

        }

        // Catch the Exceptions
        // TODO: Provide more specific Exception Handling
        catch (Exception $e) {
            echo $e->getMessage();
            exit;
        }

    }

    /**
     * Query function that executes a query and if enabled returns the results of an executed query as an associative array
     * @param string $query_SQL SQL Query in String form to execute on the Database
     * @param boolean $return_results Default: True | Return Results as an Associative Array
     * @param boolean $empty_OK Default: False | Allow Empty Result Set
     * @return array|void Associative Array or Empty Results
     * @throw DatabaseException if there is an issue with the query or results
     */
    public function q(string $query_SQL, bool $return_results = true, bool $empty_OK = true): ?array
    {
        // Declare Array to Hold Potential Results
        $results = null;

        // Exception Handling
        try {

            // Retrieve the $query_SQL argument and execute the query
            $query = $this->connection->query($query_SQL);

            // If the Query fails throw new DatabaseException
            if (!$query) {

                // There was an exception with the Query             //TODO: Redefine Exception Class and Have the SQL as a Parameter
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
    public function print_results(array $results_array, string $query_title = "Query Results"): void
    {
        ?>
        <h2> <?= $query_title ?></h2>
        <hr>
        <pre> <?= json_encode($results_array, JSON_PRETTY_PRINT) ?></pre>
        <hr>
        <?php
    }
}