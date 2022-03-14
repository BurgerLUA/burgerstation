/mob/living/simple/blob_spore

	name = "blob spore"
	desc = "Get out of my head!"
	desc_extended = "A fast-moving fragile and volatile spore of a blob designed to latch onto a sapience being's head and inject mind-controlling spores. Full control is granted when the victim succumbs to death."
	icon = 'icons/mob/living/simple/blob.dmi'
	icon_state = "blobpod"

	health_base = 50
	stamina_base = 50
	mana_base = 50

	value = 5

	ai = /ai/blob_spore

	damage_type = /damagetype/npc/blob_spore
	armor_base = list(
		BLUNT = 0,
		LASER = -40,
		HEAT = -40,
		COLD = 40,
		BOMB = -40,
		BIO = INFINITY,
		RAD = INFINITY,
		FATIGUE = INFINITY,
		ION = INFINITY,
		PAIN = INFINITY
	)

	size = SIZE_ANIMAL

	movement_delay = DECISECONDS_TO_TICKS(1)

	iff_tag = "Blob"
	loyalty_tag = "Blob"

	stun_angle = 0

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_volume = 100
	blood_type = /reagent/blood/blob

	soul_size = SOUL_SIZE_COMMON

	level = 4

	var/exploded = FALSE

	reagents = /reagent_container/blob

/mob/living/simple/blob_spore/post_death()

	var/turf/T = get_turf(src)
	if(T)
		reagents.add_reagent(/reagent/toxin/blob_spore,50)
		smoke(T,10,SECONDS_TO_DECISECONDS(3),reagents,src,255)
		var/reagent/R = REAGENT(blood_type)
		for(var/i=1,i<=9,i++)
			create_blood(/obj/effect/cleanable/blood/splatter,T,R.color,rand(-32,32),rand(-32,32))

	. = ..()

	qdel(src)

