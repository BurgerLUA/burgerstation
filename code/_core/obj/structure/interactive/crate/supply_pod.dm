/obj/structure/interactive/crate/closet/supply_pod
	name = "supply pod"
	icon = 'icons/obj/structure/supply_pods.dmi'
	icon_state = "supplypod"

	collect_contents_on_initialize = FALSE
	can_interact_with = FALSE
	anchored = TRUE

	var/transit = FALSE

	pixel_x = -16

/obj/structure/interactive/crate/closet/supply_pod/PostInitialize()

	. = ..()

	update_sprite()

	if(!open)
		play('sound/effects/mortar_long_whistle.ogg',get_turf(src),range_max = VIEW_RANGE * 2)
		pixel_z = TILE_SIZE*VIEW_RANGE*4
		pixel_w = TILE_SIZE*VIEW_RANGE*0.5
		animate(src, pixel_z = 0, pixel_w = 0,time = SECONDS_TO_DECISECONDS(2))
		CALLBACK("\ref[src]_pod_land",SECONDS_TO_DECISECONDS(2),src,.proc/land)
		CALLBACK("\ref[src]_pod_open",SECONDS_TO_DECISECONDS(6),src,.proc/open)

	return .

/obj/structure/interactive/crate/closet/supply_pod/proc/land()
	explode(get_turf(src),1,src,src)
	return TRUE

/obj/structure/interactive/crate/closet/supply_pod/open(var/mob/caller)

	. = ..()

	if(.)
		play('sound/meme/tada.ogg',get_turf(src),range_max = VIEW_RANGE * 2)

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