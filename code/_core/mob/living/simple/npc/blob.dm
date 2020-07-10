/mob/living/simple/npc/blobbernaught

	name = "blobbernaught"
	desc = "Protector of blobs."
	desc_extended = "This hulking mass of organic material only has one purpose: to protect the blob."
	icon = 'icons/mob/living/simple/blob.dmi'
	icon_state = "blobbernaut"

	health_base = 500

	value = 50

	ai = /ai/
	class = /class/bull
	damage_type = /damagetype/npc/bull

	armor_base = list(
		BLADE = 25,
		BLUNT = 50,
		PIERCE = 75,
		LASER = -50,
		MAGIC = -25,
		HEAT = -25,
		COLD = 100,
		BOMB = -50,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 75,
		DARK = 75,
		FATIGUE = INFINITY
	)

	mob_size = MOB_SIZE_LARGE

	var/obj/structure/interactive/blob/node/linked_node

	movement_delay = DECISECONDS_TO_TICKS(6)

	loyalty_tag = "Blob"

/mob/living/simple/npc/blobbernaught/New(loc,desired_client,desired_level_multiplier,var/obj/structure/interactive/blob/node/desired_node)

	if(desired_node)
		linked_node = desired_node
		linked_node.linked_blobbernaught = src
		color = linked_node.color
		blood_color = linked_node.color

	return ..()


/mob/living/simple/npc/blobbernaught/PostInitialize()
	. = ..()
	flick("blobbernaut_produce",src)
	return .

/mob/living/simple/npc/blobbernaught/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	flick("blobbernaut_death",src)
	if(linked_node)
		linked_node.linked_blobbernaught = null