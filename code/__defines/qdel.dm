var/global/list/qdel_refs_to_type = list()

#define qdel(object)																																\
	if (!object) {																																	\
		log_error("Tried to qdel null object! in [__FILE__]:[__LINE__]");																			\
	}																																				\
	else if (object.qdeleting) {																													\
		if (!object.qdel_warning) {																													\
			var/warning_message = "[object.get_debug_name()] was queued for delete more than once! in [__FILE__]:[__LINE__], Original: [object.qdeleting].";						\
			log_error(warning_message);																												\
			rustg_log_write(GARBAGE_LOGS_PATH,warning_message,"true");																				\
		}																																			\
		object.qdel_warning = TRUE;																													\
	}																																				\
	else {																																			\
		var/datum/_qdel_stored_object = object;																										\
		_qdel_stored_object.qdeleting = "[__FILE__]:[__LINE__]";																										\
		HOOK_CALL_ADV("Destroy",_qdel_stored_object,null);																							\
		qdel_refs_to_type["\ref[_qdel_stored_object]"] = _qdel_stored_object.type;																	\
		if(!_qdel_stored_object.PreDestroy()) {																										\
			var/warning_message = "[_qdel_stored_object.get_debug_name()] did not have a proper PreDestroy() call! in [__FILE__]:[__LINE__]";		\
			log_error(warning_message);																												\
			rustg_log_write(GARBAGE_LOGS_PATH,warning_message,"true");																				\
		}																																			\
		if(!_qdel_stored_object.Destroy()) {																										\
			var/warning_message = "[_qdel_stored_object.get_debug_name()] did not have a proper Destroy() call! in [__FILE__]:[__LINE__]";			\
			log_error(warning_message);																												\
			rustg_log_write(GARBAGE_LOGS_PATH,warning_message,"true");																				\
		}																																			\
		_qdel_stored_object.PostDestroy();																											\
	}

#define qdel_in(object,time) CALLBACK_GLOBAL("\ref[object]_qdel_in",time,/datum/proc/delete)