#define INTERACT_CHECK if(!src.can_caller_interact_with(caller)) return FALSE
#define INTERACT_CHECK_OTHER(x) if(!x.can_caller_interact_with(caller)) return FALSE