/mob/living/simple/leaper
	name = "leaper"
	boss_icon_state = "leaper"
	icon = 'icons/mob/living/simple/jungle/leaper.dmi'
	icon_state = "living"
	damage_type = /damagetype/unarmed/claw/


	pixel_x = -16

	value = 5000

	ai = /ai/boss/leaper

	butcher_contents = list(

	)

	stun_angle = 0

	health_base = 10000
	stamina_base = 1000
	mana_base = 2000

	boss_loot = /loot/lavaland/leaper

	boss_music = /track/frogged

	force_spawn = TRUE
	boss = TRUE

	armor = /armor/arachnid

	fatigue_mul = 0

	status_immune = list(
		STUN = TRUE,
		SLEEP = TRUE,
		PARALYZE = TRUE,
		STAMCRIT = TRUE,
		STAGGER = TRUE,
		CONFUSED = TRUE,
		CRIT = TRUE,
		REST = TRUE,
		ADRENALINE = TRUE,
		DISARM = TRUE,
		DRUGGY = TRUE,
		GRAB = TRUE
	)

	size = SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	iff_tag = "Jungle"
	loyalty_tag = "Jungle"

	blood_type = /reagent/blood/ancient
	blood_volume = 3000

	soul_size = SOUL_SIZE_RARE

	anchored = 1

	object_size = 2

	respawn_time = SECONDS_TO_DECISECONDS(300)

	level = 30

	var/list/tracked_frogs = list()

/mob/living/simple/leaper/Destroy()
	. = ..()
	tracked_frogs.Cut()
	tracked_frogs = null

/mob/living/simple/leaper/post_death()
	..()
	icon_state = "dead"
	update_sprite()
	anchored = FALSE

/mob/living/simple/leaper/proc/try_teleport()

	if(CALLBACK_EXISTS("\ref[src]_leaper_teleport"))
		return FALSE

	var/list/valid_turfs = list()

	var/turf/center_turf = ai && ai.objective_attack ? get_turf(ai.objective_attack) : get_turf(src)
	var/turf/simulated/floor/T
	FOR_DVIEW(T,2 + VIEW_RANGE*0.25,center_turf,0)
		CHECK_TICK(50,FPS_SERVER)
		if(get_dist(T,src) <= 2)
			continue
		if(!T.can_move_to() || !T.is_safe())
			continue
		valid_turfs += T
	END_FOR_DVIEW

	if(!length(valid_turfs))
		return FALSE

	var/turf/desired_turf = pick(valid_turfs)

	animate(src,alpha=0,color="#000000",time=10)
	set_density(FALSE)
	CALLBACK("\ref[src]_leaper_teleport",10,src,src::teleport(),desired_turf)

	return TRUE

//Teleportation
/mob/living/simple/leaper/proc/teleport(var/turf/desired_turf)

	if(desired_turf) src.force_move(desired_turf)
	remove_status_effect(IMMORTAL)
	set_density(TRUE)
	animate(src,alpha=color=initial(alpha),color=initial(color),time=10)

	return TRUE

//Bubble Creation
/mob/living/simple/leaper/proc/volley_bubbles()

	if(!ai || !ai.objective_attack)
		return FALSE

	if(CALLBACK_EXISTS("\ref[src]_shoot_bubble5"))
		return FALSE

	for(var/i=1,i<=3,i++)
		CALLBACK("\ref[src]_shoot_bubble[i]",5+i*6,src,src::shoot_bubble(),ai.objective_attack)

	return TRUE

/mob/living/simple/leaper/proc/spam_bubbles()

	for(var/mob/living/L in view(VIEW_RANGE,src))
		if(L.dead)
			continue
		if(L.iff_tag == src.iff_tag)
			continue
		shoot_bubble(L,play_sound=FALSE)

	play_sound('sound/weapons/magic/generic_conjure_multi.ogg',get_turf(src),volume=75)

	return TRUE

/mob/living/simple/leaper/proc/shoot_bubble(var/atom/desired_target,var/play_sound=TRUE)

	if(dead)
		return FALSE

	if(desired_target.qdeleting || desired_target.z != src.z)
		return FALSE

	if(get_dist(src,desired_target) <= 2)
		return FALSE //TOO CLOSE.

	shoot_projectile(
		src,
		desired_target,
		null,
		null,
		/obj/projectile/magic/leaper,
		/damagetype/ranged/leaper_bubble,
		16,
		16,
		0,
		TILE_SIZE*0.2,
		1,
		"#FFFFFF",
		0,
		1,
		iff_tag,
		loyalty_tag
	)

	if(play_sound)
		play_sound('sound/weapons/magic/generic_conjure.ogg',get_turf(src))

	return TRUE

//Blood Attack.
/mob/living/simple/leaper/proc/blood_attack()

	if(dead)
		return FALSE

	if(!z)
		return FALSE

	flick("shoot",src)

	var/list/block_turfs = block(
		x-VIEW_RANGE,
		y-VIEW_RANGE,
		z,
		x+VIEW_RANGE,
		y+VIEW_RANGE,
		z
	)

	var/blood_to_explode = 8
	while(length(block_turfs) && blood_to_explode > 0)
		var/turf/simulated/T = pick(block_turfs)
		block_turfs -= T
		if(!is_simulated(T))
			continue
		if(T.blood_level_hard <= 0)
			continue
		blood_to_explode -= 1
		play_sound('sound/weapons/magic/bloody_impact.ogg',T)
		var/obj/effect/E = new(T)
		E.icon = 'icons/obj/projectiles/leaper.dmi'
		E.icon_state = "leaper"
		E.pixel_z = -16
		E.alpha = 0
		flick("leaper_bubble_form",E)
		animate(E,pixel_z = 0,alpha=255,time=SECONDS_TO_DECISECONDS(3))
		CALLBACK("\ref[E]_telegraph_explode",SECONDS_TO_DECISECONDS(6),src,src::blood_attack_do_explode(),E)
		for(var/k in DIRECTIONS_ALL_CENTER)
			var/turf/T2 = get_step(T,k)
			for(var/obj/effect/cleanable/blood/B in T2.contents)
				var/obj/effect/temp/EB = new(T2,3)
				EB.icon = B.icon
				EB.icon_state = B.icon_state
				EB.color = B.color
				var/list/offsets = get_directional_offsets(T2,T)
				animate(
					EB,
					alpha=0,
					pixel_x=offsets[1]*TILE_SIZE,
					pixel_y=offsets[2]*TILE_SIZE,
					time=SECONDS_TO_DECISECONDS(3)
				)
				qdel(B)

/mob/living/simple/leaper/proc/blood_attack_do_explode(var/obj/effect/E)
	if(!E || !E.loc)
		return FALSE
	for(var/i=1,i<=4,i++)
		create_blood(/obj/effect/cleanable/blood/splatter,E.loc,"#B4150F",rand(-TILE_SIZE,TILE_SIZE),rand(-TILE_SIZE,TILE_SIZE))
	explode(E.loc,3,master ? master : src,src,loyalty_tag)
	play_sound('sound/weapons/magic/chaos_blood.ogg',E.loc)
	qdel(E)

//Frog summoning
/mob/living/simple/leaper/proc/check_frogs()

	for(var/k in tracked_frogs)
		var/mob/living/L = k
		if(L.dead || L.qdeleting || get_dist(L,src) > VIEW_RANGE*3)
			tracked_frogs -= L

	return length(tracked_frogs)


/mob/living/simple/leaper/proc/manifest_frogs()

	var/view_mod = CEILING(VIEW_RANGE*0.5,1)

	var/list/block_turfs = block(
		x-view_mod,
		y-view_mod,
		z,
		x+view_mod,
		y+view_mod,
		z
	)

	var/list/valid_turfs = list()

	for(var/k in block_turfs)
		var/turf/simulated/liquid/water/T = k
		if(!T || !istypecache(T,/turf/simulated/liquid/water))
			continue
		valid_turfs += T

	if(length(valid_turfs) <= 3)
		for(var/k in block_turfs)
			var/turf/simulated/T = k
			if(!T || !is_simulated(T) || istypecache(T,/turf/simulated/liquid/water) || !T.health )
				continue
			T.change_turf(/turf/simulated/liquid/water/river/jungle)
			valid_turfs += T

	var/frogs_to_spawn = 7

	. = FALSE

	while(frogs_to_spawn > 0 && length(valid_turfs))
		var/turf/simulated/liquid/water/T = pick(valid_turfs)
		valid_turfs -= T
		frogs_to_spawn -= 1
		var/mob/living/simple/exploding_frog/L = new(T)
		INITIALIZE(L)
		GENERATE(L)
		FINALIZE(L)
		var/obj/effect/temp/E = new(T,SECONDS_TO_DECISECONDS(1))
		E.icon = 'icons/obj/effects/tendril_spawn.dmi'
		E.icon_state = "spawning"
		L.color = "#000000"
		animate(L,color=initial(L.color),SECONDS_TO_DECISECONDS(1))
		if(L.ai)
			L.ai.set_active(TRUE)
			L.ai.find_new_objectives(AI_TICK,TRUE)
			L.ai.roaming_distance = VIEW_RANGE*0.5
				L.ai.allow_far_roaming = FALSE
		tracked_frogs += L
		. = TRUE

	if(.)
		play_sound('sound/weapons/magic/creation.ogg',get_turf(src))