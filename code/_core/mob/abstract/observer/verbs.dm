/mob/abstract/observer/add_inherent_verbs()
	verbs += /mob/abstract/observer/verb/new_character
	verbs += /mob/abstract/observer/verb/load_character
	verbs += /mob/abstract/observer/verb/load_most_recent_character
	verbs += /mob/abstract/observer/verb/make_war
	verbs += /mob/abstract/observer/verb/observe
	return ..()

/mob/abstract/observer/verb/observe()
	set name = "Observe"
	set category = "Menu"

	if(!client)
		return FALSE

	var/decision = input("Are you sure you want to observe? You can join again any time you want.","Observe Round?") as null|anything in list("Yes","No","Cancel")
	if(decision != "Yes")
		return FALSE

	if(type != /mob/abstract/observer/)
		to_chat("You are already observing!")
		return FALSE

	client.make_ghost(get_turf(src))

/mob/abstract/observer/verb/make_war()

	if(ckey != "burgerbb")
		return FALSE

	var/turf/S_T = locate(src.x+src.client.view,src.y,src.z)
	var/turf/N_T = locate(src.x-src.client.view,src.y,src.z)

	if(!S_T || !N_T)
		return

	var/list/turf/possible_NT = list()
	var/list/turf/possible_SY = list()

	for(var/turf/simulated/floor/tile/F in range(src.client.view*0.4,N_T))
		if(F.is_occupied())
			continue
		possible_NT += F

	for(var/turf/simulated/floor/tile/F in range(src.client.view*0.4,S_T))
		if(F.is_occupied())
			continue
		possible_SY += F

	for(var/i=1,i<=8,i++)
		var/turf/S = pick(possible_SY)
		possible_SY -= S

		var/turf/N = pick(possible_NT)
		possible_NT -= N

		var/mob/living/advanced/npc/nanotrasen/N_NPC = new(N)
		N_NPC.dir = EAST
		INITIALIZE(N_NPC)
		N_NPC.ai.enabled = TRUE

		var/mob/living/advanced/npc/syndicate/map/S_NPC = new(S)
		S_NPC.dir = WEST
		INITIALIZE(S_NPC)
		S_NPC.ai.enabled = TRUE