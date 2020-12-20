/mob/living/simple/glockroach
	name = "glockroach"
	desc = "!"
	desc_extended = "A harmless critter. Or so it may seem."
	icon = 'icons/mob/living/simple/glockroach.dmi'
	icon_state = "glockroach"
	damage_type = /damagetype/ranged/bullet/pistol_10mm
	class = /class/glockroach

	value = 25

	health_base = 5
	stamina_base = 5
	mana_base = 5

	ai = /ai/simple/glockroach

	stun_angle = 180

	armor_base = list(
		BIO = INFINITY,
		RAD = INFINITY,
		ION = INFINITY
	)

	mob_size = MOB_SIZE_CRITTER

	movement_delay = DECISECONDS_TO_TICKS(2)

	loyalty_tag = "Meme"
	iff_tag = "Meme"

	blood_type = /reagent/blood/insect
	blood_volume = 50

/mob/living/simple/glockroach/post_death()
	..()
	icon_state = "[initial(icon_state)]_dead"
	update_sprite()

