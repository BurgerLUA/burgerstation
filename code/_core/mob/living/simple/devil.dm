/mob/living/simple/devil
	name = "devil demon"
	desc = "Evil in its skinny form."
	desc_extended = "A rare, extremely tall and extremely fast demon capable of annoying hit and run attacks. Can be found mostly anywhere."
	icon = 'icons/mob/living/simple/devil.dmi'
	icon_state = "living"

	health_base = 300
	stamina_base = 400
	mana_base = 300

	value = 200

	ai = /ai/

	damage_type = /damagetype/unarmed/claw/

	armor_base = list(
		BLUNT = 20,
		PIERCE = 40,
		LASER = -20,
		ARCANE = 20,
		HOLY = 40,
		DARK = 40,
		ION = INFINITY
	)

	size = SIZE_LARGE

	iff_tag = "Hell"
	loyalty_tag = "Hell"

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_type = /reagent/blood/cow
	blood_volume = 700

	soul_size = SOUL_SIZE_UNCOMMON

	level = 22

/mob/living/simple/devil/get_damage_type(var/atom/attacker,var/atom/victim)
	if(prob(25))
		return /damagetype/npc/devil_gore
	. = ..()

/mob/living/simple/devil/post_death()
	..()
	qdel(src)