obj/structure/interactive/blocker //TODO: What the fuck uses this?
	name = "blocker"
	icon = 'icons/invisible.dmi'
	icon_state = "0"
	var/obj/structure/owned_object
	mouse_opacity = 0

	density = TRUE

obj/structure/interactive/blocker/New(var/desired_loc,var/obj/structure/desired_owned_object)

	owned_object = desired_owned_object
	collision_dir = owned_object.collision_dir

	update_collisions(owned_object.collision_flags,owned_object.collision_bullet_flags,collision_dir)

	return ..()