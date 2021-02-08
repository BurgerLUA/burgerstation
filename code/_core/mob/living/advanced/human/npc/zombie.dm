/mob/living/advanced/npc/zombie
	name = "zombie"
	ai = /ai/advanced/zombie
	class = /class/zombie/

	species = "zombie"

	var/loadout_to_use = /loadout/zombie
	health = /health/mob/living/advanced/zombie/

	movement_delay = DECISECONDS_TO_TICKS(1)

	var/next_talk = 0

	value = 250

	loyalty_tag = "Zombie"
	iff_tag = "Zombie"

/mob/living/advanced/npc/zombie/get_movement_delay()

	. = ..()

	var/turf/T = get_turf(src)
	. *= max(1,2 - T.lightness)
	if(ai && ai.objective_attack)
		. *= max(1,1 + get_dist(src,ai.objective_attack)/VIEW_RANGE)

	return .

/mob/living/advanced/npc/zombie/post_death()
	CALLBACK("zombie_revive_\ref[src]",SECONDS_TO_DECISECONDS(rand(3,8)),src,.proc/zombie_revive)
	return ..()

/mob/living/advanced/npc/zombie/proc/zombie_revive() //Stolen from meatmen, partially.

	if(!health)
		return FALSE

	var/obj/item/organ/head/H = labeled_organs[BODY_HEAD]
	if(!H || !H.health)
		return FALSE

	if(H.health.health_current <= 0)
		return FALSE

	if(!istype(health,/health/mob/living/advanced/zombie/))
		return FALSE

	var/health/mob/living/advanced/zombie/ZH = health
	var/extra_health = -health.health_current*1.25
	ZH.extra_max_health += extra_health
	ZH.update_health_stats()
	src.add_status_effect(ADRENALINE,100,100,stealthy=TRUE)
	ZH.update_health()


	if(!check_death())
		revive()

	return TRUE

/mob/living/advanced/npc/zombie/revive()

	. = ..()

	if(.)
		var/list/valid_sounds = list(
			'sound/voice/zombie/revive_01.ogg',
			'sound/voice/zombie/revive_02.ogg',
			'sound/voice/zombie/revive_03.ogg'
		)
		play_sound(pick(valid_sounds),get_turf(src),range_max=VIEW_RANGE)

	return .

/mob/living/advanced/npc/zombie/New(loc,desired_client,desired_level_multiplier)
	setup_sex()
	return ..()

/mob/living/advanced/npc/zombie/proc/setup_sex()
	gender = pick(MALE,FEMALE)
	sex = gender //oh god oh fuck what have i done
	return TRUE

/mob/living/advanced/npc/zombie/proc/setup_appearance()
	var/list/valid_male_hair = list("none","hair_a","hair_c","hair_d","hair_e","hair_f")
	var/list/valid_female_hair = list("hair_b","hair_ponytail2","hair_ponytail5")
	change_organ_visual("skin", desired_color = pick("#5D7F00","#5D9B00","#527200"))
	change_organ_visual("hair_head", desired_icon_state = sex == MALE ? pick(valid_male_hair) : pick(valid_female_hair), desired_color = pick("#111111","#404040","#54341F","#D8BB6A"))
	change_organ_visual("eye", desired_color = pick("#FF0000","#FF3A00","#FF5500"))
	return TRUE


/mob/living/advanced/npc/zombie/Initialize()

	. = ..()

	setup_appearance()
	update_all_blends()
	equip_loadout(loadout_to_use)

	return .


/mob/living/advanced/npc/zombie/get_emote_sound(var/emote_id)

	switch(emote_id)
		if("pain")
			return null

	return null


/mob/living/advanced/npc/zombie/on_life_slow()

	. = ..()

	if(. && ai && ai.active && next_talk <= world.time && prob(25))

		var/sound_to_play

		if(ai.alert_level == ALERT_LEVEL_NONE)
			var/list/valid_sounds = list(
				'sound/voice/zombie/generic_01.ogg',
				'sound/voice/zombie/generic_02.ogg',
				'sound/voice/zombie/generic_03.ogg',
				'sound/voice/zombie/generic_04.ogg'
			)
			sound_to_play = pick(valid_sounds)
		else
			var/list/valid_sounds = list(
				'sound/voice/zombie/alert_01.ogg',
				'sound/voice/zombie/alert_02.ogg',
				'sound/voice/zombie/alert_03.ogg',
				'sound/voice/zombie/alert_04.ogg',
				'sound/voice/zombie/alert_05.ogg'
			)
			sound_to_play = pick(valid_sounds)

		if(sound_to_play)
			play_sound(sound_to_play,get_turf(src),range_max=VIEW_RANGE)

		next_talk = world.time + SECONDS_TO_DECISECONDS(rand(5,12))

	return .


/mob/living/advanced/npc/zombie/attack(var/atom/attacker,var/atom/victim,var/list/params=list(),var/atom/blamed,var/ignore_distance = FALSE, var/precise = FALSE,var/damage_multiplier=1) //The src attacks the victim, with the blamed taking responsibility

	. = ..()

	if(. && next_talk <= world.time && prob(50))
		var/list/valid_sounds = list(
			'sound/voice/zombie/attack_01.ogg',
			'sound/voice/zombie/attack_02.ogg',
			'sound/voice/zombie/attack_03.ogg',
			'sound/voice/zombie/attack_04.ogg'
		)
		play_sound(pick(valid_sounds),get_turf(src),range_max=VIEW_RANGE)
		next_talk = world.time + SECONDS_TO_DECISECONDS(rand(5,12))
	return .

/mob/living/advanced/npc/zombie/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(!stealthy && !dead && damage_amount > 20 && prob(50))
		var/list/valid_sounds = list(
			'sound/voice/zombie/pain_01.ogg',
			'sound/voice/zombie/pain_02.ogg',
			'sound/voice/zombie/pain_03.ogg',
			'sound/voice/zombie/pain_04.ogg',
			'sound/voice/zombie/pain_05.ogg',
			'sound/voice/zombie/pain_06.ogg'
		)
		play_sound(pick(valid_sounds),get_turf(src),range_max=VIEW_RANGE)

	return .


/mob/living/advanced/npc/zombie/post_death()

	. = ..()

	if(prob(50))
		var/list/valid_sounds = list(
			'sound/voice/zombie/death_01.ogg'
		)
		play_sound(pick(valid_sounds),get_turf(src),range_max=VIEW_RANGE)

	return .

/mob/living/advanced/npc/zombie/winter
	loadout_to_use = /loadout/zombie/winter
	level_multiplier = 1.5

/mob/living/advanced/npc/zombie/desert
	loadout_to_use = /loadout/zombie/desert
	level_multiplier = 2

/mob/living/advanced/npc/zombie/greytide
	loadout_to_use = /loadout/zombie/greytide
	level_multiplier = 1

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
	level_multiplier = 10

/mob/living/advanced/npc/zombie/botanist
	loadout_to_use = /loadout/zombie/botanist
	level_multiplier = 3

/mob/living/advanced/npc/zombie/chaplain
	loadout_to_use = /loadout/zombie/chaplain
	level_multiplier = 4

/mob/living/advanced/npc/zombie/security
	loadout_to_use = /loadout/zombie/security
	level_multiplier = 4

/mob/living/advanced/npc/zombie/librarian
	loadout_to_use = /loadout/zombie/librarian
	level_multiplier = 2

/mob/living/advanced/npc/zombie/clown
	loadout_to_use = /loadout/zombie/clown
	level_multiplier = 8

/mob/living/advanced/npc/zombie/medical
	loadout_to_use = /loadout/zombie/medical
	level_multiplier = 4

/mob/living/advanced/npc/zombie/chemist
	loadout_to_use = /loadout/zombie/chemist
	level_multiplier = 4

/mob/living/advanced/npc/zombie/bartender
	loadout_to_use = /loadout/zombie/bartender
	level_multiplier = 3

/mob/living/advanced/npc/zombie/chef
	loadout_to_use = /loadout/zombie/chef
	level_multiplier = 3

/mob/living/advanced/npc/zombie/scientist
	loadout_to_use = /loadout/zombie/scientist
	level_multiplier = 1
	var/dropped_vial = FALSE

/mob/living/advanced/npc/zombie/scientist/post_death()

	if(!dropped_vial)
		var/obj/item/container/beaker/vial/zombie_antidote/ZA = new(get_turf(src))
		INITIALIZE(ZA)
		GENERATE(ZA)
		FINALIZE(ZA)
		dropped_vial = TRUE

	return ..()