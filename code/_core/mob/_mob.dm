/mob/
	name = "MOB ERROR"
	icon = 'icons/debug/mobs.dmi'
	icon_state = ""
	layer = LAYER_MOB
	var/enable_AI = FALSE

	var/tmp/movement_flags = 0x0
	var/tmp/attack_flags = 0x0

	var/list/obj/button/buttons //List of HUD buttons

	var/animation_pixel_x = 0
	var/animation_pixel_y = 0

	movement_delay = DECISECONDS_TO_TICKS(5)
	attack_delay = 10

	var/attack_turn = 0
	var/attack_turn_delay = 10

	var/auto_resist = FALSE

	mouse_opacity = 0

	plane = PLANE_MOB

	see_invisible = 20

	sight = SEE_BLACKNESS

	var/list/quests/all_quests = list()
	var/list/quests/active_quests = list()

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/karma = 0

	var/move_mod = 2

	var/attack_mode = 1

	var/list/attack_left = list(
		list(16,16),
		list(16,16),
		list(16,16),
		list(16,16)

	)

	var/list/attack_right = list(
		list(16,16),
		list(16,16),
		list(16,16),
		list(16,16)
	)

/mob/Initialize()
	for(var/obj/structure/interactive/localmachine/L in local_machines)
		L.update_for_mob(src)

	var/area/A = get_area(src)
	A.Entered(src)

	..()

/mob/New(var/loc/spawning_location,var/client/C)

	if(C)
		client = C
		all_mobs_with_clients += src
		ckey = C.ckey
		C.reset()

	buttons = list()

	all_mobs += src
	..()

/mob/Cross(var/atom/moveable/A)
	if(area && area.safe) //No collisions in safe areas.
		return TRUE

	return ..()