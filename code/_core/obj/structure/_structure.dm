/obj/structure/
	name = "structure"
	desc = "Some kind of strange structure."
	var/anchored = 1
	density = 1


/obj/structure/do_bump(var/atom/bumper, var/bump_direction = 0, var/movement_override = 0)
	return !anchored