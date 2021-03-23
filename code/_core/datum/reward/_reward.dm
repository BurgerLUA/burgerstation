#define FLAG_REWARD_NONE 0x0
#define FLAG_REWARD_ONCE 0x1
#define FLAG_REWARD_ONCE_PER_ROUND 0x2

/reward/
	var/name = "Reward Name"
	var/desc = "Reward Description"

	var/flags_reward = FLAG_REWARD_NONE

/reward/proc/can_reward(var/client/C)

	if(flags_reward & FLAG_REWARD_ONCE)
		var/savedata/client/globals/GD = GLOBALDATA(C.ckey)
		if(!GD || GD.loaded_data["redeemed_rewards"] && ("[src.type]" in GD.loaded_data["redeemed_rewards"]))
			C.to_chat(span("warning","You already redeemed this reward!"))
			return FALSE

	if(flags_reward & FLAG_REWARD_ONCE_PER_ROUND)
		if(SSreward.redeemed_rewards_by_ckey[C.ckey] && SSreward.redeemed_rewards_by_ckey[C.ckey]["[src.type]"])
			C.to_chat(span("warning","You already redeemed this reward this round!"))
			return FALSE

	return TRUE

/reward/proc/on_reward(var/client/C)

	if(flags_reward & FLAG_REWARD_ONCE)
		var/savedata/client/globals/GD = GLOBALDATA(C.ckey)
		if(!GD || !GD.loaded_data["redeemed_rewards"])
			GD.loaded_data["redeemed_rewards"] = list()
		GD.loaded_data["redeemed_rewards"] |= "[src.type]"

	if(flags_reward & FLAG_REWARD_ONCE_PER_ROUND)
		if(!SSreward.redeemed_rewards_by_ckey[C.ckey])
			SSreward.redeemed_rewards_by_ckey[C.ckey] = list()
		SSreward.redeemed_rewards_by_ckey[C.ckey] |= "[src.type]"

	return TRUE

/reward/proc/on_fail(var/client/C)
	return TRUE

/reward/credits/
	name = "Credit Reward"
	desc = "Dosh!"

	var/credits_to_give = 0

/reward/credits/can_reward(var/client/C)
	if(is_player(C.mob))
		var/mob/living/advanced/player/P = C.mob
		if(P.allow_save)
			return ..()
	C.to_chat(span("danger","You cannot receive this reward as a non-player! Redeem this reward as a player to receive it!"))
	return FALSE


/reward/credits/on_reward(var/client/C)
	var/mob/living/advanced/player/P = C.mob
	P.adjust_currency(credits_to_give)
	return ..()


/reward/burgerbux
	name = "BurgerBux reward."
	desc = "Dosh!"

	var/burgerbux_to_give = 0

/reward/burgerbux/can_reward(var/client/C)
	if(is_player(C.mob))
		var/mob/living/advanced/player/P = C.mob
		if(P.allow_save)
			return ..()
	C.to_chat(span("danger","You cannot receive this reward as a non-player! Redeem this reward as a player to receive it!"))
	return FALSE

/reward/burgerbux/on_reward(var/client/C)
	var/mob/living/advanced/player/P = C.mob
	P.adjust_burgerbux(burgerbux_to_give)
	return ..()


/reward/burgerbux/survey_oct_2020
	name = "October 2020 Survey Reward"
	desc = "A 20 burgerbux reward for completing the October 2020 Player Survey"
	flags_reward = FLAG_REWARD_ONCE
	burgerbux_to_give = 20

/reward/burgerbux/survey_mar_2021
	name = "March 2021 Survey Reward"
	desc = "A 20 burgerbux reward for completing the March 2021 Player Survey"
	flags_reward = FLAG_REWARD_ONCE
	burgerbux_to_give = 20