/mob/living/advanced/npc/unique/rogue/that_guy
	name = "That Guy"
	desc = "Hey, it's that guy. From the demon hunting posters. Haha they're going to kill me."

	sex = MALE
	gender = MALE

	blood_type = /reagent/blood/human/ab_negative

	dna = /dna/human

	loadout = /loadout/that_guy

/mob/living/advanced/npc/unique/rogue/that_guy/setup_visuals()
	. = ..()
	change_organ_visual("skin", desired_color = "#CB7F4F")
	change_organ_visual("hair_head", desired_color = "#8A5B34", desired_icon_state = "hair_crewcut")