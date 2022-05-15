/obj/item/clothing/glasses/nightvision
	name = "nightvision goggles"

	desc = "Kept you waiting, huh?"
	desc_extended = "A pair of tactical nightvision goggles. Keep away from light."
	icon = 'icons/obj/item/clothing/glasses/nightvision.dmi'

	see_in_dark = VIEW_RANGE + ZOOM_RANGE

	armor = /armor/mechanical/night_vision

	value = 100

	item_slot_layer = 2

	worn_layer = LAYER_MOB_CLOTHING_ALL

	var/active = FALSE

	var/obj/item/powercell/stored_cell = /obj/item/powercell/tiny

	var/next_think = 0

/obj/item/clothing/glasses/nightvision/get_examine_list(var/mob/examiner)
	. = ..()
	if(stored_cell)
		. += div("notice","There is \a [stored_cell] installed.")
		. += div("notice","The charge meter reads [CEILING((stored_cell.charge_current/stored_cell.charge_max)*100,1)]%.")
	else
		. += div("notice","There is no power cell installed.")

/obj/item/clothing/glasses/nightvision/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_SCREWDRIVER)
			INTERACT_CHECK
			INTERACT_DELAY(5)
			if(!stored_cell)
				caller.to_chat(span("warning","There is no power cell to remove from \the [src.name]!"))
				return TRUE
			stored_cell.drop_item(get_turf(caller))
			caller.to_chat(span("notice","You remove \the [stored_cell.name] from \the [src.name]."))
			stored_cell = null
			return TRUE
		if(istype(object,/obj/item/powercell/))
			INTERACT_CHECK
			INTERACT_DELAY(5)
			var/obj/item/PC = object
			if(stored_cell)
				caller.to_chat(span("warning","There is already \a [stored_cell.name] inside \the [src.name]!"))
				return TRUE
			if(PC.size > SIZE_0)
				caller.to_chat(span("warning","\The [PC.name] is too large to be put into \the [src.name]!"))
				return TRUE
			PC.drop_item(src)
			caller.to_chat(span("notice","You insert \the [PC.name] into \the [src.name]."))
			stored_cell = PC
			return TRUE

	. = ..()

/obj/item/clothing/glasses/nightvision/Generate()
	. = ..()
	if(ispath(stored_cell))
		stored_cell = new stored_cell(src)
		INITIALIZE(stored_cell)
		GENERATE(stored_cell)
		FINALIZE(stored_cell)

/obj/item/clothing/glasses/nightvision/Finalize()
	if(ispath(stored_cell))
		stored_cell = null
	. = ..()
	update_sprite()

/obj/item/clothing/glasses/nightvision/get_battery()
	return stored_cell

/obj/item/clothing/glasses/nightvision/think()
	. = ..()
	if(next_think <= world.time)
		next_think = world.time + SECONDS_TO_DECISECONDS(1)
		var/obj/item/powercell/PC = get_battery()
		if(PC) PC.charge_current = max(0,PC.charge_current-rand(8,12))
		if(!PC || PC.charge_current <= 0) //NO MORE CHARGE.
			active = FALSE
			var/obj/hud/inventory/I = src.loc
			update_sprite()
			if(istype(I))
				disable(I)
				if(I.worn && is_advanced(I.owner))
					var/mob/living/advanced/A = I.owner
					A.remove_overlay("\ref[src]")
					I.update_worn_icon(src)

	return active

/obj/item/clothing/glasses/nightvision/update_icon()
	. = ..()
	icon = initial(icon)
	icon_state = initial(icon_state)
	icon_state_worn = initial(icon_state_worn)
	if(!active)
		icon_state = "[icon_state]_off"
		icon_state_worn = "[icon_state_worn]_off"

/obj/item/clothing/glasses/nightvision/click_self(var/mob/caller)

	var/obj/hud/inventory/I = src.loc
	if(istype(I))
		INTERACT_CHECK
		INTERACT_DELAY(1)
		if(!active)
			var/obj/item/powercell/PC = get_battery()
			if(!PC)
				caller.to_chat(span("notice","\The [src.name] doesn't have a power cell installed!"))
				return TRUE
			if(PC.charge_current <= 0)
				caller.to_chat(span("notice","\The [src.name] doesn't have enough power!"))
				return TRUE
			PC.charge_current = max(0,PC.charge_current - 10) //Spamming removes power.
		active = !active
		if(active)
			enable(I)
			START_THINKING(src)
		else
			disable(I)
		caller.to_chat(span("notice","You toggle \the [src.name] [active ? "on" : "off"]."))
		update_sprite()
		if(I.worn && is_advanced(I.owner))
			var/mob/living/advanced/A = I.owner
			A.remove_overlay("\ref[src]")
			I.update_worn_icon(src)
		return TRUE

	. = ..()


/obj/item/clothing/glasses/nightvision/proc/enable(var/obj/hud/inventory/I)
	var/list/desired_color = list(
		1,1,0,0,
		0,1,0,0,
		0,1,1,0,
		0,0,0,1,
		0,0,0,0
	)
	if(I && I.worn)
		I.owner?.add_color_mod("\ref[src]",desired_color)
		I.owner?.add_lighting_mod("\ref[src]",100)
	return TRUE


/obj/item/clothing/glasses/nightvision/proc/disable(var/obj/hud/inventory/I)
	I?.owner?.remove_color_mod("\ref[src]")
	I?.owner?.remove_lighting_mod("\ref[src]")
	return TRUE

/obj/item/clothing/glasses/nightvision/post_move(var/atom/old_loc)

	. = ..()

	if(active)
		if(is_inventory(old_loc))
			disable(old_loc)

		if(is_inventory(loc))
			var/obj/hud/inventory/I = loc
			if(I.item_slot & SLOT_FACE)
				enable(I)

