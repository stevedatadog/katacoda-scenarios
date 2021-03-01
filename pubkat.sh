#!/bin/bash
[ $# == 0 ] && echo "Usage: pubkat [source path] [optional commit message]" && exit 1

[ "$1" == "" ] && echo "No source path provided." && exit 1

[ ! -d "$1" ] && echo "Can't find source path." && exit 1

echo "Pushing $1 to katacoda..."

START=$(pwd)
SOURCE="$1"
MSG=${2:-"Another commit"}
DEST="/Users/stephen.calnan/Code/katacoda-scenarios/$(basename $1)"

[ -d $DEST ] && rm -rf $DEST/*
cp -r $SOURCE/* $DEST/
 
cd $DEST
git add .
git commit -m "$MSG"
git push origin master
cd $START
