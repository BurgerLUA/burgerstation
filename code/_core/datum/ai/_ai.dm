var/global/list/ai_attacking_players = list() //Assoc list. key is AI, value is list of players
var/global/list/ckeys_being_hunt_by = list() //Assoc list. key is ckey, value is list of AI

/ai/

	var/active = FALSE //Read only to deterimine if this AI is actually active.

	var/debug = FALSE //Enable or disable logging.

	var/mob/living/owner

	var/atom/objective_move
	var/should_follow_objective_move = FALSE
	var/should_burger_star_objective_move = FALSE

	var/mob/living/objective_attack
	var/atom/objective_investigate

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
	var/objective_delay = DECISECONDS_TO_TICKS(10)

	var/list/target_distribution_x = list(12,16,16,16,20)
	var/list/target_distribution_y = list(12,16,16,16,20)

	var/turf/start_turf

	var/roaming_distance = 5

	var/use_pathfinding = FALSE //For frustration.

	var/shoot_obstacles = TRUE

	var/left_click_chance = 90

	var/night_vision = 0.25 //What level of darkness the mob can see in. Basically if light is above this value, it can 100% see it.

	var/see_through_walls = FALSE //Can the ai see through walls?

	var/use_blood_sight = TRUE //Give a bonus chance to see targets if the mob's health is low. This is mostly a balance thing.

	var/timeout_threshold = 600 //Amount of deciseconds of inactivty is required to ignore players. Set to 0 to disable.

	var/frustration_attack = 0
	var/frustration_attack_threshold = SECONDS_TO_TICKS(6) //Above this means they'll try to find a new target. THIS IS MEASURED IN TICKS.

	var/frustration_move = 0
	var/frustration_move_threshold = 3 //Above this means they'll try to alter their movement. THIS IS MEASURED IN MOVEMENT FAILURES.

	var/frustration_path = 0
	var/frustration_path_threshold = 10 //Above this means they'll try to find a new path. THIS IS MEASURED IN MOVEMENT FAILURES.

	var/turf/path_start_turf
	var/turf/path_end_turf

	var/list/attackers = list()

	var/kick_chance = 10

	var/attack_movement_obstructions = TRUE //Should attack ALL obstructions if blocked.

	var/path_steps = 1
	var/list/obj/marker/map_node/current_node_path = list()

	var/list/current_path_astar = list()

	var/turf/last_combat_location //last location where there was an objective_attack

	var/list/obstacles = list()

	var/use_alerts = TRUE
	var/use_alert_overlays = FALSE //Funny MGS alert overlays.
	var/true_sight = FALSE //Set to true if it can see sneaking enemies.
	var/use_cone_vision = TRUE //Set to true if it can only see things in a cone. Set to false if it can see in a 360 degree view. Note that this only applies to when the NPC is not in alert.
	var/alert_level = ALERT_LEVEL_NONE //Alert level system
	var/alert_time = SECONDS_TO_TICKS(20) //In ticks
	var/sidestep_next = FALSE
	var/should_investigate_alert = TRUE

	var/grab_time = 0
	var/grab_time_max = 20 //How long, in deciseconds, should we allow someone to grab us?

	var/ignore_immortal = FALSE

	var/reaction_time = 8 //In Deciseconds.

	var/stored_sneak_power = 0

	var/resist_grabs = TRUE

	var/retaliate = TRUE //Should we attack when getting hit?
	var/aggression = 2 //Thanks elder scrolls.
	//0 = Does not search for enemies; only attacks when told to (example: getting hit by damage, when retaliate is true).
	//1 = Attacks enemies in enemy tags.
	//2 = Attacks people who don't have the same loyalty tag as them.
	//3 = Attacks literally everyone in sight, including friends if possible.
	var/assistance = 1
	//0 = Helps no one but themselves.
	//1 = Helps people with the same loyalty tag as them. Note that aggression needs to be equal or greater to 1 in order for this to work.
	var/cowardice = -1 //Set to a value equal or greater than 0 to enable. Acts as a value of what health percentage (0.00 to 1.00) the NPC will flee at.

	var/predict_attack = TRUE //Set to true if you want to predict if the target will attack the owner, if the target is an AI.

	var/list/enemy_tags = list()

	//Roaming Stuff. Mostly read only.
	var/roam = FALSE
	var/roam_counter = 10

	var/delete_on_no_path = FALSE

	var/idle_time = 0

	var/ignore_hazard_turfs = FALSE

	var/boss = FALSE

	var/hunt_distance = VIEW_RANGE*0.5 //Distance the mob will try to get close to if there is a valid hunt target.
	var/atom/hunt_target //Will try to chase this target through a combination of astar pathing and node pathing.
	var/turf/last_hunt_target_turf //Read only. The last turf that the target was on.
	var/next_node_check_time = 0

	//Dialogue related.
	var/language_to_use = LANGUAGE_BASIC
	var/next_talk = 0
	var/combat_dialogue/combat_dialogue

	var/knows_about_lockers = FALSE

/ai/Destroy()

	set_active(FALSE,TRUE)

	var/turf/T = get_turf(owner)
	if(T)
		remove_from_active_list(T.z)
		remove_from_inactive_list(T.z)
	else
		log_error("Warning: [src.get_debug_name()] couldn't be cleared properly as it the owner ([owner ? owner.get_debug_name() : "NULL"]) had a null turf.")

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

	if(current_node_path)
		current_node_path.Cut()
		current_node_path = null

	if(current_path_astar)
		current_path_astar.Cut()
		current_path_astar = null

	return ..()

/ai/proc/add_to_active_list(var/z)
	var/list/active_ai_list = boss ? SSbossai.active_ai_by_z : SSai.active_ai_by_z
	if(!active_ai_list["[z]"])
		active_ai_list["[z]"] = list()
	active_ai_list["[z]"] |= src

/ai/proc/remove_from_active_list(var/z)
	var/list/active_ai_list = boss ? SSbossai.active_ai_by_z : SSai.active_ai_by_z
	if(length(active_ai_list) && active_ai_list["[z]"])
		active_ai_list["[z]"] -= src

/ai/proc/add_to_inactive_list(var/z)
	var/list/inactive_ai_list = boss ? SSbossai.inactive_ai_by_z : SSai.inactive_ai_by_z
	if(!inactive_ai_list["[z]"])
		inactive_ai_list["[z]"] = list()
	inactive_ai_list["[z]"] |= src

/ai/proc/remove_from_inactive_list(var/z)
	var/list/inactive_ai_list = boss ? SSbossai.inactive_ai_by_z : SSai.inactive_ai_by_z
	if(length(inactive_ai_list) && inactive_ai_list["[z]"])
		inactive_ai_list["[z]"] -= src

/ai/proc/set_active(var/desired_active=TRUE,var/force=FALSE)

	if(desired_active)
		if(!owner)
			CRASH("AI was set to active without an owner!")
		if(owner.qdeleting)
			CRASH("AI was set to active while the owner was qdeleting!")
		if(owner.dead)
			CRASH("AI was set to active while the owner was dead!")

	if(!force && active == desired_active)
		return FALSE

	active = desired_active

	var/turf/T = get_turf(owner)

	if(!T)
		CRASH("AI had an invalid turf!")

	if(active)
		PROCESS_LIVING(owner)
		add_to_active_list(T.z)
		remove_from_inactive_list(T.z)
		HOOK_ADD("post_move","\ref[src]_post_move",owner,src,.proc/post_move)
		HOOK_ADD("pre_death","\ref[src]_pre_death",owner,src,.proc/pre_death)
	else
		if(owner && owner.processing)
			UNPROCESS_LIVING(owner)
		add_to_inactive_list(T.z)
		remove_from_active_list(T.z)
		set_alert_level(ALERT_LEVEL_NONE,TRUE)
		set_objective(null)
		set_move_objective(null)
		set_hunt_target(null)
		CALLBACK_REMOVE("set_new_objective_\ref[src]")
		attackers.Cut()
		obstacles.Cut()
		HOOK_REMOVE("post_move","\ref[src]_post_move",owner)
		HOOK_REMOVE("pre_death","\ref[src]_pre_death",owner)

	return TRUE

/ai/New(var/desired_loc,var/mob/living/desired_owner) //Byond assumes the first variable is always the loc so desired_loc needs to be in there. This makes me cry.
	owner = desired_owner
	objective_ticks = rand(0,objective_delay) //So enemies are desynced and don't move as one.
	start_turf = get_turf(owner) //The turf where the enemy spawned, or in some cases, after pathing.
	if(night_vision <= 0)
		night_vision = 0.5
	. = ..()
	if(!stored_sneak_power && is_living(owner))
		var/mob/living/L = owner
		stored_sneak_power = L.get_skill_power(SKILL_SURVIVAL,0,1,2)
	set_active(active,TRUE)

/ai/proc/pre_death(var/mob/living/L,args)
	set_active(FALSE,TRUE)
	return TRUE

