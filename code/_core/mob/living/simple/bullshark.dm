/mob/living/simple/bullshark
	name = "bullshark"
	icon = 'icons/mob/living/simple/bullshark.dmi'
	icon_state = "living"

	health_base = 200
	stamina_base = 200
	mana_base = 50

	ai = /ai/bullshark

	damage_type = /damagetype/unarmed/bite/

	iff_tag = "Meme"
	loyalty_tag = "Meme"

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	size = SIZE_GIANT

	blood_type = /reagent/blood/carp
	blood_volume = 750

	butcher_contents = list(
		/obj/item/container/edible/dynamic/fish/raw_carp,
		/obj/item/container/edible/dynamic/fish/raw_carp,
		/obj/item/container/edible/dynamic/fish/raw_carp,
		/obj/item/container/edible/dynamic/fish/raw_carp
	)

	armor = /armor/carp/shark

	stun_angle = 180

	soul_size = SOUL_SIZE_COMMON

	level = 12

/mob/living/simple/bullshark/post_death()
	. = ..()
	icon_state = "dead"

