obj/structure/interactive/bed
	name = "bed"
	desc = "What does it do?"
	icon = 'icons/obj/structure/bed.dmi'
	icon_state = "bed"
	var/secondary_color = "#FF0000"

	var/pixel_offset_x = 0
	var/pixel_offset_y = 0

	plane = PLANE_MOVABLE_DEAD
	layer = LAYER_MOB_BELOW

	var/opened_time = 0

	bullet_block_chance = 50

	interaction_flags = FLAG_INTERACTION_LIVING

	pixel_y = 4

	density = TRUE

/obj/structure/interactive/bed/Crossed(atom/movable/O,atom/OldLoc)
	. = ..()
	if(src.z && is_living(O))
		var/mob/living/L = O
		if(L.horizontal)
			var/found = FALSE
			for(var/mob/living/L2 in loc.contents)
				if(L == L2)
					continue
				if(!L2.horizontal)
					continue
				L2.add_disease(/disease/hrp)
				found = TRUE
			if(found)
				L.add_disease(/disease/hrp)

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


/obj/structure/interactive/bed/double
	name = "double bed"
	icon_state = "bed_double"


/obj/structure/interactive/bed/double/Generate()
	. = ..()
	icon_state = "bed_double_top"
	pixel_offset_y = 20
	var/obj/structure/interactive/bed/B = new(src.loc)
	B.icon_state = "bed_double_bottom"
	INITIALIZE(B)
	GENERATE(B)
	FINALIZE(B)

/obj/structure/interactive/bed/double/sheet/Generate()
	. = ..()
	var/obj/item/bedsheet/S = new(src.loc)
	S.icon_state = "sheetwhite_double"
	INITIALIZE(S)
	GENERATE(S)
	FINALIZE(S)