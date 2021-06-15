/contract/
	var/name = "Contract Name"
	var/desc = "Contract Description"
	var/atom/type_to_check
	var/amount_min = 0
	var/amount_max = 0
	var/reward_min = 0
	var/reward_max = 0
	var/reward_text = "objectives completed"

/contract/proc/get_random_reward()
	if(!reward_min)
		return reward_max
	if(!reward_max)
		return reward_min
	return rand(reward_min,reward_max)

/contract/proc/get_random_amount()
	if(!amount_min)
		return amount_max
	if(!amount_max)
		return amount_min
	return rand(amount_min,amount_max)

/contract/ashwalkers
	name = "Kill Ashwalkers"
	desc = "Kill Ashwalkers."
	type_to_check = /mob/living/advanced/npc/ashwalker
	amount_min = 20
	amount_max = 50
	reward_min = 5000
	reward_max = 10000
	reward_text = "Ashwalkers killed"