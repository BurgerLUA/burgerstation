/mob/living/advanced/npc/zombie
	name = "zombie"
	ai = /ai/advanced/zombie

	species = "human"

	var/loadout_to_use = /loadout/zombie
	health = /health/mob/living/advanced/zombie/

	var/next_talk = 0

	value = 250

	loyalty_tag = "Zombie"
	iff_tag = "Zombie"

	level = 24

	health_base = 200
	stamina_base = 100
	mana_base = 100

	sex = NEUTER
	gender = NEUTER

	damage_received_multiplier = 0.75

	var/rest_chance = 25
	var/missing_limb_chance = 10

/mob/living/advanced/npc/zombie/Initialize()

	. = ..()

	if(prob(missing_limb_chance))
		var/turf/T = get_turf(src)
		switch(rand(1,2))
			if(1)
				var/obj/item/organ/O = labeled_organs[pick(BODY_ARM_RIGHT,BODY_ARM_LEFT)]
				if(O) O.unattach_from_parent(T,TRUE)
			if(2)
				var/obj/item/organ/O1 = labeled_organs[BODY_LEG_RIGHT]
				var/obj/item/organ/O2 = labeled_organs[BODY_LEG_LEFT]
				if(O1) O1.unattach_from_parent(T,TRUE)
				if(O2) O2.unattach_from_parent(T,TRUE)

	setup_appearance()
	update_all_blends()
	equip_loadout(loadout_to_use)

	var/total_loss_limit = (src.health.health_max*0.5)/length(organs)
	for(var/k in organs)
		var/obj/item/organ/O = k
		var/total_loss = RAND_PRECISE(0.25,0.5) * min(total_loss_limit,O.health.health_max) * (1/max(1,O.damage_coefficient))
		var/brute_loss = total_loss * RAND_PRECISE(0.25,0.75)
		var/burn_loss = (total_loss - brute_loss) * RAND_PRECISE(0.75,1)
		var/tox_loss = total_loss - (burn_loss + brute_loss)
		O.health.adjust_loss_smart(brute = brute_loss, burn = burn_loss, tox = tox_loss,update=FALSE)



/mob/living/advanced/npc/zombie/Finalize()
	. = ..()
	add_status_effect(ZOMBIE,100,-1, force = TRUE)
	if(prob(rest_chance))
		add_status_effect(REST,-1,-2, force = TRUE)

/*
/mob/living/advanced/npc/zombie/get_movement_delay(var/include_stance=TRUE)

	. = ..()

	var/turf/T = get_turf(src)
	. *= max(1,2 - T.lightness)
	if(ai && ai.objective_attack)
		. *= max(1,1 + get_dist(src,ai.objective_attack)/VIEW_RANGE)
*/

/mob/living/advanced/npc/zombie/New(loc,desired_client,desired_level_multiplier)
	setup_sex()
	. = ..()

/mob/living/advanced/npc/zombie/proc/setup_sex()
	if(gender == NEUTER)
		gender = pick(MALE,FEMALE)
	if(sex == NEUTER)
		sex = gender //oh god oh fuck what have i done
	return TRUE

/mob/living/advanced/npc/zombie/proc/setup_appearance()
	change_organ_visual("skin", desired_color = pick("#5D7F00","#5D9B00","#527200"))
	change_organ_visual("hair_head", desired_icon_state = "none", desired_color = "#000000")
	change_organ_visual("eye", desired_color = pick("#FF0000","#FF3A00","#FF5500"))
	return TRUE

/mob/living/advanced/npc/zombie/get_emote_sound(var/emote_id)

	switch(emote_id)
		if("pain")
			return null

	return null

/mob/living/advanced/npc/zombie/winter
	loadout_to_use = /loadout/zombie/winter

/mob/living/advanced/npc/zombie/desert
	loadout_to_use = /loadout/zombie/desert


/mob/living/advanced/npc/zombie/greytide
	loadout_to_use = /loadout/zombie/greytide


/mob/living/advanced/npc/zombie/greytide/setup_sex()
	sex = MALE
	gender = MALE
	return TRUE

/mob/living/advanced/npc/zombie/greytide/setup_appearance()
	change_organ_visual("skin", desired_color = "#5D7F00")
	change_organ_visual("hair_head", desired_icon_state = "hair_a", desired_color = "#111111")
	change_organ_visual("eye", desired_color = "#FF0000")
	return TRUE

/mob/living/advanced/npc/zombie/captain
	loadout_to_use = /loadout/zombie/captain


/mob/living/advanced/npc/zombie/botanist
	loadout_to_use = /loadout/zombie/botanist


/mob/living/advanced/npc/zombie/chaplain
	loadout_to_use = /loadout/zombie/chaplain


/mob/living/advanced/npc/zombie/security
	loadout_to_use = /loadout/zombie/security


/mob/living/advanced/npc/zombie/librarian
	loadout_to_use = /loadout/zombie/librarian


/mob/living/advanced/npc/zombie/clown
	loadout_to_use = /loadout/zombie/clown


/mob/living/advanced/npc/zombie/medical
	loadout_to_use = /loadout/zombie/medical


/mob/living/advanced/npc/zombie/chemist
	loadout_to_use = /loadout/zombie/chemist


/mob/living/advanced/npc/zombie/bartender
	loadout_to_use = /loadout/zombie/bartender


/mob/living/advanced/npc/zombie/chef
	loadout_to_use = /loadout/zombie/chef


/mob/living/advanced/npc/zombie/scientist
	loadout_to_use = /loadout/zombie/scientist

	var/dropped_vial = FALSE

/mob/living/advanced/npc/zombie/scientist/post_death()

	if(!dropped_vial)
		var/obj/item/container/simple/beaker/vial/zombie_antidote/ZA = new(get_turf(src))
		INITIALIZE(ZA)
		GENERATE(ZA)
		FINALIZE(ZA)
		dropped_vial = TRUE

	return ..()


/mob/living/advanced/npc/zombie/civilian
	loadout_to_use = /loadout/zombie/civilian

/mob/living/advanced/npc/zombie/civilian/setup_sex()
	. = ..()
	if(gender == MALE)
		loadout_to_use = /loadout/zombie/civilian/male
	else if(gender == FEMALE)
		loadout_to_use = /loadout/zombie/civilian/female