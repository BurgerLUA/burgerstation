/dialogue/npc/goblin_merchant/

/dialogue/npc/goblin_merchant/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = list()

	.["hello"] = list(
		"Welcome to Bawse loot. We don't actually sell boss loot, but we do sell #1! We also provide #2, where you can #3, for a small price.",
		"*supply crates",
		"*deathbox services",
		"*reclaim deathbox"
	)

	.["*supply crates"] = list(
		"We sell supply crates for those who feel lucky. Truth be told, we hate getting splinters and rather just sell the crates themselves. \
		No need to worry about us ripping you off; we never looked inside them or modifed their contents!"
	)

	.["*deathbox services"] = list(
		"Our perfectly legal goblin scavengers sometimes aquire lost equipment belonging to certain questionably legal NanoTrasen operatives. We don't have much use for \
		gross death-equipment, so we sell it back to NanoTrasen fror a nominal fee! Oh and by NanoTrasen, I mean you. Note that we don't have much storage in our er... \
		headquarters, so we only store 5 per person."
	)

	.["*reclaim deathbox"] = list("...")


/dialogue/npc/goblin_merchant/set_topic(var/mob/living/advanced/player/P,var/topic)

	. = ..()

	if(topic == "*reclaim deathbox")
		load_deathbox(P,P.dialogue_target)
		P.dialogue_target_id = null
		close_menu(P,/menu/dialogue/)
