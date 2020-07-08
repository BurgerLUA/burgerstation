/obj/structure/interactive/ore_box
	name = "ore box"
	desc = "A crate for moving and storing ores"
	icon = 'icons/obj/structure/ore_box.dmi'
	icon_state = "ore_box"

	anchored = FALSE
	collision_flags = FLAG_COLLISION_WALL

	bullet_block_chance = 75

/obj/structure/interactive/ore_box/clicked_on_by_object(var/mob/caller,object,location,control,params)

	INTERACT_CHECK

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


/obj/structure/interactive/ore_box/get_examine_list(var/mob/examiner)

	. = ..()

	. += div("notice","The counter shows [length(contents)] objects inside.")

	return .