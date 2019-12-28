/obj/structure/interactive/vendor/
	name = "vending machine"
	desc = "Vends things!"
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "generic"
	desc_extended = "You can use this to purchase things that are always in stock."

	var/obj/item/stored_objects = list()
	var/obj/item/stored_types = list()

	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	density_north = TRUE
	density_south = TRUE
	density_east  = TRUE
	density_west  = TRUE

/obj/structure/interactive/vendor/Initialize()

	var/turf/T = get_turf(src)

	for(var/obj/item/I in T.contents)
		I.on_spawn()
		stored_objects += I
		I.force_move(src)
		I.update_icon()
		I.plane = PLANE_HUD_OBJ
		I.pixel_y = 4

	return ..()

/obj/structure/interactive/vendor/clicked_on_by_object(var/mob/caller,object,location,control,params)

	INTERACT_CHECK

	if(!is_player(caller))
		return ..()

	var/mob/living/advanced/player/P = caller

	if(P.active_structure == src)
		P.set_structure_unactive()
	else
		P.set_structure_active(src)

	return ..()


/obj/structure/interactive/vendor/proc/show_buttons_to(var/mob/living/advanced/A)

	var/stored_objects_length = length(stored_objects)
	var/stored_types_length = length(stored_types)

	for(var/i=1,i<=stored_objects_length,i++)
		var/obj/item/I = stored_objects[i]
		var/obj/hud/button/vendor/V = new
		V.associated_item = I
		V.screen_loc = "CENTER+2,CENTER-0.5-[(stored_objects_length+stored_types_length)*0.5]+[i]"
		V.update_owner(A)
		V.update_icon()

	for(var/i=1,i<=stored_types_length,i++)
		var/obj/item/I = stored_types[i]
		var/obj/hud/button/vendor/V = new
		V.associated_item = I
		V.screen_loc = "CENTER+2,CENTER-0.5-[(stored_objects_length+stored_types_length)*0.5]+[i+stored_objects_length]"
		V.update_owner(A)
		V.update_icon()

/obj/structure/interactive/vendor/proc/hide_buttons_from(var/mob/living/advanced/A)
	for(var/obj/hud/button/vendor/V in A.buttons)
		V.update_owner(null)

/obj/structure/interactive/vendor/on_active(var/mob/living/advanced/player/P)
	show_buttons_to(P)
	return ..()

/obj/structure/interactive/vendor/on_inactive(var/mob/living/advanced/player/P)
	hide_buttons_from(P)
	return ..()