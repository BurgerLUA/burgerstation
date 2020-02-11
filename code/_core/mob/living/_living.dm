/mob/living/

	var/list/experience/attribute/attributes
	var/list/experience/skill/skills
	var/list/faction/factions
	var/list/starting_factions = list()

	movement_delay = DECISECONDS_TO_TICKS(2)

	icon_state = "directional"

	var/class = "default"

	var/enable_AI = FALSE
	var/ai/ai

	var/iff_tag

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/status = 0 //Negative status

	var/stun_time = 0
	var/sleep_time = 0
	var/paralyze_time = 0
	var/fatigue_time = 0
	var/stagger_time = 0
	var/crit_time = 0
	var/confuse_time = 0
	var/adrenaline_time = 0

	var/first_life = TRUE

	var/health_regen_buffer = 0
	var/mana_regen_buffer = 0
	var/stamina_regen_buffer = 0

	var/boss_range = VIEW_RANGE
	var/list/mob/living/advanced/player/players_fighting_boss

	var/is_sneaking = FALSE
	var/stealth_mod = 0

	var/intent = INTENT_HARM

	var/level = 0

	var/turf/old_turf //Last turf someone has been in.

	var/loot_drop
	var/loot_drop_in_corpse = FALSE

	var/level_multiplier = 1 //Multiplier for enemies. Basically how much each stat is modified by.

	var/stun_angle = 0

	var/boss = FALSE
	var/boss_music

	//var/list/mob/living/advanced/player/linked_players

	var/respawn = TRUE
	var/respawn_time = 300 //In deciseconds
	var/random_spawn_dir = TRUE

	var/has_footprints = FALSE
	var/list/footstep_override

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	var/list/obj/hud/screen_blood/screen_blood

	var/allow_experience_gains = FALSE

	var/horizontal = FALSE //Read only value to check if the mob's sprite is horizontal.

	health = /health/mob/living/

	var/force_spawn = FALSE

	var/last_flavor = ""
	var/last_flavor_time = 0

	var/list/armor_base = list(
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		MAGIC = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 0,
		DARK = 0,
		FATIGUE = 0
	)

	var/dead = FALSE

	var/obj/structure/buckled_object

	reagents = /reagent_container/living

	var/image/medical_hud_image
	var/image/security_hud_image
	var/image/medical_hud_image_advanced

	has_footsteps = TRUE

/mob/living/do_mouse_wheel(object,delta_x,delta_y,location,control,params)
	if(object && is_atom(object))
		var/atom/A = object
		A.on_mouse_wheel(src,delta_x,delta_y,location,control,params)

	return TRUE

/mob/living/Bump(var/atom/obstacle,var/Dir=0)

	. = ..()

	if(ai)
		ai.Bump(obstacle)

	return .

/mob/living/Destroy()

	//factions.Cut()

	for(var/experience/E in attributes)
		qdel(E)

	attributes.Cut()

	for(var/experience/E in skills)
		qdel(E)

	skills.Cut()

	if(ai)
		qdel(ai)
		ai = null

	if(screen_blood)
		for(var/obj/hud/screen_blood/S in screen_blood)
			qdel(S)

		screen_blood.Cut()

	all_living -= src

	if(old_turf && old_turf.old_living)
		old_turf.old_living -= src

	old_turf = null

	if(boss)
		tracked_bosses -= src

	players_fighting_boss.Cut()

	qdel(medical_hud_image)
	medical_hud_image = null

	qdel(security_hud_image)
	security_hud_image = null

	qdel(medical_hud_image_advanced)
	medical_hud_image_advanced = null

	return ..()

/mob/living/proc/get_brute_color()
	return "#FF0000"

/mob/living/proc/get_burn_color()
	return "#444444"

/mob/living/New(loc,desired_client,desired_level_multiplier)

	if(desired_level_multiplier)
		level_multiplier *= desired_level_multiplier

	attributes = list()
	skills = list()
	//factions = list()
	health_elements = list()
	players_fighting_boss = list()

	initialize_attributes()
	initialize_skills()

	medical_hud_image = new/image('icons/hud/medihud.dmi',"0")
	medical_hud_image.loc = src
	medical_hud_image.layer = PLANE_HUD_VISION
	medical_hud_image.pixel_y = 4

	security_hud_image = new/image('icons/hud/sechud.dmi',"unknown")
	security_hud_image.loc = src
	security_hud_image.layer = PLANE_HUD_VISION

	medical_hud_image_advanced = new/image('icons/hud/damage_hud.dmi',"000")
	medical_hud_image_advanced.loc = src
	medical_hud_image_advanced.layer = PLANE_HUD_VISION

	. = ..()

	if(health)
		health.armor_base = armor_base

	if(client)
		client.update_stats = TRUE
		client.statpanel = "Skills"

	if(ai)
		ai = new ai(src)

	if(desired_client)
		screen_blood = list()
		screen_blood += new /obj/hud/screen_blood(src,NORTHWEST)
		screen_blood += new /obj/hud/screen_blood(src,NORTHEAST)
		screen_blood += new /obj/hud/screen_blood(src,SOUTHEAST)
		screen_blood += new /obj/hud/screen_blood(src,SOUTHWEST)
		//screen_blood += new /obj/hud/screen_blood(src,SOUTH) //Actually the center

	all_living += src

	if(boss)
		tracked_bosses[id] = src

	return .

/mob/living/Initialize()

	//initialize_factions()
	update_level()
	. = ..()
	setup_name()

	if(boss)
		for(var/mob/living/advanced/player/P in view(src,VIEW_RANGE))
			for(var/obj/hud/button/boss_health/B in P.buttons)
				B.target_boss = src
				B.update_stats()

	return .

/mob/living/proc/setup_name()
	if(ai)
		name = "[name] (lvl. [level])"

	return TRUE

/*
/mob/living/proc/initialize_factions()
	for(var/k in starting_factions)
		factions[k] = all_factions[k]
*/