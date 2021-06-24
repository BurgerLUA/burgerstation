/mob/living/simple/clockwork_fragment
	name = "clockwork fragment"
	desc = "Spooky!"
	desc_extended = "A fragment of an old soul that previously served Ratvar."
	icon = 'icons/mob/living/simple/clockwork_fragment.dmi'
	icon_state = "living"

	health_base = 200
	stamina_base = 200
	mana_base = 200

	ai = /ai/simple/
	damage_type = /damagetype/unarmed/fists


	stun_angle = 0

	iff_tag = "Clockwork"
	loyalty_tag = "Clockwork"

	size = SIZE_LARGE

	blood_type = null
	blood_volume = 0

	soul_size = SOUL_SIZE_COMMON

/mob/living/simple/clockwork_fragment/post_death()
	. = ..()
	icon_state = "dead"
