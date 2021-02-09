/ai/

	var/mob/living/owner

	var/atom/objective_move
	var/should_follow_objective_move = FALSE

	var/mob/living/objective_attack
	var/atom/objective_investigate

	var/check_for_obstructions = TRUE //Pathing only

	var/radius_find_enemy = AI_DETECTION_RANGE //No alert.
	var/radius_find_enemy_noise = AI_DETECTION_RANGE_NOISE
	var/radius_find_enemy_caution = AI_DETECTION_RANGE_CAUTION
	var/radius_find_enemy_combat = AI_DETECTION_RANGE_COMBAT

	//Measured in ticks.
	var/objective_ticks = 0

	//Measured in ticks.
	var/objective_delay = DECISECONDS_TO_TICKS(10)

	var/list/target_distribution_x = list(8,16,16,16,24)
	var/list/target_distribution_y = list(8,16,16,16,24)

	var/turf/start_turf

	var/roaming_distance = 5

	var/shoot_obstacles = TRUE

	var/attack_distance_min = 0
	var/attack_distance_max = 1

	var/left_click_chance = 90

	var/timeout_threshold = 600 //Amount of deciseconds of inactivty is required to ignore players. Set to 0 to disable.

	var/frustration_attack = 0
	var/frustration_attack_threshold = 4 //Above this means they'll try to find a new target.

	var/frustration_move = 0
	var/frustration_move_threshold = 4 //Above this means they'll try to alter their movement.

	var/frustration_path = 0
	var/frustration_path_threshold = 10 //Above this means they'll try to find a new path.

	var/turf/path_start_turf
	var/turf/path_end_turf

	var/list/attackers = list()

	var/kick_chance = 10

	var/attack_on_block = TRUE

	var/path_steps = 1
	var/list/Vector3D/current_path = list()

	var/list/obstacles = list()

	var/distance_target_min = 1
	var/distance_target_max = 1

	var/use_alerts = TRUE
	var/true_sight = FALSE //Set to true if it can see invisible enemies.
	var/use_cone_vision = TRUE //Set to true if it can only see things in a cone. Set to false if it can see in a 360 degree view. Note that this only applies to when the NPC is not in alert.
	var/alert_level = ALERT_LEVEL_NONE //Alert level system
	var/alert_time = SECONDS_TO_TICKS(8) //In ticks
	var/sidestep_next = FALSE
	var/should_investigate_alert = TRUE

	var/grab_time = 0
	var/grab_time_max = 20 //How long, in deciseconds, should we allow someone to grab us?

	var/ignore_immortal = FALSE

	var/list/enemy_tags = list()

	var/reaction_time = 4 //In Deciseconds.

	var/stored_sneak_power = 0

	var/resist_grabs = TRUE

	var/retaliate = TRUE //Should we attack when getting hit?
	var/aggression = 2 //Thanks elder scrolls.
	//0 = Does not search for enemies; only attacks when told to (example: getting hit by damage, when retaliate is true).
	//1 = Attacks enemies in enemy tags.
	//2 = Attacks people who don't have the same loyalty tag as them.
	//3 = Attacks literally everyone in sight.
	var/assistance = 1
	//0 = Helps no one but themselves.
	//1 = Helps people with the same loyalty tag as them.
	var/predict_attack = TRUE //Set to true if you want to predict if the target will attack the owner.

	//Roaming Stuff. Mostly read only.
	var/roam = FALSE
	var/roam_counter = 10

	var/debug = FALSE

	var/active = FALSE

	var/delete_on_no_path = FALSE

	var/idle_time = 0

	var/ignore_hazard_turfs = FALSE

/ai/Destroy()
	if(owner) owner.ai = null
	owner = null
	objective_move = null
	objective_attack = null
	objective_investigate = null
	start_turf = null
	path_start_turf = null
	path_end_turf = null

	if(attackers)
		attackers.Cut()
		attackers = null

	if(obstacles)
		obstacles.Cut()
		obstacles = null

	if(current_path)
		current_path.Cut()
		current_path = null

	SSai.active_ai -= src
	SSai.inactive_ai -= src

	SSbossai.active_ai -= src
	SSbossai.inactive_ai -= src

	return ..()

/ai/proc/set_active(var/desired_active=TRUE,var/force=FALSE)

	if(!force && active == desired_active)
		return FALSE

	active = desired_active

	if(active)
		SSai.active_ai |= src
		SSai.inactive_ai -= src
	else
		SSai.active_ai -= src
		SSai.inactive_ai |= src

		set_objective(null)
		set_move_objective(null)
		CALLBACK_REMOVE("set_new_objective_\ref[src]")
		attackers.Cut()
		obstacles.Cut()

	return TRUE

/ai/New(var/desired_loc,var/mob/living/desired_owner) //Byond assumes the first variable is always the loc so desired_loc needs to be in there. This makes me cry.

	owner = desired_owner

	objective_ticks = rand(0,objective_delay)

	start_turf = get_turf(owner)

	if(!stored_sneak_power && is_living(owner))
		var/mob/living/L = owner
		stored_sneak_power = L.get_skill_power(SKILL_SURVIVAL)

	return ..()

/ai/PostInitialize()
	. = ..()
	set_active(active,TRUE)
	return .