/obj/structure/interactive/stacker
	name = "stacker"
	desc = "Stacks things."
	desc_extended = "Stacks things and attempts to stack them to their maximum item count size."
	icon = 'icons/obj/structure/stacking.dmi'
	icon_state = "stacker"

	pixel_y = 2

	bullet_block_chance = 50

/obj/structure/interactive/stacker/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	stack(O)
	return ..()

/obj/structure/interactive/stacker/proc/stack(var/atom/movable/O)

	if(!is_item(O))
		return FALSE

	var/obj/item/I = O
	if(I.item_count_max <= 1)
		return FALSE
	if(I.item_count_current >= I.item_count_max)
		return FALSE

	I.drop_item(src)

	for(var/obj/item/E in contents) //E for existing
		if(I.can_transfer_stacks_to(E))
			I.transfer_item_count_to(E)
			if(E.item_count_current == E.item_count_max)
				E.force_move(src.loc)
			break

	return TRUE