/obj/item/device/proximity
	name = "proximity sensor"
	desc = "Tick tock."
	desc_extended = "A simple proximity sensor triggers when any living creature in a 2 unit radius enters its sphere. Has a set delay."
	icon_state = "motion"

	var/time_set = 50
	var/time_min = 0
	var/time_max = 300

	var/spam_fix_time = 0

	var/mob/last_caller = null

	value = 20

/obj/item/device/proximity/Destroy()
	last_caller = null
	return ..()

/obj/item/device/proximity/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("time_set")
	return .

/obj/item/device/proximity/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("time_set")
	return .

/obj/item/device/proximity/click_self(var/mob/caller)
	INTERACT_CHECK
	SPAM_CHECK(5)
	trigger(caller,src,-1,-1)
	return TRUE

/obj/item/device/proximity/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)
	last_caller = caller
	start_thinking(src)
	active = TRUE
	var/turf/T = get_turf(src)
	play_sound('sound/weapons/timer/arm.ogg',T,range_max=VIEW_RANGE*0.5)
	create_alert(VIEW_RANGE,T,last_interacted,ALERT_LEVEL_NOISE)
	return ..()

/obj/item/device/proximity/think()

	. = ..()

	if(active)

		time_set -= 1

		if(time_set >= 0 && (time_set % clamp( FLOOR(1 + (time_set/10),1) ,1,30)) == 0)
			var/turf/T = get_turf(src)
			if(T)
				play_sound('sound/weapons/timer/beep.ogg',T,range_max=VIEW_RANGE*0.25)
				create_alert(VIEW_RANGE,T,last_interacted,ALERT_LEVEL_NOISE)

		if(time_set < 0 && !(time_set % 10))
			for(var/mob/living/L in view(get_turf(src),2))
				loc.trigger(last_interacted,src,-1,-1)
				play_sound('sound/weapons/timer/beep.ogg',get_turf(src),range_max=VIEW_RANGE*0.5)
				flick("motion_trigger",src)
				break

	return active

/obj/item/device/proximity/mouse_wheel_on_object(var/mob/caller,delta_x,delta_y,location,control,params)

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