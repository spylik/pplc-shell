pplc-shell
===

pplc-shell is very simple shell script for analyze log files.


For every input search patterns (hardcoded in script), script can calculate:

* The amount of times the URL was called.
* The mean (average), median and mode of the response time (connect time + service time).
* The "dyno" that responded the most.

pplc have implementations in others languages:

https://github.com/spylik/pplc-php (PHP)

https://github.com/spylik/pplc-erlang (Erlang)

Goals
---
pplc-shell is very simple script. pplc-shell cat log file for every search pattern. 

How to run
---
`sh ./createReport.sh ./sample.log > ./report.txt` will generate report.txt in current directory. sample.log may present in same folder.

Features
---
pplc-shell supports grep-style and regular expression definations for search patterns.

Search Patterns defines via LOOKINGFOR variable (createReport.sh). Example:
```
LOOKINGFOR=(
"grep 'method=GET' | egrep '/api/users/[[:digit:]]{1,}/count_pending_messages'"
"grep 'method=GET' | egrep '/api/users/[[:digit:]]{1,}/get_messages'"
"grep 'method=GET' | egrep '/api/users/[[:digit:]]{1,}/get_friends_progress'"
"grep 'method=GET' | egrep '/api/users/[[:digit:]]{1,}/get_friends_score'"
"grep 'method=POST' | egrep '/api/users/[[:digit:]]{1,}'"
"grep 'method=GET' | egrep '/api/users/[[:digit:]]{1,}'"
)

```
