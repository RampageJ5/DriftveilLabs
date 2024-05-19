<?php

/*
 * Author: Jay Annadurai
 * Date: 18 May 2024
 * Name: index.php
 * Description: Root Webpage File that Relies on the Dispatcher Class to Redirect to the Appropriate Method
 */

// Require the Config Class
require_once ("source/application/config.class.php");
//Instantiate the Config Class with the Config JSON Directory
//Config will set up project settings such as BASE_URL on instantiation
$c = new Config("config/");



////Execute the Dispatcher's Dispatch Method
////$dispatch = new Dispatcher();
//DispatcherJ::debug();
//DispatcherJ::dispatch();

