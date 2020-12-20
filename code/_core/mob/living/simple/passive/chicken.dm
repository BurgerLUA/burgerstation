/mob/living/simple/passive/chicken
	name = "white chicken"
	desc = "Cluck cluck."
	desc_extended = "A harmless critter."
	icon_state = "chicken_white"
	damage_type = /damagetype/npc/chicken
	class = /class/chicken
	butcher_contents = list(
		/obj/item/container/food/dynamic/chicken/raw/,
		/obj/item/container/food/dynamic/chicken/raw/,
		/obj/item/container/food/dynamic/chicken/raw/
	)
	mob_size = MOB_SIZE_CRITTER

	loyalty_tag = "Chicken"
	iff_tag = "Chicken"

	blood_type = /reagent/blood/chicken
	blood_volume = 100

	health_base = 25
	stamina_base = 50
	mana_base = 25

/mob/living/simple/passive/chicken/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

/mob/living/simple/passive/chicken/brown
	name = "brown chicken"
	icon_state = "chicken_brown"

/mob/living/simple/passive/chicken/black
	name = "black chicken"
	icon_state = "chicken_black"

/mob/living/simple/passive/chicken/black/Initialize()
	. = ..()
	if(prob(1))
		name = "black cock"
		desc = "Comedy achieved."
	return .