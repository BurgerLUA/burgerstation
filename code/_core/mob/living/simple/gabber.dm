var/global/list/valid_gabber_sound_files = list()


/mob/living/simple/gabber
	name = "Zechariah the Synthangel"
	icon = 'icons/mob/living/simple/gabber.dmi'
	icon_state = "idle"
	pixel_w = -16
	pixel_z = -8

	boss_icon_state = "zechariah"

	damage_type = /damagetype/unarmed/holy

	var/ape_mode = FALSE

	ai = /ai/boss/gabber/

	force_spawn = TRUE
	boss = TRUE

	value = 10000

	stun_angle = 0

	health_base = 12500
	stamina_base = 5000
	mana_base = 12500

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

	level = 80

	movement_delay = DECISECONDS_TO_TICKS(3)



/mob/living/simple/gabber/update_icon()
	. = ..()
	if(ape_mode)
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
			valid_gabber_sound_files[word] = "sound/voice/silicon/gabber/[file]"
			world.log << "valid_gabber_sound_files\[[word]\] = sound/voice/silicon/gabber/[file]"

	. = ..()

	update_sprite()
	set_light_sprite(VIEW_RANGE*0.5,0.25, "#3184B7",LIGHT_OMNI)

/*
	transform = get_base_transform()

/mob/living/simple/gabber/get_base_transform()
	var/matrix/M = matrix()
	M.Scale(2)
	return M
*/

/mob/living/simple/gabber/proc/do_voice(var/text_to_say)

	if(valid_gabber_sound_files[text_to_say])
		var/turf/T = get_turf(src)
		if(T)
			play_sound(valid_gabber_sound_files[text_to_say],T,range_min=VIEW_RANGE*0.5,range_max=VIEW_RANGE*2)

	src.do_say("[uppertext(text_to_say)].")

	return TRUE

/mob/living/simple/gabber/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"[icon_state]_light")
	I.plane = PLANE_LIGHTING
	I.appearance_flags = src.appearance_flags | RESET_COLOR | KEEP_APART
	I.alpha = 125
	I.layer = 1000
	add_overlay(I)

var/global/list/gabber_voice_curse = list(
	"fool" = MANAVOID,
	"slow" = SLOW,
	"suffer" = STRESSED,
	"weak" = BLIGHTED
)

/mob/living/simple/gabber/proc/curse()

	if(has_status_effect(PARALYZE))
		return FALSE

	add_status_effect(PARALYZE,duration=10,magnitude=-1,stealthy=TRUE)

	var/chosen_curse = pick(gabber_voice_curse)

	do_voice(chosen_curse)

	for(var/mob/living/L in viewers(VIEW_RANGE,src))
		if(!allow_hostile_action(src.loyalty_tag,L))
			continue
		add_status_effect(chosen_curse,duration=SECONDS_TO_DECISECONDS(30),magnitude=25)
		L.to_chat(span("danger","You've been cursed by [src.name]!"))

var/global/list/gabber_voice_slam = list(
	"death",
	"destroy",
	"die",
	"down"
)

/mob/living/simple/gabber/proc/slam(var/turf/target)
	if(has_status_effect(PARALYZE))
		return FALSE
	do_voice(pick(gabber_voice_slam))
	add_status_effect(PARALYZE,duration=8,magnitude=-1,stealthy=TRUE)
	var/obj/effect/gabber_slam/S = new(target)
	S.owner = src
	S.charge()
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
	"abstain",
	"away",
	"escape",
	"run"
)

/mob/living/simple/gabber/proc/shoot_bouncy_projectiles(var/atom/desired_target,var/amount=5)

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
		TILE_SIZE*0.25,
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


var/global/list/gabber_voice_block = list(
	"blocked",
	"denied",
	"failure"
)