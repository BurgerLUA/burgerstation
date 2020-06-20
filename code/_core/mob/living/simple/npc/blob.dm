/mob/living/simple/npc/blobbernaught

	name = "blobbernaught"
	desc = "Protector of blobs."
	desc_extended = "This hulking mass of organic material only has one purpose: to protect the blob."
	icon = 'icons/mob/living/simple/blob.dmi'
	icon_state = "blobbernaut"

	health_base = 500

	ai = /ai/
	class = /class/bull
	damage_type = /damagetype/npc/bull

	armor_base = list(
		BLADE = 25,
		BLUNT = 75,
		PIERCE = 75,
		LASER = 25,
		MAGIC = 25,
		HEAT = 25,
		COLD = 75,
		BOMB = 25,
		BIO = INFINITY,
		RAD = INFINITY,
		HOLY = 50,
		DARK = 100,
		FATIGUE = INFINITY
	)

	mob_size = MOB_SIZE_LARGE

	var/obj/structure/interactive/blob/node/linked_node

/mob/living/simple/npc/blobbernaught/New(loc,desired_client,desired_level_multiplier,var/obj/structure/interactive/blob/node/desired_node)

	if(desired_node)
		linked_node = desired_node
		linked_node.linked_blobbernaught = src
		color = linked_node.color
		blood_color = linked_node.color

	return ..()


/mob/living/simple/npc/blobbernaught/Initialize()
	. = ..()
	flick("blobbernaut_produce",src)
	return .

/mob/living/simple/npc/blobbernaught/post_death()
	. = ..()
	icon_state = "[initial(icon_state)]_dead"
	flick("blobbernaut_death",src)
	if(linked_node)
		linked_node.linked_blobbernaught = null