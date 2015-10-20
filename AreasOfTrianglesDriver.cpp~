//Author information
//  Author name: Art Grichine
//  Author email: ArtGrichine@gmail.com
//Course information
//  Course number: CPSC240
//  Assignment number: 2
//  Due date: 2014-Feb-11
//Project information
//  Project title: Vector Processing / Area of Triangles (Assignment 2)
//  Purpose: Preform vector processing on four different triangles at once. User input sides of triangles; Output triangle area
//  Status: No known errors
//  Project files: arprocdriver.cpp, arprocmain.asm, debug.inc, debug.asm
//Module information
//  This module's call name: AreasOfTriangles.  This module is invoked by the user.
//  Language: C++
//  Date last modified: 2014-Feb-06
//  Purpose: This module is the top level driver: it will call AreasOfTriangles()
//  File name: AreasOfTrianglesDriver.cpp
//  Status: In production.  No known errors.
//  Future enhancements: None planned
//Translator information (Tested in Linux (Ubuntu) shell)
//  Gnu compiler: g++ -c -m64 -Wall -l AreasOfTrianglesDriver.lis -o AreasOfTrianglesDriver.o AreasOfTrianglesDriver.cpp
//  Gnu linker:   g++ -m64 -o test.out AreasOfTrianglesDriver.o AreasOfTriangles.o debug.o
//  Execute:      ./test.out
//References and credits
//  References: Professor Holliday/CSUF
//  Module: this module is standard C++ language
//Format information
//  Page width: 132 columns
//  Begin comments: N/A
//  Optimal print specification: Landscape, 8 points or smaller, monospace, 81⁄2x11 paper
//
//===== Begin code area ===========================================================================================================
//
#include <stdio.h>
#include <stdint.h>

extern "C" long int AreasOfTriangles(); 

int main(){
  long int return_code = -99.99;
  
  printf("%s","Welcome to Assignment 2!. \n");
  return_code = AreasOfTriangles();
  printf("%s%2ld%s\n","The driver received code number ",return_code,". Have a nice day. Bye.");

return 0;
}
