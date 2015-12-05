// ==========================================================================

// {insert general title}

// ==========================================================================

// standard opening options

version 14
capture log close
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// change directory

if "`c(os)'" == "MacOSX" {
	cd "/Users/`c(username)'/Documents/Working"
}

else if "`c(os)'" == "Windows" {
	cd "C:\Users\`c(username)'\Documents\Working"	
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// check to see if source data exists

capture confirm file {data file}

if _rc==601 {
	display in red "This do-file requires that the source dataset be saved in your working folder."
	exit
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// check to see if appropriate directories exists

capture mkdir "{primary folder name}"
cd "{primary folder name}"

capture mkdir "Plots"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// log process

log using {filename}.txt, text replace

// ==========================================================================

/* 
file name - 

project name -	
                                                                                 
purpose -
	                                                                               
created - 04 Dec 2015

updated - 04 Dec 2015
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 

*/

/* 
updates - 

*/

// ==========================================================================

/* 
superordinates  - 

*/

/* 
subordinates - 

*/

// ==========================================================================

// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit