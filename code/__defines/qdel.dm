#define qdel(object)																								\
	if (!object) {																									\
		CRASH_SAFE("Tried to qdel null object!");																	\
	}																												\
	else if (object.qdeleting) {																					\
		if (!object.qdel_warning) {														\
			var/warning_message = "[object.get_debug_name()] was queued for delete more than once!";				\
			CRASH_SAFE(warning_message);																			\
			rustg_log_write(GARBAGE_LOGS_PATH,warning_message,"true");															\
		}																											\
		object.qdel_warning = TRUE;																					\
	}																												\
	else {																											\
		object.qdeleting = TRUE;																					\
		qdel_refs_to_type["\ref[object]"] = object.type;															\
		if (!object.Destroy()) {																					\
			var/warning_message = "[object.get_debug_name()] did not have a proper destroy call!";					\
			CRASH_SAFE(warning_message);																			\
			rustg_log_write(GARBAGE_LOGS_PATH,warning_message,"true");															\
		}																											\
	}

#define qdel_in(object,time) CALLBACK_GLOBAL("\ref[object]_qdel_in",time,/datum/proc/delete)