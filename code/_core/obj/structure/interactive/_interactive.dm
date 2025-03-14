obj/structure/interactive/
	name = "interactive structure"
	desc = "What does it do?"
	mouse_over_pointer = MOUSE_ACTIVE_POINTER

	var/repair_flag = FLAG_TOOL_NONE //Set this to something if it can be repaired by it.

	var/obj/structure/interactive/wire/connected_wire

	var/power_draw = 0
	var/power_supply = 0

	var/wire_powered = FALSE //Set to true if this should take power from a wire.
	var/apc_powered = FALSE //Set to true if this should take power from an APC.

	var/powered = FALSE //Whether or not this object is currently powered.

	var/power_type = POWER_MACHINE

obj/structure/interactive/proc/link_power(var/area/A,var/link=TRUE)

	if(!apc_powered)
		return FALSE

	if(link)
		switch(power_type)
			if(POWER_MACHINE)
				if(A.requires_power)
					A.powered_machines += src
				powered = A.enable_power_machines & ON ? TRUE : FALSE
			if(POWER_DOOR)
				if(A.requires_power)
					A.powered_doors += src
				powered = A.enable_power_doors & ON ? TRUE : FALSE
			if(POWER_LIGHT)
				if(A.requires_power)
					A.powered_lights += src
				powered = A.enable_power_lights & ON ? TRUE : FALSE
	else
		if(A.requires_power)
			switch(power_type)
				if(POWER_MACHINE)
					A.powered_machines -= src
				if(POWER_DOOR)
					A.powered_doors -= src
				if(POWER_LIGHT)
					A.powered_lights -= src
		powered = FALSE

	if(A.requires_power)
		if(powered)
			update_power_draw(get_power_draw())
		else
			update_power_draw(0)

/obj/structure/interactive/PreDestroy()

	if(is_turf(loc))
		var/turf/T = loc
		link_power(T.loc,FALSE)

	if(connected_wire)
		connected_wire.do_snap()

	. = ..()

/obj/structure/interactive/Destroy()
	apc_powered = FALSE
	wire_powered = FALSE
	. = ..()

/obj/structure/interactive/Finalize()

	if(is_turf(loc))
		var/turf/T = loc
		link_power(T.loc,TRUE)

	. = ..()

/obj/structure/interactive/post_move(var/atom/old_loc)
	. = ..()

	if(connected_wire)
		connected_wire.do_snap()

	if(apc_powered)
		if(is_turf(old_loc))
			var/turf/T = old_loc
			link_power(T.loc,FALSE)

		if(is_turf(src.loc))
			var/turf/T = src.loc
			link_power(T.loc,TRUE)

/obj/structure/interactive/proc/get_power_draw()
	return 0

/obj/structure/interactive/proc/get_power_supply()
	return 0

obj/structure/interactive/get_examine_list(var/mob/examiner)

	. = ..()

	if(health)
		var/health_percent = health.health_current/health.health_max
		switch(health_percent)
			if(-INFINITY to 0.2)
				. += div("danger","It's falling apart!")
			if(0.2 to 0.4)
				. += div("danger","It looks seriously damaged.")
			if(0.4 to 0.6)
				. += div("warning","It looks very damaged.")
			if(0.6 to 0.9)
				. += div("warning","It looks damaged.")
			if(0.9 to 0.95)
				. += div("notice","It has a few scrapes.")


obj/structure/interactive/proc/can_repair(var/mob/living/advanced/activator,var/obj/item/I)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(I)

	if(activator.intent != INTENT_HELP)
		return FALSE

	if(!health)
		return FALSE

	if(health.health_current >= health.health_max)
		activator?.to_chat(span("warning","\The [src.name] is already repaired!"))
		return FALSE

	if(!(I.flags_tool & repair_flag))
		activator?.to_chat(span("warning","\The [I.name] cannot be used to repair \the [src.name]!"))
		return FALSE

	return TRUE


obj/structure/interactive/proc/do_repair(var/mob/living/advanced/activator,var/obj/item/I)
	visible_message(span("notice","\The [activator.name] repairs \the [src.name] with \the [I.name]."))
	health.adjust_loss_smart(brute=-100,burn=-100)

	return TRUE

obj/structure/interactive/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)


	if(is_item(object))
		var/obj/item/I = object

		if(repair_flag && is_advanced(activator) && can_repair(activator,I))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			PROGRESS_BAR(activator,src,SECONDS_TO_DECISECONDS(5),src::do_repair(),activator,object)
			PROGRESS_BAR_CONDITIONS(activator,src,src::can_repair(),activator,object)
			return TRUE

		var/obj/item/I2 = src.check_interactables(activator,src,location,control,params)
		if(I2)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			I2.drop_item(get_turf(activator))
			activator.to_chat(span("notice","You successfully remove \the [I2.name] from \the [I.name] with \the [src.name]."))
			return TRUE




	return ..()

/obj/structure/interactive/proc/power_process(var/power_multiplier=1)
	return TRUE

obj/structure/interactive/proc/check_interactables(var/mob/activator,var/atom/object,location,control,params)

	var/list/valid_interactables = list()

	var/has_multitool = FALSE

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_MULTITOOL)
			has_multitool = TRUE

	for(var/obj/item/device/T in contents)
		if(!has_multitool && !T.interactable)
			continue
		valid_interactables += T

	var/valid_length = length(valid_interactables)
	if(!valid_length)
		return FALSE

	var/obj/item/device/T

	if(valid_length == 1)
		T = valid_interactables[1]
	else
		T = input(activator,"Which device do you wish to interact with?","Device Interaction") as null|anything in valid_interactables

	return T



/obj/structure/interactive/proc/update_power_draw(var/desired_power_draw,var/reset=FALSE)

	var/area/A = null

	if(wire_powered)
		if(!connected_wire)
			desired_power_draw = 0
		else if(!connected_wire.power_network)
			desired_power_draw = 0
	else if(apc_powered)
		A = get_area(src)
		if(A && !A.linked_apc)
			desired_power_draw = 0

	desired_power_draw = max(0,desired_power_draw)

	if(desired_power_draw != power_draw)
		if(wire_powered)
			if(!reset) connected_wire.power_network.power_draw -= power_draw
			power_draw = desired_power_draw
			connected_wire.power_network.power_draw += power_draw
		else if(A && apc_powered)
			if(!reset) A.power_draw -= power_draw
			power_draw = desired_power_draw
			A.power_draw += power_draw

	update_atom_light()
	update_sprite()

	return TRUE

/obj/structure/interactive/proc/update_power_supply(var/desired_power_supply,var/reset=FALSE)

	if(!wire_powered)
		power_supply = 0

	if(!connected_wire)
		power_supply = 0

	if(!connected_wire.power_network)
		power_supply = 0

	desired_power_supply = max(0,desired_power_supply)

	if(desired_power_supply != power_supply)
		if(!reset) connected_wire.power_network.power_supply -= power_supply
		power_supply = desired_power_supply
		connected_wire.power_network.power_supply += power_supply

	return TRUE
