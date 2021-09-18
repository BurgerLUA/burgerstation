/event/tax_check
	name = "Tax Check"

	probability = 20 //relative

	occurances_max = 20

	minor_event = TRUE

	var/list/ckey_blacklist = list()

/event/tax_check/on_start()

	log_debug("Starting Tax Check Event")

	var/list/chunk_data = get_chunk_data(TRUE)

	var/check_limit = 5

	var/valid_targets = 0
	for(var/k in all_players)
		if(check_limit <= 0)
			break
		CHECK_TICK(50,FPS_SERVER)
		var/mob/living/advanced/player/P = k
		if(P.dead || !P.client || !SStax.check_delinquent(P))
			continue
		if(ckey_blacklist[P.ckey])
			continue
		var/turf/T = get_turf(P)
		if(!T)
			continue
		var/area/A = T.loc
		if(A.flags_area & FLAGS_AREA_NO_EVENTS)
			continue
		if(A.area_identifier != "Mission")
			continue

		var/list/valid_chunks = list()
		var/chunk_x = CEILING(T.x/CHUNK_SIZE,1)
		var/chunk_y = CEILING(T.y/CHUNK_SIZE,1)
		for(var/x=-1,x<=1,x++)
			for(var/y=1,y<=1,y++)
				var/final_string = "[chunk_x + x*2],[chunk_y + y*2],[T.z]"
				if(chunk_data[final_string])
					continue
				valid_chunks += final_string

		check_limit -= 1

		if(!length(valid_chunks))
			continue

		var/chunk_to_choose = pick(valid_chunks)
		chunk_to_choose = splittext(chunk_to_choose,",")
		var/x = text2num(chunk_to_choose[1])
		var/y = text2num(chunk_to_choose[2])
		var/z = text2num(chunk_to_choose[3])
		var/list/valid_turfs = list()
		for(var/j in get_chunk(x,y,z))
			var/turf/T2 = j
			if(!T2.is_safe_teleport(FALSE))
				continue
			valid_turfs += T2

		if(!length(valid_turfs))
			continue

		for(var/n=1,n<=4,n++)
			var/mob/living/advanced/npc/tax_collector/TC = new(pick(valid_turfs))
			INITIALIZE(TC)
			GENERATE(TC)
			FINALIZE(TC)
			if(TC.ai)
				TC.ai.set_move_objective(P,TRUE)

		ckey_blacklist[P.ckey] = TRUE
		valid_targets++

	log_debug("Found [valid_targets] valid target for tax hunt event.")

	. = ..()
