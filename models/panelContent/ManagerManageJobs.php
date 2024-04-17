<?php
/**
* This file contains the ManagerManageJobs Class
* 
*/


/**
 * ManagerManageJobs is an extended PanelModel Class
 * 
 * The purpose of this class is to generate HTML view panel headings and template content
 * for an <em><b>ManagerManageJobs</b></em>  page.  The content generated is intended for 3 panel
 * view layouts. 
 * 
 * This class is intended as a TEMPLATE - to be copied and modified to provide
 * specific panel content.  
 *
 * @author gerry.guinane
 * 
 */

class ManagerManageJobs extends PanelModel {
  
    /**
    * Constructor Method
    * 
    * The constructor for the PanelModel class. The ManagerManageJobs class provides the 
    * panel content for up to 3 page panels.
    * 
    * @param User $user  The current user
    * @param MySQLi $db The database connection handle
    * @param Array $postArray Copy of the $_POST array
    * @param String $pageTitle The page Title
    * @param String $pageHead The Page Heading
    * @param String $pageID The currently selected Page ID
    * 
    */  
    function __construct($user,$db,$postArray,$pageTitle,$pageHead,$pageID){  
        $this->modelType='ManagerManageJobs';
        parent::__construct($user,$db,$postArray,$pageTitle,$pageHead,$pageID);
    } 

    
    /**
     * Set the Panel 1 heading 
     */
    public function setPanelHead_1(){
        
        switch ($this->pageID) {
            case "manageJobs":
                $this->panelHead_1='<h3>Manage Jobs</h3>';
                break;
            case "viewJobs":
                $this->panelHead_1='<h3>View Jobs</h3>';
                break;
            case "editJobs": 
	    $this->panelHead_1='<h3>Edit Jobs</h3>';
                break;
            case "addJob": 
	    $this->panelHead_1='<h3>Add job</h3>';
                break;
            default:  //DEFAULT menu item handler
                $this->panelHead_1='<h3>Manage Jobs</h3>';
                break;
            }//end switch   
        
    }
    
    /**
    * Set the Panel 1 text content 
    */ 
    public function setPanelContent_1(){
        
        switch ($this->pageID) {
            case "manageJobs":  // menu item handler
                $this->panelContent_1="Panel 1 content for \$pageID <b>$this->pageID</b> menu item is under construction.";
                break;
            case "viewJobs":  // menu item handler
                $this->panelContent_1="Panel 1 content for \$pageID <b>$this->pageID</b> menu item is under construction.";
                break;
            case "editJobs":  // menu item handler
                $this->panelContent_1="Panel 1 content for \$pageID <b>$this->pageID</b> menu item is under construction.";
                break;
            case "addJobs":  // menu item handler
                $this->panelContent_1="Panel 1 content for \$pageID <b>$this->pageID</b> menu item is under construction.";
                break;
            default:  // DEFAULT menu item handler
                $this->panelContent_1="Panel 1 content for \$pageID <b>DEFAULT</b> menu item is under construction.";
                break;

            }//end switch   
        
    }        

    /**
     * Set the Panel 2 heading 
     */
    public function setPanelHead_2(){ 
               switch ($this->pageID) {
            case "manageJobs":  // menu item handler
                $this->panelHead_2='<h3>Manage Jobs</h3>';
                break;
            case "viewJobs":  // menu item handler
                $this->panelHead_2='<h3>View Jobs</h3>';
                break;
            case "editJobs":  // menu item handler
                $this->panelHead_2='<h3>Edit Jobs</h3>';
                break;
            case "addJobs":  // menu item handler
                $this->panelHead_2='<h3>Add Jobs</h3>';
                break;
            default:  // DEFAULT menu item handler
                $this->panelHead_2='<h3>Manage Jobs</h3>';
                break;

            }//end switch   
    }  
    
    /**
    * Set the Panel 2 text content 
    */ 
    public function setPanelContent_2(){
        switch ($this->pageID) {
            case "manageJobs":  // menu item handler
                $this->panelContent_2="Panel 1 content for \$pageID <b>$this->pageID</b> menu item is under construction.";
                break;
            case "viewJobs":  // menu item handler
                $this->panelContent_2="Panel 1 content for \$pageID <b>$this->pageID</b> menu item is under construction.";
                break;
            case "editJobs":  // menu item handler
                $this->panelContent_2="Panel 1 content for \$pageID <b>$this->pageID</b> menu item is under construction.";
                break;
            case "addJobs":  // menu item handler
                $this->panelContent_2="Panel 1 content for \$pageID <b>$this->pageID</b> menu item is under construction.";
                break;
            default:  // DEFAULT menu item handler
                $this->panelContent_2="Panel 1 content for \$pageID <b>DEFAULT</b> menu item is under construction.";
                break;

            }//end switch   
    }

    /**
     * Set the Panel 3 heading 
     */
    public function setPanelHead_3(){ 
         switch ($this->pageID) {
            case "manageJobs":  // menu item handler
                $this->panelHead_3='<h3>Manage Jobs</h3>';
                break;
            case "viewJobs":  // menu item handler
                $this->panelHead_3='<h3>View Jobs</h3>';
                break;
            case "editJobs":  // menu item handler
                $this->panelHead_3='<h3>Edit Jobs</h3>';
                break;
            case "addJobs":  // menu item handler
                $this->panelHead_3='<h3>Add Jobs</h3>';
                break;
            default:  // DEFAULT menu item handler
                $this->panelHead_3='<h3>Manage Jobs</h3>';
                break;

            }//end switch   
    } 
    
    /**
    * Set the Panel 3 text content 
    */ 
    public function setPanelContent_3(){
        switch ($this->pageID) {
            case "manageJobs":  // menu item handler
                $this->panelContent_3="Panel 1 content for \$pageID <b>$this->pageID</b> menu item is under construction.";
                break;
            case "viewJobs":  // menu item handler
                $this->panelContent_3="Panel 1 content for \$pageID <b>$this->pageID</b> menu item is under construction.";
                break;
            case "editJobs":  // menu item handler
                $this->panelContent_3="Panel 1 content for \$pageID <b>$this->pageID</b> menu item is under construction.";
                break;
            case "addJobs":  // menu item handler
                $this->panelContent_3="Panel 1 content for \$pageID <b>$this->pageID</b> menu item is under construction.";
                break;
            default:  // DEFAULT menu item handler
                $this->panelContent_3="Panel 1 content for \$pageID <b>DEFAULT</b> menu item is under construction.";
                break;

            }//end switch   
    }        

        
        
}
        