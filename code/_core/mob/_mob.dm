/mob/
	name = "MOB ERROR"
	icon = 'icons/debug/mobs.dmi'
	icon_state = ""
	layer = LAYER_MOB
	plane = PLANE_MOVABLE

	appearance_flags = PIXEL_SCALE | LONG_GLIDE | KEEP_TOGETHER

	var/ckey_last //The person controlling this. Can be null if control is given up.
	var/ckey_owner //The one who spawned it in. Only null if deleting.

	var/rarity = RARITY_COMMON //Basically a strength modifier for the mob.
	var/tier = -1 //-1 means not set.
	var/tier_type = "mob"

	var/tmp/movement_flags = 0x0
	var/tmp/attack_flags = 0x0

	var/list/obj/hud/button/buttons //List of HUD buttons
	var/list/obj/hud/button/health_elements //List of health elements. This is an assoc list!
	var/list/obj/hud/button/examine_butons //List of examine buttons.

	//var/animation_pixel_x = 0
	//var/animation_pixel_y = 0

	movement_delay = DECISECONDS_TO_TICKS(4)

	var/sprint_delay_mul = 1
	var/jog_delay_mul = 1.25
	var/walk_delay_mul = 1.5

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

	var/obj/plane_master/floors/plane_master_floor
	var/obj/plane_master/walls/plane_master_wall
	var/obj/plane_master/water_floor/plane_master_water_floor
	var/obj/plane_master/mobs/plane_master_mob
	var/obj/plane_master/mobs_stealth/plane_master_mob_stealth
	var/obj/plane_master/scenery/plane_master_scenery
	var/obj/plane_master/lighting/plane_master_lighting
	var/obj/plane_master/hud/plane_master_hud
	var/obj/plane_master/weather/plane_master_weather
	var/obj/plane_master/area_exterior/plane_master_area_exterior
	var/obj/plane_master/water_mask/plane_master_water_mask
	var/obj/plane_master/water/plane_master_water

	var/obj/hud/button/examine_bar/examine_bar
	var/obj/hud/button/tooltip/tooltip

	var/obj/fov/fov

	var/obj/ambient_lighting/ambient_lighting

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

	var/next_emote = 0 //Prevents spam

	var/last_z = 0

	var/list/observers = list() //A list of observers/ghosts observing this mob
	var/mob/observing //Who is this mob observing.

	var/mob/fallback_mob //The mob that this mob is slaved to. Basically if this mob tries to turn into a ghost, it will instead control this mob.
	var/list/mob/linked_mobs = list() //Basically a reverse of the above. If this mob dies, then the rest die.

	var/displaying_turf_contents = FALSE

/mob/proc/update_eyes()
	vision = initial(vision)
	sight = initial(sight)
	see_invisible = initial(see_invisible)
	return TRUE

/mob/PreDestroy()

	if(client)
		log_error("[src.get_debug_name()] deleted itself while there was still a client ([client]) attached!")
		var/turf/T = get_turf(src)
		client.make_ghost(T ? T : FALLBACK_TURF)

	for(var/k in buttons)
		var/obj/hud/button/B = k
		B.update_owner(null)

	for(var/k in health_elements)
		var/obj/hud/button/B = health_elements[k]
		B.update_owner(null)

	if(examine_bar)
		examine_bar.update_owner(null)
		examine_bar = null

	if(tooltip)
		tooltip.update_owner(null)
		tooltip = null

	if(observers)
		for(var/k in observers)
			var/mob/M = k
			M.observing = null
		observers.Cut()

	QDEL_NULL(plane_master_floor)
	QDEL_NULL(plane_master_wall)
	QDEL_NULL(plane_master_water_floor)
	QDEL_NULL(plane_master_mob)
	QDEL_NULL(plane_master_mob_stealth)
	QDEL_NULL(plane_master_scenery)
	QDEL_NULL(plane_master_lighting)
	QDEL_NULL(plane_master_hud)
	QDEL_NULL(plane_master_weather)
	QDEL_NULL(plane_master_area_exterior)
	QDEL_NULL(plane_master_water_mask)
	QDEL_NULL(plane_master_water)

	QDEL_NULL(fov)

	QDEL_NULL(examine_overlay)

	QDEL_CUT_ASSOC(parallax)

	all_mobs -= src
	all_mobs_with_clients -= src

	if(observing)
		observing.observers -= src
		observing = null

	if(fallback_mob)
		fallback_mob.linked_mobs -= src
	fallback_mob = null

	for(var/k in linked_mobs)
		var/mob/M = k
		M.fallback_mob = null
	linked_mobs?.Cut()

	. = ..()

/mob/Destroy()

	. = ..()

	ckey_owner = null
	ckey_last = null
	key = null // required to GC

	stored_chat_text?.Cut()

	color_mods?.Cut()

	lighting_mods?.Cut()

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

	if(!plane_master_water_floor)
		plane_master_water_floor = new(src)
	C.screen += plane_master_water_floor

	if(!plane_master_mob)
		plane_master_mob = new(src)
	C.screen += plane_master_mob

	if(!plane_master_mob_stealth)
		plane_master_mob_stealth = new(src)
	C.screen += plane_master_mob_stealth

	if(!plane_master_scenery)
		plane_master_scenery = new(src)
	C.screen += plane_master_scenery

	if(!plane_master_lighting)
		plane_master_lighting = new(src)
	C.screen += plane_master_lighting

	if(!plane_master_hud)
		plane_master_hud = new(src)
	C.screen += plane_master_hud

	if(!plane_master_weather)
		plane_master_weather = new(src)
	C.screen += plane_master_weather

	if(!plane_master_area_exterior)
		plane_master_area_exterior = new(src)
	C.screen += plane_master_area_exterior

	if(!plane_master_water_mask)
		plane_master_water_mask = new(src)
	C.screen += plane_master_water_mask

	if(!plane_master_water)
		plane_master_water = new(src)
	C.screen += plane_master_water

	if(!examine_overlay)
		examine_overlay = new(src)
	C.screen += examine_overlay

	if(!fov)
		fov = new(src)
		fov.render_target = "*fov_\ref[src]"
		overlays += fov

	if(!examine_bar)
		examine_bar = new(src)
	examine_bar.update_owner(src)

	if(!tooltip)
		tooltip = new(src)
	tooltip.update_owner(src)

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
	update_z_position()
	handle_lighting_alpha()

/mob/New(var/desired_loc,var/client/C)

	parallax = list()
	buttons = list()
	health_elements = list()
	examine_butons = list()

	if(C)
		C.control_mob(src,FALSE)

	all_mobs += src

	. = ..()

/mob/is_player_controlled()
	return ckey || ckey_last


/mob/proc/is_afk()

	if(src.ckey_last && !src.ckey)
		return TRUE

	if(client && client.inactivity >= SECONDS_TO_TICKS(180))
		return TRUE

	return FALSE


/mob/proc/handle_mouse_pointer()
	return TRUE