obj/structure/interactive/chair
	name = "chair"
	desc = "You will sit in this. By will or by force."
	desc_extended = "A chair is a peice of furniture with a raised surface supported by legs, commonly used to seat a single person. Buckling is automatic and will be attempted upon walking over something you can buckle into."
	icon = 'icons/obj/structure/chairs.dmi'
	icon_state = "chair"

	bullet_block_chance = 25

	density = TRUE

obj/structure/interactive/chair/set_dir(var/desired_dir,var/force = FALSE)

	. = ..()

	if(.)
		if(dir == NORTH)
			plane = PLANE_MOB
			layer = LAYER_MOB_ABOVE
		else
			plane = initial(plane)

	return .

obj/structure/interactive/chair/Crossed(atom/movable/O)

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
	desc = "Apply butt."
	desc_extended = "A chair without back or arm rests, also known as a stool."
	icon_state = "stool"

	bullet_block_chance = 5

obj/structure/interactive/chair/stool/bar
	name = "bar stool"
	desc = "Apply butt."
	desc_extended = "A chair without back or arm rests, also known as a stool. This one is raised up, therefore it classifies as a bar stool."
	icon_state = "bar"


obj/structure/interactive/chair/wood
	name = "wooden chair"
	desc = "You will sit in this. By will or by force."
	desc_extended = "A chair is a peice of furniture with a raised surface supported by legs, commonly used to seat a single person. Buckling is automatic and will be attempted upon walking over something you can buckle into."
	icon_state = "wooden_chair"

	bullet_block_chance = 10