obj/structure/interactive/computer/arcade
	name = "arcade"
	desc = "Spend your hard earned money on games."
	desc_extended = "A modular arcade machine."
	icon_state = "arcade"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	collision_dir = NORTH | EAST | SOUTH | WEST

	bullet_block_chance = 75

	density = TRUE

obj/structure/interactive/computer/arcade/bubbletwist
	name = "arcade - bubble twist"

obj/structure/interactive/computer/arcade/bubbletwist/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK

	var/mob/living/L = caller
	L.toggle_research_game(FALSE,TRUE)

	return TRUE