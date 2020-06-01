/mob/living/simple/npc/captain_beepsky
	name = "Captain Beepsky"
	desc = "He's the Captain now."
	desc_extended = "A named securitron model. It is programmed to guard the shuttle from punk passengers via bluespace stunbaton. Its circuits and wheels are a little loose..."
	icon = 'icons/mob/living/simple/beepsky.dmi'
	icon_state = "captain"

	health_base = 1000 //I'm a god.
	immortal = TRUE //How can you kill a god?
	damage_received_multiplier = 0.1 //What a grand and intoxicating innocence.


	ai = /ai/doorman
	class = "beepsky"
	damage_type = /damagetype/npc/captain_beepsky

	iff_tag = "NanoTrasen"
	loyalty_tag = "NanoTrasen"
