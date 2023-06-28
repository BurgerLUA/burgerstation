#define ERROR_LIMIT 5
#define ERROR_MAJOR_LIMIT 25

var/global/list/tracked_errors = list()
var/global/list/tracker_errors_spam = list()

/world/Error(var/exception/e)

	if(SSreport)
		SSreport.runtime_count += 1

	var/error_title = "[e.name] in [e.file]:[e.line]"
	var/error_details = "[e.desc]"

	tracked_errors[error_title]++
	if(ERROR_MAJOR_LIMIT > 0 && tracked_errors[error_title] > ERROR_MAJOR_LIMIT && !(tracked_errors[error_title] % ERROR_MAJOR_LIMIT))
		log_error("Major error spam is occuring for [error_title]!")
	if(ERROR_LIMIT && tracked_errors[error_title] > ERROR_LIMIT)
		return TRUE

	log_error("[error_title]\n[error_details]")

	for(var/k in all_runtimes)
		var/mob/living/simple/cat/runtime/R = k
		if(!R || R.qdeleting)
			all_runtimes -= k
			continue
		R.reproduce()

	return TRUE