/mob/living/simple/npc/captain_beepsky
	name = "Captain Beepsky"
	desc = "He's the Captain now."
	desc_extended = "A named securitron model. It is programmed to guard the shuttle from punk passengers via bluespace stunbaton. Its circuits and wheels are a little loose..."
	icon = 'icons/mob/living/simple/beepsky.dmi'
	icon_state = "captain"

	health_base = 10000 //I'm a god.
	immortal = TRUE //How can you kill a god?


	ai = /ai/doorman
	class = /class/beepsky
	damage_type = /damagetype/npc/captain_beepsky

	iff_tag = "NanoTrasen"
	loyalty_tag = "NanoTrasen"

	mob_size = MOB_SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE