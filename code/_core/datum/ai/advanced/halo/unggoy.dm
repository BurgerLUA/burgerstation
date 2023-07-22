/ai/advanced/halo/unggoy
	enemy_tags = list("NanoTrasen","Syndicate")
	should_find_weapon = TRUE
	roaming_distance = 8
	aggression = 2
	assistance = 1

	var/language_to_use = LANGUAGE_BASIC

/ai/advanced/halo/unggoy/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(damage_amount >= 10 && . && prob(40))
		if(prob(10) && get_dist(owner,attacker) >= 3)
			var/attack_dir = dir2text(get_dir(owner,attacker))
			owner.do_say("Taking fire from the [attack_dir]!")
		else
			var/list/responses = list(
				"A-ah don't let him near the nipple!",
				"STOP molesting me!",
				"You big bastards!",
				"They got my [atom_damaged.name]!",
				"They hit me in the [atom_damaged.name]!",
				"We suck as one! We fight as one!",
				"You'll kill us!",
				"This is a biblical kind of doom!",
				"I just wet myself!",
				"Well this suck i'm going north!",
				"Me little! But very, VERY angry!!!",
				"Why are humans been showing in groups of four or more? I miss good old days, when just one young guy and little blue lady!",
				"YOU GIANT BULLYING MONSTERRRR!"
			)
			owner.do_say(pick(responses),language_to_use = language_to_use)

	return .


/ai/advanced/halo/unggoy/on_alert_level_changed(var/old_alert_level,var/new_alert_level,var/atom/alert_source)

	. = ..()

	if(. && prob(55))
		var/list/responses = list()
		if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_CAUTION)
			responses = list(
				"Not there!",
				"Why is he chasing me?",
				"He's undead!",
				"Quick question! Have we ever wondered off to go look for the enemy? And not ended up dead!",
				"Shh! Me hunting herwatics!",
				"Green - good camouflage. SHINY green? Not so musch!"
			)
		else if(old_alert_level == ALERT_LEVEL_COMBAT && new_alert_level == ALERT_LEVEL_NONE)
			responses = list(
				"Here comes the grunty punishment!",
				"His boots are mine.",
				"It's safe to come out?",
				"Any more?"
			)
		else if(old_alert_level == ALERT_LEVEL_CAUTION && new_alert_level == ALERT_LEVEL_COMBAT)
			responses = list(
				"Told yah, chicken!",
				"Stick together nipple mates!",
				"Oh my stars and gardens, there he is!",
				"You are unfit for nipple!",
				"JERKS! YOU! ALL OF YAH!",
				"Please enjoy my BRIGHT. BLUE. BALLS.",
				"Hey look he's here! I thought he was just a piece of scenery, but not it's him!",
				"Bad guy, 12 o'clock! Is anybody wearing a watch?",
				"Heres one for yo mama!",
				"Because of you, MY kids can't get enough gas. OR NIPPLE!",
				"Take off suit, get on knees, THEN see who's tough!"
			)
		else if(old_alert_level == ALERT_LEVEL_NONE && new_alert_level == ALERT_LEVEL_NOISE)
			responses = list(
				"You hear that?",
				"What was that?",
				"Did you hear something?",
				"Wait. What was that?"
			)
		else if(new_alert_level == ALERT_LEVEL_NOISE)
			responses = list(
				"I know I heard something...",
				"Where are you?",
				"Come out... where are you?",
				"I swear I heard something..."
			)
		else if(new_alert_level == ALERT_LEVEL_NONE)
			responses = list(
				"Nothing here. Resuming patrols.",
				"Resuming patrols."
			)

		if(length(responses))
			owner.do_say(pick(responses),language_to_use = language_to_use)

	return .

/ai/advanced/halo/unggoy/lobby
	active = TRUE