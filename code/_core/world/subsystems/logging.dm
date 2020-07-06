
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
		var/file_text = file2text(ROUND_ID_DIR)
		round_id = text2num(file_text)
	round_id++
	fdel(ROUND_ID_DIR)
	text2file("[round_id]",ROUND_ID_DIR)
	start_date = time2text(world.realtime,"YYYY-MMM-DD")
	return ..()

/subsystem/logging/proc/log_chat(var/data_to_log)
	buffered_log_chat += data_to_log
	return TRUE

/subsystem/logging/proc/get_logging_dir(var/type)
	return "data/server/logging/[round_id]-[start_date]/[type].txt"

/subsystem/logging/on_life()

	if(length(buffered_log_chat))
		var/chat_log_string = english_list(buffered_log_chat,"ERROR.","\n","\n")
		text2file(chat_log_string,get_logging_dir("chat"))
		buffered_log_chat.Cut()

	return TRUE