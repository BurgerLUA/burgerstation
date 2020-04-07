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

	var/is_active = FALSE

	var/mob/living/owner

	var/stand_mode = STAND_MODE_NONE

/mob/living/advanced/stand/Destroy()
	owner = null
	return ..()

/mob/living/advanced/stand/handle_alpha()
	return is_active ? 255 : 0


/mob/living/advanced/stand/set_dir(var/desired_dir,var/force = FALSE)

	. = ..()

	if(force)
		. = desired_dir

	if(.)
		var/desired_x = -4
		var/desired_y = 4
		layer = LAYER_MOB_ABOVE

		if(owner && is_active)
			if(. & (owner.intent == INTENT_HARM ? SOUTH : NORTH))
				desired_y = -16
				layer = LAYER_MOB_ABOVE
			else if(. & (owner.intent == INTENT_HARM ? NORTH : SOUTH))
				desired_y = 16
				layer = LAYER_MOB_BELOW

			if(. & (owner.intent == INTENT_HARM ? WEST : EAST))
				desired_x = -16
			else if(. & (owner.intent == INTENT_HARM ? EAST : WEST))
				desired_x = 16
		else
			desired_x = 0
			desired_y = 0

		animate(src, pixel_x = desired_x, pixel_y = desired_y, time = 1)

	return .

/mob/living/advanced/stand/proc/set_active(var/active=FALSE)

	is_active = active

	if(is_active)
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