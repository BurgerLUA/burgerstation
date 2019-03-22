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

	plane = PLANE_MOB

	see_invisible = INVISIBILITY_LIGHTING

	sight = SEE_BLACKNESS | SEE_SELF | SEE_TURFS | SEE_PIXELS

	var/list/quests/all_quests = list()
	var/list/quests/active_quests = list()

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/move_mod = 2
	var/real_move_mod = 2

	var/karma = 0

	see_invisible = INVISIBILITY_DEFAULT
	invisibility = INVISIBILITY_MOBS

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