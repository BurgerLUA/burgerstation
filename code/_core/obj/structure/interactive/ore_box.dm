/obj/structure/interactive/ore_box
	name = "ore box"
	desc = "A crate for moving and storing ores"
	icon = 'icons/obj/structure/ore_box.dmi'
	icon_state = "ore_box"

	anchored = FALSE
	collision_flags = FLAG_COLLISION_WALL

	bullet_block_chance = 75

	density = TRUE

/obj/structure/interactive/ore_box/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	if(istype(object,/obj/item/material/ore))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/item/material/ore/O = object
		O.drop_item(src)
		return TRUE

	return ..()

/obj/structure/interactive/ore_box/Cross(atom/movable/O)

	if(istype(O,/obj/item/material/ore/))
		var/obj/item/material/ore/I = O
		I.drop_item(src)
		return FALSE

	return ..()


/obj/structure/interactive/ore_box/get_examine_list(var/mob/examiner)

	. = ..()

	. += div("notice","The counter shows [length(contents)] objects inside.")

	return .