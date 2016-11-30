#!/bin/bash
#sed -i 'Ns/.*/replacement-line/' file.txt
sed -i '/7/c\This line is removed by the admin.' ./test.txt
