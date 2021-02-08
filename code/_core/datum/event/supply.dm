/event/supply
	name = "Stray Supply Pods"

	probability = 15 //relative

	var/list/turf/valid_turfs = list()
	var/list/area/valid_areas = list()

	occurances_max = 3

	var/list/atom/movable/possible_items = list(
		/obj/item/supply_crate/russian,
		/obj/item/supply_crate/syndicate,
		/obj/item/supply_crate/american,
		/obj/item/supply_crate/nanotrasen,
		/mob/living/advanced/npc/beefman
	)

/event/supply/Destroy()
	valid_turfs.Cut()
	valid_areas.Cut()
	return ..()

/event/supply/New()

	for(var/area/A in world)
		if(A.area_identifier != "Mission")
			continue
		if(A.interior)
			continue
		if(A.flags_area & FLAGS_AREA_NO_EVENTS)
			continue
		valid_areas += A

	log_debug("Found [length(valid_turfs)] valid turfs for carp event.")

	return ..()

/event/supply/on_start()

	valid_turfs.Cut()

	log_debug("Starting Carp Event")

	var/list/announce_areas = list()

	for(var/i=1,i<=3,i++)
		if(!length(valid_areas))
			return FALSE
		var/area/A = pick(valid_areas)
		announce_areas |= A.name
		for(var/turf/simulated/floor/T in A.contents)
			if(T.x <= 10 || T.x >= WORLD_SIZE - 10)
				continue
			if(T.y <= 10 || T.y >= WORLD_SIZE - 10)
				continue
			valid_turfs += T

	if(!length(valid_turfs))
		return FALSE

	announce(
		"Central Command Cargo Control",
		"Stray Supply Pods",
		"Several stray supply pods are predicted to land in the area of operations. Predicted landing areas: [english_list(announce_areas)].",
		sound_to_play = 'sound/voice/announcement/supply.ogg'
	)

	for(var/i=1,i<=rand(4,8),i++)
		if(!length(valid_turfs))
			break
		var/turf/T = pick(valid_turfs)
		var/obj/structure/interactive/crate/closet/supply_pod/stray/S = new(T)
		for(var/k=1,k<=rand(2,5),k++)
			var/atom/movable/M = pick(possible_items)
			M = new M(T)
			INITIALIZE(M)
			GENERATE(M)
			FINALIZE(M)
			M.force_move(S)

		INITIALIZE(S)
		GENERATE(S)
		FINALIZE(S)

	return ..()

/event/supply/on_end()
	log_debug("Ending Supply Event")
	return ..()