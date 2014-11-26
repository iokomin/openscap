#!/bin/bash
#
# Copyright 2014 Red Hat Inc., Durham, North Carolina.
# All Rights Reserved.

set -e -o pipefail
set -x

name=$(basename $0 .sh)
dir=$(mktemp -d -t ${name}.XXXXXX)
stderr=$(mktemp -t ${name}.err.XXXXXX)
echo "Stderr file = $stderr"
sds=$dir/sds.xml
xccdf=$dir/xccdf.xml
cp $srcdir/../DS/sds_multiple_oval/*.xml $dir/
mv $dir/multiple-oval-xccdf.xml $xccdf

#
# Checks before DataStream compose
#
bzip2 $xccdf
[ -f "${xccdf}.bz2" ]
$OSCAP info "${xccdf}.bz2" 2> $stderr
[ -f $stderr ]; [ ! -s $stderr ]

$OSCAP xccdf validate-xml "${xccdf}.bz2" > $stderr
[ ! -s $stderr ]

#
# Compose DataStream
#
$OSCAP ds sds-compose "${xccdf}.bz2" "$sds" 2>&1 > $stderr
[ ! -s $stderr ]

bzip2 $sds
[ -f "${sds}.bz2" ]
$OSCAP info "${sds}.bz2" 2> $stderr
[ ! -s $stderr ]

$OSCAP ds sds-validate "${sds}.bz2" > $stderr
[ ! -s $stderr ]

#
# Evaluate
#
ret=0
$OSCAP xccdf eval "${xccdf}.bz2" 2> $stderr || ret=$?
[ $ret -eq 2 ]; ret=0
[ ! -s $stderr ]

arf=$dir/arf.xml
$OSCAP xccdf eval --results-arf $arf "${sds}.bz2" 2> $stderr || ret=$?
[ $ret -eq 2 ]
[ ! -s $stderr ]

#
# Generate report from ARF
#
bzip2 $arf
[ -f "${arf}.bz2" ]
report=$dir/report.html
$OSCAP xccdf generate report --output $report "${arf}.bz2" 2> $stderr
[ ! -s $stderr ]
[ -f $report ]

cp $report /tmp/x
grep 'OVAL details' /tmp/x
rm $stderr
rm -rf $dir