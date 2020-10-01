#define REWARD_DIR "data/server/reward_codes.txt"




SUBSYSTEM_DEF(reward)
	name = "Reward Subsystem"
	desc = "Handles rewards and whatnot."
	priority = SS_ORDER_PRELOAD

	var/list/reward_code_to_reward = list()
	var/list/stored_rewards = list()
	var/list/redeemed_rewards_by_ckey = list() //Only with FLAG_REWARD_ONCE_PER_ROUND set.

/subsystem/reward/Initialize()

	for(var/k in subtypesof(/reward/))
		var/reward/R = new k
		stored_rewards[R.type] = R
		log_subsystem(src.name,"Created reward [R.name]([R.type]).")

	if(fexists(REWARD_DIR))
		var/loaded = file2text(REWARD_DIR)
		var/list/loaded_list = splittext(loaded,"\n")
		var/current_line = 0
		for(var/line in loaded_list)
			current_line++
			var/list/code_type_pair = splittext(line," ")
			if(length(code_type_pair) != 2)
				log_error("Reward Subsystem: Could not correctly parse line [current_line] of [REWARD_DIR].")
				continue
			var/code = code_type_pair[1]
			var/reward = text2path(code_type_pair[2])
			if(!reward || !stored_rewards[reward])
				log_error("Reward Subsystem: Invalid reward type \"[code_type_pair[2]]\" for line [current_line] of [REWARD_DIR].")
			code = sanitize(code) //So it's always the same.
			reward_code_to_reward[code] = stored_rewards[reward]
			var/debug_reward = sanitize("[reward_code_to_reward[code]] = [reward]")
			log_subsystem(src.name,"Found reward: [debug_reward].")
	else
		log_subsystem(src.name,"Reward directory \"[REWARD_DIR]\" does not exist.")


	return ..()


/subsystem/reward/proc/check_code(var/client/C,var/desired_code)

	if(!reward_code_to_reward[desired_code])
		C.to_chat(span("warning","Invalid reward code! Reward codes can be obtained and entered here upon completing special surveys or events."))
		return FALSE

	var/reward/R = reward_code_to_reward[desired_code]

	if(R.can_reward(C))
		R.on_reward(C)
	else
		R.on_fail(C)

	return TRUE