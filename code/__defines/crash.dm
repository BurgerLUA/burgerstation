#define CRASH_SAFE(x) 												\
	try													\
		CRASH(x);												\
	catch(var/exception/e) 											\
		log_error("[e.name] in [e.file]:[e.line].\n[e.desc]");