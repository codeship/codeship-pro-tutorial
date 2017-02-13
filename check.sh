#!/bin/bash
set -e

function check_port() {
	local host=${1} && shift
	local port=${1} && shift
	local retries=25
	local wait=1

	until( $(nc -zv ${host} ${port}) ); do
		((retries--))
		if [ $retries -lt 0 ]; then
			echo "Service ${host} didn't become ready in time."
			exit 1
		fi
		sleep "${wait}"
	done
}

check_port "postgres" "5432"
check_port "redis" "6379"

bundle exec ruby check.rb
