/event/carp
	name = "Carp Migration"

	probability = 20 //relative

	var/list/turf/valid_turfs = list()
	var/list/area/valid_areas = list()

	occurances_max = 3

/event/carp/Destroy()
	valid_turfs.Cut()
	valid_areas.Cut()
	return ..()

/event/carp/New()

	for(var/area/A in world)
		if(A.z != 3)
			continue
		if(A.interior)
			continue
		if(A.flags_area & FLAGS_AREA_NO_EVENTS)
			continue
		valid_areas += A

	LOG_DEBUG("Found [length(valid_turfs)] valid turfs for carp event.")

	return ..()

/event/carp/on_start()

	valid_turfs.Cut()

	LOG_DEBUG("Starting Carp Event")

	var/list/announce_areas = list()

	for(var/i=1,i<=3,i++)
		if(!length(valid_areas))
			return FALSE
		var/area/A = pick(valid_areas)
		announce_areas |= A.name
		for(var/turf/simulated/floor/T in A.contents)
			valid_turfs += T

	if(!length(valid_turfs))
		return FALSE

	announce(
		"Central Command Space Marine Biology Division",
		"Carp Migration",
		"A carp migration has been detected near the area of operations. Predicted migration areas: [english_list(announce_areas)]."
	)

	for(var/i=1,i<=20,i++)
		CHECK_TICK(50,FPS_SERVER*10)
		if(!length(valid_turfs))
			break
		var/turf/T = pick(valid_turfs)
		if(!T)
			break
		CREATE_SAFE(/mob/living/simple/npc/spacecarp/,T)

	return ..()

/event/carp/on_end()
	LOG_DEBUG("Ending Carp Migration Event")
	return ..()