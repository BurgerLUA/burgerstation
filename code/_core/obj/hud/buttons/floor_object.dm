/obj/hud/button/floor_object
	name = "floor object"
	var/atom/associated_object //set before the object is initialized
	var/atom/associated_loc //set before the object is initialized

	icon_state = "square"
	screen_loc = "CENTER,CENTER"

	plane = PLANE_HUD_OBJ
	layer = -100

/obj/hud/button/floor_object/PreDestroy()
	if(associated_object)
		HOOK_REMOVE("post_move","floor_object_post_move_\ref[src]",associated_object)
		associated_object = null
	. = ..()

/obj/hud/button/floor_object/Destroy()
	associated_loc = null
	. = ..()

/obj/hud/button/floor_object/proc/assoc_object_post_move()
	if(associated_object && associated_loc != associated_object.loc)
		HOOK_REMOVE("post_move","floor_object_post_move_\ref[src]",associated_object)
		associated_object = null
		update_sprite()
	return TRUE

/obj/hud/button/floor_object/update_owner(var/mob/desired_owner)

	var/owner_changed = owner != desired_owner

	if(owner_changed && owner)
		owner.examine_butons -= src

	. = ..()

	if(owner_changed && owner)
		owner.examine_butons += src
		if(!associated_object)
			log_error("Warning: [get_debug_name()] didn't have an associated object on initialization!")
			return FALSE
		HOOK_ADD("post_move","floor_object_post_move_\ref[src]",associated_object,src,src::assoc_object_post_move())


/obj/hud/button/floor_object/update_sprite()

	vis_contents.Cut()

	. = ..()

	if(!associated_object)
		name = "missing object"
		color = "#888888"
		desc_extended = initial(desc_extended)
	else
		color = "#FFFFFF"
		name = associated_object.name
		desc_extended = associated_object.desc_extended

	tooltip_text = initial(tooltip_text)
	if(!tooltip_text)
		tooltip_text = generate_tooltip_text()

	vis_contents += associated_object


/obj/hud/button/floor_object/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)
	if(associated_object)
		return object.click_on_object(activator,associated_object,location,control,params)
	return ..()