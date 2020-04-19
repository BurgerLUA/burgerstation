/mob/
	name = "MOB ERROR"
	icon = 'icons/debug/mobs.dmi'
	icon_state = ""
	layer = LAYER_MOB

	var/ckey_last

	var/tmp/movement_flags = 0x0
	var/tmp/attack_flags = 0x0

	var/list/obj/hud/button/buttons //List of HUD buttons
	var/list/obj/hud/button/health_elements

	//var/animation_pixel_x = 0
	//var/animation_pixel_y = 0

	movement_delay = DECISECONDS_TO_TICKS(4)

	var/sprint_delay_mul = 1
	var/jog_delay_mul = 1.5
	var/walk_delay_mul = 2

	var/attack_turn = 0
	var/attack_turn_delay = 10

	var/auto_resist = FALSE

	plane = PLANE_MOB

	see_invisible = INVISIBILITY_LIGHTING

	sight = 0x0

	var/vision = 0x0

	/*
	var/list/quests/all_quests = list()
	var/list/quests/active_quests = list()
	*/

	mouse_over_pointer = MOUSE_ACTIVE_POINTER
	mouse_drop_zone = TRUE

	var/move_mod = 2
	var/move_mod_button = 0

	see_invisible = INVISIBILITY_DEFAULT
	invisibility = INVISIBILITY_MOBS

	var/draw_buttons = TRUE
	var/draw_health = TRUE

	var/can_attack_while_moving = TRUE

	var/skip_cutscene = FALSE //For cutscene skipping.

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/obj/hud/screen/paralax

	var/obj/plane_master/walls/plane_master_wall
	var/obj/plane_master/mobs/plane_master_mob
	var/obj/plane_master/darkness/plane_master_darkness
	var/obj/plane_master/objs/plane_master_obj
	var/obj/plane_master/render_target/plane_master_render_target
	var/obj/plane_master/shuttle/plane_master_shuttle

	var/last_words = ""

	var/list/stored_chat_text = list() //experiment

	pixel_z = MOB_HEIGHT_OFFSET

	change_dir_on_move = TRUE

	var/view = VIEW_RANGE

	anchored = FALSE

	//step_size = 4

	var/list/known_languages = list(
		LANGUAGE_BASIC = TRUE
	)

/mob/proc/update_eyes()
	vision = 0x0
	sight = (SEE_SELF | SEE_BLACKNESS | SEE_TURFS)
	return TRUE

/mob/Destroy()

	if(client)
		client.clear_mob(src,TRUE)

	key = null // required to GC
	buttons.Cut()
	health_elements.Cut()
	if(stored_chat_text)
		stored_chat_text.Cut()

	all_mobs -= src
	all_mobs_with_clients -= src

	qdel(plane_master_wall)
	plane_master_wall = null

	qdel(plane_master_mob)
	plane_master_mob = null

	qdel(paralax)
	paralax = null

	qdel(plane_master_darkness)
	plane_master_darkness = null

	qdel(plane_master_obj)
	plane_master_obj = null

	qdel(plane_master_shuttle)
	plane_master_shuttle = null

	return ..()

/mob/proc/do_mouse_wheel(object,delta_x,delta_y,location,control,params)
	return TRUE

/mob/Login()

	. = ..()

	var/client/C = src.client

	C.view = view

	for(var/obj/structure/interactive/localmachine/L in local_machines)
		L.update_for_mob(src)

	if(!plane_master_wall)
		plane_master_wall = new
	C.screen += plane_master_wall

	if(!plane_master_mob)
		plane_master_mob = new
	C.screen += plane_master_mob

	if(!plane_master_darkness)
		plane_master_darkness = new
	C.screen += plane_master_darkness

	if(!plane_master_obj)
		plane_master_obj = new
	C.screen += plane_master_obj

	if(!plane_master_shuttle)
		plane_master_shuttle = new
	C.screen += plane_master_shuttle

	update_eyes()

	return TRUE

/mob/Initialize()

	. = ..()

	force_move(src.loc)

	return .

/mob/New(var/loc/spawning_location,var/client/C)

	buttons = list()
	health_elements = list()

	if(C)
		C.control_mob(src,FALSE)

	all_mobs += src

	return ..()