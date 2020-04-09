obj/structure/interactive/chair
	name = "chair"
	desc = "What does it do?"
	icon = 'icons/obj/structure/chairs.dmi'
	icon_state = "chair"

obj/structure/interactive/chair/set_dir(var/desired_dir,var/force = FALSE)

	. = ..()

	if(.)
		if(dir == NORTH)
			plane = PLANE_MOB
		else
			plane = initial(plane)

	return .

obj/structure/interactive/chair/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)

	. = ..()

	if(is_advanced(O))
		spawn(SECONDS_TO_DECISECONDS(1))
			var/turf/T = O.loc
			if(src in T.contents)
				O.set_dir(src.dir)

	return .


obj/structure/interactive/chair/stool
	name = "stool"
	icon_state = "stool"

obj/structure/interactive/chair/stool/bar
	name = "bar stool"
	icon_state = "bar"


obj/structure/interactive/chair/wood
	name = "wooden chair"
	icon_state = "wooden_chair"