/obj/hud/button/floor_object
	name = "floor object"
	var/atom/associated_object //set before the object is initialized
	var/atom/associated_loc //set before the object is initialized

	icon_state = "square"
	screen_loc = "CENTER,CENTER"

	plane = PLANE_HUD_OBJ

/obj/hud/button/floor_object/Destroy()
	if(associated_object)
		HOOK_REMOVE("post_move","floor_object_post_move_\ref[src]",associated_object)
		associated_object = null
	return ..()

/obj/hud/button/floor_object/proc/assoc_object_post_move()
	if(associated_object && associated_loc != associated_object.loc)
		HOOK_REMOVE("post_move","floor_object_post_move_\ref[src]",associated_object)
		associated_object = null
		update_sprite()
		return TRUE
	return TRUE

/obj/hud/button/floor_object/update_owner()

	var/mob/previous_owner = owner

	. = ..()

	if(previous_owner && previous_owner != owner)
		previous_owner.examine_butons -= src

	if(. && owner)
		owner.examine_butons += src
		if(!associated_object)
			log_error("Warning: [get_debug_name()] didn't have an associated object on initialization!")
			return FALSE
		HOOK_ADD("post_move","floor_object_post_move_\ref[src]",associated_object,src,.proc/assoc_object_post_move)

	return .


/obj/hud/button/floor_object/update_sprite()

	vis_contents.Cut()

	. = ..()

	if(!associated_object)
		name = "missing object"
		color = "#888888"
	else
		color = "#FFFFFF"
		name = associated_object.name

	vis_contents |= associated_object

	return .

/obj/hud/button/floor_object/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	if(associated_object)
		return object.click_on_object(caller,associated_object,location,control,params)
	return ..()