/obj/structure/
	name = "structure"
	desc = "Some kind of strange structure."
	density = 1
	anchored = 1

/obj/structure/Cross(var/atom/movable/A)

	if(density)
		return FALSE

	return ..()