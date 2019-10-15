/mob/living/

	var/list/experience/attribute/attributes
	var/list/experience/skill/skills
	var/list/faction/factions
	var/list/starting_factions = list()

	icon_state = "directional"

	var/class = "default"

	var/ai/ai

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/status = 0 //Negative status

	var/stun_time = 0 //Deciseconds of stun. Stun is being knocked down.
	var/sleep_time = 0 //Decieconds of sleep Sleep is being knocke down and blind.
	var/paralyze_time = 0 //Decieconds of paralyze. Paralyze is being unable to move.
	var/fatigue_time = 0 //Deciseconds of fatigue.

	var/first_life = TRUE

	//Base attributes.
	var/health_base = 10
	var/stamina_base = 10
	var/mana_base = 10

	var/armor_burn_base = 0
	var/armor_brute_base = 0

	//Regeneration times are in seconds.

	var/stamina_max = 0
	var/stamina_current = 0
	var/stamina_regeneration = 0

	var/mana_max = 0
	var/mana_current = 0
	var/mana_regeneration = 0

	var/health_regen_buffer = 0
	var/mana_regen_buffer = 0
	var/stamina_regen_buffer = 0

	var/boss_range = VIEW_RANGE
	var/list/mob/living/advanced/player/players_fighting_boss

	var/is_sneaking = FALSE
	var/stealth_mod = 0

	var/intent = INTENT_HELP

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

	var/has_footsteps = FALSE
	var/has_footprints = FALSE
	var/list/footstep_override

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	var/list/obj/hud/screen_blood/screen_blood

	var/list/armor_base = list(  //Base armor for the mob.
		BLADE = 0,
		BLUNT = 0,
		PIERCE = 0,
		LASER = 0,
		MAGIC = 0,
		HEAT = 25,
		COLD = -25,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 25,
		DARK = 25,
		FATIGUE = 0
	)

	interact_delay_base = 4

	var/allow_experience_gains = FALSE

	var/should_be_knocked_down = FALSE

/mob/living/destroy()

	factions.Cut()

	for(var/experience/E in attributes)
		qdel(E)

	attributes.Cut()

	for(var/experience/E in skills)
		qdel(E)

	skills.Cut()

	qdel(ai)
	ai = null

	if(screen_blood)
		for(var/obj/hud/screen_blood/S in screen_blood)
			qdel(S)

		screen_blood.Cut()

	all_living -= src

	if(old_turf)
		old_turf.old_living -= src

	old_turf = null

	if(boss)
		tracked_bosses -= src

	players_fighting_boss.Cut()

	return ..()

/mob/living/proc/get_brute_color()
	return "#FF0000"

/mob/living/proc/get_burn_color()
	return "#444444"

/mob/living/New(loc,desired_client,desired_level_multiplier)
	. = ..()

	if(desired_level_multiplier)
		level_multiplier *= desired_level_multiplier

	attributes = list()
	skills = list()
	factions = list()
	health_elements = list()
	//linked_players = list()
	players_fighting_boss = list()

	initialize_attributes()
	initialize_skills()

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

/mob/living/Initialize()
	initialize_factions()
	update_stats()
	update_health()
	stamina_current = stamina_max
	mana_current = mana_max
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


/mob/living/proc/initialize_factions()
	for(var/k in starting_factions)
		factions[k] = all_factions[k]