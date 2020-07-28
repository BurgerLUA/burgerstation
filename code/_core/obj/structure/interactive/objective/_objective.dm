obj/structure/interactive/artifact
	name = "valuable artifact"
	icon = 'icons/obj/structure/objectives.dmi'
	icon_state = "1"

	anchored = FALSE
	collision_flags = FLAG_COLLISION_WALL

	value = 1000

	bullet_block_chance = 75

obj/structure/interactive/artifact/Initialize()
	name = "[pick(SSname.adjectives)] artifact of [pick(SSname.verbs)]"
	return ..()

obj/structure/interactive/artifact/on_crush()
	var/turf/T = get_turf(pick(all_fall_markers))
	src.visible_message(span("danger","\The [name] strains as it disappears in a large flash!"))
	src.force_move(T)
	return FALSE

obj/structure/interactive/artifact/New(var/desired_loc)
	icon_state = "[rand(1,9)]"
	return ..()