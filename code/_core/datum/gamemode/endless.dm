/gamemode/endless
	name = "Freeroam"
	desc = "No missions right now. Do anything you want."
	hidden = FALSE

	var/last_vote = 0
	var/vote_delay = SECONDS_TO_DECISECONDS(60*60)

	round_time_next = 0

	var/stage = 0
	//0 = starting
	//1 = gearing
	//2 = prepping
	//3 = allowed to launch
	//4 = enemies are spawning
	//5 = evac time
	//6 = pvp
	//7 = victory

	var/status_display_text
	var/status_display_time

	var/pvp_start_time = -1
	var/boredom_warning = FALSE

/gamemode/endless/New()
	. = ..()
	round_time_next = 30

/gamemode/endless/on_life()

	. = ..()

	if(round_time_next > 0 && round_time >= round_time_next)
		round_time = 0
		stage++
		switch(stage)
			if(1)
				status_display_text = "GEAR"
				round_time_next = 6*60
				SSshuttle.next_pod_launch = world.time + SECONDS_TO_DECISECONDS(6*60)
				announce(
					"Central Command Mission Update",
					"Prepare for Landfall",
					"All landfall crew are ordered to gear up for planetside combat. Estimated time until drop pod functionality: 6 minutes.",
					sound_to_play = 'sound/voice/announcement/landfall_crew_6_minutes.ogg'
				)
			if(2)
				status_display_text = "PREP"
				round_time_next = 1*60
				SSshuttle.next_pod_launch = world.time + SECONDS_TO_DECISECONDS(60)
				announce(
					"Central Command Mission Update",
					"Drop Pod Boarding",
					"All landfall crew are ordered to proceed to the hanger bay and prep for drop pod launch. Drop pods will be allowed to launch in 1 minute.",
					sound_to_play = 'sound/voice/announcement/landfall_crew_1_minute.ogg'
				)
			if(3)
				status_display_text = "RDY"
				SSshuttle.next_pod_launch = world.time
				round_time_next = 3*60
				announce(
					"Central Command Mission Update",
					"Mission is a Go",
					"Drop pods are prepped and ready to depart into the Area of Operations. All crew are cleared to launch.",
					sound_to_play = 'sound/voice/announcement/landfall_crew_0_minutes.ogg'
				)
			if(4)
				status_display_text = "BTTLE"
				round_time_next = 40*60
				announce(
					"Central Command Mission Update",
					"Threat Detected",
					"Unusual enemy combatants detected in the Area of Operations. All crew are instructed to remove the threat as needed.",
					sound_to_play = 'sound/voice/announcement/landfall_crew_enemy_detected.ogg'
				)
			if(5)
				status_display_text = "EVAC"
				round_time_next = 5*60
				announce(
					"Central Command Mission Update",
					"Evacuation Orders",
					"Incoming Ion Storm detected. All crew are recommended to evacuate the area. Failure to evacuate may result in-\n%@&^#*#^&STREAM INTERUPTED%&#(&#\n\
					Hey, John Syndicate here. Ever wanted to kill your co-workers? How about blow their fucking brains out? Well, stick around and I'll disable those pesky\
					IFF implants for you so you can beat the shit out of eachother. Want an incentive? Last person standing gets 80,000 credits.",
					sound_to_play = 'sound/voice/announcement/landfall_crew_evac_notice.ogg'
				)
			if(6)
				status_display_text = "UNSAFE"
				SSshuttle.next_pod_launch = -1
				var/number_of_players = 0
				for(var/k in all_players)
					var/mob/living/advanced/player/P = k
					if(P.dead)
						continue
					if(P.loyalty_tag != "NanoTrasen")
						continue
					var/area/A = get_area(src)
					if(A.area_identifier != "Mission")
						continue
					number_of_players++

				if( number_of_players <= 1)
					if(number_of_players == 1)
						announce(
							"Syndicate Command Mission Update",
							"Wow.",
							"John Syndicate here. There is a bit of slight problem; only one of you decided to stay. We can't have brutal corporate sabotage deathmatch with just one person, so that's lame. OH WELL, time to move onto the next unsanctioned mission to sabotage."
						)
					else
						announce(
							"Syndicate Command Mission Update",
							"Wow.",
							"John Syndicate here. There is a bit ofa slight problem; none of you decided to stay. We can't have brutal corporate sabotage deathmatch with literally no one, so that's lame. OH WELL, time to move onto the next unsanctioned mission to sabotage."
						)
					round_time_next = 0
					world.end(WORLD_END_NANOTRASEN_VICTORY)
				else
					announce(
						"Syndicate Command Mission Update",
						"IFF Implants Disabled",
						"John Syndicate here. I've disabled all IFF implants. We're sending drop pods containing premium tracking equipment to your location to speed this up. Don't stand under it. You have 10 minutes to kill eachother before I get bored and start sending Elite Operatives to take everyone out. I'll be checking every minute to see if you're all dead."
					)
					set_friendly_fire(TRUE)
					round_time_next = 10*60
					pvp_start_time = world.time
			if(7) //7 is the checking stage.
				status_display_text = "UNSAFE"
				var/number_of_players = 0
				var/mob/living/advanced/player/last_person
				for(var/k in all_players)
					var/mob/living/advanced/player/P = k
					if(P.dead)
						continue
					if(P.loyalty_tag != "NanoTrasen")
						continue
					var/area/A = get_area(src)
					if(A.area_identifier != "Mission")
						continue
					number_of_players++
					last_person = P
				if(number_of_players <= 1) //Last person standing.
					if(number_of_players <= 0 || !last_person)
						announce(
							"Syndicate Command Mission Update",
							"Uhh...",
							"John Syndicate here. I don't know what the hell happened, but it appears that there is no one left. Did you kill eachother at once? Did you both leave? Fuck if I know, I'll have to look at the replays or some shit. Regardless, no one gets any money. OH WELL, time to move onto the next unsanctioned mission to sabotage."
						)
						world.end(WORLD_END_NANOTRASEN_VICTORY)
					else
						announce(
							"Syndicate Command Mission Update",
							"We have a winner!",
							"John Syndicate here. Seems we found ourselves a victor. [last_person.real_name], was it? Who the hell came up with that name? Whatever, they get the 80,000 credits- and a crown, why the hell not?"
						)
						world.end(WORLD_END_NANOTRASEN_VICTORY)
						last_person.adjust_currency(80000)
						var/turf/T = get_turf(last_person)
						var/obj/item/clothing/head/hat/crown/C = new(T)
						C.winner_name = lowertext(last_person.real_name)
						INITIALIZE(C)
						GENERATE(C)
						FINALIZE(C)
						C.quick_equip(last_person)
					world.end(WORLD_END_NANOTRASEN_VICTORY)
					round_time_next = 0
				else
					stage = 6 //Go back to stage 6 by default
					round_time_next = 30 //Check every half-minute.


		if(stage == 6 && pvp_start_time > 0 && world.time >= pvp_start_time + SECONDS_TO_DECISECONDS(600))
			if(!boredom_warning)
				announce(
					"Syndicate Command Mission Update",
					"Zzzz.",
					"John Syndicate here. I'm starting to get bored, so I'm going to send in my worst best operatives to speed things up. Hope you like drop pods that land directly on you."
				)
			else
				for(var/k in all_players)
					var/mob/living/advanced/player/P = k
					if(P.dead)
						continue
					if(P.loyalty_tag != "NanoTrasen")
						continue
					var/area/A = get_area(src)
					if(A.area_identifier != "Mission")
						continue



	if(stage < 3)
		var/time_left = round_time_next - round_time
		status_display_time = get_clock_time(FLOOR(time_left,1))

	if(status_display_text && status_display_time)
		set_status_display("mission","[status_display_text ? status_display_text : "HI"]\n[status_display_time ? status_display_time : "THERE"]")