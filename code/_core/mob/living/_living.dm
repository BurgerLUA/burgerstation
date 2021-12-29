/mob/living/

	health_base = 50
	stamina_base = 50
	mana_base = 50

	enable_chunk_clean = TRUE

	vis_flags = VIS_INHERIT_ID

	var/rarity = RARITY_COMMON

	var/list/experience/attribute/attributes
	var/list/experience/skill/skills

	movement_delay = DECISECONDS_TO_TICKS(1)

	icon_state = "directional"

	var/class = /class/npc
	var/level = 1

	var/enable_AI = FALSE
	var/ai/ai
	//var/id //Boss ID

	var/iff_tag
	var/loyalty_tag

	var/list/dynamic_variable_base = list()
	var/list/dynamic_variable_mul = list()
	var/list/dynamic_variable_add = list()

	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/death_threshold = 0 //If you're below this health, then you're dead.

	var/nutrition = 1000
	var/nutrition_max = 1000
	var/nutrition_fast = 0
	var/hydration = 1000
	var/hydration_max = 1000
	var/nutrition_quality = 1000 //0 to 2000. 2000 means super health, 0 means absolutely fucking obese unfit and all that.
	var/nutrition_quality_max = 2000
	var/intoxication = 0
	var/last_intoxication_message = 0

	var/blood_type = /reagent/blood
	var/blood_volume = BLOOD_VOLUME_DEFAULT
	var/blood_volume_max = 0 //Set to blood_volume on new.
	var/blood_toxicity = 0 //Value of how toxic your blood is. Increased by consuming chems.
	var/chem_power = 1 //Multiplier of chemical power. Changed via blood toxicity.

	var/blood_oxygen = 0 //Additional blood oxygen.

	var/first_life = TRUE

	var/brute_regen_buffer = 0
	var/burn_regen_buffer = 0
	var/tox_regen_buffer = 0
	var/pain_regen_buffer = 0
	var/rad_regen_buffer = 0
	var/sanity_regen_buffer = 0
	var/mana_regen_buffer = 0
	var/stamina_regen_buffer = 0

	var/health_regen_delay = 0
	var/stamina_regen_delay = 0
	var/mana_regen_delay = 0
	//Oxy not present as that is controlled via an organ.
	//The rest are not present as you cannot naturally regenerate them.

	var/boss_range = VIEW_RANGE
	var/list/mob/living/advanced/player/players_fighting_boss

	var/is_sneaking = FALSE
	var/stealth_mod = 0

	var/selected_intent = INTENT_HELP
	var/intent = INTENT_HELP

	var/turf/old_turf //Last turf someone has been in.

	var/stun_angle = 90

	var/boss = FALSE
	var/boss_music
	var/boss_icon_state
	var/loot/boss_loot

	//var/list/mob/living/advanced/player/linked_players

	var/respawn = TRUE
	var/respawn_time = SECONDS_TO_DECISECONDS(180) //In deciseconds
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
		ARCANE = 0,
		HEAT = 0,
		COLD = 0,
		BOMB = 0,
		BIO = 0,
		RAD = 0,
		HOLY = 100,
		DARK = 100,
		FATIGUE = 0,
		ION = INFINITY,
		PAIN = 0,
		SANITY = 0
	)

	var/list/mob_value

	var/list/status_immune = list() //What status effects area they immune to?
	//STATUS = TRUE //Means it's immune.
	//STATUS = OTHERSTATUS //Means it will do OTHERSTATUS instead for half the duration.

	var/damage_received_multiplier = 1

	var/dead = FALSE
	var/time_of_death = -1

	var/obj/structure/buckled_object

	reagents = /reagent_container/living

	var/image/medical_hud_image
	var/image/security_hud_image
	var/image/medical_hud_image_advanced

	var/has_footsteps = TRUE

	var/climb_counter = 0

	var/stand/stand

	var/list/status_effects = list()

	acceleration_mod = 0.5
	acceleration = 5
	deceleration = 10
	use_momentum = TRUE

	var/override_butcher = FALSE //Set to true for custom butcher contents.
	var/list/obj/butcher_contents = list()

	var/next_resist = 0
	var/resist_counter = 0

	size = SIZE_ANIMAL //Size scale when calculating health as well as collision handling for things like crates and doors. See size.dm for values

	var/max_level = 500 //Max level for attributes of the mob.

	var/is_typing = FALSE
	var/talk_duration = 0
	var/talk_type = 0

	var/obj/effect/chat_overlay
	var/obj/effect/alert_overlay
	var/obj/effect/fire_overlay
	var/obj/effect/shield_overlay

	var/enable_medical_hud = TRUE
	var/enable_security_hud = TRUE

	var/footstep_mod = 2 //How many cycles required to make a footstep sound.
	var/footstep_counter = 0 //Read only
	var/footstep_left_right_counter = FALSE //Read only. For playing left/right footstep sounds. Good only for advanced but you never know.

	var/on_fire = FALSE
	var/fire_stacks = 0 //Fire remaining. Measured in deciseconds.

	var/fatigue_mul = 1 //Multipier of fatigue damage given due to blocking projectiles with armor.
	var/pain_mul = 1

	value = 250

	var/mob/living/advanced/player/following = null

	var/suicide = FALSE

	var/mob/living/minion //This object's minion.
	var/mob/living/master //This object's master.
	var/minion_remove_time = 0

	var/obj/structure/totem/totem //This object's totem.

	var/queue_health_update = FALSE //From automated processes like reagent and health updating. Should not be used for bullet impacts and whatnot.

	known_emotes = list(
		"laugh",
		"cough",
		"deathgasp",
		"gasp",
		"grenade",
		"medic",
		"pain",
		"scream",
		"dab",
		"nod",
		"shake",
		"bow",
		"fist",
		"think",
		"wave",
		"shrug",
		"cheer",
		"beckon",
		"yawn",
		"cry",
		"clap",
		"salute",
		"spin",
		"inhale",
		"drag",
		"help"
	)

	var/tabled = FALSE
	var/currently_tabled = FALSE

	density = TRUE

	var/list/defense_bonuses = list() //From perks, powers, and whatever.

	var/blocking = FALSE

	var/list/addictions = list() //List of addictions.

	var/soul_size = null

	var/list/traits = list() //Assoc list. This is saved.
	var/list/traits_by_category = list() //Assoc list. This isn't saved.

	can_be_bumped = FALSE

	var/delete_on_death = FALSE

	var/drops_gold = 0 //Set to a value to make this mob drop this amount of gold when it dies.

	var/obj/hud/flash/flash_overlay

	var/deafened_duration = 0

	var/list/hit_logs = list()

/mob/living/Destroy()

	buckled_object = null

	if(minion)
		minion.master = null
		minion = null

	if(master)
		master.minion = null
		master = null

	QDEL_NULL(totem)

	if(following)
		following.followers -= src
		following = null

	QDEL_CUT(linked_mobs)

	if(fallback_mob)
		fallback_mob.linked_mobs -= src
		attributes = null
		skills = null
	else
		QDEL_CUT_ASSOC(attributes)
		QDEL_CUT_ASSOC(skills)

	QDEL_NULL(ai)

	if(screen_blood)
		QDEL_CUT(screen_blood)

	hit_logs?.Cut()

	all_living -= src

	if(old_turf && old_turf.old_living)
		old_turf.old_living -= src
	old_turf = null

	if(boss)
		SSbosses.tracked_bosses -= src
		SSbosses.living_bosses -= src

	players_fighting_boss?.Cut()

	QDEL_NULL(alert_overlay)
	QDEL_NULL(chat_overlay)
	QDEL_NULL(fire_overlay)
	QDEL_NULL(shield_overlay)

	QDEL_NULL(medical_hud_image)
	QDEL_NULL(security_hud_image)
	QDEL_NULL(medical_hud_image_advanced)

	QDEL_NULL(flash_overlay)

	if(client)
		CRASH_SAFE("[src.get_debug_name()] deleted itself while there was still a client ([client]) attached!")
		client.make_ghost(FALLBACK_TURF)

	traits?.Cut()
	traits_by_category?.Cut()

	status_effects?.Cut()

	QDEL_NULL(stand)

	return ..()

/mob/living/proc/try_rot()

	if(!isturf(src.loc))
		return FALSE

	var/area/A = get_area(src)
	if(A.flags_area & FLAGS_AREA_NO_EVENTS)
		CALLBACK("rot_\ref[src]",ROT_DELAY,src,.proc/try_rot)
		return FALSE

	var/turf/possible_turfs = list()
	for(var/turf/simulated/T in view(VIEW_RANGE,src))
		if(!T.organic)
			continue
		if(T.lightness > 0)
			continue
		if(!T.is_safe_teleport())
			continue
		possible_turfs += T

	if(!length(possible_turfs))
		CALLBACK("rot_\ref[src]",ROT_DELAY,src,.proc/try_rot)
		return FALSE

	var/turf/chosen_turf = pick(possible_turfs)

	var/mob/living/advanced/npc/beefman/B = new(chosen_turf)
	INITIALIZE(B)
	GENERATE(B)
	FINALIZE(B)
	B.ai.set_path_astar(src.loc)

	return TRUE

/mob/living/proc/bang(var/duration=100)

	if(!client)
		return FALSE

	if(duration <= 0)
		return FALSE

	deafened_duration = max(deafened_duration,duration)

/mob/living/get_sound_environment()

	if(deafened_duration > 0)
		return ENVIRONMENT_UNDERWATER

	. = ..()

/mob/living/get_sound_volume(var/volume=100,var/channel=1)

	. = ..()

	if(deafened_duration > 0 && channel != SOUND_CHANNEL_MUSIC && channel != SOUND_CHANNEL_FLASHBANG)
		. *= 0.01


/mob/living/proc/flash(var/duration=100,var/desired_color="#FFFFFF")

	if(!client)
		return FALSE

	if(duration <= 0)
		return FALSE

	if(flash_overlay)
		flash_overlay.duration = max(duration,flash_overlay.duration)
		flash_overlay.color = desired_color
		return TRUE

	flash_overlay = new
	flash_overlay.owner = src
	flash_overlay.duration = duration
	flash_overlay.color = desired_color
	client.screen += flash_overlay

	return TRUE

/mob/living/on_crush() //What happens when this object is crushed by a larger object.
	. = ..()
	play_sound(pick('sound/effects/impacts/flesh_01.ogg','sound/effects/impacts/flesh_02.ogg','sound/effects/impacts/flesh_03.ogg'),get_turf(src))
	visible_message(span("danger","\The [src.name] is violently crushed!"))
	if(blood_type)
		var/reagent/R = REAGENT(blood_type)
		for(var/i=1,i<=9,i++)
			create_blood(/obj/effect/cleanable/blood/splatter,get_turf(src),R.color,rand(-32,32),rand(-32,32))
	death(TRUE)
	if(!qdeleting) qdel(src)

/mob/living/on_fall(var/turf/old_loc)
	. = ..()
	health?.adjust_loss_smart(brute=100)
	add_status_effect(STUN,40,40)

/mob/living/get_base_value()
	. = ..()
	if(!dead) . *= 3

/mob/living/get_debug_name()
	return "[dead ? "(DEAD)" : ""][src.name]([src.client ? src.client : "NO CKEY"])([src.type])<a href='?spectate=1;x=[x];y=[y];z=[z]'>([x],[y],[z])</a>"

/mob/living/get_log_name()
	return "[dead ? "(DEAD)" : ""][src.name]([src.client ? src.client : "NO CKEY"])([src.type])([x],[y],[z])"

/mob/living/proc/dust()
	new /obj/effect/temp/death(src.loc,30)
	qdel(src)
	return TRUE

/mob/living/New(loc,desired_client,desired_level_multiplier)

	blood_volume_max = blood_volume

	if(desired_level_multiplier > 0)
		level *= desired_level_multiplier

	attributes = list()
	skills = list()
	//factions = list()
	health_elements = list()
	players_fighting_boss = list()

	if(enable_medical_hud)
		medical_hud_image = new/image('icons/hud/medihud.dmi',"0")
		medical_hud_image.loc = src
		medical_hud_image.layer = PLANE_AUGMENTED
		medical_hud_image.pixel_y = 4
		medical_hud_image.appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM

		medical_hud_image_advanced = new/image('icons/hud/damage_hud.dmi',"000")
		medical_hud_image_advanced.loc = src
		medical_hud_image_advanced.layer = PLANE_AUGMENTED
		medical_hud_image_advanced.appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM

	if(enable_security_hud)
		security_hud_image = new/image('icons/hud/sechud.dmi',"unknown")
		security_hud_image.loc = src
		security_hud_image.layer = PLANE_AUGMENTED
		security_hud_image.appearance_flags = RESET_COLOR | RESET_ALPHA | RESET_TRANSFORM

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

	shield_overlay = new(src.loc)
	shield_overlay.layer = LAYER_EFFECT
	shield_overlay.icon = 'icons/obj/effects/combat.dmi'
	shield_overlay.icon_state = "block"
	shield_overlay.alpha = 0

	. = ..()

	if(desired_client)
		screen_blood = list()
		screen_blood += new /obj/hud/screen_blood(src,NORTHWEST)
		screen_blood += new /obj/hud/screen_blood(src,NORTHEAST)
		screen_blood += new /obj/hud/screen_blood(src,SOUTHEAST)
		screen_blood += new /obj/hud/screen_blood(src,SOUTHWEST)
		screen_blood += new /obj/hud/screen_blood(src,SOUTH) //Actually the center

	all_living += src


/mob/living/Initialize()

	if(ai) ai = new ai(null,src)

	if(boss)
		SSbosses.tracked_bosses += src
		SSbosses.living_bosses += src

	initialize_attributes()
	initialize_skills()

	update_intent(TRUE)

	. = ..()

/mob/living/PostInitialize()
	. = ..()
	if(health)
		health.armor_base = armor_base
	if(ai)
		INITIALIZE(ai)
	set_loyalty_tag(loyalty_tag,TRUE)
	set_iff_tag(iff_tag,TRUE)
	setup_name()

/mob/living/Finalize()

	. = ..()

	if(ai)
		FINALIZE(ai)

	if(boss)
		for(var/mob/living/advanced/player/P in viewers(VIEW_RANGE,src))
			for(var/obj/hud/button/boss_health/B in P.buttons)
				B.target_bosses |= src
				B.update_stats()
	if(dead)
		dead = FALSE //I know this feels like shitcode but *dab
		death()

	update_level(TRUE)

/mob/living/proc/setup_name()
	if(boss)
		return FALSE
	name = "[CHECK_NAME(name)] (LVL: [level])"
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
		health.update_health() //TODO: Find out what the fuck this is for.

	return ..()

/mob/living/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)

	if(desired_loyalty && loyalty_tag && desired_loyalty == loyalty_tag && owner != src)
		return TRUE

	if(magnitude > 6)
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

	else if(magnitude > 4)
		add_status_effect(STUN,magnitude*3,magnitude*3)

	else if(magnitude > 2)
		add_status_effect(STAGGER,magnitude,magnitude, source = epicenter)

	if(health)
		do_explosion_damage(owner,source,epicenter,magnitude,desired_loyalty)

	return TRUE

/mob/living/proc/do_explosion_damage(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)
	var/list/params = list()
	params[PARAM_ICON_X] = 16
	params[PARAM_ICON_Y] = 16
	var/atom/object_to_damage = src.get_object_to_damage(owner,source,params,FALSE,TRUE)
	var/damagetype/D = all_damage_types[/damagetype/explosion/]
	D.process_damage(source,src,source,object_to_damage,owner,magnitude)
	return TRUE

/mob/living/proc/draw_blood(var/mob/caller,var/atom/needle,var/amount=0,var/messages = TRUE)

	if(!blood_type || !min(amount,blood_volume))
		if(messages) caller?.to_chat(span("warning","There is no blood to draw!"))
		return FALSE

	var/amount_added = needle.reagents.add_reagent(blood_type,min(amount,blood_volume),caller = caller)
	blood_volume -= amount_added
	queue_health_update = TRUE

	if(messages)
		caller?.visible_message(span("notice","\The [caller.name] draws some blood from \the [src.name]."),span("notice","You drew [amount_added]u of blood from \the [src.name]."))

	return amount_added
