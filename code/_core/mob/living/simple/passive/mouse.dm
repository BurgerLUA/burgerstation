/mob/living/simple/passive/mouse
	name = "mouse"
	desc = "Squeak!"
	desc_extended = "A harmles mouse."
	icon = 'icons/mob/living/simple/mouse.dmi'
	icon_state = "mouse_brown"
	damage_type = /damagetype/unarmed/bite/
	class = /class/passive

	health_base = 25
	stamina_base = 50
	mana_base = 25

	stun_angle = 0

	loyalty_tag = "Mouse"
	iff_tag = "Mouse"

	mob_size = MOB_SIZE_CRITTER

	blood_type = /reagent/blood/mouse
	blood_volume = 50

/mob/living/simple/passive/mouse/Crossed(atom/movable/O)
	return TRUE

/mob/living/simple/passive/mouse/brown
	icon_state = "mouse_brown"

/mob/living/simple/passive/mouse/white
	icon_state = "mouse_white"

/mob/living/simple/passive/mouse/grey
	icon_state = "mouse_gray"

/mob/living/simple/passive/mouse/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()