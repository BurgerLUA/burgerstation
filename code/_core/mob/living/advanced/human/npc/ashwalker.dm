/mob/living/advanced/npc/ashwalker
	name = "ashwalker villager"
	desc = "Walker of the ash."
	desc_extended = "A more primitive cousin to the lizardmen that NanoTrasen hires, these bipedal Ashwalkers tend to hunt in lava-infested regions for meat and leather. They're hostile to anything that isn't their own kin."

	dna = /dna/lizard
	ai = /ai/advanced/ashwalker

	species = "reptile"

	var/loadout_to_use_male = /loadout/ashwalker/
	var/loadout_to_use_female = /loadout/ashwalker/female

	loyalty_tag = "Ashwalker"
	iff_tag = "Ashwalker"

	level = 8

/mob/living/advanced/npc/ashwalker/Generate()
	drops_gold = RAND_PRECISE(0.5,1.25) * level * (1/SSeconomy.credits_per_gold)
	gender = pick(MALE,FEMALE)
	sex = gender
	if(gender == FEMALE)
		loadout = loadout_to_use_female
	else
		loadout = loadout_to_use_male
	. = ..()

/mob/living/advanced/npc/ashwalker/hunter
	name = "ashwalker hunter"
	loadout_to_use_male = /loadout/ashwalker/hunter
	loadout_to_use_female = /loadout/ashwalker/hunter/female

	level = 14

/mob/living/advanced/npc/ashwalker/assassin
	name = "ashwalker assassin"

	loadout_to_use_male = /loadout/ashwalker/assassin
	loadout_to_use_female = /loadout/ashwalker/assassin/female

	level = 22

/mob/living/advanced/npc/ashwalker/warrior
	name = "ashwalker warrior"

	loadout_to_use_male = /loadout/ashwalker/warrior
	loadout_to_use_female = /loadout/ashwalker/warrior/female

	level = 50