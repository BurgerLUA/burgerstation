/obj/structure/interactive/vendor/
	name = "vending machine"
	desc = "Vends things!"
	icon = 'icons/obj/structure/vending.dmi'
	icon_state = "generic"
	desc_extended = "You can use this to purchase things that are always in stock."

	var/obj/item/stored_objects = list()

	density_north = FALSE
	density_south = FALSE
	density_east  = FALSE
	density_west  = FALSE

/obj/structure/interactive/vendor/Initialize()

	var/turf/T = get_turf(src)

	for(var/obj/item/I in T.contents)
		stored_objects += I
		I.force_move(src)

	return ..()


/obj/structure/interactive/vendor/clicked_on_by_object(var/mob/caller,object,location,control,params)

	INTERACT_CHECK

	if(!is_player(caller))
		return ..()

	var/mob/living/advanced/player/P = caller

	P.set_structure_active(src)

	return ..()


/obj/structure/interactive/vendor/proc/show_buttons_to(var/mob/living/advanced/A)

	var/vending_size = length(stored_objects)

	for(var/i=1,i<=vending_size,i++)
		var/obj/item/I = stored_objects[i]
		var/obj/hud/button/vendor/V = new
		V.associated_item = I
		V.screen_loc = "CENTER-4,CENTER-0.5-[vending_size*0.5]+[i]"
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