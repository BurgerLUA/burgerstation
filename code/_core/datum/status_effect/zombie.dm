/status_effect/zombie
	name = "Zombified"
	desc = "You've been zombified!"
	id = ZOMBIE

	affects_dead = TRUE

/status_effect/zombie/can_add_status_effect(var/atom/attacker,var/mob/living/victim)
	if(!is_advanced(victim))
		return FALSE
	var/mob/living/advanced/A = victim
	var/obj/item/organ/head/H = A.labeled_organs[BODY_HEAD]
	if(!H || !H.health)
		return FALSE
	var/obj/item/organ/internal/brain/B = A.labeled_organs[BODY_BRAIN]
	if(!B || !B.health || !B.health.organic)
		return FALSE
	. = ..()

/status_effect/zombie/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)

	. = ..()

	if(!is_advanced(owner))
		return .

	var/mob/living/advanced/A = owner

	var/obj/item/organ/head/H = A.labeled_organs[BODY_HEAD]
	if(H) HOOK_REMOVE("on_damage_received","\ref[H]_zombie_on_damage_received",H)
	HOOK_REMOVE("post_death","\ref[owner]_zombie_post_death",owner)
	HOOK_REMOVE("attack","\ref[owner]_zombie_attack",owner)
	HOOK_REMOVE("on_damage_received","\ref[owner]_zombie_on_damage_received",owner)


/status_effect/zombie/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)
	stealthy = TRUE
	. = ..()
	var/mob/living/advanced/A = owner

	var/turf/T = get_turf(A)

	A.drop_hands(T)

	var/obj/item/organ/hand/HR = A.labeled_organs[BODY_HAND_RIGHT]
	if(HR)
		A.remove_organ(HR,T,TRUE)
		A.add_organ(/obj/item/organ/hand/zombie) //Right hand.
	var/obj/item/organ/hand/HL = A.labeled_organs[BODY_HAND_LEFT]
	if(HL)
		A.remove_organ(HL,T,TRUE)
		A.add_organ(/obj/item/organ/hand/zombie/left) //Left hand.

	A.change_organ_visual("skin", desired_color = pick("#5D7F00","#5D9B00","#527200"), should_update = TRUE)

	var/obj/item/organ/head/H = A.labeled_organs[BODY_HEAD]
	H.add_blend("zombie", desired_icon = 'icons/mob/living/advanced/hair/human_misc.dmi', desired_icon_state = "zombie", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY)
	HOOK_ADD("on_damage_received","\ref[H]_zombie_on_damage_received",H,src,src::on_headshot())
	HOOK_ADD("post_death","\ref[owner]_zombie_post_death",owner,src,src::post_death())
	HOOK_ADD("attack","\ref[owner]_zombie_attack",owner,src,src::attack())
	HOOK_ADD("on_damage_received","\ref[owner]_zombie_on_damage_received",owner,src,src::on_damage_received())
	H.update_sprite()

	if(istype(source,/obj/item/clothing/head/helmet/full/blob_spore))
		var/obj/item/clothing/head/helmet/full/blob_spore/BS = source
		H.health.adjust_loss_smart(
			brute=-BS.total_damage_dealt,
			organic=TRUE,
			robotic=FALSE
		)

	for(var/k in A.organs)
		var/obj/item/organ/O = k
		if(!O.health)
			continue
		if(O.id == BODY_TORSO)
			O.damage_coefficient *= 0.5
		else if(O.id == BODY_HEAD)
			O.damage_coefficient *= 1.5
		else
			O.damage_coefficient *= 0.25

	A.health.adjust_loss_smart(
		brute=-(20 + A.health.damage[BRUTE]*0.5),
		burn=-(10 + A.health.damage[BURN]*0.25),
		tox=-A.health.damage[BRUTE],
		organic=TRUE,
		robotic=FALSE
	)

	var/obj/item/organ/internal/implant/head/loyalty/L = locate() in A.organs
	if(L) L.loyalty_tag = "Blob"
	owner.set_loyalty_tag("Blob")

	var/obj/item/organ/internal/implant/hand/left/iff/I = locate() in A.organs
	if(I) I.iff_tag = "Blob"
	owner.set_iff_tag("Blob")

	if(!istype(A.ai,/ai/advanced/zombie))
		qdel(A.ai)
		A.ai = new /ai/advanced/zombie(null,A)
		A.ai.active = FALSE //I know this feels like shitcode but *dab

	if(A.client)
		T = get_turf(A)
		A.client.make_ghost(T ? T : FALLBACK_TURF)

	A.ckey_last = null

	A.add_status_effect(ADRENALINE,100,-1,force=TRUE,stealthy=TRUE)

	A.revive()

/status_effect/zombie/on_effect_life(var/mob/living/owner,var/magnitude,var/duration)
	. = ..()
	if(. && !owner.dead && owner.ai && owner.ai.active && !owner.has_status_effect(REST) && prob(1))
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

	CALLBACK("zombie_revive_\ref[L]",SECONDS_TO_DECISECONDS(rand(4,10)),src,src::zombie_revive(),L)
	return TRUE

/status_effect/zombie/proc/zombie_revive(var/mob/living/advanced/L) //Stolen from meatmen.

	if(L.qdeleting || !L.health)
		return FALSE

	var/obj/item/organ/head/H = L.labeled_organs[BODY_HEAD]
	if(!H || !H.health || H.health.health_current <= 0)
		return FALSE

	var/extra_health = clamp(-L.health.health_current*1.25,0,L.health.health_max*0.5)
	L.add_status_effect(UNDYING,extra_health,-1,force=TRUE,stealthy=TRUE)

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

	if(length(args) && !args[8] && !L.dead && args[6] > 20 && prob(50))
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

/status_effect/zombie/proc/on_headshot(var/obj/item/organ/O,var/args) //When the zombie gets shot in the head.

	var/mob/living/advanced/A = O.loc

	if(!is_advanced(A))
		return FALSE

	if(!A.dead)
		if(A.health.health_current/A.health.health_max <= 0.5)
			A.death() //Instant death.
		else
			return FALSE

	var/obj/hud/inventory/I = A.inventories_by_id[BODY_HEAD]
	if(!I)
		return FALSE

	var/obj/item/I2 = I.get_top_object()
	if(!istype(I2,/obj/item/clothing/head/helmet/full/blob_spore))
		return FALSE
	var/turf/T = get_turf(A)
	if(T)
		A.reagents.add_reagent(/reagent/toxin/blob_spore,50)
		smoke(T,10,SECONDS_TO_DECISECONDS(3),A.reagents,A,255)
		var/reagent/R = REAGENT(/reagent/blood/blob)
		for(var/i=1,i<=3,i++)
			create_blood(
				/obj/effect/cleanable/blood/splatter,
				T,
				R.color,
				rand(-TILE_SIZE,TILE_SIZE),
				rand(-TILE_SIZE,TILE_SIZE)
			)

	qdel(I2)

	return TRUE