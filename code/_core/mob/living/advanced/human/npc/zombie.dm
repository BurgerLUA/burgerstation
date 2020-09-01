/mob/living/advanced/npc/zombie
	name = "zombie"
	ai = /ai/advanced/zombie
	class = /class/zombie/

	species = "zombie"

	var/loadout_to_use = /loadout/zombie
	var/spear_chance = 0

	health = /health/mob/living/advanced/zombie/
	health_base = 300

	movement_delay = DECISECONDS_TO_TICKS(10)

	var/next_talk = 0



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
		play(pick(valid_sounds),get_turf(src))

	return .

/mob/living/advanced/npc/zombie/New(loc,desired_client,desired_level_multiplier)

	gender = pick(MALE,FEMALE)
	sex = gender //oh god oh fuck what have i done

	return ..()


/mob/living/advanced/npc/zombie/Initialize()

	. = ..()

	change_organ_visual("skin", desired_color = "#5D7F00")
	change_organ_visual("hair_head", desired_icon_state = "hair_a", desired_color = "#111111")
	change_organ_visual("eye", desired_color = "#FF0000")

	update_all_blends()
	equip_loadout(loadout_to_use)

	if(spear_chance)
		put_in_hands(new /obj/item/weapon/melee/spear(src.loc),FALSE)

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

		if(sound_to_play) play(sound_to_play,get_turf(src))

		next_talk = world.time + SECONDS_TO_DECISECONDS(rand(5,12))

	return .


/mob/living/advanced/npc/zombie/attack(var/atom/attacker,var/atom/victim,var/list/params,var/atom/blamed,var/ignore_distance = FALSE, var/precise = FALSE) //The src attacks the victim, with the blamed taking responsibility

	. = ..()

	if(. && next_talk <= world.time && prob(50))
		var/list/valid_sounds = list(
			'sound/voice/zombie/attack_01.ogg',
			'sound/voice/zombie/attack_02.ogg',
			'sound/voice/zombie/attack_03.ogg',
			'sound/voice/zombie/attack_04.ogg'
		)
		play(pick(valid_sounds),get_turf(src))
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
		play(pick(valid_sounds),get_turf(src))

	return .


/mob/living/advanced/npc/zombie/post_death()

	. = ..()

	if(prob(50))
		var/list/valid_sounds = list(
			'sound/voice/zombie/death_01.ogg'
		)
		play(pick(valid_sounds),get_turf(src))

	return .

/mob/living/advanced/npc/zombie/winter
	loadout_to_use = /loadout/zombie/winter
	spear_chance = 100
	level_multiplier = 1.5

/mob/living/advanced/npc/zombie/desert
	loadout_to_use = /loadout/zombie/desert
	spear_chance = 0
	level_multiplier = 2

/mob/living/advanced/npc/zombie/greytide
	loadout_to_use = /loadout/greytide
	spear_chance = 0
	level_multiplier = 2