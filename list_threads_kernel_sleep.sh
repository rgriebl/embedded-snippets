#!/bin/sh

pid="$1"
[ ! -d /proc/$pid ] && pid=$(pidof $pid)
[ -z "$pid" -o ! -d /proc/$pid ] && { echo "Unknown pid/process $pid"; exit 2; }

echo "Threads for pid $pid, sleeping in these kernel functions:"

for i in `find /proc/$pid/task/ -mindepth 1 -maxdepth 1`; do
  name=$(cat $i/status | grep Name | sed -e 's,Name:[ \t]*,,')
  [ $(basename "$i") = "$pid" ] && name="(mainthread)"
  cat $i/wchan ; echo " \t${name}" 
done 
