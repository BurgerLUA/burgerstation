/obj/structure/interactive/ore_box
	name = "ore box"
	icon = 'icons/obj/structure/ore_box.dmi'
	icon_state = "ore_box"

	anchored = FALSE
	collision_flags = FLAG_COLLISION_REAL

/obj/structure/interactive/ore_box/Initialize()
	SShorde.possible_horde_targets += src
	return ..()

/obj/structure/interactive/ore_box/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(istype(object,/obj/item/material/ore))
		var/obj/item/material/ore/O = object
		O.drop_item(src.loc)
		O.force_move(src)
		return TRUE

	return ..()

/obj/structure/interactive/ore_box/Cross(var/atom/movable/O)

	if(istype(O,/obj/item/material/ore/))
		var/obj/item/material/ore/I = O
		I.force_move(src)
		return TRUE

	return ..()


/obj/structure/interactive/ore_box/get_examine_text(var/mob/examiner)

	. = ..()

	. += div("notice","The counter shows [length(contents)] objects inside.")

	return .