#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <log_file_path>"
    exit 1
fi

log=$1

if [ -f "$log" ];then
        echo "Checking Log File"

        ipaddresses=$(cat $log | awk '{print $1}' | uniq -c | sort -nr | head -5)

        echo "Top 5 IP Addresses with the Most Requests:"
        echo "$ipaddresses" | awk '{print $2 " - " $1 " requests"}'
        echo ""

        echo "Top 5 Most Requested Paths: "
        requests=$(cat $log | awk '{print $6,$7}' | sort | uniq -c | sort -nr | head -5)
        echo "$requests" | awk '{print $2,$3 " - " $1 " requests"}'
        echo ""

        echo "Top 5 Response status codes: "
        responses=$(cat $log | awk '{print $9}' | uniq -c |sort -nr|  head -5)
        echo "$responses" | awk '{print $2 " - " $1 " requests"}'
        echo ""

        echo "Top 5 User Agents:"
        agents=$(cat "$log" | grep -o '".*"$' | sort | uniq -c | sort -nr | head -5)
        echo "$agents" | while read -r count agent; do
        echo "$agent - $count requests"
        done

else
        echo "File not available or cannot be accessed"
fi
