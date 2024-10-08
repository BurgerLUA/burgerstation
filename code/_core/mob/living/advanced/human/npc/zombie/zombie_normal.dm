/mob/living/advanced/npc/zombie/normal
	loadout = /loadout/zombie/civilian/male

/mob/living/advanced/npc/zombie/normal/female
	loadout = /loadout/zombie/civilian/female

/mob/living/advanced/npc/zombie/worker
	name = "zombie worker"
	loadout = /loadout/zombie/worker

	level = 10


/mob/living/advanced/npc/zombie/worker/decapitated/Finalize()
	. = ..()
	var/obj/item/organ/head/H = src.labeled_organs[BODY_HEAD]
	if(H) H.gib()

/mob/living/advanced/npc/zombie/normal/decapitated/Finalize()
	. = ..()
	var/obj/item/organ/head/H = src.labeled_organs[BODY_HEAD]
	if(H) H.gib()