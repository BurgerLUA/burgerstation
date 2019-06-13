#define EVENT_TYPE_AREA "area"
#define EVENT_TYPE_GLOBAL "global"
#define EVENT_TYPE_MARKER "marker"

/event/
	name = "Event"
	id = null


	var/weight = 0 //Chance of happening.
	var/event_type = EVENT_TYPE_GLOBAL

	var/start_time = 0
	var/end_time = 0

/event/proc/on_start()


/event/proc/on_finish()

	qdel(src)