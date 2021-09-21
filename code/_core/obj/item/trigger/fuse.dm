/obj/item/device/fuse
	name = "fuse"
	desc = "Like in the cartoons."
	desc_extended = "A simple fuse. Can be used to build totally innocuous and non-explosive things. Non-electronic, and silent."
	icon_state = "timer"

	var/time_set = 50
	var/time_min = 0
	var/time_max = 300

	var/spam_fix_time = 0

	var/mob/last_caller = null

	value = 0

/obj/item/device/fuse/Destroy()
	last_caller = null
	return ..()

/obj/item/device/fuse/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEVAR("time_set")

/obj/item/device/fuse/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("time_set")

/obj/item/device/fuse/click_self(var/mob/caller)
	INTERACT_CHECK
	SPAM_CHECK(5)
	trigger(caller,src,-1,-1)
	return TRUE

/obj/item/device/fuse/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)
	last_caller = caller
	start_thinking(src)
	active = TRUE
	var/turf/T = get_turf(src)
	play_sound('sound/items/fuse_start.ogg',T,range_max=VIEW_RANGE*0.5)
	create_alert(VIEW_RANGE,T,src,ALERT_LEVEL_NOISE)
	return ..()

/obj/item/device/fuse/think()
	. = ..()
	if(. && active)
		time_set -= 1
		if(time_set <= 0)
			if(loc)
				loc.trigger(last_interacted,src,-1,-1)
			active = FALSE
			time_set = 0
			return FALSE