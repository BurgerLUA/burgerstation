var/global/list/valid_gabber_sound_files = list()


/mob/living/simple/gabber
	name = "Zechariah the Synthangel"
	icon = 'icons/mob/living/simple/gabber.dmi'
	icon_state = "idle"
	pixel_w = -16
	pixel_z = -8

	boss_icon_state = "zechariah"

	damage_type = /damagetype/unarmed/holy

	ai = /ai/boss/gabber/

	force_spawn = TRUE
	boss = TRUE

	value = 10000

	stun_angle = 0

	health_base = 5000
	stamina_base = 5000
	mana_base = 5000

	size = SIZE_BOSS

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	iff_tag = "Gabber"
	loyalty_tag = "Gabber"

	blood_type = /reagent/blood/robot
	blood_volume = 3000

	boss_loot = /loot/lavaland/gabber

	boss_music = /track/light_of_zach

	soul_size = SOUL_SIZE_MYSTIC

	object_size = 2

	respawn_time = 300 SECONDS

	level = 50

	movement_delay = DS2TICKS(3)

	var/sword_mode = FALSE

	var/superslam_latch = 0

	var/next_special_attack = 0 //Prevents voice stacking.

	can_attack_while_moving = TRUE

	var/static/list/gabber_voice_slam = list(
		"death",
		"die",
		"down"
	)

	var/static/list/gabber_voice_multishot = list(
		"away",
		"escape",
		"run"
	)

	var/static/list/gabber_voice_parry = list(
		"blocked",
		"denied",
		"failure"
	)

/mob/living/simple/gabber/get_block_power(atom/victim,atom/attacker,atom/weapon,atom/object_to_damage,damagetype/DT)
	return 1

/mob/living/simple/gabber/get_movement_delay()

	. = ..()

	if(sword_mode)
		. *= 0.5

/mob/living/simple/gabber/get_damage_received_multiplier(atom/attacker,atom/victim,atom/weapon,atom/hit_object,atom/blamed,damagetype/DT)

	. = ..()

	if(sword_mode)
		. *= 0.75

/mob/living/simple/gabber/death(silent=FALSE)

	if(!sword_mode) //Prevents exploits.
		start_sword_mode()
		return FALSE

	. = ..()

/mob/living/simple/gabber/on_damage_received(atom/atom_damaged,atom/attacker,atom/weapon,damagetype/DT,list/damage_table,damage_amount,critical_hit_multiplier,stealthy=FALSE)

	. = ..()

	if(health && health.health_current <= health.health_max*0.5 && !sword_mode && !has_status_effect(IMMORTAL)) //Start second phase at 50% health.
		start_sword_mode()


/mob/living/simple/gabber/update_icon()
	. = ..()
	if(sword_mode)
		icon_state = "swords"
	else
		icon_state = initial(icon_state)

/mob/living/simple/gabber/Finalize()

	if(!length(valid_gabber_sound_files))
		var/list/found_files = flist("sound/voice/silicon/gabber/")
		for(var/file in found_files)
			if(!has_suffix(file,".ogg"))
				continue
			var/word = replacetext(file,".ogg","")
			word = replacetext(word,"_"," ")
			valid_gabber_sound_files[word] = "sound/voice/silicon/gabber/[file]"

	. = ..()

	update_sprite()
	set_light_sprite(VIEW_RANGE*0.5,0.25, "#3184B7",LIGHT_OMNI)

/mob/living/simple/gabber/proc/start_sword_mode()

	add_status_effect(IMMORTAL)
	animate(src,pixel_z = -16,time=5)
	animate(pixel_z = initial(pixel_z),time=50)

	CALLBACK("\ref[src]_monologue_1",10,src,src::do_voice(),"fool",TRUE)
	CALLBACK("\ref[src]_monologue_2",10+10,src,src::do_voice(),"you are not a threat",TRUE)
	CALLBACK("\ref[src]_monologue_3",10+10+40,src,src::showoff())
	CALLBACK("\ref[src]_monologue_4",10+10+40+10,src,src::do_voice(),"but \[I am\]",TRUE)
	CALLBACK("\ref[src]_monologue_5",10+10+40+10+40,src,src::end_sword_mode())

	return TRUE

/mob/living/simple/gabber/get_damage_type(atom/attacker,atom/victim)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.horizontal)
			return /damagetype/unarmed/holy/kick

	if(sword_mode)
		return /damagetype/melee/sword/energy_katana/on

	. = ..()

/mob/living/simple/gabber/proc/showoff()
	sword_mode = TRUE
	update_sprite()
	play_sound('sound/effects/gabber_sword_draw.ogg',get_turf(src),range_min=VIEW_RANGE*0.5,range_max=VIEW_RANGE*2)
	src.rejuvenate()
	add_status_effect(IMMORTAL,stealthy=TRUE) //Rejuvenate removes all status effects, including this one. Needs to be re-added.

/mob/living/simple/gabber/proc/end_sword_mode()
	remove_status_effect(IMMORTAL)
	destroy_surrounding_obstacles()
	if(ai)
		ai.set_active(TRUE)

/mob/living/simple/gabber/proc/do_voice(text_to_say,force=FALSE)

	if(!force && next_special_attack > world.time) //No voice stacking.
		return TRUE

	if(valid_gabber_sound_files[text_to_say])
		var/turf/T = get_turf(src)
		if(T)
			play_sound(valid_gabber_sound_files[text_to_say],T,volume=75,range_min=VIEW_RANGE*0.5,range_max=VIEW_RANGE*2)

	src.do_say("[uppertext(text_to_say)].")

	next_special_attack = world.time + 1 SECONDS

	return TRUE

/mob/living/simple/gabber/update_icon()
	. = ..()
	icon_state = initial(icon_state)
	if(sword_mode)
		icon_state = "swords"

/mob/living/simple/gabber/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"[icon_state]_light")
	I.plane = PLANE_LIGHTING
	I.appearance_flags = src.appearance_flags | RESET_COLOR | KEEP_APART
	I.alpha = 125
	I.layer = 1000
	add_overlay(I)

/mob/living/simple/gabber/proc/slam(turf/target)
	if(has_status_effect(PARALYZE))
		return FALSE
	if(sword_mode)
		do_voice("die")
	else
		do_voice(pick(gabber_voice_slam))
	add_status_effect(PARALYZE,duration=8,magnitude=-1,stealthy=TRUE)
	var/obj/effect/gabber_slam/S = new(target)
	S.owner = src
	S.charge()
	return TRUE


/mob/living/simple/gabber/proc/super_slam_jam(turf/target)

	if(has_status_effect(PARALYZE))
		return FALSE

	var/list/list_to_use = superslam_latch ? DIRECTIONS_INTERCARDINAL : DIRECTIONS_CARDINAL
	superslam_latch = !superslam_latch

	do_voice("\[die\]")
	add_status_effect(PARALYZE,duration=12,magnitude=-1,stealthy=TRUE)
	var/obj/effect/gabber_slam/S = new(target)
	S.owner = src
	S.charge()

	for(var/d in list_to_use)
		var/turf/T = get_step(target,d)
		if(!T)
			continue
		T = get_step(T,d)
		if(!T)
			continue
		T = get_step(T,d)
		if(!T)
			continue
		var/obj/effect/gabber_slam/S2 = new(T)
		S2.owner = src
		S2.animate_caster = FALSE
		CALLBACK("\ref[S2]_directional_slam",10,S2,/obj/effect/gabber_slam/proc/charge)

	return TRUE




/mob/living/simple/gabber/proc/trap_spam(atom/target)

	if(has_status_effect(PARALYZE))
		return FALSE

	do_voice("challenge")

	play_sound('sound/weapons/magic/creation.ogg',get_turf(src))

	add_status_effect(PARALYZE,duration=16,magnitude=-1,stealthy=TRUE)

	var/offset = pick(0,90,180,270)
	var/direction = pick(-1,1)

	for(var/i=1,i<=16,i++)
		var/math_x = sin( (i/8 * 360 * direction) + offset)*VIEW_RANGE*0.5
		var/math_y = cos( (i/8 * 360 * direction) + offset)*VIEW_RANGE*0.5
		CALLBACK("\ref[src]_shoot_trap_[i]",5 + i*2,src,src::shoot_trap(),target,math_x,math_y)


/mob/living/simple/gabber/proc/trap_lines(trap_switch = 0)

	if(has_status_effect(PARALYZE))
		return FALSE

	if(trap_switch % 2)
		do_voice("there is \[no escape\]")
	else
		do_voice("there will be \[no mercy\]")

	var/turf/T = get_turf(src)

	play_sound('sound/weapons/magic/creation.ogg',T)

	add_status_effect(PARALYZE,duration=16,magnitude=-1,stealthy=TRUE)

	var/x_mul = pick(-1,1)
	var/y_mul = pick(-1,1)

	if(prob(50))
		if(prob(50))
			x_mul = 0
		else
			y_mul = 0

	for(var/i=1,i<=16,i++)
		var/math_x = (i - 8)*x_mul
		var/math_y = (i - 8)*y_mul
		CALLBACK("\ref[src]_shoot_trap_[i]",i*2,src,src::shoot_trap(),T,math_x,math_y)

/mob/living/simple/gabber/proc/shoot_trap(atom/target,math_x,math_y)

	if(!target || !target.z || target.z != target.z)
		return FALSE

	play_sound('sound/weapons/magic/zap.ogg',get_turf(src))

	var/turf/T = locate(
		target.x + round(math_x),
		target.y + round(math_y),
		z
	)

	if(!T)
		return FALSE

	if(locate(/obj/effect/temp/gabber_death_trap) in T)
		return FALSE

	var/obj/effect/temp/gabber_death_trap/DT = new(T)
	DT.owner = src
	DT.loyalty_tag = src.loyalty_tag
	DT.place()

	return TRUE




/mob/living/simple/gabber/proc/shoot_bouncy_projectiles(atom/desired_target,amount=3)

	play_sound('sound/weapons/magic/holy_shoot.ogg',get_turf(src))

	shoot_projectile(
		src,
		desired_target,
		null,
		null,
		/obj/projectile/magic/gabber_ring,
		/damagetype/ranged/laser/holy,
		16,
		16,
		0,
		sword_mode ? TILE_SIZE*0.25 : TILE_SIZE*0.125,
		amount,
		"#FFFFFF",
		0,
		1,
		iff_tag,
		loyalty_tag,
		base_spread = 0
	)

	return TRUE


/mob/living/simple/gabber/get_projectile_offset(initial_offset_x,initial_offset_y,bullet_num,bullet_num_max,accuracy)

	if(bullet_num_max == 1)
		return ..()

	var/num = bullet_num/bullet_num_max

	var/norm_x = initial_offset_x + sin(num*360)
	var/norm_y = initial_offset_y + cos(num*360)

	var/mul = max(abs(norm_x),abs(norm_y))

	return list(norm_x/mul,norm_y/mul)

/mob/living/simple/gabber/proc/destroy_surrounding_obstacles()

	do_voice("\[waste away\]")

	var/ix=0
	var/iy=0
	var/imaximum = 0
	while(imaximum < VIEW_RANGE)
		if(iy > imaximum)
			imaximum++
			ix = -imaximum
			iy = -imaximum
		else if(ix > imaximum)
			ix = -imaximum
			iy += 1
		else
			ix += 1
		var/turf/T = locate(x + ix,y + iy,z)
		if(!T)
			continue
		CALLBACK("\ref[src]_create_turf_destruction_[ix]_[iy]",(abs(ix) + abs(iy))*4,src,src::create_turf_destruction(),T)


/mob/living/simple/gabber/proc/create_turf_destruction(turf/T)
	new /obj/effect/gabber_turf_destruction(T)
	return TRUE

/mob/living/simple/gabber/on_parried_hit(atom/attacker,atom/weapon,atom/hit_object,atom/blamed,damagetype/DT,damage_multiplier=1)
	. = ..()
	do_voice(pick(gabber_voice_parry))
