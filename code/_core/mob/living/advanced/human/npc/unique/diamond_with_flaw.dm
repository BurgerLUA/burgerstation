/mob/living/advanced/human/npc/unique/diamond_with_flaw
	name = "Diamond with Flaw"
	desc = "Fucking trees."
	mob_species = /datum/species/diona/

	mob_outfit = /datum/outfit/diamond_with_flaw/

	ai = null

	gender = NEUTER

/mob/living/advanced/human/npc/unique/diamond_with_flaw/Initialize()
	..()
	change_color_skin("#BC9D58")
	change_secondary_color("#719333")
	change_glow_color("#B2F861")