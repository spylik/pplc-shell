#!/bin/sh

LOOKINGFOR=(
"grep 'method=GET' | egrep '/api/users/[[:digit:]]{1,}/count_pending_messages'"
"grep 'method=GET' | egrep '/api/users/[[:digit:]]{1,}/get_messages'"
"grep 'method=GET' | egrep '/api/users/[[:digit:]]{1,}/get_friends_progress'"
"grep 'method=GET' | egrep '/api/users/[[:digit:]]{1,}/get_friends_score'"
"grep 'method=POST' | egrep '/api/users/[[:digit:]]{1,}'"
"grep 'method=GET' | egrep '/api/users/[[:digit:]]{1,}'"
)


for l in "${LOOKINGFOR[@]}" 
do
cat $1 | eval $l  | 
	gawk '
	{
		split($0,a," "); 
		dyno[total]=substr(a[8],6); 
		split(substr(a[9],9),connection_time,"ms"); 
		split(substr(a[10],9),processing_time,"ms"); 
		response_time[total]=connection_time[1]+processing_time[1];
		modeIndex[response_time[total]]++;
		modeDyno[dyno[total]]++;
		totalTime=totalTime+response_time[total];
		total++; 
	};
	END {
		average = totalTime / total;
		asort(response_time);
		if(total % 2){
			median=response_time[(total+1)/2];
		}else{
			median=(response_time[(total/2)] + response_time[(total/2)+1]) / 2.0;
		}
		for(i in modeIndex){
			if (modeIndex[i] > freq) {mode=i; freq=modeIndex[i] }
		}
		for(i in modeDyno){
			if (modeDyno[i] > freq2) {modeDyn=i; freq2=modeDyno[i] }
		}
		print "Pattern "$l" \nmatched: " total " average response time: " average"ms, median of response time: " median"ms, mode of reponse time: " mode"ms, the most responded dyno: " modeDyn"\n" 
	}' ;
done
