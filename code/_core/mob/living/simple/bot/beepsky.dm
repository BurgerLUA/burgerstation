/mob/living/simple/bot/securitron/captain
	name = "Captain Beepsky"
	desc = "He's the Captain now."
	desc_extended = "A named securitron model. It is programmed to guard the shuttle from punk passengers via bluespace stunbaton. Its circuits and wheels are a little loose..."
	icon = 'icons/mob/living/simple/beepsky.dmi'
	icon_state = "captain"

	immortal = TRUE //How can you kill a god?

	ai = /ai/doorman
	class = /class/beepsky
	damage_type = /damagetype/npc/captain_beepsky

	iff_tag = "NanoTrasen"
	loyalty_tag = "NanoTrasen"

	size = SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

/mob/living/simple/bot/securitron/captain/can_be_grabbed(var/atom/grabber,var/messages=FALSE)

	if(messages && is_living(grabber))
		var/mob/living/L = grabber
		L.to_chat(span("warning","Beepsky instantly resists out of your grab!"))

	return FALSE