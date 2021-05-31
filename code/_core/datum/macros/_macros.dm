/macros/
	var/client/owner
	var/list/macros = QWERTY_MACROS

	var/list/radio_keys = list(
		"g" = RADIO_FREQ_COMMON,
		"s" = RADIO_FREQ_SHIP,
		"a" = RADIO_FREQ_ALPHA,
		"1" = RADIO_FREQ_ALPHA,
		"b" = RADIO_FREQ_BRAVO,
		"2" = RADIO_FREQ_BRAVO,
		"c" = RADIO_FREQ_CHARLIE,
		"3" = RADIO_FREQ_CHARLIE,
		"4" = RADIO_FREQ_DELTA,
		"d" = RADIO_FREQ_DELTA,
		"t" = RADIO_FREQ_SYNDICATE,
		"m" = RADIO_FREQ_MERCENARY
	)

	var/list/language_keys = list(
		"1" = LANGUAGE_BASIC,
		"o" = LANGUAGE_LIZARD,
		"t" = LANGUAGE_CODESPEAK,
		"p" = LANGUAGE_RUSSIAN,
		"e" = LANGUAGE_CANADIAN,
		"0" = LANGUAGE_BINARY,
		"c" = LANGUAGE_CULT

	)

/macros/Destroy()
	owner = null
	return ..()

/macros/New(var/client/spawning_owner)
	owner = spawning_owner

/macros/proc/on_pressed(button)
	var/command = macros[button]

	if(has_prefix(command,"bind"))
		var/text_num = copytext(command,6,7)
		if(is_advanced(owner.mob))
			var/mob/living/advanced/A = owner.mob
			var/obj/hud/button/slot/B = A.slot_buttons[text_num]
			if(B) B.activate_button(owner.mob)
		return TRUE

	switch(command)
		if("move_up")
			owner.mob.move_dir |= NORTH
			owner.mob.move_delay = max(owner.mob.move_delay,1)
			if(!owner.mob.first_move_dir) owner.mob.first_move_dir = NORTH
		if("move_down")
			owner.mob.move_dir |= SOUTH
			owner.mob.move_delay = max(owner.mob.move_delay,1)
			if(!owner.mob.first_move_dir) owner.mob.first_move_dir = SOUTH
		if("move_left")
			owner.mob.move_dir |= WEST
			owner.mob.move_delay = max(owner.mob.move_delay,1)
			if(!owner.mob.first_move_dir) owner.mob.first_move_dir = WEST
		if("move_right")
			owner.mob.move_dir |= EAST
			owner.mob.move_delay = max(owner.mob.move_delay,1)
			if(!owner.mob.first_move_dir) owner.mob.first_move_dir = EAST
		if("sprint")
			owner.mob.movement_flags |= MOVEMENT_RUNNING
		if("walk")
			owner.mob.attack_flags |= CONTROL_MOD_DISARM
			if(is_living(owner.mob))
				var/mob/living/L = owner.mob
				L.update_intent()
		if("examine_mode")
			owner.examine_mode = TRUE
			owner.mob.examine_overlay.alpha = 255
		if("crouch")
			owner.mob.movement_flags |= MOVEMENT_CROUCHING
		if("throw")
			owner.mob.attack_flags |= CONTROL_MOD_THROW
		if("drop")
			owner.mob.attack_flags |= CONTROL_MOD_DROP
		if("hold")
			owner.mob.attack_flags |= CONTROL_MOD_BLOCK
			if(is_living(owner.mob))
				var/mob/living/L = owner.mob
				L.handle_blocking()
				if(world.time - owner.mob.last_hold < 5)
					L.dash(null,owner.mob.move_dir ? owner.mob.move_dir : owner.mob.dir,2)
				else if(world.time - owner.mob.last_hold >= 30) //Can't spam it.
					owner.mob.last_hold = world.time
			else
				owner.mob.last_hold = world.time
		if("grab")
			owner.mob.attack_flags |= CONTROL_MOD_GRAB
			if(is_living(owner.mob))
				var/mob/living/L = owner.mob
				L.update_intent()
		if("quick_self")
			owner.mob.attack_flags |= CONTROL_MOD_SELF
		if("quick_holder")
			owner.mob.attack_flags |= CONTROL_MOD_OWNER
		if("kick")
			owner.mob.attack_flags |= CONTROL_MOD_KICK
		if("zoom")
			owner.zoom_held = TRUE
			if(!owner.is_zoomed)
				owner.is_zoomed = owner.mob.dir
				owner.zoom_time = world.time
				var/real_angle = dir2angle(owner.mob.dir)
				var/desired_x_offset = sin(real_angle)
				var/desired_y_offset = cos(real_angle)
				owner.update_camera_offset(desired_x_offset,desired_y_offset)
		else
			winset(owner, null, "command='[command]'")

	return TRUE

/macros/proc/on_released(button)
	var/command = macros[button]

	if(has_prefix(command,"bind"))
		return TRUE

	switch(command)
		if("move_up")
			owner.mob.move_dir &= ~NORTH
			if(owner.mob.first_move_dir == NORTH) owner.mob.first_move_dir = null
		if("move_down")
			owner.mob.move_dir &= ~SOUTH
			if(owner.mob.first_move_dir == SOUTH) owner.mob.first_move_dir = null
		if("move_left")
			owner.mob.move_dir &= ~WEST
			if(owner.mob.first_move_dir == WEST) owner.mob.first_move_dir = null
		if("move_right")
			owner.mob.move_dir &= ~EAST
			if(owner.mob.first_move_dir == EAST) owner.mob.first_move_dir = null
		if("sprint")
			owner.mob.movement_flags &= ~MOVEMENT_RUNNING
		if("walk")
			owner.mob.attack_flags &= ~CONTROL_MOD_DISARM
			if(is_living(owner.mob))
				var/mob/living/L = owner.mob
				L.update_intent()
		if("examine_mode")
			owner.examine_mode = FALSE
			owner.mob.examine_overlay.alpha = 0
		if("crouch")
			owner.mob.movement_flags &= ~MOVEMENT_CROUCHING
		if("throw")
			owner.mob.attack_flags &= ~CONTROL_MOD_THROW
		if("drop")
			owner.mob.attack_flags &= ~CONTROL_MOD_DROP
		if("hold")
			owner.mob.attack_flags &= ~CONTROL_MOD_BLOCK
			if(is_living(owner.mob))
				var/mob/living/L = owner.mob
				L.handle_blocking()
		if("grab")
			owner.mob.attack_flags &= ~CONTROL_MOD_GRAB
			if(is_living(owner.mob))
				var/mob/living/L = owner.mob
				L.update_intent()
		if("quick_self")
			owner.mob.attack_flags &= ~CONTROL_MOD_SELF
		if("quick_holder")
			owner.mob.attack_flags &= ~CONTROL_MOD_OWNER
		if("kick")
			owner.mob.attack_flags &= ~CONTROL_MOD_KICK
		if("zoom")
			owner.zoom_held = FALSE
			if(owner.is_zoomed && (world.time - owner.zoom_time) > 4)
				owner.zoom_time = world.time
				owner.is_zoomed = 0x0

	return TRUE