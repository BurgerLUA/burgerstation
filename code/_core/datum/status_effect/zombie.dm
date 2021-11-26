/status_effect/zombie
	name = "Zombified"
	desc = "You've been zombified!"
	id = ZOMBIE

	affects_dead = TRUE

/status_effect/zombie/can_add_status_effect(var/atom/attacker,var/mob/living/victim)
	if(!is_advanced(victim))
		return FALSE
	. = ..()

/status_effect/zombie/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	stealthy = TRUE
	. = ..()
	var/mob/living/advanced/A = owner
	A.change_organ_visual("skin", desired_color = pick("#5D7F00","#5D9B00","#527200"))
	A.add_status_effect(PAINKILLER,100,-1,stealthy=stealthy)
	A.add_status_effect(ADRENALINE,100,-1,stealthy=stealthy)
	HOOK_ADD("post_death","\ref[owner]_zombie_post_death",owner,src,.proc/post_death)
	HOOK_ADD("attack","\ref[owner]_zombie_attack",owner,src,.proc/attack)
	HOOK_ADD("on_damage_received","\ref[owner]_zombie_on_damage_received",owner,src,.proc/on_damage_received)

	var/obj/item/organ/internal/implant/head/loyalty/L = locate() in A.organs
	if(L) L.update_implant(desired_id="Blob")

	var/obj/item/organ/internal/implant/hand/left/iff/I = locate() in A.organs
	if(I) I.update_implant(desired_id="Blob")

	if(A.ai) qdel(A.ai)
	A.ai = new /ai/advanced/zombie(null,A)
	INITIALIZE(A.ai)
	FINALIZE(A.ai)

	if(A.client)
		var/turf/T = get_turf(A)
		A.client.make_ghost(T ? T : FALLBACK_TURF)
	A.ckey_last = null

	A.health.adjust_loss_smart(tox=-A.health.get_loss(TOX))

	post_death(A)

	A.update_all_blends()

/status_effect/zombie/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)
	. = ..()
	if(. && prob(3) && !owner.dead && owner.ai)
		var/sound_to_play
		if(owner.ai.alert_level == ALERT_LEVEL_NONE)
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
			play_sound(sound_to_play,get_turf(owner),range_max=VIEW_RANGE)

/status_effect/zombie/proc/post_death(var/mob/living/L,args)

	if(prob(50))
		var/list/valid_sounds = list(
			'sound/voice/zombie/death_01.ogg'
		)
		play_sound(pick(valid_sounds),get_turf(L),range_max=VIEW_RANGE)

	CALLBACK("zombie_revive_\ref[L]",SECONDS_TO_DECISECONDS(rand(4,10)),src,.proc/zombie_revive,L)
	return TRUE

/status_effect/zombie/proc/zombie_revive(var/mob/living/advanced/L) //Stolen from meatmen.

	if(L.qdeleting || !L.health)
		return FALSE

	var/obj/item/organ/head/H = L.labeled_organs[BODY_HEAD]
	if(!H || !H.health)
		return FALSE

	var/extra_health = max(0,-L.health.health_current*1.25)
	if(extra_health)
		L.health_base += extra_health
		L.health.update_health_stats()
		L.health.update_health()

	if(!L.check_death())
		L.revive()
		var/list/valid_sounds = list(
			'sound/voice/zombie/revive_01.ogg',
			'sound/voice/zombie/revive_02.ogg',
			'sound/voice/zombie/revive_03.ogg'
		)
		play_sound(pick(valid_sounds),get_turf(L),range_max=VIEW_RANGE)

	return TRUE


/status_effect/zombie/proc/attack(var/mob/living/advanced/L,var/args)

	if(prob(25))
		var/list/valid_sounds = list(
			'sound/voice/zombie/attack_01.ogg',
			'sound/voice/zombie/attack_02.ogg',
			'sound/voice/zombie/attack_03.ogg',
			'sound/voice/zombie/attack_04.ogg'
		)
		play_sound(pick(valid_sounds),get_turf(L),range_max=VIEW_RANGE)

	return TRUE


/status_effect/zombie/proc/on_damage_received(var/mob/living/advanced/L,var/args)

	if(!args["stealthy"] && !L.dead && args["damage_amount"] > 20 && prob(50))
		var/list/valid_sounds = list(
			'sound/voice/zombie/pain_01.ogg',
			'sound/voice/zombie/pain_02.ogg',
			'sound/voice/zombie/pain_03.ogg',
			'sound/voice/zombie/pain_04.ogg',
			'sound/voice/zombie/pain_05.ogg',
			'sound/voice/zombie/pain_06.ogg'
		)
		play_sound(pick(valid_sounds),get_turf(L),range_max=VIEW_RANGE)

	return TRUE