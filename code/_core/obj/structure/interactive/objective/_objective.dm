obj/structure/interactive/artifact
	name = "valuable artifact"
	icon = 'icons/obj/structure/objectives.dmi'
	icon_state = "1"

	anchored = FALSE
	collision_flags = FLAG_COLLISION_WALL
	density = TRUE

	value = 1000

	bullet_block_chance = 75

	desired_light_power = 0.25
	desired_light_range = 2
	desired_light_color = "#FFFFFF"

obj/structure/interactive/artifact/Initialize()
	name = "[pick(SStext.adjectives)] artifact of [pick(SStext.verbs)]"
	return ..()

obj/structure/interactive/artifact/on_crush()
	var/turf/T = get_turf(pick(rift_markers))
	src.visible_message(span("danger","\The [name] strains as it disappears in a large flash!"))
	src.force_move(T)
	return FALSE

obj/structure/interactive/artifact/New(var/desired_loc)
	icon_state = "[rand(1,9)]"
	return ..()