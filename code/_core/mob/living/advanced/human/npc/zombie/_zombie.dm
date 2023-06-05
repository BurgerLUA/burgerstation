/mob/living/advanced/npc/zombie
	name = "zombie"
	ai = /ai/advanced/zombie

	health = /health/mob/living/advanced/zombie/

	var/next_talk = 0

	value = 250

	loyalty_tag = "Zombie"
	iff_tag = "Zombie"

	level = 12

	health_base = 200
	stamina_base = 100
	mana_base = 100

	var/rest_chance = 25
	var/missing_limb_chance = 10

	dna = /dna/human

/mob/living/advanced/npc/zombie/PostInitialize()

	if(prob(missing_limb_chance))
		var/turf/T = get_turf(src)
		switch(rand(1,3))
			if(1)
				var/obj/item/organ/O = labeled_organs[pick(BODY_ARM_RIGHT,BODY_ARM_LEFT)]
				if(O) O.unattach_from_parent(T,TRUE)
			if(2)
				var/obj/item/organ/O1 = labeled_organs[BODY_LEG_RIGHT]
				var/obj/item/organ/O2 = labeled_organs[BODY_LEG_LEFT]
				if(O1) O1.unattach_from_parent(T,TRUE)
				if(O2) O2.unattach_from_parent(T,TRUE)
			if(3)
				var/obj/item/organ/O = labeled_organs[pick(BODY_ARM_RIGHT,BODY_ARM_LEFT)]
				if(O) O.broken = TRUE

	. = ..()

	make_convincing_corpse(place_blood=FALSE)

	add_status_effect(ZOMBIE,100,-1, force = TRUE)
	if(prob(rest_chance))
		add_status_effect(REST,-1,-2, force = TRUE)

/mob/living/advanced/npc/zombie/get_emote_sound(var/emote_id)

	switch(emote_id)
		if("pain")
			return null

	return null