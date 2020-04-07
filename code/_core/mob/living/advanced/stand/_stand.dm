#define STAND_MODE_NONE "none" //Idle
#define STAND_MODE_AUTOMATIC "automatic" //The stand will get an AI and use it.
#define STAND_MODE_MANUAL "manual" //The stand will attack on your behalf.

/mob/living/advanced/stand
	name = "stand"
	desc = "Boss, that's an enemy stand."
	plane = PLANE_MOB
	appearance_flags = KEEP_TOGETHER | LONG_GLIDE | PIXEL_SCALE
	species = "stand"

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	var/enabled = FALSE

	var/mob/living/owner

	var/stand_mode = STAND_MODE_NONE

	ai = /ai/advanced/stand

/mob/living/advanced/stand/Destroy()
	owner = null
	return ..()

/mob/living/advanced/stand/handle_alpha()
	return enabled ? 200 : 0

/mob/living/advanced/stand/set_dir(var/desired_dir,var/force = FALSE)
	. = ..()
	update_offsets()
	return .

/mob/living/advanced/stand/on_life_slow()
	. = ..()
	update_offsets()
	return .

/mob/living/advanced/stand/proc/update_offsets()
	var/desired_x = -4
	var/desired_y = 4
	layer = LAYER_MOB_ABOVE

	var/desired_dir = dir

	/*
	if(ai && ai.objective_attack)
		desired_dir = get_dir(src,ai.objective_attack)
	*/

	var/list/vector_2d = direction_to_pixel_offset(desired_dir)

	if(owner)
		if(!enabled || (ai && ai.objective_attack) || src.loc != owner.loc)
			desired_x = 0
			desired_y = 0
		else if(owner.intent == INTENT_HARM)
			desired_x += vector_2d[1] * 16
			desired_y += vector_2d[2] * 16
		else
			desired_x += vector_2d[1] * -16
			desired_y += vector_2d[2] * -16

		if(desired_y < 0)
			layer = LAYER_MOB_ABOVE
		else
			layer = LAYER_MOB_BELOW
	else
		desired_x = 0
		desired_y = 0

	if(pixel_x != desired_x || pixel_y != desired_y)
		animate(src, pixel_x = desired_x, pixel_y = desired_y, time = 1)

	return TRUE

/mob/living/advanced/stand/proc/set_enabled(var/desired_enable=FALSE)

	enabled = desired_enable

	if(enabled)
		collision_flags = initial(collision_flags)
		collision_bullet_flags = initial(collision_bullet_flags)
		force_move(owner.loc)
		immortal = FALSE
		mouse_opacity = initial(mouse_opacity)
	else
		collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
		collision_flags = FLAG_COLLISION_NONE
		immortal = TRUE
		mouse_opacity = 0

	set_dir(owner.dir,TRUE)

	return TRUE

/mob/living/advanced/stand/clicked_on_by_object(var/mob/caller,var/atom/object)

	if(caller == owner)
		return TRUE

	return ..()

/mob/living/advanced/stand/Initialize()
	. = ..()
	var/species/S = all_species[species]
	var/skin_color = random_color()
	var/hair_color = random_color()
	change_organ_visual("skin", desired_color = skin_color)
	change_organ_visual("hair_head", desired_color = hair_color, desired_icon_state = pick(S.all_hair_head))
	if(sex == MALE && prob(25))
		change_organ_visual("hair_face", desired_color = hair_color, desired_icon_state = pick(S.all_hair_face))
	update_all_blends()
	return .