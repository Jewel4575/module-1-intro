// ==========================================================================

// SOC 4650/5650 - LECTURE 01

// ==========================================================================

// standard opening options

version 14
log close _all
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// change directory

if "`c(os)'" == "MacOSX" {
	cd "/Users/`c(username)'/Documents"
}

else if "`c(os)'" == "Windows" {
	cd "C:\Users\`c(username)'\Documents"	
}


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// check to see if appropriate directories exists

capture mkdir "Intro to GISc - Lecture 01"
cd "Intro to GISc - Lecture 01"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// log process

log using lecture01.txt, text replace

// ==========================================================================

/* 
file name - lecture01.do

project name -	SOC 4650/5650
                                                                                 
purpose - lecture 01 replication file
	                                                                               
created - 13 Jan 2016

updated - 13 Jan 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This file replicates *some* of the Stata steps for Lecture 01. Some steps
were illustrated using point-and-click and are therefore not included.
*/

/* 
updates - 
none
*/

// ==========================================================================

// open census data file

sysuse census

// ==========================================================================

// list all variables

describe

// ==========================================================================

// list only some variables

describe state state2 region

// ==========================================================================

// list all observations for certain variables

list state state2

// ==========================================================================

// list only some observations for certain variables

list state state2

// ==========================================================================

// get basic descriptive statistics for a variable

summarize pop

// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit