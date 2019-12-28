/event/meteors
	name = "Meteor Storm"
	id = "meteors"

	probability = 10
	duration = SECONDS_TO_DECISECONDS(60)

	var/list/valid_turfs = list()

/event/meteors/Destroy()
	valid_turfs.Cut()
	return ..()

/event/meteors/New()

	for(var/area/world/forest/exterior/plains/A in world)
		for(var/turf/T in A.contents)
			valid_turfs += T

	LOG_DEBUG("Found [length(valid_turfs)] valid turfs for meteors event.")

	return ..()

/event/meteors/on_start()

	LOG_DEBUG("Starting Meteor Event")

	return TRUE

/event/meteors/on_life()

	for(var/i=1,i<=rand(10,20),i++)
		var/turf/T = pick(valid_turfs)
		new/obj/effect/temp/hazard/falling_meteor(T)

	return TRUE

/event/meteors/on_end()

	LOG_DEBUG("Ending Meteor Event")
	return TRUE