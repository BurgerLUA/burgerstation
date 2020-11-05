#define INTERACT_CHECK if(!src.can_caller_interact_with(caller)) return FALSE
#define INTERACT_CHECK_OTHER(x) if(!x.can_caller_interact_with(caller)) return FALSE

#define SPAM_CHECK(x) \
	if(caller && caller.client) { \
		if(caller.client.spam_protection_interact > x) { \
			return FALSE; \
		} \
		caller.client.spam_protection_interact += x; \
	}
