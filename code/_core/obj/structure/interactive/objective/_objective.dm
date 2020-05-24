obj/structure/interactive/objective
	name = "valuable artifact"
	icon = 'icons/obj/structure/objectives.dmi'
	icon_state = "1"

	anchored = FALSE
	collision_flags = FLAG_COLLISION_WALL

	value = 5000

	bullet_block_chance = 75

obj/structure/interactive/objective/Initialize()
	name = "[pick(SSname.adjectives)] artifact of [pick(SSname.verbs)]"
	return ..()

obj/structure/interactive/objective/Destroy()
	if(src in SShorde.tracked_objectives)
		SShorde.queue_objectives_update()
	return ..()

obj/structure/interactive/objective/New(var/desired_loc)
	icon_state = "[rand(1,9)]"
	return ..()