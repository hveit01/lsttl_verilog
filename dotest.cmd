@echo off
rem run this out of the libtest directory with the name of a test
rem e.g. 
rem cd libtest
rem ..\dotest 74ls00_test [min|typ|max]
rem
iverilog -I ../lib -T %2 -o %1 %1.v
vvp %1