#!/bin/sh

#sets dir to directory containing this script
dir=`dirname $0`

#use $dir to access programs in this directory
#so that this script can be run from any directory.

#echo "no build done"
export CLASSPATH=.:json-simple-1.1.1.jar
javac Parser.java
java Parser ~/cs471/projects/prj1/extras/tests/20-simple-array.test

