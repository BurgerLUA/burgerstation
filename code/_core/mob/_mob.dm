/mob/
	name = "MOB ERROR"
	icon = 'icons/debug/mobs.dmi'
	icon_state = ""
	layer = LAYER_MOB
	var/enable_AI = FALSE

	var/tmp/movement_flags = 0x0
	var/tmp/attack_flags = 0x0

	var/list/obj/hud/button/buttons //List of HUD buttons
	var/list/obj/hud/button/health/health_elements

	//var/animation_pixel_x = 0
	//var/animation_pixel_y = 0

	movement_delay = DECISECONDS_TO_TICKS(4)
	interact_delay_base = 10

	var/attack_turn = 0
	var/attack_turn_delay = 10

	var/auto_resist = FALSE

	plane = PLANE_MOB

	see_invisible = INVISIBILITY_LIGHTING

	sight = SEE_SELF | SEE_PIXELS | SEE_BLACKNESS

	/*
	var/list/quests/all_quests = list()
	var/list/quests/active_quests = list()
	*/

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/move_mod = 2
	var/real_move_mod = 2

	var/karma = 0

	see_invisible = INVISIBILITY_DEFAULT
	invisibility = INVISIBILITY_MOBS

	var/draw_buttons = TRUE
	var/draw_health = TRUE

	var/can_attack_while_moving = TRUE

	var/spam_protection_say = 0
	//Increases by a certain amount every time you speak in IC.
	//Measured in seconds.
	//Reduces by 1 every second

	var/skip_cutscene = FALSE //For cutscene skipping.

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/obj/hud/screen/paralax = /obj/hud/screen/

/mob/destroy()

	if(client)
		all_mobs_with_clients -= src
		//Keep the last ckey just in case.
		client.reset()
		client = null

	key = null // required to GC
	buttons = null
	health_elements = null


	all_mobs -= src

	return ..()

/mob/can_attack(var/atom/victim,var/atom/weapon,var/params)

	/*
	if(weapon && weapon != src && !weapon.can_attack(victim,weapon,params))
		return FALSE
	*/

	if(!can_attack_while_moving && move_delay > 0)
		return FALSE

	return ..()

/mob/Initialize()

	. = ..()

	if(src.client)

		var/client/C = src.client

		for(var/obj/structure/interactive/localmachine/L in local_machines)
			L.update_for_mob(src)

		paralax = new paralax
		paralax.name = "unknown"
		paralax.mouse_opacity = 1
		paralax.icon = 'icons/hud/screen.dmi'
		paralax.icon_state = "blank"
		paralax.color = "#000000"
		paralax.plane = PLANE_PARALAX
		paralax.screen_loc = "LEFT,BOTTOM"
		paralax.update_icon()
		C.screen += paralax

	var/area/A = get_area(src)
	A.Entered(src)






	return .

/mob/New(var/loc/spawning_location,var/client/C)

	if(C)
		client = C
		all_mobs_with_clients += src
		ckey = C.ckey
		C.reset()

	buttons = list()

	all_mobs += src
	..()