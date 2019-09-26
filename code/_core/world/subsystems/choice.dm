var/global/list/choice_button_id_to_button = list()
var/global/list/question_button_id_to_button = list()

/subsystem/choices/
	name = "Choice Subsystem"
	desc = "Controls the choices people make."
	tick_rate = DECISECONDS_TO_TICKS(1)
	priority = SS_ORDER_IMPORTANT

/subsystem/choices/Initialize()

	for(var/type_of in subtypesof(/obj/hud/button/choice/))
		var/obj/hud/button/choice/B = type_of
		var/b_id = initial(B.id)
		if(!b_id)
			continue
		choice_button_id_to_button[b_id] = B

	for(var/type_of in subtypesof(/obj/hud/button/question/))
		var/obj/hud/button/question/Q = type_of
		var/q_id = initial(Q.id)
		if(!q_id)
			continue
		question_button_id_to_button[q_id] = Q

	return TRUE

/proc/start_choice(var/mob/M,var/choice/C)

	if(is_living(M))
		var/mob/living/L = M
		L.paralyze_time = -1

	C = new C(M)

	while(!C.choice_made)
		sleep(TICK_LAG)

	var/decision_made = C.on_decision()
	if(is_living(M))
		var/mob/living/L = M
		L.paralyze_time = 1
	qdel(C)
	return decision_made