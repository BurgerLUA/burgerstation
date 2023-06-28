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

	var/obj/item/powercell/stored_cell = /obj/item/powercell/tiny

	rarity = RARITY_RARE

	var/active = FALSE

	var/nightvision_power = 100 //Alpha to remove.

/obj/item/clothing/glasses/nightvision/get_base_value()
	. = ..()
	// https://www.desmos.com/calculator/hjwomvwuwm
	. += 250 + ((nightvision_power**1.5)/255)*2500*0.062

/obj/item/clothing/glasses/nightvision/PreDestroy()
	CALLBACK_REMOVE("\ref[src]_drain_power")
	QDEL_NULL(stored_cell)
	. = ..()

/obj/item/clothing/glasses/nightvision/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEATOM("stored_cell")

/obj/item/clothing/glasses/nightvision/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADATOM("stored_cell")

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

/obj/item/clothing/glasses/nightvision/update_icon()
	. = ..()
	icon = initial(icon)
	icon_state = initial(icon_state)
	icon_state_worn = initial(icon_state_worn)
	if(!active)
		icon_state = "[icon_state]_off"
		icon_state_worn = "[icon_state_worn]_off"

/obj/item/clothing/glasses/nightvision/proc/drain_power(var/mob/caller)

	if(!active)
		return FALSE

	var/obj/item/powercell/PC = get_battery()
	if(!PC)
		set_active(caller,FALSE)
		return FALSE

	var/drain_amount = CELL_SIZE_TINY * (1/(60*30)) //~30 minutes of nightvision
	drain_amount = CEILING(drain_amount,1)

	PC.charge_current = max(0,PC.charge_current - 3)

	if(PC.charge_current <= 0)
		set_active(caller,FALSE)
		return FALSE

	CALLBACK("\ref[src]_drain_power",SECONDS_TO_DECISECONDS(1),src,src::drain_power(),caller)

	return TRUE

/obj/item/clothing/glasses/nightvision/proc/set_active(var/mob/caller,var/desired_active=TRUE)

	if(active == desired_active)
		return FALSE

	if(!active)
		var/obj/item/powercell/PC = get_battery()
		if(!PC)
			caller?.to_chat(span("notice","\The [src.name] doesn't have a power cell installed!"))
			return TRUE
		PC.charge_current = max(0,PC.charge_current - 10) //Spamming removes power.
		if(PC.charge_current <= 0)
			caller?.to_chat(span("notice","\The [src.name] doesn't have enough power!"))
			return TRUE

	active = !active

	var/obj/hud/inventory/I = src.loc
	if(is_inventory(I))
		if(I.worn && I.item_slot & SLOT_FACE && is_living(I.owner))
			var/mob/living/L = I.owner
			if(active)
				L.add_mob_value("\ref[src]","nightvision",nightvision_power,ADDITION)
			else
				L.remove_mob_value("\ref[src]","nightvision",ADDITION)
			L.handle_lighting_alpha()
		update_sprite()
		if(I.worn)
			I.update_worn_icon(src)

	if(active && !drain_power(caller))
		return FALSE

	caller?.to_chat(span("notice","\The [src.name] flickers [active ? "on" : "off"]."))

	return TRUE


/obj/item/clothing/glasses/nightvision/click_self(var/mob/caller,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	set_active(caller,!active)

	return TRUE


/obj/item/clothing/glasses/nightvision/on_equip(var/atom/old_location,var/silent=FALSE)
	. = ..()
	var/obj/hud/inventory/I = loc
	if(I.worn && I.item_slot & SLOT_FACE && is_living(I.owner))
		var/mob/living/L = I.owner
		if(active)
			L.add_mob_value("\ref[src]","nightvision",nightvision_power,ADDITION)
			L.handle_lighting_alpha()
		else if(L.ai)
			set_active(L,TRUE)

/obj/item/clothing/glasses/nightvision/on_unequip(var/obj/hud/inventory/old_inventory,var/silent=FALSE) //When the object is dropped from the old_inventory
	. = ..()
	if(active && old_inventory.worn && old_inventory.item_slot & SLOT_FACE && is_living(old_inventory.owner))
		var/mob/living/L = old_inventory.owner
		L.remove_mob_value("\ref[src]","nightvision",ADDITION)
		L.handle_lighting_alpha()




/obj/item/clothing/glasses/nightvision/syndicate
	name = "syndicate nightvision goggles"
	desc_extended = "A pair of tactical nightvision goggles. Keep away from light. Better than most nightvision goggles on the market."

	icon = 'icons/obj/item/clothing/glasses/nightvision_syndicate.dmi'

	nightvision_power = 200

	rarity = RARITY_MYTHICAL