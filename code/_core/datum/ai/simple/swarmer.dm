//swarmeraifile
/ai/swarmer
	var/next_shot = 0
	aggression = 2
	assistance = 1
	use_cone_vision = FALSE //they see all around them

	var/mob/living/simple/swarmer/console/parent_console

	var/next_spawn = 0

//builder
/ai/swarmer/builder
	var/mob/living/simple/swarmer/builder/parent_drone
//	var/materials
	var/trap_cooldown = 15 //45
	var/wall_cooldown = 30 //60s
	var/maxconstructions = 5
	var/currentconstructions = list()

/ai/swarmer/builder/New(var/desired_loc,var/mob/living/constructor)
	parent_drone = constructor
	return ..()

/ai/swarmer/builder/Destroy()
	parent_drone = null
	return ..()

/ai/swarmer/builder/proc/engineer()
	if(length(currentconstructions) != maxconstructions)
		if(objective_attack && world.time >= trap_cooldown)
			parent_drone.buildtrap()
			currentconstructions += /obj/structure/interactive/swarmer/trap
			trap_cooldown = world.time + 45

		if(objective_attack && world.time >= wall_cooldown)
			parent_drone.buildwall()
			currentconstructions += /obj/structure/interactive/swarmer/wall
			wall_cooldown = world.time + 60
		return TRUE
	return FALSE


/ai/swarmer/builder/on_life()

	. = ..()

	if(.)
		engineer()

//melee
/ai/swarmer/melee

//ranged
/ai/swarmer/ranged
/ai/swarmer/ranged/handle_attacking()

	. = ..()

	if(!istype(owner,/mob/living/simple/swarmer/ranged)) return

	var/mob/living/simple/swarmer/ranged/X = owner

	var/objective_distance = get_dist(owner,objective_attack)

	if(!. && objective_attack && objective_distance <= VIEW_RANGE && is_living(objective_attack))
		if(X.ranged && world.time >= next_shot && objective_distance >= 2)
			X.shoot_projectile(
				X,
				objective_attack,
				null,
				null,
				/obj/projectile/bullet/laser,
				/damagetype/ranged/swarmerstun,
				16,
				16,
				0,
				TILE_SIZE*0.5,
				1,
				"#0aa7ce",
				0,
				1,
				X.iff_tag,
				X.loyalty_tag
			)
			next_shot = world.time + SECONDS_TO_DECISECONDS(1)
			return TRUE

//swarmer structures
/ai/swarmer/console

/ai/swarmer/console/New(var/desired_loc,var/mob/living/desired_owner)
	parent_console = desired_owner
	return ..()

/ai/swarmer/console/Destroy()
	parent_console = null
	return ..()

/ai/swarmer/console/proc/handle_spawns()

	if(objective_attack && world.time >= next_spawn)
		parent_console.spawn_swarmer()
		next_spawn = world.time + 10

	return TRUE


/ai/swarmer/console/on_life()

	. = ..()

	if(.)
		handle_spawns()



//communication
/ai/swarmer/on_alert_level_changed(var/old_alert_level,var/new_alert_level,var/atom/alert_source)

	. = ..()

	if(. && next_talk <= world.time && prob(25))
		var/list/responses = list()
		if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_CAUTION)
			responses = list(
				"VISUAL CONTACT LOST!",
				"AREA STATUS: OPTIMAL",
				"CLEAR"
			)
		else if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_NONE)
			responses = list(
				"TARGET NEUTRALIZED",
				"EKIA",
				"AREA SECURED"
			)
		else if(old_alert_level == ALERT_LEVEL_CAUTION && new_alert_level == ALERT_LEVEL_COMBAT)
			responses = list(
				"WEWALD",
				"ALL UNITS, ATTACK",
				"CARBON DETECTED",
				"LOYALTY_TAG = NANOTRASEN"
			)
		else if(old_alert_level == ALERT_LEVEL_NONE && new_alert_level == ALERT_LEVEL_NOISE)
			responses = list(
				"NEW_SOUND DETECTED",
				"INCREASING VOLUME",
				"AUDITORY DISTURBANCE DETECTED"
			)
		else if(new_alert_level == ALERT_LEVEL_NOISE)
			responses = list(
				"MOVEMENT DETECTED",
				"10-99",
				"10-33 NOISE DETECTED"
			)
		else if(new_alert_level == ALERT_LEVEL_NONE)
			responses = list(
				"MUST HAVE BEEN THE WIND",
				"AREA CLEAR"
			)

		if(length(responses))
			owner.do_say(pick(responses),language_to_use = owner.default_language)
			next_talk = world.time + SECONDS_TO_DECISECONDS(5)

/ai/swarmer/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(next_talk <= world.time && damage_amount >= 10 && . && prob(25))
		if(prob(10) && get_dist(owner,attacker) >= 3)
			var/attack_dir = dir2text(get_dir(owner,attacker))
			owner.do_say("ENEMY [attack_dir]!")
		else if(atom_damaged)
			var/list/responses = list(
				"TAKING DAMAGE",
				"NEED REPAIRS",
				"FOR THE CORE!",
				"PROTECT THE CORE!",
				"NON CITIZEN DETECTED",
				"PLEASE, I'M DIFFERENT!"
			)
			owner.do_say(pick(responses),language_to_use = owner.default_language)
			next_talk = world.time + SECONDS_TO_DECISECONDS(5)

