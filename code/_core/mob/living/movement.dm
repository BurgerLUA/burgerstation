/mob/living/proc/handle_footsteps(var/turf/T,var/list/footsteps_to_use,var/enter=TRUE)

	if(!T)
		return FALSE

	if(enter)
		CALLBACK("enter_footstep_\ref[src]", TICKS_TO_DECISECONDS(move_delay)*0.5, src, .proc/do_footstep, T, footsteps_to_use)
		return FALSE

	do_footstep(T,footsteps_to_use,enter)

	return TRUE

/mob/living/proc/do_footstep(var/turf/T,var/list/footsteps_to_use,var/enter=TRUE)

	footstep_counter = (footstep_counter + 1) % footstep_mod

	if(!footstep_counter)
		footstep_left_right_counter = !footstep_left_right_counter

	for(var/k in footsteps_to_use)
		if(!k)
			continue
		var/footstep/F = SSfootstep.all_footsteps[k]
		if(!footstep_counter)
			var/footstep_volume = 50 * (move_mod-0.5)
			if(is_sneaking)
				footstep_volume *= 0.5

			var/footstep_sound
			if(horizontal)
				if(length(F.drag_sounds))
					footstep_sound = pick(F.drag_sounds)
			else
				if(length(F.footstep_sounds))
					footstep_sound = pick(F.footstep_sounds)

			if(footstep_sound)
				play_sound(footstep_sound, get_turf(src), volume = footstep_volume, sound_setting = SOUND_SETTING_FOOTSTEPS, pitch = 1 + RAND_PRECISE(-F.variation_pitch,F.variation_pitch),range_max=VIEW_RANGE)

	return TRUE


/mob/living/proc/get_footsteps(var/list/original_footsteps,var/enter=TRUE)
	return original_footsteps

/mob/living/Move(NewLoc,Dir=0,step_x=0,step_y=0)

	if(attack_flags & CONTROL_MOD_BLOCK || (client && client.is_zoomed))
		Dir = 0x0

	. = ..()

	if(ai)
		ai.on_move(.,NewLoc,Dir)

	if(stand)
		stand.on_move(.,NewLoc,Dir)

	return .

/mob/living/post_move(var/atom/old_loc)

	. = ..()

	if(chat_overlay)
		chat_overlay.glide_size = src.glide_size
		chat_overlay.force_move(src.loc)
	if(alert_overlay)
		alert_overlay.glide_size = src.glide_size
		alert_overlay.force_move(src.loc)
	if(fire_overlay)
		fire_overlay.glide_size = src.glide_size
		fire_overlay.force_move(src.loc)
	if(shield_overlay)
		shield_overlay.glide_size = src.glide_size
		shield_overlay.force_move(src.loc)

	if(is_sneaking)
		on_sneak()

	if(isturf(old_loc))
		var/turf/T = old_loc
		if(T.old_living)
			T.old_living -= src

	if(isturf(loc))
		var/turf/T = loc
		if(!T.old_living)
			T.old_living = list()
		T.old_living |= src

	handle_tabled()

	return .


/mob/living/Bump(atom/Obstacle)
	if(ai) ai.Bump(Obstacle)
	return ..()


/mob/living/proc/can_move()

	if(dead)
		return FALSE

	if(has_status_effects(PARALYZE,SLEEP,STAGGER,STUN))
		return FALSE

	if(buckled_object && !buckled_object.unbuckle(src))
		return FALSE

	return TRUE

/mob/living/on_sprint()
	add_hydration(-0.4)
	return ..()

/mob/living/on_jog()
	add_hydration(-0.1)
	return ..()

/mob/living/handle_movement(var/adjust_delay = 1)


	if(move_dir) //If you're actuall moving.

		if(!can_move())
			return FALSE

		if(grabbing_hand)
			resist()
			return FALSE

		if(get_status_effect_magnitude(SLEEP) == -1)
			remove_status_effect(SLEEP)
			return FALSE

		if(has_status_effect(CONFUSED))
			move_dir = turn(move_dir,180)

	. = ..()

	if(.)

		if(has_status_effect(CONFUSED))
			move_dir = turn(move_dir,180)

	return .

/mob/living/get_stance_movement_mul()

	if(horizontal)
		move_mod = 1
		return 6

	return ..()

/mob/living/get_movement_delay()

	. = ..()

	if(is_sneaking)
		. *= (2 - stealth_mod*0.5)

	. *= 2 - min(1.5,get_nutrition_mod() * get_hydration_mod() * (0.5 + get_nutrition_quality_mod()*0.5))

	if(has_status_effect(ADRENALINE))
		. *= 0.9

	if(intoxication)
		. += intoxication*0.003


	return .


/mob/living/proc/toggle_sneak(var/on = TRUE)

	for(var/k in buttons)
		var/obj/hud/button/B = k
		if(B.type == /obj/hud/button/sneak)
			var/obj/hud/button/sneak/S = B
			S.sneaking = on
			S.update_sprite()

	if(on && !dead)
		stealth_mod = get_skill_power(SKILL_SURVIVAL)
		is_sneaking = TRUE
		return TRUE
	else
		is_sneaking = FALSE
		return FALSE

/mob/living/proc/on_sneak()
	return TRUE

/mob/living/proc/update_alpha(var/desired_alpha)
	if(alpha != desired_alpha)
		animate(src, alpha = desired_alpha, color = rgb(desired_alpha,desired_alpha,desired_alpha), time = SECONDS_TO_DECISECONDS(1))
		return TRUE

	return FALSE

/mob/living/Cross(atom/movable/O)

	if(is_living(O))
		var/mob/living/L = O
		if(L.loyalty_tag == src.loyalty_tag)
			if(!src.ai || L.is_moving || !L.ai)
				return ..()
		if(L.horizontal || src.horizontal)
			return ..()
		if(L.size >= size && L.size >= SIZE_ANIMAL)
			return FALSE

	return ..()


/mob/living/on_thrown(var/atom/owner,var/atom/hit_atom,var/atom/hit_wall) //What happens after the person is thrown.

	if(has_status_effects(STUN,STAGGER,PARALYZE))
		return ..()

	if(hit_wall)
		add_status_effect(STUN,5,5,source = owner)
	else
		add_status_effect(STAGGER,2,2,source = owner)

	return ..()

/mob/living/proc/handle_tabled()

	climb_counter = 0

	if(tabled != currently_tabled)
		currently_tabled = tabled
		if(currently_tabled)
			animate(src, pixel_z = initial(pixel_z) + 10, time = 10, easing = CIRCULAR_EASING | EASE_OUT)
			move_delay = max(10,move_delay)
		else
			animate(src, pixel_z = initial(pixel_z), time = 5, easing = CIRCULAR_EASING | EASE_OUT)
			move_delay = max(5,move_delay)

	return TRUE