#define INTERACT_CHECK if(!src.can_activator_interact_with(activator)) return FALSE
#define INTERACT_CHECK_OBJECT if(!object.can_activator_interact_with(activator)) return FALSE
#define INTERACT_CHECK_DEFER if(!defer_object.can_activator_interact_with(activator)) return FALSE
#define INTERACT_CHECK_OTHER(x) if(!x.can_activator_interact_with(activator)) return FALSE
#define INTERACT_CHECK_NO_DELAY(x) if(!x.can_activator_interact_with(activator,delay_checks=FALSE)) return FALSE

#define DEFER_OBJECT var/atom/defer_object = object.defer_click_on_object(activator,location,control,params)

#define SPAM_CHECK(x) \
	if(activator && activator.client) { \
		if(activator.client.spam_protection_interact > x) { \
			return FALSE; \
		} \
		activator.client.spam_protection_interact += x; \
	}
//SPAM_CHECK usage: x is deciseconds. higher values means tougher spam protection.

#define SPAM_CHECK_CLIENT(x) \
	if(src.spam_protection_interact > x) { \
		return FALSE; \
	} \
	src.spam_protection_interact += x; \







#define INTERACT_DELAY(x) if(activator.client) {activator.client.interact_next = max(activator.client.interact_next,world.time + x)}