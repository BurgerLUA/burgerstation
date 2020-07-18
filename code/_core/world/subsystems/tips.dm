#define TIPS "text/tips.txt"

SUBSYSTEM_DEF(tips)
	name = "Tips Subsystem"
	desc = "Random spew tips."
	priority = SS_ORDER_PRELOAD
	tick_rate = SECONDS_TO_TICKS(300)

	var/list/stored_tips = list()

/subsystem/tips/Initialize()

	var/tips_text = rustg_file_read(TIPS)

	if(!tips_text)
		log_error("WARNING: [TIPS] does not exist!")
		return TRUE

	stored_tips = splittext(tips_text,"\n")

	log_subsystem(name,"Found and stored [length(stored_tips)] tips.")

	return ..()

/subsystem/tips/on_life()
	broadcast_to_clients(span("bot","TIP: [pick(stored_tips)]"))
	return TRUE

