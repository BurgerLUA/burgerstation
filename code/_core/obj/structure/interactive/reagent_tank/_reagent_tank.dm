/obj/structure/interactive/reagent_tank
	name = "liquid tank"
	desc = "Versitile!"
	desc_extended = "A large portable liquid tank that stores all types of fluids."

	reagents = /reagent_container/water_tank

	allow_reagent_transfer_from = TRUE
	allow_reagent_transfer_to = FALSE

	anchored = FALSE

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density = TRUE