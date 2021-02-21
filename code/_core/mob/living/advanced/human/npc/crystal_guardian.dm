/mob/living/advanced/npc/crystal_guardian/
	name = "crystal guardian"
	desc = "A Crystal Guardian summoned from a leigon of knights that dedicate their lives towards protecting and advancing the knowlege of crystal magic."
	species = "human"
	var/desired_loadout = /loadout/crystal_guardian
	class = /class/crystal_guardian
	ai = /ai/advanced/crystal_guardian

/mob/living/advanced/npc/crystal_guardian/Initialize()
	. = ..()
	equip_loadout(desired_loadout)

	sex = pick(MALE,FEMALE)
	gender = sex

	