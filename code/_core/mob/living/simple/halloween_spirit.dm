/mob/living/simple/halloween_spirit
	name = "spirit of halloween"
	desc = "No, not that one."
	desc_extended = "Extremely spooky spirits that only exist to bite your ankles."
	icon = 'icons/mob/living/simple/spooky.dmi'
	icon_state = "red"
	damage_type = /damagetype/melee/sword/claymore/cult


	health_base = 50
	stamina_base = 100
	mana_base = 100

	value = 100

	ai = /ai/

	stun_angle = 0

	armor = /armor/default_organic

	size = SIZE_ANIMAL

	movement_delay = DECISECONDS_TO_TICKS(2)

	loyalty_tag = "Ghost"
	iff_tag = "Ghost"

	blood_type = null

	soul_size = SOUL_SIZE_COMMON

	level = 18

/mob/living/simple/halloween_spirit/blue
	icon_state = "blue"