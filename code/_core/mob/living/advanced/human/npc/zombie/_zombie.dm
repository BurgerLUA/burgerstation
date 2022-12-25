/mob/living/advanced/npc/zombie
	name = "zombie"
	ai = /ai/advanced/zombie

	health = /health/mob/living/advanced/zombie/

	var/next_talk = 0

	value = 250

	loyalty_tag = "Zombie"
	iff_tag = "Zombie"

	level = 15

	health_base = 200
	stamina_base = 100
	mana_base = 100

	var/rest_chance = 25
	var/missing_limb_chance = 10

	dna = /dna/human

/mob/living/advanced/npc/zombie/Finalize()

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

	var/total_loss_limit = (src.health.health_max*0.5)/length(organs)
	for(var/k in organs)
		var/obj/item/organ/O = k
		var/total_loss = RAND_PRECISE(0.25,0.5) * min(total_loss_limit,O.health.health_max) * (1/max(1,O.damage_coefficient))
		var/brute_loss = total_loss * RAND_PRECISE(0.25,0.75)
		var/burn_loss = (total_loss - brute_loss) * RAND_PRECISE(0.75,1)
		var/tox_loss = total_loss - (burn_loss + brute_loss)
		O.health.adjust_loss_smart(brute = brute_loss, burn = burn_loss, tox = tox_loss)

	. = ..()

	add_status_effect(ZOMBIE,100,-1, force = TRUE)
	if(prob(rest_chance))
		add_status_effect(REST,-1,-2, force = TRUE)

/mob/living/advanced/npc/zombie/get_emote_sound(var/emote_id)

	switch(emote_id)
		if("pain")
			return null

	return null