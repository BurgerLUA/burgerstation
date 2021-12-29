/mob/living/advanced/npc/crystal_guardian/
	name = "crystal guardian"
	desc = "A Crystal Guardian summoned from a leigon of knights that dedicate their lives towards protecting and advancing the knowlege of crystal magic."
	species = "human"
	ai = /ai/advanced/

	level = 25


/mob/living/advanced/npc/crystal_guardian/Initialize()
	. = ..()
	sex = pick(MALE,FEMALE)
	gender = sex
	equip_loadout(/loadout/crystal_guardian)

