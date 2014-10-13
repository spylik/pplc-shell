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
Example of output:
---
```
Pattern "GET /api/users/{userid}/count_pending_messages"
matched: 2430 average response time: 25.9967ms, median of response time: 15ms, mode of reponse time: 11ms, the most responded dyno: web.2

Pattern "GET /api/users/{userid}/count_pending_messages"
matched: 652 average response time: 62.1702ms, median of response time: 32ms, mode of reponse time: 23ms, the most responded dyno: web.11

Pattern "GET /api/users/{userid}/count_pending_messages"
matched: 1117 average response time: 111.897ms, median of response time: 51ms, mode of reponse time: 35ms, the most responded dyno: web.5

Pattern "GET /api/users/{userid}/count_pending_messages"
matched: 1533 average response time: 228.765ms, median of response time: 143ms, mode of reponse time: 67ms, the most responded dyno: web.7

Pattern "GET /api/users/{userid}/count_pending_messages"
matched: 2036 average response time: 82.4538ms, median of response time: 46ms, mode of reponse time: 23ms, the most responded dyno: web.11

Pattern "GET /api/users/{userid}/count_pending_messages"
matched: 6293 average response time: 96.7076ms, median of response time: 36ms, mode of reponse time: 11ms, the most responded dyno: web.8
```
