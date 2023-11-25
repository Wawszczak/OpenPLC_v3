#!/bin/bash
./background_installer.sh $1 $2 2>&1 | tee install_log.txt
if [ ${PIPESTATUS[0]} -ne 0 ] ; then
    echo "Error running background installer!"
    echo "OpenPLC was NOT installed or installed partially!"
    exit 1
fi

