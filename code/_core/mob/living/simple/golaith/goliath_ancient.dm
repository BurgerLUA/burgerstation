/mob/living/simple/goliath/ancient
	name = "ancient goliath"
	icon = 'icons/mob/living/simple/lavaland/goliath_ancient.dmi'
	icon_state = "agoliath"
	damage_type = /damagetype/unarmed/claw/


	ai = /ai/goliath/ancient

	stun_angle = 0

	health_base = 400

	armor = /armor/goliath

	size = SIZE_GIANT

	blood_type = /reagent/blood/ancient
	blood_volume = 1000

	butcher_contents = list(
		/obj/item/container/edible/dynamic/meat/raw_goliath,
		/obj/item/container/edible/dynamic/meat/raw_goliath
	)

	soul_size = SOUL_SIZE_UNCOMMON

	level = 40