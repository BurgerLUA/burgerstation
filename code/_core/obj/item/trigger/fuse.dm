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

/obj/item/device/fuse/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE)
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
	START_THINKING(src)
	active = TRUE
	var/turf/T = get_turf(src)
	play_sound('sound/items/fuse_start.ogg',T,range_max=VIEW_RANGE)
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

/obj/item/device/fuse/hehe
	name = "hehe fuse"

	value_burgerbux = 1

	var/sound_played = FALSE

/obj/item/device/fuse/hehe/think()
	. = ..()
	if(. && active && !sound_played && time_set <= 8)
		play_sound('sound/meme/hehe.ogg',get_turf(src),range_max=VIEW_RANGE)
		sound_played = TRUE
