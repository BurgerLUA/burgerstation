/mob/living/advanced/player/proc/set_squad(var/squad/S)

	if(S == current_squad)
		return FALSE

	current_squad = S

	add_squad_buttons()

	return TRUE

/mob/living/advanced/player/proc/unset_squad()

	if(!current_squad)
		return FALSE

	remove_squad_buttons()

	current_squad = null

	return TRUE


/mob/living/advanced/player/proc/add_squad_button(var/mob/living/advanced/player/P)

	for(var/obj/hud/button/squad/member/B in buttons)
		if(B.tracked_mob == P)
			return FALSE

	var/obj/hud/button/squad/member/B = new(null,P)
	B.update_owner(src)

	return TRUE

/mob/living/advanced/player/proc/remove_squad_button(var/mob/living/advanced/player/P)

	for(var/obj/hud/button/squad/member/B in buttons)
		if(B.tracked_mob == P)
			remove_button(B)

	return TRUE

/mob/living/advanced/player/proc/update_squad_buttons()

	var/count = 0

	for(var/obj/hud/button/squad/member/B in buttons)
		B.screen_loc = "LEFT,TOP-2.25-[count]"
		B.update_sprite()
		count++

	return TRUE

/mob/living/advanced/player/proc/add_squad_buttons()

	if(!current_squad)
		return FALSE

	if(current_squad.leader)
		add_squad_button(current_squad.leader)

	for(var/k in current_squad.members)
		var/mob/living/advanced/player/P = k
		add_squad_button(P)

	update_squad_buttons()

	return TRUE

/mob/living/advanced/player/proc/remove_squad_buttons()

	for(var/obj/hud/button/squad/member/B in buttons)
		remove_button(B)

	return TRUE