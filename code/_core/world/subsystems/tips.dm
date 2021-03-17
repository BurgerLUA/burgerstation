#define TIPS "text/tips.txt"
#define FACTS "text/facts.txt"
#define JOKES "text/jokes.txt"

SUBSYSTEM_DEF(tips)
	name = "Tips Subsystem"
	desc = "Random spew tips."
	priority = SS_ORDER_PRELOAD
	tick_rate = SECONDS_TO_TICKS(300)

	var/list/stored_tips = list()
	var/list/stored_facts = list()
	var/list/stored_jokes = list()

/subsystem/tips/Initialize()

	var/tips_text = rustg_file_read(TIPS)
	if(!tips_text)
		log_error("WARNING: [TIPS] does not exist!")
		return TRUE
	stored_tips = splittext(tips_text,"\n")
	log_subsystem(name,"Found and stored [length(stored_tips)] tips.")

	var/facts_text = rustg_file_read(FACTS)
	if(!facts_text)
		log_error("WARNING: [FACTS] does not exist!") //Only feelings.
		return TRUE
	stored_facts = splittext(facts_text,"\n")
	log_subsystem(name,"Found and stored [length(stored_facts)] fun facts.")

	var/jokes_text = rustg_file_read(JOKES)
	if(!jokes_text)
		log_error("WARNING: [JOKES] does not exist!")
		return TRUE
	stored_jokes = splittext(jokes_text,"\n")
	log_subsystem(name,"Found and stored [length(stored_jokes)] jokes.")

	return ..()

/subsystem/tips/on_life()
	if(length(stored_jokes) && prob(1))
		broadcast_to_clients(span("bot","TRU FACT: [pick(stored_jokes)]"))
	else if(length(stored_tips) && prob(80))
		broadcast_to_clients(span("bot","Tip: [pick(stored_tips)]"))
	else if(length(stored_facts))
		broadcast_to_clients(span("bot","Fun Fact: [pick(stored_facts)]"))
	return TRUE

