#!/bin/bash
#It builds the xampp-htdocs tarballs per platform for XAMPP


AFDIR=`pwd`/../
DATE=`date +%Y%m%d`

cd $AFDIR
for platform in linux osx windows stackman; do
    echo "Building XAMPP htdocs for $platform"
    rm -r $AFDIR/build-xampp-$platform-* $AFDIR/xampp-htdocs-$platform-*
    APP=xampp platform=$platform bin/middleman build
    mv build-xampp-$platform xampp-htdocs-$platform
    tar -czvf xampp-htdocs-$platform-$DATE.tar.gz xampp-htdocs-$platform
done
