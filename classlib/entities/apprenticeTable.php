<?php
/**
* This file contains the apprenticeTable Class Template
* 
*/

/**
 * 
 * ProductsTable entity class implements the table entity class for the 'ProductsTable' table in the database. 
 * 
 * 
 * @author Gerry Guinane
 * 
 */

class apprenticeTable extends TableEntity {

    /**
     * Constructor for the ProductsTable Class
     * 
     * @param MySQLi $databaseConnection  The database connection object. 
     */
    function __construct($databaseConnection){
        parent::__construct($databaseConnection,’products');  //the name of the table is passed to the parent constructor
    }
    //END METHOD: Construct
    
}


