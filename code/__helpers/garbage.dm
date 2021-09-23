#define QDEL_NULL(x) if(x) { if(!ispath(x)) {qdel(x)} ; x = null }

#define QDEL_CUT(x)				\
	if(x) {						\
		for(var/kd in x) {		\
			var/datum/DD = kd;	\
			qdel(DD);			\
		}						\
		x.Cut();				\
	}


#define QDEL_CUT_ASSOC(x)			\
	if(x) {							\
		for(var/kd in x) {			\
			var/datum/DD = x[kd];	\
			qdel(DD);				\
		}							\
		x.Cut();					\
	}