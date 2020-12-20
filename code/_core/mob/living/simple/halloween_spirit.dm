/mob/living/simple/halloween_spirit
	name = "spirit of halloween"
	desc = "No, not that one."
	desc_extended = "Extremely spooky spirits that only exist to bite your ankles."
	icon = 'icons/mob/living/simple/spooky.dmi'
	icon_state = "red"
	damage_type = /damagetype/melee/sword/claymore/cult
	class = /class/crab

	health_base = 50
	stamina_base = 100
	mana_base = 100

	value = 100

	ai = /ai/

	stun_angle = 0

	armor_base = list(
		LASER = AP_AXE,
		ARCANE = AP_AXE,
		HEAT = AP_AXE,
		COLD = AP_AXE,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = -AP_GREATCLUB,
		DARK = AP_GREATCLUB,
		FATIGUE = INFINITY,
		PAIN = INFINITY
	)

	mob_size = MOB_SIZE_ANIMAL

	movement_delay = DECISECONDS_TO_TICKS(2)

	loyalty_tag = "Ghost"
	iff_tag = "Ghost"

	blood_type = null

/mob/living/simple/halloween_spirit/blue
	icon_state = "blue"