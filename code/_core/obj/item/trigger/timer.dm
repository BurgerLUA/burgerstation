/obj/item/device/timer
	name = "timer"
	icon_state = "timer"

	var/time_set = 50
	var/time_min = 0
	var/time_max = 300

	var/active = FALSE

	var/spam_fix_time = 0

/obj/item/device/timer/click_self(var/mob/caller)
	trigger(caller,src,-1,-1)
	return TRUE

/obj/item/device/timer/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)
	start_thinking(src)
	active = TRUE
	var/turf/T = get_turf(src)
	var/area/A = T.loc
	play_sound('sounds/weapons/timer/arm.ogg',get_mobs_in_range(T,VIEW_RANGE),list(T.x,T.y,T.z),volume=50, environment = A.sound_environment, alert=ALERT_LEVEL_NOISE)
	return ..()

/obj/item/device/timer/think()
	. = ..()
	if(active)
		time_set -= 1

		if( (time_set % clamp( FLOOR(1 + (time_set/10),1) ,1,30)) == 0)
			var/turf/T = get_turf(src)
			if(T)
				var/area/A = T.loc
				play_sound('sounds/weapons/timer/beep.ogg',get_mobs_in_range(T,VIEW_RANGE),list(T.x,T.y,T.z),volume=50, environment = A.sound_environment, alert=ALERT_LEVEL_NOISE)

		if(time_set <= 0)
			if(loc)
				loc.trigger(last_interacted,src,-1,-1)
			active = FALSE
			time_set = 0
			return FALSE
	return .

/obj/item/device/timer/on_mouse_wheel(var/mob/caller,delta_x,delta_y,location,control,params)

	var/fixed_delta = delta_y ? 1 : -1

	if(time_set >= 15)
		fixed_delta = round(fixed_delta*5,5)
	else if(time_set >= 60)
		fixed_delta = round(fixed_delta*10,10)
	else if(time_set >= 120)
		fixed_delta = round(fixed_delta*10,30)

	var/old_time_set = time_set

	time_set = clamp(time_set + fixed_delta,time_min,time_max)

	if(old_time_set == time_set)
		caller.to_chat(span("notice","\The [src.name] can't seem to go any [time_set == time_min ? "lower" : "higher"]."))
	else if(spam_fix_time <= world.time)
		caller.to_chat(span("notice","You change \the [src.name]'s time to [time_set] deciseconds..."))
	else
		caller.to_chat(span("notice","...[time_set] deciseconds..."))

	spam_fix_time = world.time + 20

	return TRUE