/obj/structure/interactive/dont_look
	name = "made you look"
	desc = "Nice."
	desc_extended = "Uh oh."
	icon = 'icons/obj/item/meme.dmi'
	icon_state = "lol"

/obj/structure/interactive/dont_look/Finalize()
	. = ..()
	CALLBACK("\ref[src]_look_delete",SECONDS_TO_DECISECONDS(60),src,.proc/callback_delete)
	if(isturf(loc))
		start_thinking(src)

/obj/structure/interactive/dont_look/proc/callback_delete()
	qdel(src)
	return TRUE

/obj/structure/interactive/dont_look/think()
	if(!isturf(loc))
		..()
		return FALSE
	check_look() //I mean, it's an admin item. Who care if it's intensive?
	. = ..()

/obj/structure/interactive/dont_look/post_move(var/atom/old_loc)
	. = ..()
	if(isturf(loc) && !isturf(old_loc))
		start_thinking(src)

/obj/structure/interactive/dont_look/proc/do_explode()
	var/turf/T = get_turf(src)
	explode(T,100,T,T,"God")
	qdel(src)
	return TRUE

/obj/structure/interactive/dont_look/proc/check_look()

	if(CALLBACK_EXISTS("\ref[src]_do_explode"))
		return FALSE

	var/found_viewers = 0

	for(var/mob/living/L in viewers(VIEW_RANGE,get_turf(src)))
		if(L.dead)
			continue
		L.visible_message("<b>\The [L.name]</b> looked!")
		L.do_emote("scream")
		found_viewers += 1

	if(found_viewers > 0)
		CALLBACK("\ref[src]_do_explode",SECONDS_TO_DECISECONDS(1),src,.proc/do_explode)
		return TRUE

	return FALSE