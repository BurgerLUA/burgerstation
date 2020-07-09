obj/structure/interactive/bed
	name = "bed"
	desc = "What does it do?"
	icon = 'icons/obj/structure/bed.dmi'
	icon_state = "bed"
	var/secondary_color = "#FF0000"

	var/pixel_offset_x = 0
	var/pixel_offset_y = 0

	layer = LAYER_MOB_BELOW
	var/opened_time = 0

	bullet_block_chance = 50

	interaction_flags = FLAG_INTERACTION_LIVING

/obj/structure/interactive/bed/buckle(var/mob/living/victim,var/mob/caller,var/silent=FALSE)

	. = ..()

	if(.)
		victim.add_status_effect(REST,-1,-1)
		victim.pixel_x = pixel_offset_x
		victim.pixel_y = pixel_offset_y

	return .

/obj/structure/interactive/bed/unbuckle(var/mob/caller,var/silent=FALSE)

	var/mob/living/L = buckled

	. = ..()

	if(.)
		L.remove_status_effect(REST)
		animate(L,pixel_x = initial(L.pixel_x), pixel_y = initial(L.pixel_y),time = 5)

	return .

obj/structure/interactive/bed/clicked_on_by_object(var/mob/caller,object,location,control,params)

	INTERACT_CHECK

	if(buckled)
		unbuckle(caller)
		return TRUE

	var/mob/living/L
	for(var/mob/living/L2 in contents)
		if(istype(L2,/mob/living/advanced/stand))
			continue
		L = L2
		break

	if(L)
		buckle(L,caller)
		return TRUE

	return FALSE

obj/structure/interactive/bed/PostInitialize()
	. = ..()
	update_sprite()
	return .

obj/structure/interactive/bed/padded
	name = "padded bed"


obj/structure/interactive/bed/padded/update_overlays()

	. = ..()

	var/image/sheets = new(icon,"bed_padding")
	sheets.color = secondary_color
	add_overlay(sheets)

	return .

/*

obj/structure/interactive/bed/padded/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new(icon,icon_state)
	var/icon/I2 = new(icon,"bed_padding")

	I.Blend(I2,ICON_OVERLAY)

	icon = I
*/

