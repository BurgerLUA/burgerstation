/mob/living/simple/bear
	name = "brown bear"
	desc = "She will devour you, blyat!"
	desc_extended = "A harmful critter."
	icon = 'icons/mob/living/simple/bears.dmi'
	icon_state = "brown"
	damage_type = /damagetype/unarmed/claw/


	value = 100

	ai = /ai/

	stun_angle = 90

	armor = /armor/tough_furred

	health_base = 200
	stamina_base = 100
	mana_base = 50

	butcher_contents = list(
		/obj/item/container/edible/dynamic/meat/raw_bear/,
		/obj/item/container/edible/dynamic/meat/raw_bear/,
		/obj/item/container/edible/dynamic/meat/raw_bear/,
		/obj/item/container/edible/dynamic/meat/raw_bear/
	)

	size = SIZE_GIANT

	var/armored = FALSE

	iff_tag = "Bear"
	loyalty_tag = "Bear"

	blood_type = /reagent/blood/bear
	blood_volume = 700

	soul_size = SOUL_SIZE_UNCOMMON

	level = 6

/mob/living/simple/bear/update_overlays()
	. = ..()

	if(armored)
		var/image/I = new/image(initial(icon),"armor")
		add_overlay(I)

/mob/living/simple/bear/Finalize()
	. = ..()
	update_sprite()

/mob/living/simple/bear/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/bear/armored
	name = "armored bear"

	armor = /armor/tough_furred/armored

	armored = TRUE

	level = 9

/mob/living/simple/bear/armored/revolutionary
	name = "armored slavic bear"
	loyalty_tag = "Revolutionary"
	iff_tag = "Revolutionary"

	enable_security_hud = TRUE
	enable_medical_hud = TRUE

	level = 12

/mob/living/simple/bear/snow
	name = "snow bear"
	icon_state = "white"

	armor = /armor/tough_furred/snow

	level = 7

/mob/living/simple/bear/black
	name = "black bear"
	icon_state = "black"

	level = 8

/mob/living/simple/bear/space
	name = "space bear"
	icon_state = "space"

	armor = /armor/tough_furred/space

	level = 9
