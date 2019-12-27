obj/structure/interactive/blocker
	name = "blocker"
	icon = 'icons/invisible.dmi'
	icon_state = "0"
	var/obj/structure/owned_object
	mouse_opacity = 0

obj/structure/interactive/blocker/New(var/desired_loc,var/obj/structure/desired_owned_object)

	owned_object = desired_owned_object

	collision_flags = owned_object.collision_flags
	collision_bullet_flags = owned_object.collision_bullet_flags

	density_north = owned_object.density_north
	density_south = owned_object.density_south
	density_east  = owned_object.density_east
	density_west  = owned_object.density_west

	return ..()