/obj/structure/
	name = "structure"
	desc = "Some kind of strange structure."
	density = 1
	anchored = 1

/obj/structure/do_bump(var/atom/bumper, var/bump_direction = 0, var/movement_override = 0)
	if(!anchored)
		return ..()

	return FALSE

/obj/structure/can_not_enter(A,move_direction)
	if(density)
		return src

	return FALSE