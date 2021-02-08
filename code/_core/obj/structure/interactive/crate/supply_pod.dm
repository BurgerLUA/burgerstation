/obj/structure/interactive/crate/closet/supply_pod
	name = "supply pod"
	icon = 'icons/obj/structure/supply_pods.dmi'
	icon_state = "supplypod"

	collect_contents_on_initialize = FALSE

	interaction_flags = FLAG_INTERACTION_LIVING

	anchored = TRUE

	var/transit = FALSE

	pixel_x = -16

	var/auto_open = TRUE

/obj/structure/interactive/crate/closet/supply_pod/PostInitialize()

	. = ..()

	update_sprite()

	if(!open)
		play_sound('sound/effects/mortar_long_whistle.ogg',get_turf(src),range_min = VIEW_RANGE*0.5,range_max = VIEW_RANGE * 2)
		create_alert(VIEW_RANGE,src.loc,src,ALERT_LEVEL_NOISE)
		pixel_z = TILE_SIZE*VIEW_RANGE*4
		pixel_w = TILE_SIZE*VIEW_RANGE*0.5
		animate(src, pixel_z = 0, pixel_w = 0,time = SECONDS_TO_DECISECONDS(2))
		CALLBACK("pod_land_\ref[src]",SECONDS_TO_DECISECONDS(2),src,.proc/land)
		if(auto_open)
			CALLBACK("pod_open_\ref[src]",SECONDS_TO_DECISECONDS(6),src,.proc/open)

	return .

/obj/structure/interactive/crate/closet/supply_pod/proc/land()
	//explode(get_turf(src),1,src,src)
	return TRUE

/obj/structure/interactive/crate/closet/supply_pod/close(var/mob/caller)

	if(caller && auto_open)
		return FALSE

	return ..()

/obj/structure/interactive/crate/closet/supply_pod/open(var/mob/caller)

	if(caller && auto_open)
		return FALSE

	. = ..()

	if(. && auto_open)
		play_sound('sound/meme/tada.ogg',get_turf(src),range_max = VIEW_RANGE)

	queue_delete(src,ITEM_DELETION_TIME_DROPPED,TRUE)

	return .


/obj/structure/interactive/crate/closet/supply_pod/update_icon()
	. = ..()
	icon_state = initial(icon_state)
	if(transit)
		icon_state = "[icon_state]_falling"
	return .

/obj/structure/interactive/crate/closet/supply_pod/update_overlays()
	. = ..()
	if(!transit)
		var/image/I = new/image(icon,"[icon_state]_[open ? "open" : "closed"]")
		add_overlay(I)
	return .

/obj/structure/interactive/crate/closet/supply_pod/bluespace
	name = "bluespace supply pod"
	icon_state = "bluespacepod"

/obj/structure/interactive/crate/closet/supply_pod/centcomm
	name = "centcomm supply pod"
	icon_state = "centcommpod"

/obj/structure/interactive/crate/closet/supply_pod/syndicate
	name = "syndicate supply pod"
	icon_state = "syndiepod"

/obj/structure/interactive/crate/closet/supply_pod/stray
	name = "stray supply pod"
	icon_state = "squadpod"
	auto_open = FALSE