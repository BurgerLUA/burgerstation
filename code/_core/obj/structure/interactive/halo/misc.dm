/obj/structure/interactive/misc/halo

/obj/structure/interactive/misc/halo/statue
	name = "statue"
	icon = 'icons/halo/icons/memorial_statue.dmi'
	desc = "A statue"
	pixel_x = -9
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

/obj/structure/interactive/misc/halo/statue/limbobaggins
	icon_state = "bilba_stone"
	desc_extended = "Memorial of Jhonny Smith, ODST troops sergeant."

/obj/structure/interactive/misc/halo/statue/ghostgamer
	icon_state = "ghostgamer_stone"
	desc_extended = "Memorial of Andrey Kasperov, Commander of the UNSC Light Brigade."

/obj/structure/interactive/misc/halo/statue/darksovet
	icon_state = "sovet_stone"
	desc_extended = "Memorial of Fedor Yablochkin, UNSC marine."

/obj/structure/interactive/misc/halo/statue/doctoralex
	icon_state = "alex_stone"
	desc_extended = "Memorial of Michael Brown, Pilot of the UNSC Light Brigade."

/obj/structure/interactive/misc/halo/signs
	name = "floor marker"
	icon = 'icons/halo/Hallwaymarkers.dmi'
	desc = "Marker"

/obj/structure/interactive/misc/halo/signs/armory
	icon_state = "armory"

/obj/structure/interactive/misc/halo/signs/hangar
	icon_state = "hangar"

/obj/structure/interactive/misc/halo/decor

/obj/structure/interactive/misc/halo/decor/machinery/table
	name = "Holo-table"
	icon = 'icons/halo/icons/machinery/computer.dmi'
	icon_state = "holotable"
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density = TRUE
	bullet_block_chance = 25

/obj/structure/interactive/misc/halo/decor/machinery/tower
	name = "Communication Tower"
	icon = 'icons/halo/icons/machinery/comm_tower.dmi'
	icon_state = "comm_tower"
	layer = LAYER_LARGE_OBJ
	plane = PLANE_SCENERY
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density = TRUE
	bullet_block_chance = 50

/obj/structure/interactive/misc/halo/decor/machinery/radio_tower_gm
	name = "Main Radio-Tower"
	icon = 'icons/halo/icons/machinery/radio_tower.dmi'
	icon_state = "tower_on"
	layer = LAYER_LARGE_OBJ
	plane = PLANE_SCENERY
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	bound_width = TILE_SIZE*3
	bound_height = TILE_SIZE*3
	health = /health/construction
	health_base = 2000
	density = TRUE
	bullet_block_chance = 50

/obj/structure/interactive/misc/halo/decor/machinery/radio_tower_gm/on_destruction(var/mob/caller,var/damage = FALSE)

	icon_state = "tower_broke"

	return ..()

/obj/structure/interactive/misc/halo/decor/machinery/radio_tower_gm/urf
	name = "Main Radio-Tower"
	desc = "Destruction of this tower will end the round with the UNSC's victory."
	icon = 'icons/halo/icons/machinery/radio_tower.dmi'
	icon_state = "tower_on"
	layer = LAYER_LARGE_OBJ
	plane = PLANE_SCENERY
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	bound_width = TILE_SIZE*3
	bound_height = TILE_SIZE*3
	health = /health/construction
	health_base = 4000
	density = TRUE
	bullet_block_chance = 50

/obj/structure/interactive/misc/halo/decor/machinery/radio_tower_gm/urf/on_destruction(var/mob/caller,var/damage = FALSE)

	icon_state = "tower_broke"
	world.end(WORLD_END_NANOTRASEN_VICTORY)

	return ..()

/obj/structure/interactive/misc/halo/decor/machinery/radio_tower_gm/unsc
	name = "Secondary Radio-Tower"
	desc = "Destruction of this tower will end the round with the URF's victory."
	icon = 'icons/halo/icons/machinery/radio_tower.dmi'
	icon_state = "tower_on"
	layer = LAYER_LARGE_OBJ
	plane = PLANE_SCENERY
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	bound_width = TILE_SIZE*3
	bound_height = TILE_SIZE*3
	health = /health/construction
	health_base = 4000
	density = TRUE
	bullet_block_chance = 50

/obj/structure/interactive/misc/halo/decor/machinery/radio_tower_gm/unsc/on_destruction(var/mob/caller,var/damage = FALSE)

	icon_state = "tower_broke"
	world.end(WORLD_END_SYNDICATE_VICTORY)

	return ..()

/obj/structure/interactive/misc/halo/decor/vehicles
	density = TRUE

/obj/structure/interactive/misc/halo/decor/vehicles/spirit
	name = "Type-25 Spirit"
	icon = 'icons/halo/vehicles/types/spirit.dmi'
	icon_state = "base"
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	bound_width = TILE_SIZE*4
	bound_height = TILE_SIZE*8

/obj/structure/interactive/misc/halo/decor/vehicles/scorpion
	name = "M808B Scorpion"
	icon = 'icons/halo/vehicles/types/Scorpion.dmi'
	icon_state = "west"
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	bound_width = TILE_SIZE*3

/obj/structure/interactive/misc/halo/decor/vehicles/warthog
	name = "M12 Warthog"
	icon = 'icons/halo/vehicles/types/finalwarthog.dmi'
	icon_state = "Warthog"
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	bound_width = TILE_SIZE*2

/obj/structure/interactive/misc/halo/decor/tanktrap
	name = "tanktrap"
	icon = 'icons/halo/structures/structures1.dmi'
	icon_state = "tanktrap"
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	density = TRUE
	bullet_block_chance = 50

/obj/structure/interactive/misc/halo/decor/vehicles/placeholder
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	invisibility = 101

	density = TRUE