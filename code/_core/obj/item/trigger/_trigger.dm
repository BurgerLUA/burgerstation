/obj/item/trigger
	name = "trigger assembly"
	icon = 'icons/obj/items/trigger.dmi'

/obj/item/trigger/timer
	name = "timer"
	icon_state = "timer"
	var/time_set = 5
	var/time_left = 0
	var/active = FALSE

/obj/item/trigger/timer/click_self(var/mob/caller)
	trigger(caller,-1,-1)
	return TRUE

/obj/item/trigger/timer/trigger(var/atom/source,var/signal_freq,var/signal_code)

	time_left = time_set
	if(!(src in all_thinkers))
		all_thinkers += src

	thinks = TRUE
	active = TRUE

/obj/item/trigger/timer/think()

	. = ..()

	if(active)
		time_left--
		var/turf/T = get_turf(src)
		T.visible_message(span("warning","The grenade beeps, \"[time_left]\""))
		if(time_left <= 0)
			if(loc)
				loc.trigger(src,-1,-1)
			active = FALSE
			thinks = FALSE
			return FALSE

	return .


/obj/item/trigger/timer/on_mouse_wheel(var/mob/caller,delta_x,delta_y,location,control,params)

	var/fixed_delta = round(Clamp(delta_y,-1,1))

	if(time_set > 15)
		fixed_delta = round(fixed_delta*5,5)
	else if(time_set > 60)
		fixed_delta = round(fixed_delta*10,10)
	else if(time_set > 120)
		fixed_delta = round(fixed_delta*10,30)

	time_set = Clamp(time_set + fixed_delta,1,60)

	return TRUE