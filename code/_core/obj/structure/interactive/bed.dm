obj/structure/interactive/bed
	name = "bed"
	desc = "What does it do?"
	icon = 'icons/obj/structure/bed.dmi'
	icon_state = "bed"
	var/secondary_color = "#FF0000"

	var/pixel_offset_x = 0
	var/pixel_offset_y = 0

	plane = PLANE_MOB_STEALTH
	layer = 0
	var/opened_time = 0

	bullet_block_chance = 50

	interaction_flags = FLAG_INTERACTION_LIVING

	pixel_y = 4

/obj/structure/interactive/bed/buckle(var/mob/living/victim,var/mob/caller,var/silent=FALSE)

	. = ..()

	if(.)
		victim.add_status_effect(REST,-1,-1)
		victim.pixel_x = pixel_offset_x
		victim.pixel_y = pixel_offset_y

/obj/structure/interactive/bed/unbuckle(var/mob/caller,var/silent=FALSE)

	var/mob/living/L = buckled

	. = ..()

	if(.)
		L.remove_status_effect(REST)
		animate(L,pixel_x = initial(L.pixel_x), pixel_y = initial(L.pixel_y),time = 5)


obj/structure/interactive/bed/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(buckled)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		unbuckle(caller)
		return TRUE

	var/mob/living/L
	for(var/mob/living/L2 in contents)
		if(istype(L2,/mob/living/advanced/stand))
			continue
		L = L2
		break

	if(L)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		buckle(L,caller)
		return TRUE

	return FALSE

obj/structure/interactive/bed/Finalize()
	. = ..()
	update_sprite()

obj/structure/interactive/bed/sheet/Generate()
	. = ..()
	var/obj/item/bedsheet/S = new(src.loc)
	INITIALIZE(S)
	GENERATE(S)
	FINALIZE(S)