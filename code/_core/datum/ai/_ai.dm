var/global/list/ai_attacking_players = list() //Assoc list. key is AI, value is list of players
var/global/list/ckeys_being_hunt_by = list() //Assoc list. key is ckey, value is list of AI

/ai/

	var/can_attack = TRUE

	var/active = FALSE //Read only to deterimine if this AI is actually active.

	var/debug = FALSE //Enable or disable logging.

	var/mob/living/owner

	var/atom/objective_move
	var/should_follow_objective_move = FALSE
	var/should_astar_objective_move = FALSE
	var/objective_move_distance = 1 //The follow distance.

	var/mob/living/objective_attack

	var/check_for_obstructions = TRUE //Pathing only

	var/radius_find_enemy = AI_DETECTION_RANGE //No alert.
	var/radius_find_enemy_noise = AI_DETECTION_RANGE_NOISE
	var/radius_find_enemy_caution = AI_DETECTION_RANGE_CAUTION
	var/radius_find_enemy_combat = AI_DETECTION_RANGE_COMBAT

	var/distance_target_min = 1 //The minimum distance in which the mob can start "clicking" to attack.
	var/distance_target_max = 1 //The maximum distance in which the mob can start "clicking" to attack.

	var/attack_distance_min = 0 //The minimum distance in which the mob should move to the target to attack.
	var/attack_distance_max = 1 //The maximum distance in which the mob should move to the target to attack.

	//Measured in ticks.
	var/objective_ticks = 0

	//Measured in ticks.
	var/objective_delay = SECONDS_TO_TICKS(4) //Base objective delay. Gets smaller with alertness.

	var/list/target_distribution_x = list(12,16,20)
	var/list/target_distribution_y = list(4.8,12,16,20,24)

	var/turf/home_turf //Where the mob's home is.

	var/attack_obstacles = TRUE

	var/left_click_chance = 90

	var/night_vision = 0.25 //What level of darkness the mob can see in. Basically if light is above this value, it can 100% see it. Lower is better.

	var/see_through_walls = FALSE //Can the ai see through walls?

	var/use_blood_sight = TRUE //Give a bonus chance to see targets if the mob's health is low. This is mostly a balance thing.

	var/timeout_threshold = 600 //Amount of deciseconds of inactivty is required to ignore players. Set to 0 to disable.

	var/frustration_attack = 0
	var/frustration_attack_threshold = SECONDS_TO_TICKS(6) //Above this means they'll try to find a new target. THIS IS MEASURED IN TICKS.

	var/frustration_move = 0
	var/frustration_move_threshold = 10 //Above this means they'll try to alter their movement. THIS IS MEASURED IN MOVEMENT FAILURES.
	var/use_astar_on_frustration_move = FALSE
	var/sidestep_on_frustration_move = FALSE

	var/frustration_node_path = 0
	var/frustration_node_path_threshold = 10 //Above this means they'll try to find a new node path. THIS IS MEASURED IN MOVEMENT FAILURES.

	var/frustration_astar_path = 0
	var/frustration_astar_path_threshold = 10 //Above this means they'll try to find a new node path. THIS IS MEASURED IN MOVEMENT FAILURES.

	var/list/attackers = list()

	var/attack_movement_obstructions = TRUE //Should attack ALL obstructions if blocked.

	var/list/astar_path_current = list()
	var/atom/astar_path_current_object
	var/astar_path_current_object_sensitivity_max = 4 //Distance from the target to repath. If the distance is more than this, repath the path.
	var/astar_path_current_object_sensitivity_min = 2 //Distance from the target to not repath. If the distance is less than this, remove the path.

	var/node_path_current_step = 1
	var/list/obj/marker/map_node/node_path_current = list()
	var/turf/node_path_start_turf
	var/turf/node_path_end_turf
	var/node_path_current_object

	var/turf/last_combat_location //last location where there was an objective_attack

	var/list/obstacles = list()

	var/use_alerts = TRUE
	var/use_alert_overlays = FALSE //Funny MGS alert overlays.
	var/true_sight = FALSE //Set to true if it can see sneaking enemies.
	var/use_cone_vision = TRUE //Set to true if it can only see things in a cone. Set to false if it can see in a 360 degree view. Note that this only applies to when the NPC is not in alert.
	var/alert_level = ALERT_LEVEL_NONE //Alert level system
	var/alert_time = SECONDS_TO_TICKS(10) //In ticks
	var/sidestep_next = FALSE
	var/should_investigate_alert = TRUE
	var/alert_movement_latch = 0x0 //Direction

	var/grab_time = 0
	var/grab_time_max = 20 //How long, in deciseconds, should we allow someone to grab us?

	var/ignore_immortal = FALSE

	var/reaction_time = 8 //In Deciseconds.

	var/stored_sneak_power = 0

	var/resist_grabs = 1
	//0 = do not resist grabs
	//1 = resist grabs by enemies
	//2 = resist grabs by everyone

	var/retaliate = TRUE //Should we attack when getting hit?
	var/aggression = 2 //Thanks elder scrolls.
	//0 = Does not search for enemies; only attacks when told to (example: getting hit by damage, when retaliate is true).
	//1 = Attacks enemies in enemy tags.
	//2 = Attacks people who don't have the same loyalty tag as them, except for AI (unless the AI is in combat).
	//3 = Attacks people who don't have the same loyalty tag as them, including AI.
	//4 = Attacks literally everyone in sight, including friends if possible.
	var/assistance = 1
	//0 = Helps no one but themselves.
	//1 = Helps people with the same loyalty tag as them. Note that aggression needs to be equal or greater to 1 in order for this to work.
	var/cowardice = -1 //Set to a value equal or greater than 0 to enable. Acts as a value of what health percentage (0.00 to 1.00) the NPC will flee at.

	var/predict_attack = TRUE //Set to true if you want to predict if the target will attack the owner, if the target is an AI.

	var/list/enemy_tags = list()

	//Roaming Stuff.
	var/allow_far_roaming = FALSE //Set to true to change the origin point of the roam when the roam finishes.
	var/roaming_distance = 0 //Allowed distance to roam. Set to a value above 0 to enable.
	var/roaming_counter = 0 //Allowed steps to roam. Will be set to double roaming_distance, so there is no point in changing this.
	var/roaming_direction = 0x0 // The direction the mob is currently romaing. Don't change this.

	var/guard = FALSE //Set to true if the mob constantly tries to guard the current location.

	var/enable_loc_safety = TRUE //Set to true to tell the AI to move in a random direction if it's not on a turf (usually in a crate or a locker).

	var/delete_on_no_path = FALSE

	var/idle_time = 0

	var/ignore_hazard_turfs = FALSE

	var/boss = FALSE

	var/hunt_distance = VIEW_RANGE*0.5 //Distance the mob will try to get close to if there is a valid hunt target.
	var/atom/hunt_target //Will try to chase this target through a combination of astar pathing and node pathing.
	var/turf/last_hunt_target_turf //Read only. The last turf that the target was on.
	var/next_node_check_time = 0

	var/next_talk = 0

	var/knows_about_lockers = FALSE

	var/move_from_ally_dir = 0x0
	var/move_from_ally = 0

	var/sleep_on_idle = TRUE

	var/last_movement_proc = "none"

	var/ai/master_ai
	var/list/ai/linked_ais

/ai/proc/set_master_ai(var/ai/target_ai)

	if(target_ai == master_ai)
		return FALSE

	if(src == target_ai)
		return FALSE

	if(master_ai) //If we already have a master ai, remove it.
		master_ai.linked_ais -= src

	master_ai = target_ai //Set it to the desired target_ai

	if(master_ai)
		if(!master_ai.linked_ais)
			master_ai.linked_ais = list()
		master_ai.linked_ais += src //Add ourselves to linked AIs.
		if(master_ai.objective_attack)
			src.objective_attack = master_ai.objective_attack
		if(master_ai.astar_path_current)
			src.astar_path_current = master_ai.astar_path_current.Copy()
		if(master_ai.node_path_current)
			src.node_path_current = master_ai.node_path_current.Copy()

	if(length(src.linked_ais))
		for(var/k in linked_ais)
			var/ai/A = k
			A.set_master_ai(master_ai)

	return TRUE

/ai/PreDestroy()

	if(length(linked_ais)) //Reset master.
		var/ai/new_master_ai = linked_ais[1]
		for(var/k in linked_ais)
			var/ai/linked_ai = k
			if(new_master_ai == linked_ai)
				linked_ai.set_master_ai(null)
			else
				linked_ai.set_master_ai(new_master_ai)

	set_active(FALSE,deleting=TRUE)

	if(owner) owner.ai = null
	owner = null

	. = ..()

/ai/Destroy()

	objective_move = null
	objective_attack = null
	home_turf = null
	node_path_start_turf = null
	node_path_end_turf = null

	if(attackers)
		attackers.Cut()
		attackers = null

	if(obstacles)
		obstacles.Cut()
		obstacles = null

	if(node_path_current)
		node_path_current.Cut()
		node_path_current = null

	if(astar_path_current)
		astar_path_current.Cut()
		astar_path_current = null

	. = ..()

/ai/New(var/desired_loc,var/mob/living/desired_owner) //Byond assumes the first variable is always the loc so desired_loc needs to be in there. This makes me cry.
	owner = desired_owner
	roaming_counter = roaming_distance*2
	objective_ticks = rand(0,objective_delay) //So enemies are desynced and don't move as one.
	home_turf = get_turf(owner) //The turf where the enemy spawned, or in some cases, after pathing.
	. = ..()
	if(!stored_sneak_power && is_living(owner))
		var/mob/living/L = owner
		stored_sneak_power = L.get_skill_power(SKILL_SURVIVAL,0,1,2)

/ai/proc/pre_death(var/mob/living/L,args)
	set_active(FALSE)
	return TRUE

