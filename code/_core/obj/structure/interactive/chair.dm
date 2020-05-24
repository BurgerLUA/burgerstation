obj/structure/interactive/chair
	name = "chair"
	desc = "What does it do?"
	icon = 'icons/obj/structure/chairs.dmi'
	icon_state = "chair"

	bullet_block_chance = 25

obj/structure/interactive/chair/set_dir(var/desired_dir,var/force = FALSE)

	. = ..()

	if(.)
		if(dir == NORTH)
			plane = PLANE_MOB
			layer = LAYER_MOB_ABOVE
		else
			plane = initial(plane)

	return .

obj/structure/interactive/chair/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)

	. = ..()

	if(is_living(O))
		CALLBACK("sit_down_\ref[src]",SECONDS_TO_DECISECONDS(1),src,.proc/sit_your_ass_down,O)

	return .

obj/structure/interactive/chair/proc/sit_your_ass_down(var/mob/living/L)

	if(L.loc != src.loc)
		return FALSE

	L.set_dir(src.dir)

	return TRUE

obj/structure/interactive/chair/stool
	name = "stool"
	icon_state = "stool"

	bullet_block_chance = 5

obj/structure/interactive/chair/stool/bar
	name = "bar stool"
	icon_state = "bar"


obj/structure/interactive/chair/wood
	name = "wooden chair"
	icon_state = "wooden_chair"

	bullet_block_chance = 10