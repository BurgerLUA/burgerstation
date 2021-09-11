/mob/living/simple/blobbernaught

	name = "blobbernaught"
	desc = "Protector of blobs."
	desc_extended = "This hulking mass of organic material only has one purpose: to protect the blob."
	icon = 'icons/mob/living/simple/blob.dmi'
	icon_state = "blobbernaut"

	health_base = 300
	stamina_base = 100
	mana_base = 50

	value = 50

	ai = /ai/

	damage_type = /damagetype/npc/blobbernaut

	armor_base = list(
		BLUNT = 40,
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

	size = SIZE_LARGE

	var/obj/structure/interactive/blob/node/linked_node

	movement_delay = DECISECONDS_TO_TICKS(6)

	iff_tag = "Blob"
	loyalty_tag = "Blob"

	stun_angle = 0

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	blood_volume = 750
	blood_type = /reagent/blood/blob

	soul_size = SOUL_SIZE_COMMON

	level = 22

/mob/living/simple/blobbernaught/New(loc,desired_client,desired_level_multiplier,var/obj/structure/interactive/blob/node/desired_node)

	if(desired_node)
		linked_node = desired_node
		linked_node.linked_blobbernaught = src
		color = linked_node.color

	return ..()


/mob/living/simple/blobbernaught/PostInitialize()
	. = ..()
	flick("blobbernaut_produce",src)

/mob/living/simple/blobbernaught/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	flick("blobbernaut_death",src)
	if(linked_node)
		linked_node.linked_blobbernaught = null