#!/bin/sh
symbolicatecrash=$(find ${1} -name symbolicatecrash -type f | grep "SharedFrameworks")
echo -n "${symbolicatecrash}"
