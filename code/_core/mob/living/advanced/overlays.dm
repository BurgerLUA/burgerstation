mob/living/advanced/proc/add_overlay(var/obj/object,var/desired_layer,var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_additional_blends,var/desired_never_blend = FALSE, var/desired_no_initial = FALSE, var/desired_pixel_x = 0, var/desired_pixel_y = 0)
	var/obj/overlay/O = new /obj/overlay
	O.attached_object = object
	O.initial_icon = desired_icon ? desired_icon : object.icon
	O.initial_icon_state = desired_icon_state ? desired_icon_state : object.icon_state
	O.layer = desired_layer ? desired_layer : object.layer
	O.plane = src.plane
	O.icon = desired_icon ? desired_icon : object.icon
	O.icon_state = desired_icon_state ? desired_icon_state : object.icon_state
	O.color = desired_color ? desired_color : object.color
	O.never_blend = desired_never_blend
	O.no_initial = desired_no_initial
	O.pixel_x = desired_pixel_x
	O.pixel_y = desired_pixel_y
	if(!desired_never_blend)
		O.additional_blends = desired_additional_blends ? desired_additional_blends : object.additional_blends
	O.update_icon()
	add_overlay_image(O)

mob/living/advanced/proc/show_overlay(var/obj/object,var/show=TRUE)


	for(var/obj/overlay/O in overlays_assoc)
		if(O.attached_object != object)
			continue
		update_overlay_direct(O,desired_alpha= show ? 255 : 0)

	return TRUE

mob/living/advanced/proc/remove_overlay(var/atom/A)
	for(var/obj/overlay/O in overlays_assoc)
		if(O.attached_object != A)
			continue
		remove_overlay_image(O)
		qdel(O)

mob/living/advanced/proc/update_overlay(var/atom/A,var/desired_layer,var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_additional_blends,var/desired_pixel_x=0,var/desired_pixel_y=0)

	for(var/obj/overlay/O in overlays_assoc)
		if(O.attached_object != A)
			continue
		update_overlay_direct(O,desired_layer,desired_icon,desired_icon_state,desired_color,desired_additional_blends,desired_pixel_x,desired_pixel_y)
		return TRUE

	return FALSE

var/global/meme_count = 0

mob/living/advanced/proc/update_all_blends()
	for(var/obj/overlay/O in overlays_assoc)
		update_overlay_direct(O)

/*
mob/living/advanced/player/verb/debug_blends()
	for(var/obj/overlay/O in overlays_assoc)
		src << "[O.name]: [O.layer]"
		if(length(O.additional_blends))
			src<< "    Additional Blends:"
			for(var/id in O.additional_blends)
				src << "        [id]: [O.additional_blends[id].layer] [O.additional_blends[id].icon] [O.additional_blends[id].icon_state]"
*/


mob/living/advanced/proc/add_overlay_image(var/obj/overlay/O)
	var/image/I = new /image(O.icon)
	I.appearance = O.appearance
	overlays += I
	overlays_assoc[O] = I

mob/living/advanced/proc/remove_overlay_image(var/obj/overlay/O)
	var/image/I = overlays_assoc[O]
	overlays -= I
	overlays_assoc -= O
	qdel(I)

mob/living/advanced/proc/update_overlay_direct(var/obj/overlay/O,var/desired_layer,var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_additional_blends,var/desired_pixel_x=0,var/desired_pixel_y=0,var/desired_alpha=255)

	remove_overlay_image(O)

	if(desired_layer)
		O.layer = desired_layer
	if(desired_icon)
		O.icon = desired_icon
		O.initial_icon = desired_icon
	if(desired_icon_state)
		O.icon_state = desired_icon_state
		O.initial_icon_state = desired_icon_state
	if(desired_color)
		O.color = desired_color
	if(desired_additional_blends)
		O.additional_blends = desired_additional_blends

	O.pixel_x = desired_pixel_x
	O.pixel_y = desired_pixel_y
	O.alpha = desired_alpha
	O.update_icon()

	add_overlay_image(O)