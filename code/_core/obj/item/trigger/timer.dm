/obj/item/device/timer
	name = "timer"
	desc = "Tick tock."
	desc_extended = "A simple timer. Can be used to build totally innocuous and non-explosive things."
	icon_state = "timer"

	var/time_set = 50
	var/time_min = 0
	var/time_max = 300

	var/spam_fix_time = 0

	var/mob/last_activator = null

	value = 20

/obj/item/device/timer/Destroy()
	last_activator = null
	return ..()

/obj/item/device/timer/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("time_set")

/obj/item/device/timer/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("time_set")

/obj/item/device/timer/click_self(var/mob/activator,location,control,params)
	INTERACT_CHECK
	SPAM_CHECK(5)
	trigger(activator,src,-1,-1)
	return TRUE

/obj/item/device/timer/trigger(var/mob/activator,var/atom/source,var/signal_freq,var/signal_code)
	last_activator = activator
	START_THINKING(src)
	active = TRUE
	var/turf/T = get_turf(src)
	play_sound('sound/items/timer/arm.ogg',T,range_max=VIEW_RANGE)
	create_alert(VIEW_RANGE,T,activator,ALERT_LEVEL_NOISE)
	return ..()

/obj/item/device/timer/think()

	. = ..()

	if(. && active)

		time_set -= 1

		if( (time_set % clamp( FLOOR(1 + (time_set/10),1) ,1,30)) == 0)
			var/turf/T = get_turf(src)
			if(T)
				play_sound('sound/items/timer/beep.ogg',T,range_max=VIEW_RANGE)

		if(time_set <= 0)
			if(loc)
				loc.trigger(last_interacted,src,-1,-1)
			active = FALSE
			time_set = 0
			return FALSE


/obj/item/device/timer/mouse_wheel_on_object(var/mob/activator,delta_x,delta_y,location,control,params)

	var/fixed_delta = clamp(delta_y,-1,1)

	if(time_set >= 15)
		fixed_delta = round(fixed_delta*5,5)
	else if(time_set >= 60)
		fixed_delta = round(fixed_delta*10,10)
	else if(time_set >= 120)
		fixed_delta = round(fixed_delta*10,30)

	var/old_time_set = time_set

	time_set = clamp(time_set + fixed_delta,time_min,time_max)

	if(old_time_set == time_set)
		activator.to_chat(span("notice","\The [src.name] can't seem to go any [time_set == time_min ? "lower" : "higher"]."))
	else if(spam_fix_time <= world.time)
		activator.to_chat(span("notice","You change \the [src.name]'s time to [time_set] deciseconds..."))
	else
		activator.to_chat(span("notice","...[time_set] deciseconds..."))

	spam_fix_time = world.time + 20

	return TRUE