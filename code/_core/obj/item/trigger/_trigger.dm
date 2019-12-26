/obj/item/trigger_mechanism
	name = "trigger assembly"
	icon = 'icons/obj/items/trigger.dmi'

/obj/item/trigger_mechanism/timer
	name = "timer"
	icon_state = "timer"

	var/time_set = 50
	var/time_min = 0
	var/time_max = 300

	var/active = FALSE

	var/spam_fix_time = 0

/obj/item/trigger_mechanism/timer/click_self(var/mob/caller)
	trigger(caller,src,-1,-1)
	return TRUE

/obj/item/trigger_mechanism/timer/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)
	start_thinking(src)
	active = TRUE
	return ..()

/obj/item/trigger_mechanism/timer/think()

	. = ..()

	if(active)
		time_set -= 1
		if(time_set <= 0)
			if(loc)
				loc.trigger(last_interacted,src,-1,-1)
			active = FALSE
			time_set = 0
			return FALSE

	return .


/obj/item/trigger_mechanism/timer/on_mouse_wheel(var/mob/caller,delta_x,delta_y,location,control,params)

	var/fixed_delta = round(Clamp(delta_y,-1,1))

	if(time_set >= 15)
		fixed_delta = round(fixed_delta*5,5)
	else if(time_set >= 60)
		fixed_delta = round(fixed_delta*10,10)
	else if(time_set >= 120)
		fixed_delta = round(fixed_delta*10,30)

	var/old_time_set = time_set

	time_set = Clamp(time_set + fixed_delta,time_min,time_max)

	if(old_time_set == time_set)
		caller.to_chat(span("notice","The timer can't seem to go any [time_set == time_min ? "lower" : "higher"]."))
	else if(spam_fix_time <= curtime)
		caller.to_chat(span("notice","You change \the [src.name]'s time to [time_set] deciseconds..."))
	else
		caller.to_chat(span("notice","...[time_set] deciseconds..."))

	spam_fix_time = curtime + 20

	return TRUE