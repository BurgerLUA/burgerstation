/mob/living/simple/spacecarp/
	name = "giant carp"
	desc = "Wait, where is the space?"
	icon = 'icons/mob/living/simple/carp.dmi'
	icon_state = "living"

	ai = /ai/carp
	damage_type = /damagetype/unarmed/bite/

	health_base = 150
	stamina_base = 100
	mana_base = 50

	value = 100

	butcher_contents = list(
		/obj/item/container/edible/dynamic/fish/raw_carp/,
		/obj/item/container/edible/dynamic/fish/raw_carp/,
		/obj/item/container/edible/dynamic/fish/raw_carp/
	)

	collision_flags = FLAG_COLLISION_FLYING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	loyalty_tag = "Carp"
	iff_tag = "Carp"

	armor = /armor/carp

	size = SIZE_GIANT

	movement_delay = AI_TICK //I'm fast as fuck boi.

	has_footsteps = FALSE

	stun_angle = 0

	blood_type = /reagent/blood/carp

	soul_size = SOUL_SIZE_COMMON

	level = 8

	var/color_body = "#FFFFFF"
	var/color_eyes = "#FFFFFF"
	var/color_iris = "#FFFFFF"

/mob/living/simple/spacecarp/proc/generate_colors()
	var/r = rand(0,1) ? 1 : RAND_PRECISE(0,1) //This is fucky, but it werks.
	var/g = r == 1 ? rand(0,1) : RAND_PRECISE(0,1)
	var/b = r == 1 || g == 1 ? rand(0,1) : RAND_PRECISE(0,1)
	var/black = rand(0,50)
	color_body = rgb(r*255,g*255,b*255)
	color_iris = rgb(255,rand(100,255),0)
	color_eyes = rgb(black,black,black)
	return TRUE

/mob/living/simple/spacecarp/Generate()
	. = ..()
	generate_colors()

/mob/living/simple/spacecarp/Finalize()
	. = ..()
	update_sprite()

/mob/living/simple/spacecarp/update_overlays()
	. = ..()

	icon_state = "none"

	var/state = dead ? "dead" : "living"

	var/image/I_body = new/image(icon,"[state]_body")
	I_body.color = color_body
	add_overlay(I_body)

	var/image/I_mouth = new/image(icon,"[state]_mouth")
	add_overlay(I_mouth)

	var/image/I_eyes = new/image(icon,"[state]_eyes")
	I_eyes.color = color_eyes
	add_overlay(I_eyes)

	var/image/I_iris = new/image(icon,"[state]_iris")
	I_iris.color = color_iris
	add_overlay(I_iris)

/mob/living/simple/spacecarp/post_death()
	. = ..()
	update_sprite()

/mob/living/simple/spacecarp/leader
	name = "alpha giant carp"

	level = 28

/mob/living/simple/spacecarp/jungle
	name = "giant jungle carp"
	level = 14

/mob/living/simple/spacecarp/jungle/generate_colors()
	var/r = RAND_PRECISE(0,0.5)
	var/g = RAND_PRECISE(0.1,0.25)
	var/b = 0
	var/black = rand(0,50)
	color_body = rgb(r*255,g*255,b*255)
	color_iris = rgb(255,rand(100,255),0)
	color_eyes = rgb(black,black,black)
	return TRUE