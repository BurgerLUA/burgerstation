#define STAND_MODE_NONE "none" //Idle
#define STAND_MODE_AUTOMATIC "automatic" //The stand will get an AI and use it.
#define STAND_MODE_MANUAL "manual" //The stand will attack on your behalf.

/mob/living/advanced/stand
	name = "stand"
	desc = "Boss, that's an enemy stand."
	plane = PLANE_MOVABLE
	species = "stand"

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC

	var/enabled = FALSE

	var/mob/living/owner

	var/stand_mode = STAND_MODE_NONE

	ai = /ai/advanced/stand

	dna = /dna/human

	var/display_menacing = FALSE

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

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
		FIRE = TRUE
	)

/mob/living/advanced/stand/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(attacker && owner && attacker == owner)
		return FALSE

	if(!enabled)
		return FALSE

	return ..()

/mob/living/advanced/stand/Destroy()
	. = ..()
	owner = null

/mob/living/advanced/stand/handle_alpha()
	return enabled ? 255 : 0

/mob/living/advanced/stand/set_dir(var/desired_dir,var/force = FALSE)
	. = ..()
	if(.) update_offsets()

/mob/living/advanced/stand/on_life()
	. = ..()


	if(. && enabled)
		if(display_menacing)
			new/obj/effect/temp/menacing(src.loc,20,pixel_x-16,pixel_y+16)
			display_menacing = FALSE
		else
			display_menacing = TRUE

/mob/living/advanced/stand/on_life_slow()
	. = ..()
	if(.)
		update_offsets()

/mob/living/advanced/stand/proc/update_offsets()
	var/desired_x = -4
	var/desired_y = 4
	layer = LAYER_MOB_ABOVE

	var/list/vector_2d = direction_to_pixel_offset(get_true_4dir(owner.dir))

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
		update_collisions(initial(collision_flags),initial(collision_bullet_flags))
		force_move(owner.loc)
		remove_status_effect(IMMORTAL)
		var/initial_mouse = initial(mouse_opacity)
		mouse_opacity = initial_mouse ? initial_mouse : 1
	else
		update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE)
		add_status_effect(IMMORTAL)
		mouse_opacity = 0

	set_dir(owner.dir,TRUE)

	return TRUE

/mob/living/advanced/stand/clicked_on_by_object(var/mob/caller,var/atom/object)

	if(caller == owner)
		return TRUE

	return ..()
