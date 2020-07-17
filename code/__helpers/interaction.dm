#define INTERACT_CHECK if(!src.can_caller_interact_with(caller)) return FALSE
#define INTERACT_CHECK_OTHER(x) if(!x.can_caller_interact_with(caller)) return FALSE

#define SPAM_CHECK \
	if(caller && caller.client) { \
		if(caller.client.spam_protection_interact >= 10) { \
			return FALSE; \
		} \
		caller.client.spam_protection_interact += 5; \
	}
