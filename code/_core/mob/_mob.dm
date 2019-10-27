/mob/
	name = "MOB ERROR"
	icon = 'icons/debug/mobs.dmi'
	icon_state = ""
	layer = LAYER_MOB
	var/enable_AI = FALSE

	var/tmp/movement_flags = 0x0
	var/tmp/attack_flags = 0x0

	var/list/obj/hud/button/buttons //List of HUD buttons
	var/list/obj/hud/button/health_elements

	//var/animation_pixel_x = 0
	//var/animation_pixel_y = 0

	movement_delay = DECISECONDS_TO_TICKS(4)

	var/attack_turn = 0
	var/attack_turn_delay = 10

	var/auto_resist = FALSE

	plane = PLANE_MOB

	see_invisible = INVISIBILITY_LIGHTING

	sight = SEE_SELF | SEE_BLACKNESS

	/*
	var/list/quests/all_quests = list()
	var/list/quests/active_quests = list()
	*/

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/move_mod = 2
	var/move_mod_button = 0

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

	var/obj/hud/screen/paralax

	var/obj/plane_master/walls/plane_master_wall
	var/obj/plane_master/mobs/plane_master_mob
	var/obj/plane_master/darkness/plane_master_darkness
	var/obj/plane_master/trees/plane_master_tree
	var/obj/plane_master/render_target/plane_master_render_target

	var/last_words = ""

/mob/destroy()

	if(client)
		client.clear_mob(src)

	key = null // required to GC
	buttons.Cut()
	health_elements.Cut()

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

	qdel(plane_master_tree)
	plane_master_tree = null

	return ..()

/mob/proc/do_mouse_wheel(object,delta_x,delta_y,location,control,params)
	return TRUE

/mob/can_attack(var/atom/victim,var/atom/weapon,var/params)

	if(!can_attack_while_moving && move_delay > 0)
		return FALSE

	return ..()

/mob/Initialize()

	//set_light(VIEW_RANGE*0.25,0.25,"#FFFFFF")

	. = ..()

	if(src.client)

		var/client/C = src.client

		for(var/obj/structure/interactive/localmachine/L in local_machines)
			L.update_for_mob(src)

		/*
		if(!paralax)
			paralax = new
			paralax.name = "unknown"
			paralax.mouse_opacity = 0
			paralax.icon = 'icons/hud/screen.dmi'
			paralax.icon_state = "blank"
			paralax.color = "#FF0000"
			paralax.plane = PLANE_PARALAX
			paralax.screen_loc = "LEFT,BOTTOM"
			paralax.update_icon()
			C.screen += paralax
		*/

		if(!plane_master_wall)
			plane_master_wall = new
			C.screen += plane_master_wall

		if(!plane_master_mob)
			plane_master_mob = new
			C.screen += plane_master_mob

		if(!plane_master_darkness)
			plane_master_darkness = new
			C.screen += plane_master_darkness

		if(!plane_master_tree)
			plane_master_tree = new
			C.screen += plane_master_tree

		/*
		if(!plane_master_render_target)
			plane_master_render_target = new
			C.screen += plane_master_render_target
		*/

		/*
		var/image/I = new/image('icons/obj/effects/light_sprite/192x192.dmi',"")
		I.pixel_x = 16-(192*0.5)
		I.pixel_y = 16-(192*0.5)
		I.blend_mode = BLEND_MULTIPLY
		I.loc = src
		I.plane = PLANE_LIGHTING+0.1
		client.images += I
		see_in_dark  = 2
		*/

	force_move(src.loc)

	return .

/mob/New(var/loc/spawning_location,var/client/C)

	buttons = list()
	health_elements = list()

	if(C)
		C.control_mob(src,TRUE)

	all_mobs += src

	return ..()