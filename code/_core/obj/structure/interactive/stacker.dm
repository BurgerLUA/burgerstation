/obj/structure/interactive/stacker
	name = "stacker"
	desc = "Stacks things."
	desc_extended = "Stacks things and attempts to stack them to their maximum item count size."
	icon = 'icons/obj/structure/stacking.dmi'
	icon_state = "stacker_map"

	pixel_y = 2

	var/turf/exit_point

/obj/structure/interactive/stacker/Initialize()
	exit_point = get_step(src,dir)
	icon_state = "stacker"
	return ..()

/obj/structure/interactive/stacker/Crossed(var/atom/movable/O)
	stack(O)
	return ..()

/obj/structure/interactive/stacker/proc/stack(var/atom/movable/O)

	if(!is_item(O))
		O.force_move(exit_point)
		return FALSE

	var/obj/item/I = O
	if(I.item_count_max <= 1)
		I.force_move(exit_point)
		return FALSE

	O.force_move(src)

	for(var/obj/item/E in contents) //E for existing
		if(I.can_transfer_stacks_to(E))
			I.transfer_stacks_to(E)
			if(E.item_count_current == E.item_count_max)
				E.force_move(exit_point)
			break

	return TRUE