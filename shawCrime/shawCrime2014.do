// ==========================================================================

// SOC 4650/5650: WEEK-01 SHAW CRIME EXAMPLE

// ==========================================================================

// define project name

local projName "shawCrime2014"

// ==========================================================================

// standard opening options

log close _all
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// construct directory structure for tabular data
capture mkdir "CodeArchive"
capture mkdir "DataClean"
capture mkdir "DataRaw"
capture mkdir "LogFile"
capture mkdir "Output"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// create permanent text-based log file
log using "LogFile/`projName'.txt", replace text name(permLog)

// create temporary smcl log file for MarkDoc
quietly log using "LogFile/`projName'.smcl", replace smcl name(tempLog)

// ==========================================================================

/***
# Shaw Crime (2014) Data Cleaning
#### SOC 4650/5650: Intro to GIS
#### Christopher Prener, Ph.D.
#### 12 Jan 2017

### Description
This do-file imports and cleans 2014 crime incident data for the Shaw 
Neighborhood in St. Louis, Missouri. These data were originally produced by 
the St. Louis Metropolitan Police Department and are available on 
[their website](http://www.slmpd.org/Crimereports.shtml). They were 
subsequently cleaned and subsetted to cover only Shaw by Chris.  All data 
and code for this example are archived in the Week-01
[repository](https://github.com/slu-soc5650/week-01) on GitHub. Answer blanks 
are created at the end of this file for the lab questions that required
written responses.

## Stata Code

### Dependencies
This do-file was written and executed using Stata 14.2, update 09 Jan 2017.

It also uses the latest [MarkDoc](https://github.com/haghish/markdoc/wiki) 
package via GitHub as well as the latest versions of its dependencies:
***/

version 14
which markdoc
which weave
which statax

/***
### Import Raw Data
The raw data from Chris are .csv formatted:
***/

local rawData "shawCrime2014.csv"
import delimited `rawData', varnames(1)

/***
### Clean `id` Variable
Ensure that the `id` variable uniquely identifies each observation, and 
add an appropriate variable label:
***/

label variable id "study id var"
isid id

/***
### Drop Unneeded Variables
The following variables are not needed for the current analysis and are 
removed from the dataset for simplicity:
***/

drop dateoccurr newcrime unfounded adjustment count district neighborho ///
	cadaddress cadstreet locationna locationco insample _source

/***
### Clean Incident and Report Date/Time Variables
The date and time variables for both the initial incident and when they 
that incident was reported to the SLMPD are renamed with simpler variable 
names and labeled. The month variables are also given value labels.
***/
	
rename yearoccurr inciYear
label variable inciYear "incident year"

rename monthoccur inciMonth
label define month 1 January 2 February 3 March 4 April 5 May 6 June ///
	7 July 8 August 9 September 10 October 11 November 12 December
label values inciMonth month
label variable inciMonth "incident month"

rename dayoccurre inciDay
label variable inciDay "incident date"

rename timeoccurr inciTime
label variable inciTime "incident time"

/***
The report month variable was imported as string data, so it is converted 
to numeric here and given the appropriate value labels.
***/

encode month, generate(rptMonth)
label variable rptMonth "report month"
drop month
order rptMonth, after(inciTime)

rename year rptYear
label variable rptYear "report year"

/***
### Clean Crime Variables
The crime variables are all given simplier names and variable labels. The 
variable representing the type of crime was imported as string data, so 
it is converted to numeric data. The detailed description of each crime 
is kept as string data, since the `ucrCode` variable represents those data 
numerically already.
***/

rename crime ucrCode
label variable ucrCode "ucr code"

encode ucr, generate(crime)
label variable crime "type of crime"
drop ucr
order crime, after(rptYear)

rename descriptio crimeDetail
label variable crimeDetail "description of crime"

/***
### Location Variables
Simplified variable names are applied to the street number and street name 
variables. Labels are added to all four variables as well.
***/

rename ileadsaddr streetNum
label variable streetNum "street/house number"

rename ileadsstre streetName
label variable streetName "street name"

label variable xcoord "utm x coord"
label variable ycoord "utm y coord"

/***
### Save and Export Clean Data
***/

sort id
save "DataClean/`projName'.dta", replace
export delimited "DataClean/`projName'.csv", replace

/***
## Answers
**6.**

**17.**

**16.**

***/

// ==========================================================================

// end MarkDoc log
/*
quietly log close tempLog
*/
// convert MarkDoc log to Markdown
markdoc "LogFile/`projName'", replace export(md)
copy "LogFile/`projName'.md" "Output/`projName'.md", replace
shell rm -R "LogFile/`projName'.md"
shell rm -R "LogFile/`projName'.smcl"

// ==========================================================================

// archive code and raw data
copy "`projName'.do" "CodeArchive/`projName'.do", replace
copy "`rawData'" "DataRaw/`rawData'", replace

// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
