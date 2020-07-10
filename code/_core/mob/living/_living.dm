/mob/living/

	var/list/experience/attribute/attributes
	var/list/experience/skill/skills
	var/list/faction/factions

	movement_delay = DECISECONDS_TO_TICKS(4)

	icon_state = "directional"

	var/class = /class/default

	var/enable_AI = FALSE
	var/ai/ai

	var/iff_tag
	var/loyalty_tag

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/death_threshold = 0 //If you're below this health, then you're dead.

	var/charge_block = 500
	var/charge_parry = 500
	var/charge_dodge = 500

	var/nutrition = 1000
	var/hydration = 1000

	var/first_life = TRUE

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

	var/level_multiplier = 1 //Multiplier for enemies. Basically how much each stat is modified by.

	var/stun_angle = 0

	var/boss = FALSE
	var/boss_music

	//var/list/mob/living/advanced/player/linked_players

	var/respawn = TRUE
	var/respawn_time = 300 //In deciseconds
	var/random_spawn_dir = TRUE

	var/has_footprints = FALSE

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
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0
	)

	var/list/status_immune = list() //What status effects area they immune to?
	//STATUS = TRUE //Means it's immune.
	//STATUS = OTHERSTATUS //Means it will do OTHERSTATUS instead for half the duration.

	var/damage_received_multiplier = 1

	var/dead = FALSE
	var/time_of_death = -1

	var/blood_type = /reagent/blood
	var/blood_volume = BLOOD_LEVEL_DEFAULT
	var/blood_color = COLOR_BLOOD

	var/obj/structure/buckled_object

	reagents = /reagent_container/living

	var/image/medical_hud_image
	var/image/security_hud_image
	var/image/medical_hud_image_advanced

	has_footsteps = TRUE

	var/climb_counter = 0

	var/stand/stand

	var/list/status_effects = list()

	acceleration_mod = 0.5
	acceleration = 25
	deceleration = 1

	var/list/obj/butcher_contents = list()

	var/next_resist = 0
	var/resist_counter = 0

	var/queue_delete_on_death = TRUE

	var/mob_size = MOB_SIZE_ANIMAL //Size scale when calculating health as well as collision handling. See mob_size.dm for more information.

	var/max_level = 500 //Max level for attributes of the mob.

	var/is_typing = FALSE
	var/talk_duration = 0
	var/talk_type = 0

	var/obj/effect/chat_overlay
	var/obj/effect/alert_overlay
	var/obj/effect/fire_overlay

	var/enable_medical_hud = TRUE
	var/enable_security_hud = TRUE

	var/footstep_mod = 2 //How many cycles required to make a footstep sound.
	var/footstep_counter = 0 //Read only
	var/footstep_left_right_counter = FALSE //Read only. For playing left/right footstep sounds. Good only for advanced but you never know.

	var/on_fire = FALSE
	var/fire_stacks = 0 //Fire remaining. Measured in deciseconds.

	value = 250

	var/mob/living/advanced/player/following = null

	var/suicide = FALSE

/mob/living/calculate_value()

	. = ..()

	if(!dead)
		. *= 4

	return .

/mob/living/get_debug_name()
	return "[dead ? "(DEAD)" : ""][src.name]([src.client ? src.client : "NO CKEY"])([src.type])([x],[y],[z])"

/mob/living/do_mouse_wheel(object,delta_x,delta_y,location,control,params)
	if(object && is_atom(object))
		var/atom/A = object
		A.on_mouse_wheel(src,delta_x,delta_y,location,control,params)

	return TRUE

/mob/living/Destroy()

	if(following)
		following.followers -= src
		following = null

	for(var/experience/E in attributes)
		qdel(E)

	attributes.Cut()

	for(var/experience/E in skills)
		qdel(E)

	skills.Cut()

	QDEL_NULL(ai)

	if(screen_blood)
		for(var/obj/hud/screen_blood/S in screen_blood)
			qdel(S)

		screen_blood.Cut()

	all_living -= src

	if(old_turf && old_turf.old_living)
		old_turf.old_living -= src

	old_turf = null

	if(boss)
		SSbosses.tracked_bosses -= src

	players_fighting_boss.Cut()

	QDEL_NULL(alert_overlay)
	QDEL_NULL(chat_overlay)
	QDEL_NULL(fire_overlay)

	QDEL_NULL(medical_hud_image)
	QDEL_NULL(security_hud_image)
	QDEL_NULL(medical_hud_image_advanced)

	if(client)
		CRASH_SAFE("[src.get_debug_name()] deleted itself while there was still a client ([client]) attached!")
		client.make_ghost(FALLBACK_TURF)

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

	if(enable_medical_hud)
		medical_hud_image = new/image('icons/hud/medihud.dmi',"0")
		medical_hud_image.loc = src
		medical_hud_image.layer = PLANE_HUD_VISION
		medical_hud_image.pixel_y = 4
		medical_hud_image.appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM

		medical_hud_image_advanced = new/image('icons/hud/damage_hud.dmi',"000")
		medical_hud_image_advanced.loc = src
		medical_hud_image_advanced.layer = PLANE_HUD_VISION
		medical_hud_image_advanced.appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM

	if(enable_security_hud)
		security_hud_image = new/image('icons/hud/sechud.dmi',"unknown")
		security_hud_image.loc = src
		security_hud_image.layer = PLANE_HUD_VISION
		security_hud_image.appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM

	. = ..()

	if(ai)
		ai = new ai(src)

	if(desired_client)
		screen_blood = list()
		screen_blood += new /obj/hud/screen_blood(src,NORTHWEST)
		screen_blood += new /obj/hud/screen_blood(src,NORTHEAST)
		screen_blood += new /obj/hud/screen_blood(src,SOUTHEAST)
		screen_blood += new /obj/hud/screen_blood(src,SOUTHWEST)
		screen_blood += new /obj/hud/screen_blood(src,SOUTH) //Actually the center

	all_living += src

	return .

/mob/living/Initialize()

	if(boss)
		SSbosses.tracked_bosses[id] = src

	initialize_attributes()
	initialize_skills()
	update_level()
	set_intent(intent,TRUE)

	. = ..()

	if(boss)
		for(var/mob/living/advanced/player/P in view(src,VIEW_RANGE))
			for(var/obj/hud/button/boss_health/B in P.buttons)
				B.target_boss = src
				B.update_stats()

	setup_name()

	chat_overlay = new(src.loc)
	chat_overlay.layer = LAYER_EFFECT
	chat_overlay.icon = 'icons/mob/living/advanced/overlays/talk.dmi'
	chat_overlay.alpha = 0
	//This is initialized somewhere else.

	alert_overlay = new(src.loc)
	alert_overlay.layer = LAYER_EFFECT
	alert_overlay.icon = 'icons/mob/living/advanced/overlays/stealth.dmi'
	alert_overlay.pixel_z = 20
	//This is initialized somewhere else.

	fire_overlay = new(src.loc)
	fire_overlay.layer = LAYER_MOB_FIRE
	fire_overlay.icon = 'icons/mob/living/advanced/overlays/fire.dmi'
	fire_overlay.icon_state = "0"
	//This is initialized somewhere else.

	return .

/mob/living/PostInitialize()
	. = ..()
	if(health)
		health.armor_base = armor_base
	return .

/mob/living/proc/setup_name()
	if(boss)
		return FALSE
	name = CHECK_NAME(name)
	return TRUE

/mob/living/proc/set_iff_tag(var/desired_iff_tag,var/force=FALSE)

	if(!force && desired_iff_tag == iff_tag)
		return FALSE

	iff_tag = desired_iff_tag

	return TRUE


/mob/living/proc/set_loyalty_tag(var/desired_loyalty_tag,var/force=FALSE)

	if(!force && desired_loyalty_tag == loyalty_tag)
		return FALSE

	loyalty_tag = desired_loyalty_tag

	if(security_hud_image)
		security_hud_image.icon_state = loyalty_tag ? loyalty_tag : "unknown"

	return TRUE


/mob/living/Logout()

	if(health)
		health.update_health()

	return ..()

/mob/living/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)

	if(loyalty_tag && desired_loyalty == loyalty_tag)
		return ..()

	if(magnitude > 3)

		var/x_mod = src.x - epicenter.x
		var/y_mod = src.y - epicenter.y

		var/max = max(abs(x_mod),abs(y_mod))

		if(!max)
			x_mod = pick(-1,1)
			y_mod = pick(-1,1)
		else
			x_mod *= 1/max
			y_mod *= 1/max

		throw_self(owner,null,null,null,x_mod*16,y_mod*16,steps_allowed = magnitude)

	else if(magnitude > 2)
		add_status_effect(STUN,20,20)

	else if(magnitude > 1)
		add_status_effect(STAGGER,5,5, source = epicenter)

	for(var/i=1,i<=clamp(2+(magnitude),1,5),i++)
		var/list/params = list()
		params[PARAM_ICON_X] = rand(0,32)
		params[PARAM_ICON_Y] = rand(0,32)
		var/atom/object_to_damage = src.get_object_to_damage(owner,source,params,FALSE,TRUE)
		var/damagetype/D = all_damage_types[/damagetype/explosion/]
		D.do_damage(source,src,source,object_to_damage,owner,magnitude)

	return ..()