/obj/structure/interactive/stacker
	name = "stacker"
	desc = "Stacks things."
	desc_extended = "Stacks things and attempts to stack them to their maximum item count size."
	icon = 'icons/obj/structure/stacking.dmi'
	icon_state = "stacker"

	pixel_y = 2

	bullet_block_chance = 50

	density = TRUE

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#0000FF"

/obj/structure/interactive/stacker/Crossed(atom/movable/O)
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
				E.drop_item(src.loc)
			break

	return TRUE