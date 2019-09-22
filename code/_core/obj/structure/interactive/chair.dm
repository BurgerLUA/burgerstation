obj/structure/interactive/chair
	name = "chair"
	desc = "What does it do?"
	icon = 'icons/obj/structure/chairs.dmi'
	icon_state = "chair"

obj/structure/interactive/chair/Crossed(var/atom/movable/O)

	. = ..()

	if(is_advanced(O))
		spawn(SECONDS_TO_DECISECONDS(1))
			var/turf/T = O.loc
			if(src in T.contents)
				O.dir = src.dir

	return .


obj/structure/interactive/chair/stool
	name = "stool"
	icon_state = "stool"


obj/structure/interactive/chair/wood
	name = "wooden chair"
	icon_state = "wooden_chair"