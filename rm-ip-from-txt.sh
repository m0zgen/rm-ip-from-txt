#!/bin/bash
# Author: Yevgeniy Goncharov aka xck, https://lab.sys-adm.in
# Find & Delete IP from .txt located in target dir
# Sys env / paths / etc
# -------------------------------------------------------------------------------------------\
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd); cd $SCRIPT_PATH

# -------------------------------------------------------------------------------------------\

# Checking passed args
if [ $# -ne 2 ]; then
    echo "Usage: $0 <dir> <IP-address>"
    exit 1
fi

# VArs for dir and IP
directory="$1"
ip_address="$2"

# Check if catalog is exist
if [ ! -d "$directory" ]; then
    echo "Каталог '$directory' не существует."
    exit 1
fi

# Search and delete line with IP-address from .txt
echo "Find IP-address '$ip_address' in .txt from catalog '$directory'..."
find "$directory" -type f -name "*.txt" | while read -r file; do
    # Ищем IP-адрес в файле и удаляем строку, если он найден
    # Find IP-address in found file and delete line, if found
    grep -qF "$ip_address" "$file" && sed -i "/$ip_address/d" "$file"
done

echo "Done."
