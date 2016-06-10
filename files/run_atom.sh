#!/bin/bash

#set -x

START_DIR=`pwd`
PIDFILE=$START_DIR/pid

cd ./Boomi_AtomSphere/Atom/Atom_$BOOMI_ATOM/bin
./atom start

    OLDPID=""
    while true; do
      PID=""

      for PID in $(ps -ef | awk '/[b]oomi/ {printf "%s\n", $2}');
      do

      if [ -z "$OLDPID" ]; then
          OLDPID=$PID
          echo $PID >> $PIDFILE
          echo "boomi started, PID is $PID"
      fi

      done

      echo "status - $PID/$OLDPID"

      if [ -n "$PID" ]; then
        echo "boomi still running, PID is $PID"
      elif [ -z "$PID" ] && [ -z "$OLDPID" ]; then
        echo "waiting for boomi to start"
      elif [ -z "$PID" ] && [ -n "$OLDPID" ]; then
        echo "boomi died, exiting process"
        break;
      else
        echo "hmm"
      fi

      sleep 60

    done
    echo "start step complete"
