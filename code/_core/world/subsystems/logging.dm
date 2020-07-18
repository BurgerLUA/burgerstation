#define ROUND_ID_DIR "data/server/round_id.txt"

#define LOG_RATE 10

SUBSYSTEM_DEF(logging)
	name = "Logging Subsystem"
	desc = "Logs things that are important."
	tick_rate = DECISECONDS_TO_TICKS(LOG_RATE)
	priority = SS_ORDER_LOGGING
	var/list/buffered_log_chat = list()
	var/round_id = 0
	var/start_date = ""

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

/subsystem/logging/proc/get_logging_dir(var/type)
	return "data/server/logging/[round_id]-[start_date]/[type].txt"

/subsystem/logging/on_life()

	if(length(buffered_log_chat))
		var/chat_log_string = english_list(buffered_log_chat,"ERROR.","\n","\n")
		rustg_log_write(get_logging_dir("chat"),chat_log_string,"true")
		buffered_log_chat.Cut()

	return TRUE