#!/bin/bash

tmux start-server
tmux has-session -t music 2>&1 > /dev/null

if [ $? -ne 0 ]; then
  tmux new-session -d -s music -n somafm 'somafm.sh' 
  tmux new-window -a -d -n pandora 'pianobar'
  tmux new-window -a -d -n mp3 'mp3blaster'
fi

tmux attach -t music
