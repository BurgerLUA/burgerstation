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

	soul_size = SOUL_SIZE_MYSTIC

	object_size = 2

	respawn_time = SECONDS_TO_DECISECONDS(300)

	level = 50

	movement_delay = DECISECONDS_TO_TICKS(3)

	var/sword_mode = FALSE

	var/superslam_latch = 0

/mob/living/simple/gabber/get_damage_received_multiplier(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)

	. = ..()

	if(sword_mode)
		. *= 0.5

/mob/living/simple/gabber/death(var/silent=FALSE)

	if(!sword_mode)
		start_sword_mode()
		return FALSE

	. = ..()

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
			word = replacetext(word," ","_")
			valid_gabber_sound_files[word] = "sound/voice/silicon/gabber/[file]"

	. = ..()

	update_sprite()
	set_light_sprite(VIEW_RANGE*0.5,0.25, "#3184B7",LIGHT_OMNI)

/mob/living/simple/gabber/proc/start_sword_mode()

	add_status_effect(IMMORTAL)
	animate(src,pixel_z = -16,time=5)
	animate(pixel_z = initial(pixel_z),time=50)

	CALLBACK("\ref[src]_monologue_1",10,src,.proc/do_voice,"fool")
	CALLBACK("\ref[src]_monologue_2",10+10,src,.proc/do_voice,"you are not a threat")
	CALLBACK("\ref[src]_monologue_3",10+10+40,src,.proc/showoff)
	CALLBACK("\ref[src]_monologue_4",10+10+40+10,src,.proc/do_voice,"but \[I am\]")
	CALLBACK("\ref[src]_monologue_5",10+10+40+10+40,src,.proc/end_sword_mode)

	return TRUE

/mob/living/simple/gabber/get_damage_type(var/atom/attacker,var/atom/victim)

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

/mob/living/simple/gabber/proc/end_sword_mode()
	remove_status_effect(IMMORTAL)
	destroy_surrounding_obstacles()
	if(ai)
		ai.set_active(TRUE)

/mob/living/simple/gabber/proc/do_voice(var/text_to_say)

	if(valid_gabber_sound_files[text_to_say])
		var/turf/T = get_turf(src)
		if(T)
			play_sound(valid_gabber_sound_files[text_to_say],T,range_min=VIEW_RANGE*0.5,range_max=VIEW_RANGE*2)

	src.do_say("[uppertext(text_to_say)].")

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

var/global/list/gabber_voice_slam = list(
	"death",
	"die",
	"down"
)

/mob/living/simple/gabber/proc/slam(var/turf/target)
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


/mob/living/simple/gabber/proc/super_slam_jam(var/turf/target)

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
		var/obj/effect/gabber_slam/S2 = new(T)
		S2.owner = src
		CALLBACK("\ref[S2]_directional_slam",5,S2,/obj/effect/gabber_slam/proc/charge)

	return TRUE




/mob/living/simple/gabber/proc/trap_spam(var/atom/target)

	if(has_status_effect(PARALYZE))
		return FALSE

	do_voice("challenge")

	play_sound('sound/weapons/magic/creation.ogg',get_turf(src))

	add_status_effect(PARALYZE,duration=16,magnitude=-1,stealthy=TRUE)

	var/offset = pick(0,90,180,270)
	var/direction = pick(-1,1)

	for(var/i=1,i<=16,i++)
		var/math_x = sin(i/8 * 360 * direction + offset)*VIEW_RANGE*0.5
		var/math_y = cos(i/8 * 360 * direction + offset)*VIEW_RANGE*0.5
		CALLBACK("\ref[src]_shoot_trap_[i]",i*2,src,.proc/shoot_trap,target,math_x,math_y)


/mob/living/simple/gabber/proc/trap_lines()

	if(has_status_effect(PARALYZE))
		return FALSE

	do_voice("there is \[no escape\]")

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
		CALLBACK("\ref[src]_shoot_trap_[i]",i*2,src,.proc/shoot_trap,T,math_x,math_y)

	for(var/i=1,i<=16,i++)
		var/math_x = (i - 8)*x_mul*-1
		var/math_y = (i - 8)*y_mul*-1
		CALLBACK("\ref[src]_shoot_trap_[-i]",i*2,src,.proc/shoot_trap,T,math_x,math_y)

/mob/living/simple/gabber/proc/shoot_trap(var/atom/target,var/math_x,var/math_y)

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


var/global/list/gabber_voice_multishot = list(
	"away",
	"escape",
	"run"
)

/mob/living/simple/gabber/proc/shoot_bouncy_projectiles(var/atom/desired_target,var/amount=3)

	play_sound('sound/weapons/magic/holy_shoot.ogg',get_turf(src))

	if(amount > 1)
		do_voice(pick(gabber_voice_multishot))

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
		TILE_SIZE*0.125,
		amount,
		"#FFFFFF",
		0,
		1,
		iff_tag,
		loyalty_tag,
		base_spread = 0
	)

	return TRUE


/mob/living/simple/gabber/get_projectile_offset(var/initial_offset_x,var/initial_offset_y,var/bullet_num,var/bullet_num_max,var/accuracy)

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
	while(TRUE)
		if(imaximum >= VIEW_RANGE)
			break
		else if(iy > imaximum)
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
			break
		CALLBACK("\ref[src]_create_turf_destruction_[ix]_[iy]",(abs(ix) + abs(iy))*4,src,.proc/create_turf_destruction,T)


/mob/living/simple/gabber/proc/create_turf_destruction(var/turf/T)
	new /obj/effect/gabber_turf_destruction(T)
	return TRUE

var/global/list/gabber_voice_parry = list(
	"blocked",
	"denied",
	"failure"
)

/mob/living/simple/gabber/on_parried_hit(var/atom/attacker,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT,var/damage_multiplier=1)
	. = ..()
	do_voice(pick(gabber_voice_parry))