/var/list/turf/turfs = list()

/turf/New()
	. = ..()
	global.turfs += src

/turf/Del()
	global.turfs -= src
	. = ..()
