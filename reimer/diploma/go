#!/bin/bash

latex $1
makeindex $1.nlo -o $1.nls -s nomencl.ist
bibtex $1
latex $1
