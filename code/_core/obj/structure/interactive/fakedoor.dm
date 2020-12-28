/obj/structure/scenery/fake_door
	name = "airlock"
	icon = 'icons/obj/structure/airlock/fake.dmi'

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	opacity = 1

	density = TRUE

/obj/structure/scenery/fake_door/glass_bolted
	icon_state = "glass_bolted"
	opacity = 0

/obj/structure/scenery/fake_door/blast_door
	icon_state = "blast_closed"

/obj/structure/scenery/fake_door/fire_door
	icon_state = "fire_closed"
	opacity = 0

/obj/structure/scenery/fake_door/sec_door
	icon_state = "sec_closed"

/obj/structure/scenery/fake_door/command_door
	icon_state = "command_closed"

/obj/structure/scenery/fake_door/command_door_glass
	icon_state = "command_closed"

/obj/structure/scenery/fake_door/glass_door
	icon_state = "glass_closed"
	opacity = 0

/obj/structure/scenery/fake_door/maint_door
	icon_state = "maint_closed"

/obj/structure/scenery/fake_door/airlock_external
	icon_state = "external_closed"

/obj/structure/scenery/fake_door/airlock_external/glass
	icon_state = "external_closed_glass"
	opacity = 0

/obj/structure/scenery/fake_door/nocolide
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
	opacity = 0

/obj/structure/scenery/fake_door/nocolide/glass_door
	icon_state = "glass_opened"

/obj/structure/scenery/fake_door/nocolide/fire_door
	icon_state = "fire_opened"

/obj/structure/scenery/fake_door/nocolide/external
	icon_state = "external_opened"

/obj/structure/scenery/fake_door/nocolide/blast_door
	icon_state = "blast_opened"

/obj/structure/scenery/fake_door/nocolide/maint_door
	icon_state = "maint_opened"