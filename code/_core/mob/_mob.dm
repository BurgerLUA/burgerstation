/mob/
	name = "MOB ERROR"
	icon = 'icons/debug/mobs.dmi'
	icon_state = ""
	layer = LAYER_MOB
	plane = PLANE_MOB

	var/ckey_last

	var/tmp/movement_flags = 0x0
	var/tmp/attack_flags = 0x0

	var/list/obj/hud/button/buttons //List of HUD buttons
	var/list/obj/hud/button/health_elements //List of health elements. This is an assoc list!
	var/list/obj/hud/button/examine_butons //List of examine buttons.

	//var/animation_pixel_x = 0
	//var/animation_pixel_y = 0

	movement_delay = DECISECONDS_TO_TICKS(4)

	var/sprint_delay_mul = 1
	var/jog_delay_mul = 1.5
	var/walk_delay_mul = 2

	var/attack_turn = 0
	var/attack_turn_delay = 10

	var/auto_resist = FALSE

	mouse_over_pointer = MOUSE_ACTIVE_POINTER
	mouse_drop_zone = TRUE

	var/move_mod = 2
	var/move_mod_button = 0

	var/vision = 0x0
	sight = 0x0
	see_invisible = INVISIBILITY_DEFAULT

	invisibility = INVISIBILITY_MOBS

	var/draw_buttons = TRUE
	var/draw_health = TRUE

	var/can_attack_while_moving = TRUE

	var/skip_cutscene = FALSE //For cutscene skipping.

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/obj/plane_master/walls/plane_master_wall
	var/obj/plane_master/mobs/plane_master_mob
	var/obj/plane_master/darkness/plane_master_darkness
	var/obj/plane_master/objs/plane_master_obj
	var/obj/plane_master/render_target/plane_master_render_target
	var/obj/plane_master/shuttle/plane_master_shuttle
	var/obj/plane_master/scenery/plane_master_scenery
	var/obj/plane_master/lighting/plane_master_lighting
	var/obj/plane_master/floor/plane_master_floor

	var/list/parallax

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

	var/obj/hud/examine/examine_overlay

	var/list/color_mods = list()
	var/list/lighting_mods = list()

	var/list/known_emotes = list()

	var/last_hold = -1

	var/next_emote = 0 //Prevents spam

	var/last_z = 0

/mob/proc/update_eyes()
	vision = initial(vision)
	sight = initial(sight)
	see_invisible = initial(see_invisible)
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

	QDEL_NULL(plane_master_floor)
	QDEL_NULL(plane_master_wall)
	QDEL_NULL(plane_master_mob)
	QDEL_NULL(plane_master_darkness)
	QDEL_NULL(plane_master_obj)
	QDEL_NULL(plane_master_shuttle)
	QDEL_NULL(plane_master_scenery)
	QDEL_NULL(plane_master_lighting)
	QDEL_NULL(examine_overlay)

	return ..()

/mob/Login()

	. = ..()

	var/client/C = src.client

	for(var/k in local_machines)
		var/obj/structure/interactive/localmachine/L = k
		L.update_for_mob(src)

	if(!plane_master_floor)
		plane_master_floor = new(src)
	C.screen += plane_master_floor

	if(!plane_master_wall)
		plane_master_wall = new(src)
	C.screen += plane_master_wall

	if(!plane_master_mob)
		plane_master_mob = new(src)
	C.screen += plane_master_mob

	if(!plane_master_darkness)
		plane_master_darkness = new(src)
	C.screen += plane_master_darkness

	if(!plane_master_obj)
		plane_master_obj = new(src)
	C.screen += plane_master_obj

	if(!plane_master_shuttle)
		plane_master_shuttle = new(src)
	C.screen += plane_master_shuttle

	if(!plane_master_scenery)
		plane_master_scenery = new(src)
	C.screen += plane_master_scenery

	if(!plane_master_lighting)
		plane_master_lighting = new(src)
	C.screen += plane_master_lighting

	if(!examine_overlay)
		examine_overlay = new(src)
	C.screen += examine_overlay

	if(!parallax["A"])
		var/obj/parallax/layer1/P = new(src)
		parallax["A"] += P
		P.owner = src
	C.screen += parallax["A"]

	if(!parallax["B"])
		var/obj/parallax/layer2/P = new(src)
		parallax["B"] += P
		P.owner = src
	C.screen += parallax["B"]

	if(!parallax["C"])
		var/obj/parallax/layer3/P = new(src)
		parallax["C"] += P
		P.owner = src
	C.screen += parallax["C"]

	if(!parallax["D"])
		var/obj/parallax/layer4/P = new(src)
		parallax["D"] += P
		P.owner = src
	C.screen += parallax["D"]

	update_eyes()

	return TRUE

/mob/Finalize()
	. = ..()
	force_move(src.loc)
	return .

/mob/New(var/loc/spawning_location,var/client/C)

	parallax = list()
	buttons = list()
	health_elements = list()
	examine_butons = list()

	if(C)
		C.control_mob(src,FALSE)

	all_mobs += src

	return ..()

/mob/is_player_controlled()
	return ckey || ckey_last


/mob/proc/is_afk()

	if(src.ckey_last && !src.ckey)
		return TRUE

	if(client && client.inactivity >= SECONDS_TO_TICKS(180))
		return TRUE

	return FALSE