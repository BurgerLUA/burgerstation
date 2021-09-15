/event/tax_check
	name = "Tax Check"

	probability = 20 //relative

	occurances_max = 20

	minor_event = TRUE

/event/tax_check/on_start()

	log_debug("Starting Tax Check Event")

	var/list/chunk_data = get_chunk_data()

	var/check_limit = 3

	for(var/k in all_players)
		if(check_limit <= 0)
			break
		CHECK_TICK(50,FPS_SERVER)
		var/mob/living/advanced/player/P = k
		if(P.dead || !P.client || !SStax.check_delinquent(P))
			continue
		var/turf/T = get_turf(P)
		if(!T)
			continue

		var/list/valid_chunks = list()
		for(var/x=-1,x<=1,x++)
			for(var/y=1,y<=1,y++)
				var/final_string = "[x],[y],[T.z]"
				if(chunk_data[final_string])
					continue
				valid_chunks += final_string

		check_limit -= 1

		if(length(valid_chunks))
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
				if(T2.lightness > 0)
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









