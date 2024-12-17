/mob/living/advanced/npc/ashwalker
	name = "ashwalker villager"
	desc = "Walker of the ash."
	desc_extended = "A more primitive cousin to the lizardmen that NanoTrasen hires, these bipedal Ashwalkers tend to hunt in lava-infested regions for meat and leather. They're hostile to anything that isn't their own kin."

	dna = /dna/lizard
	ai = /ai/advanced/ashwalker

	species = "reptile"

	loadout = /loadout/ashwalker/
	loyalty_tag = "Ashwalker"
	iff_tag = "Ashwalker"

	level = 10

/mob/living/advanced/npc/ashwalker/Initialize()
	. = ..()
	drops_gold = RAND_PRECISE(0.5,1.25) * level * (1/CREDITS_PER_GOLD)

/mob/living/advanced/npc/ashwalker/female
	loadout = /loadout/ashwalker/female
	gender = FEMALE

//Hunter
/mob/living/advanced/npc/ashwalker/hunter
	name = "ashwalker hunter"
	loadout = /loadout/ashwalker/hunter
	level = 20

/mob/living/advanced/npc/ashwalker/hunter/female
	loadout = /loadout/ashwalker/hunter/female
	gender = FEMALE

//Shaman
/mob/living/advanced/npc/ashwalker/shaman
	name = "ashwalker shaman"
	loadout = /loadout/ashwalker/shaman
	level = 60

/mob/living/advanced/npc/ashwalker/shaman/female
	loadout = /loadout/ashwalker/shaman/female
	gender = FEMALE

//Warrior
/mob/living/advanced/npc/ashwalker/warrior
	name = "ashwalker warrior"
	loadout = /loadout/ashwalker/warrior
	level = 40

/mob/living/advanced/npc/ashwalker/warrior/female
	loadout = /loadout/ashwalker/warrior/female
	gender = FEMALE