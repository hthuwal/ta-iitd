#!/bin/bash

if [ -d "submissions" ]; then
	echo "Cleaning results"
	rm -rf "submissions"
fi
mkdir -p "submissions"

if [ -d "sandbox" ]; then
	echo "Cleaning sandbox"
	rm -rf "sandbox"
fi
mkdir -p "sandbox"

if ! [ -d "env_py3" ]; then
	virtualenv "env_py3"
	source "env_py3/bin/activate"
	pip install -r "requirements.txt"
	deactivate
fi

if ! [ -d "env_py2" ]; then
	virtualenv -p "/usr/bin/python2" "env_py2"
	source "env_py2/bin/activate"
	pip install -r "requirements.txt"
	deactivate
fi
