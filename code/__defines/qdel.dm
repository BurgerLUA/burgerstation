var/global/list/qdel_refs_to_type = list()

#define qdel(object)																											\
	if (!object) {																												\
		log_error("Tried to qdel null object! in [__FILE__]:[__LINE__]");														\
	}																															\
	else if (object.qdeleting) {																								\
		if (!object.qdel_warning) {																								\
			var/warning_message = "[object.get_debug_name()] was queued for delete more than once! in [__FILE__]:[__LINE__]";	\
			log_error(warning_message);																							\
			rustg_log_write(GARBAGE_LOGS_PATH,warning_message,"true");															\
		}																														\
		object.qdel_warning = TRUE;																								\
	}																															\
	else {																														\
		object.qdeleting = TRUE;																								\
		HOOK_CALL_ADV("Destroy",object,null);																					\
		qdel_refs_to_type["\ref[object]"] = object.type;																		\
		if(!object.PreDestroy()) {																								\
			var/warning_message = "[object.get_debug_name()] did not have a proper PreDestroy() call! in [__FILE__]:[__LINE__]";\
			log_error(warning_message);																							\
			rustg_log_write(GARBAGE_LOGS_PATH,warning_message,"true");															\
		}																														\
		if(!object.Destroy()) {																									\
			var/warning_message = "[object.get_debug_name()] did not have a proper Destroy() call! in [__FILE__]:[__LINE__]";	\
			log_error(warning_message);																							\
			rustg_log_write(GARBAGE_LOGS_PATH,warning_message,"true");															\
		}																														\
		object.PostDestroy();																									\
	}

#define qdel_in(object,time) CALLBACK_GLOBAL("\ref[object]_qdel_in",time,/datum/proc/delete)