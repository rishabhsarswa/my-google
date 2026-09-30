#!/bin/bash

for i in $@
do
	kill $i
	rm qq/$i
done
