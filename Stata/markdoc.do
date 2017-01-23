// ==========================================================================

// SOC 4650/5650: MARKDOC SET UP

// ==========================================================================

/* DESCRIPTION:
This do-file is a script for installing or updating the packages needed
for MarkDoc to work. It installs three Stata packages: markdoc, weaver, 
and statax. It also installs Pandoc and wkhtmltopdf, third party
software packages that help produce the output that markdoc is capable
of generating. */

// ==========================================================================

/* UPDATES:
23 Jan 2017 - changed lines 76 to 79 from the erase command to the shell
command where the bash code for deleting a file is passed from Stata to
the operating system; erase command causes errors in Windows */

// ==========================================================================

// standard opening options

version 14
log close _all
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// change working directory

if "`c(os)'" == "MacOSX" {
  cd "/Users/`c(username)'/Desktop"
}
else if "`c(os)'" == "Windows" {
  cd "E:/Users/`c(username)'/Desktop"
}

/*
If you are using a Windows computer that is not administered by SLU, you
will need to change the drive letter on line 33 from E:/ to the appropriate
drive letter for your Windows installation. This is typically C:/.
*/

// ==========================================================================

// set successful installation message

local status "MarkDoc has been successfully updated on this computer"

// ==========================================================================

// check for packages and either update or install from github

net install markdoc, replace ///
	from("https://raw.githubusercontent.com/haghish/markdoc/master/")

net install weaver, replace ///
	from("https://raw.githubusercontent.com/haghish/weaver/master/")	
	
net install statax, replace ///
	from("https://raw.githubusercontent.com/haghish/statax/master/")
	
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// create test output

markdoc, test install

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// delete test output

shell rm -R example.html
shell rm -R example.pdf
shell rm -R example.smcl
shell rm -R graph.png

// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

display as result _newline "`status'"
