//Here be shitcode.

#define FILTER_ADD(A,id,filterargs...)\
	if(!A.filter_list) {A.filter_list = list()};\
	if(A.filter_list.Find(id)) {FILTER_REMOVE(A,id)};\
	A.filters += filter(filterargs);\
	A.filter_list += id;

#define FILTER_REMOVE(A,id)\
	if(A.filter_list) {\
		var/found__LINE__ = A.filter_list.Find(id);\
		if(found__LINE__) {\
			A.filters -= A.filters[found__LINE__];\
			A.filter_list -= id\
		}\
	};
