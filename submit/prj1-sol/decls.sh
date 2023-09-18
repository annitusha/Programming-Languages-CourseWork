#!/bin/sh

#sets dir to directory containing this script
dir=`dirname $0`

#use $dir/ as prefix to run any programs in this dir
#so that this script can be run from any directory.

#java Parser ~/cs471/projects/prj1/extras/tests/10-single-simple.test
javac Parser.java
java Parser
