/mob/living/simple/clockwork_marauder
	name = "clockwork marauder"
	desc = "Spooky!"
	desc_extended = "A fragment of an old soul that previously served Ratvar, kitted in armor."
	icon = 'icons/mob/living/simple/clockwork_marauder.dmi'
	icon_state = "living"

	health_base = 500
	stamina_base = 500
	mana_base = 100

	ai = /ai/simple/
	damage_type = /damagetype/melee/spear/ratvar/
	class = /class/clockwork_marauder

	stun_angle = 0

	iff_tag = "Clockwork"
	loyalty_tag = "Clockwork"

	size = SIZE_LARGE

	blood_type = null
	blood_volume = 0

/mob/living/simple/clockwork_marauder/post_death()
	. = ..()
	icon_state = "dead"
	return .