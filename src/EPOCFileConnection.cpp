/*********************************************************************************
 * Copyright (C) 2012	Australian Antarctic Division
 *
 * Authors: Troy Robertson (TR), Andrew Constable (AC)
 * 
 * History
 * 
 * 20120000 TR latest version before multi-authors
 * 20200521 AC corrections to make EPOC work in R4.0
 *
 *
 * EPOCFileConnection.cpp
 * This file forms part of the API library for EPOC and is included in the 
 * EPOC R package along with:
 * EPOC.h
 * EPOC.cpp
 * EPOCFileConnection.cpp
 * EPOCSignature.cpp
 * EPOCObject.cpp
 * EPOCElement.cpp
 * EPOCUniverse.cpp
 * EPOCPeriod.cpp
 * EPOCController.cpp
 *
 * EPOC is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *********************************************************************************/
#include <Rcpp.h> // 20200521 removed comment to activate 'include'
#include <string>
#include <iostream>
#include <fstream>
#include <map>

#ifndef EPOC_hpp    // AC note - guard against redundancy in declarations
#include <EPOC.h>
#endif              // AC note - end of guard

using namespace std;
using namespace Rcpp;

//************* class FileConnection - constructor, destructor, functions *****************

// constructor

FileConnection::FileConnection ( std::string connpath, std::string openmode ) : path(connpath), mode(openmode) {
	if ( path == "" ) return;
	if ( mode.find("r") != string::npos ) {
		iofile.open(path.c_str(), ios::in);
		if (!iofile) std::cerr << "Can't open input file: " << path << endl;
	} else if ( mode.find("w") != string::npos ) {
		iofile.open(path.c_str(), ios::out);
	} else {
		// open in append mode
		mode = "a";
		iofile.open(path.c_str(), ios::out | std::ios::app);
	}
}

// destructor

FileConnection::~FileConnection () {
	if ( iofile.is_open() ) iofile.close();
}

// open

bool FileConnection::open(string connpath, string openmode) {
	if ( connpath == "" ) return false;
	// reopen in new mode if necessary
	if ( (connpath == path && openmode == mode) && iofile.is_open() ) return true; 
	path = connpath;
	mode = openmode;
	close();
	return openconn();
}

// openconn (?? TR did not include as a method)
bool FileConnection::openconn() {
  if ( iofile.is_open() ) return true;
  if ( mode.find("r") != string::npos ) {
    iofile.open(path.c_str(), ios::in);
    if (!iofile) {
      cerr << "Can't open input file: " << path << endl;
      return false;
    }
  } else if ( mode.find("w") != string::npos ) {
    iofile.open(path.c_str(), ios::out);
  } else {
    // open in append mode
    iofile.open(path.c_str(), ios::out | std::ios::app);
  }
  return true;
}


// isopen
bool FileConnection::isopen() { return iofile.is_open(); }

//getpath
const char* FileConnection::getpath() { return path.c_str(); }

//getmode
const char* FileConnection::getmode() { return mode.c_str(); }

//write
bool FileConnection::write(std::string msg, bool eol) {
	// Check mode
	if ( mode.find("w") == string::npos && mode.find("a") == string::npos ) open(path.c_str(), "a");
	if ( openconn() ) {
		iofile << msg;
		if ( eol ) iofile << endl;
		iofile.flush();
		return true;
	}
	return false;
}

//readline
string FileConnection::readline(int linenum) {
	string msg;
	// Check mode and reopen if necessary
	if ( mode.find("r") == string::npos ) open(path.c_str(), "r");
	if ( openconn() ) {
		int lineidx = linenum - 1;
		if ( lineidx >= 0 ) {
			iofile.clear();
			iofile.seekg(ios::beg);
			for ( int i = 0 ; i < lineidx && getline(iofile, msg) ; i++ );
		}
		if ( !iofile.eof() ) getline(iofile, msg);
	}
	return msg;
}

//readfile  (?? TR did not include as a method)
map<int, string> FileConnection::readfile() {
  string line;
  int i = 0;
  map<int, string> msg;
  
  // Check mode and reopen if necessary, reset to start file
  if ( mode.find("r") == string::npos ) open(path.c_str(), "r");
  if ( openconn() ) {
    iofile.clear();
    iofile.seekg(ios::beg);
    while ( getline(iofile, line) ) {
      msg.insert(std::pair<int, string>(i, line));
      i += 1;
      //msg.push_back(line);
    }
  }
  return msg;
}


// close
bool FileConnection::close() {
	if ( iofile.is_open() ) {
		iofile.close();
		// If file was write and is later reopened it will then be in append
		if ( mode.find("w") != string::npos ) mode = "a"; 
		return true;
	}
	return false;
}

//************************** creation of RCPP_MODULE - FileConn_Module

RCPP_MODULE(FileConn_Module) {
	class_<FileConnection>( "FileConnection" )
	.constructor<std::string, std::string>()
	.method( "open", &FileConnection::open )
  .method( "openconn", &FileConnection::openconn )
  .method( "isopen", &FileConnection::isopen )
	.method( "getpath", &FileConnection::getpath )
	.method( "getmode", &FileConnection::getmode )
	.method( "write", &FileConnection::write )
	.method( "readline", &FileConnection::readline )
  .method( "readfile", &FileConnection::readline )
	.method( "close", &FileConnection::close )
	;
}

RcppExport SEXP createRcppFileConn(SEXP connpath, SEXP openmode) {
  BEGIN_RCPP
  if ( toStr(connpath) == "" ) Rf_error("Connection path required.");
  if ( toStr(openmode) == "" ) openmode = Rcpp::wrap("a");
  return Rcpp::XPtr<FileConnection>( new FileConnection(Rcpp::as<std::string>(connpath), 
                                                        Rcpp::as<std::string>(openmode)), true );
  END_RCPP
}
SEXP createRcppFileConn(const char* connpath, const char* openmode) {
  return createRcppFileConn(Rcpp::wrap(connpath), Rcpp::wrap(openmode));
}


RcppExport SEXP openRcppFileConn(SEXP fcObj, SEXP connpath, SEXP openmode) {
BEGIN_RCPP
	Rcpp::XPtr<FileConnection> fc(fcObj);
	if ( toStr(openmode) == "" ) openmode = Rcpp::wrap("a");
	if ( toStr(connpath) == "" ) return Rcpp::wrap(fc->openconn());
	return Rcpp::wrap(fc->open(Rcpp::as<std::string>(connpath), Rcpp::as<std::string>(openmode)));
END_RCPP
}
SEXP openRcppFileConn(SEXP fcObj, const char* connpath, const char* openmode) {
	return openRcppFileConn(fcObj, Rcpp::wrap(connpath), Rcpp::wrap(openmode));
}

RcppExport SEXP openconnRcppFileConn(SEXP fcObj) {
    BEGIN_RCPP
    Rcpp::XPtr<FileConnection> fc(fcObj);
    return Rcpp::wrap(fc->openconn());
    END_RCPP
}
  
RcppExport SEXP isopenRcppFileConn(SEXP fcObj) {
BEGIN_RCPP
	Rcpp::XPtr<FileConnection> fc(fcObj);
	return Rcpp::wrap(fc->isopen());
END_RCPP
}


RcppExport SEXP getpathRcppFileConn(SEXP fcObj) {
BEGIN_RCPP
	Rcpp::XPtr<FileConnection> fc(fcObj);
	return Rcpp::wrap(fc->getpath());
END_RCPP
}


RcppExport SEXP getmodeRcppFileConn(SEXP fcObj) {
BEGIN_RCPP
	Rcpp::XPtr<FileConnection> fc(fcObj);
	return Rcpp::wrap(fc->getmode());
END_RCPP
}


RcppExport SEXP writeRcppFileConn(SEXP fcObj, SEXP msg, SEXP eol) {
BEGIN_RCPP
	if ( eol == NULL || Rf_isNull(eol) ) eol = Rcpp::wrap(true);
	Rcpp::XPtr<FileConnection> fc(fcObj);
	return Rcpp::wrap(fc->write(Rcpp::as<std::string>(msg), Rcpp::as<bool>(eol)));
END_RCPP
}
SEXP writeRcppFileConn(SEXP fcObj, const char* msg, bool eol) {
	return writeRcppFileConn(fcObj, Rcpp::wrap(string(msg)), Rcpp::wrap(eol));
}


RcppExport SEXP readlineRcppFileConn(SEXP fcObj, SEXP linenum) {
BEGIN_RCPP
	if ( linenum == NULL || Rf_isNull(linenum) ) linenum = Rcpp::wrap(0);
	Rcpp::XPtr<FileConnection> fc(fcObj);
	return Rcpp::wrap(fc->readline(Rcpp::as<int>(linenum)));
END_RCPP
}
SEXP readlineRcppFileConn(SEXP fcObj, int linenum) {
	return readlineRcppFileConn(fcObj, Rcpp::wrap(linenum));
}

RcppExport SEXP readRcppFileConn(SEXP fcObj) {
  BEGIN_RCPP
  Rcpp::XPtr<FileConnection> fc(fcObj);
  std::map<int, string> linemap = fc->readfile();
  std::map<int, string>::iterator mapiter;
  Rcpp::List linelist(linemap.size());
  for ( mapiter = linemap.begin() ; mapiter != linemap.end() ; ++mapiter ) {
    linelist[mapiter->first] = mapiter->second;
  }
  return linelist;
  END_RCPP
}


RcppExport SEXP closeRcppFileConn(SEXP fcObj) {
BEGIN_RCPP
	Rcpp::XPtr<FileConnection> fc(fcObj);
	return Rcpp::wrap(fc->close());
END_RCPP
}
