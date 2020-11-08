#define ROUND_ID_DIR "data/server/round_id.txt"

#define LOG_RATE 10

SUBSYSTEM_DEF(logging)
	name = "Logging Subsystem"
	desc = "Logs things that are important."
	tick_rate = DECISECONDS_TO_TICKS(LOG_RATE)
	priority = SS_ORDER_LOGGING
	var/round_id = 0
	var/start_date = ""

	var/list/buffered_log_chat = list()
	var/list/buffered_log_admin = list()
	var/list/buffered_log_error = list()
	var/list/buffered_log_debug = list()

/subsystem/logging/Initialize()
	if(fexists(ROUND_ID_DIR))
		var/file_text = rustg_file_read(ROUND_ID_DIR)
		round_id = text2num(file_text)
	round_id++
	rustg_file_write("[round_id]",ROUND_ID_DIR)
	start_date = lowertext(time2text(world.realtime,"YYYY-MMM-DD"))
	return ..()

/subsystem/logging/proc/log_chat(var/data_to_log)
	buffered_log_chat += data_to_log
	return TRUE

/subsystem/logging/proc/log_admin(var/data_to_log)
	buffered_log_admin += data_to_log
	return TRUE

/subsystem/logging/proc/get_logging_dir(var/type)
	return "data/server/logging/[round_id]-[start_date]/[type].txt"

/subsystem/logging/proc/log_from_list(var/identifier,var/list/desired_list)
	if(length(desired_list))
		var/log_string = english_list(desired_list,"LIST ERROR","\n","\n")
		rustg_log_write(get_logging_dir(identifier),log_string,"true")
		desired_list.Cut()
		return TRUE
	return FALSE

/subsystem/logging/on_life()

	if(log_from_list("chat",buffered_log_chat) == null)
		buffered_log_chat.Cut()
		buffered_log_chat += "Warning! buffered_log_chat could not be processed. Some data is missing."
		log_debug("Warning! buffered_log_chat could not be processed. Some data is missing.")

	if(log_from_list("admin",buffered_log_admin) == null)
		buffered_log_admin.Cut()
		buffered_log_admin += "Warning! buffered_log_admin could not be processed. Some data is missing."
		log_debug("Warning! buffered_log_admin could not be processed. Some data is missing.")

	if(log_from_list("error",buffered_log_error) == null)
		buffered_log_error.Cut()
		buffered_log_error += "Warning! buffered_log_error could not be processed. Some data is missing."
		log_debug("Warning! buffered_log_error could not be processed. Some data is missing.")

	if(log_from_list("debug",buffered_log_debug) == null)
		buffered_log_debug.Cut()
		buffered_log_debug += "Warning! buffered_log_debug could not be processed. Some data is missing."
		log_debug("Warning! buffered_log_debug could not be processed. Some data is missing.")

	return TRUE