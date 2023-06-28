#define ROUND_ID_DIR "data/server/round_id.txt"

#define LOG_RATE 10

SUBSYSTEM_DEF(logging)
	name = "Logging Subsystem"
	desc = "Logs things that are important."
	tick_rate = DECISECONDS_TO_TICKS(LOG_RATE)
	priority = SS_ORDER_CONFIG
	var/round_id = 0
	var/start_date = ""

	var/list/buffered_log_chat = list()
	var/list/buffered_log_admin = list()
	var/list/buffered_log_error = list()
	var/list/buffered_log_debug = list()
	var/list/buffered_log_subsystem = list()

//Logging shouldn't be unclogged.
/subsystem/logging/unclog(var/mob/caller)
	. = ..()

/subsystem/logging/Initialize()
	if(fexists(ROUND_ID_DIR))
		var/file_text = rustg_file_read(ROUND_ID_DIR)
		round_id = text2num(file_text)
	round_id++
	rustg_file_write("[round_id]",ROUND_ID_DIR)
	start_date = lowertext(time2text(world.realtime,"YYYY-MMM-DD"))
	return ..()

/subsystem/logging/proc/get_logging_dir(var/type)
	return "data/server/logging/[round_id]-[start_date]/[type].txt"


/subsystem/logging/proc/raw_log(var/file_name,var/text_data,var/timestamps=FALSE)
	if(!file_name || !text_data)
		return FALSE
	rustg_log_write(get_logging_dir(file_name),text_data, timestamps ? "true" : null)
	return TRUE

/subsystem/logging/proc/log_from_list(var/identifier,var/list/desired_list)
	if(!length(desired_list))
		return FALSE
	var/log_string = english_list(desired_list,"LIST ERROR","\n","\n")
	rustg_log_write(get_logging_dir(identifier),log_string,"true")

	var/list/identifier_to_rank = list(
		"admin" = FLAG_PERMISSION_ADMIN,
		"error" = FLAG_PERMISSION_DEVELOPER,
		"debug" = FLAG_PERMISSION_DEVELOPER	,
		"subsystem" = FLAG_PERMISSION_DEVELOPER
	)

	if(world.port != 0 && identifier_to_rank[identifier])
		for(var/k in all_clients)
			var/client/C = all_clients[k]
			if(!(C.permissions & identifier_to_rank[identifier]))
				continue
			if(C.settings)
				if(identifier == "admin")
					if(!C.settings.loaded_data["show_admin_messages"])
						continue
				else
					if(!C.settings.loaded_data["show_debug_messages"])
						continue
			C.queued_chat_messages.Add(
				list(
					list(
						"text" = span(identifier,log_string),
						"output_target_list" = (identifier_to_rank[identifier] & FLAG_PERMISSION_DEVELOPER) ? list("chat_debug.output") : list("chat_all.output")
					)
				)
			)

	desired_list.Cut()

	return TRUE

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

	if(log_from_list("subsystem",buffered_log_subsystem) == null)
		buffered_log_subsystem.Cut()
		buffered_log_subsystem += "Warning! buffered_log_subsystem could not be processed. Some data is missing."
		log_debug("Warning! buffered_log_subsystem could not be processed. Some data is missing.")


	return TRUE