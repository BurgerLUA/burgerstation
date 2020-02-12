/macros/
	var/client/owner
	var/list/macros = list(

		"W" = NORTH,
		"D" = EAST,
		"S" = SOUTH,
		"A" = WEST,

		"UP" = NORTH,
		"RIGHT" = EAST,
		"DOWN" = SOUTH,
		"LEFT" = WEST,

		"Shift" = "sprint",
		"Alt" = "walk",

		"Ctrl" = "grab",
		"R" = "throw",
		"Q" = "drop",
		"C" = "quick_self",
		"Z" = "zoom",
		"Space" = "kick",

		"1" = "bind_1",
		"2" = "bind_2",
		"3" = "bind_3",
		"4" = "bind_4",
		"5" = "bind_5",
		"6" = "bind_6",
		"7" = "bind_7",
		"8" = "bind_8",
		"9" = "bind_9",
		"0" = "bind_0",

		"T" = "say",
		"O" = "ooc",
		"L" = "looc"
	)
	var/list/radio_keys = list(
		";" = RADIO_FREQ_COMMON,
		"g" = RADIO_FREQ_COMMON,
		"s" = RADIO_FREQ_SHIP,
		"a" = RADIO_FREQ_ALPHA,
		"1" = RADIO_FREQ_ALPHA,
		"b" = RADIO_FREQ_BRAVO,
		"2" = RADIO_FREQ_BRAVO,
		"c" = RADIO_FREQ_CHARLIE,
		"3" = RADIO_FREQ_CHARLIE,
		"4" = RADIO_FREQ_DELTA,
		"d" = RADIO_FREQ_DELTA
	)

/macros/Destroy()
	owner = null
	return ..()

/macros/New(var/client/spawning_owner)
	owner = spawning_owner

/macros/proc/on_pressed(button)
	var/command = macros[button]
	if(isnum(command))
		owner.mob.move_dir |= command
		if(owner.mob)
			owner.mob.move_delay = max(owner.mob.move_delay,2)

	else if(copytext(command,1,5) == "bind")
		var/text_num = copytext(command,6,7)
		if(is_advanced(owner.mob))
			var/mob/living/advanced/A = owner.mob
			for(var/obj/hud/button/slot/B in A.buttons)
				if(B.id == text_num)
					B.activate_button(owner.mob)

	else
		switch(command)
			if("sprint")
				owner.mob.movement_flags |= MOVEMENT_RUNNING
			if("walk")
				owner.mob.movement_flags |= MOVEMENT_WALKING
			if("crouch")
				owner.mob.movement_flags |= MOVEMENT_CROUCHING
			if("throw")
				owner.mob.attack_flags |= ATTACK_THROW
			if("drop")
				owner.mob.attack_flags |= ATTACK_DROP
			if("kick")
				owner.mob.attack_flags |= ATTACK_KICK
			if("grab")
				owner.mob.attack_flags |= ATTACK_GRAB
			if("quick_self")
				owner.mob.attack_flags |= ATTACK_SELF
			if("zoom")
				owner.is_zoomed = TRUE

	return TRUE

/macros/proc/on_released(button)
	var/command = macros[button]

	if(isnum(command))
		owner.mob.move_dir &= ~command
	else
		switch(command)
			if("say")
				spawn owner.mob.say()
			if("sprint")
				owner.mob.movement_flags &= ~MOVEMENT_RUNNING
			if("walk")
				owner.mob.movement_flags &= ~MOVEMENT_WALKING
			if("crouch")
				owner.mob.movement_flags &= ~MOVEMENT_CROUCHING
			if("throw")
				owner.mob.attack_flags &= ~ATTACK_THROW
			if("drop")
				owner.mob.attack_flags &= ~ATTACK_DROP
			if("kick")
				owner.mob.attack_flags &= ~ATTACK_KICK
			if("grab")
				owner.mob.attack_flags &= ~ATTACK_GRAB
			if("quick_self")
				owner.mob.attack_flags &= ~ATTACK_SELF
			if("zoom")
				owner.is_zoomed = FALSE
				owner.pixel_x = 0
				owner.pixel_y = 0
				//animate(owner,pixel_x = 0, pixel_y = 0, time = SECONDS_TO_DECISECONDS(1))
			if("ooc")
				spawn owner.ooc()


	return TRUE