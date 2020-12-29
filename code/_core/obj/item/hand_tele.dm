/obj/item/hand_teleporter
	name = "hand teleporter"
	desc = "What could possibly go wrong?"
	desc_extended = "A magical hand teleporter used by people trying to break the fucking game."

	rarity = RARITY_MYTHICAL
	value = 3000

	var/obj/item/powercell/battery = /obj/item/powercell/

	icon = 'icons/obj/item/hand_tele.dmi'
	icon_state = "inventory"

	var/teleport_cost = CELL_SIZE_BASIC

	weight = 2

/obj/item/hand_teleporter/Generate()

	if(ispath(battery))
		battery = new battery(src)
		INITIALIZE(battery)
		GENERATE(battery)
		FINALIZE(battery)

	return ..()

/obj/item/hand_teleporter/Finalize()

	. = ..()

	if(!istype(battery))
		battery = null

	update_sprite()

	return .


/obj/item/hand_teleporter/update_icon()

	icon_state = initial(icon_state)

	if(!battery)
		icon_state = "[icon_state]_open"
	else
		var/obj/item/powercell/battery = get_battery()
		if(battery.charge_current < teleport_cost)
			icon_state = "[icon_state]_no_charge"

/obj/item/hand_teleporter/get_battery()
	return battery

/obj/item/hand_teleporter/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("battery")
	return .

/obj/item/hand_teleporter/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("battery")
	return .

/obj/item/hand_teleporter/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	object = object.defer_click_on_object(location,control,params)

	if(battery && is_inventory(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/hud/inventory/I = object
		if(I.add_held_object(battery))
			caller.to_chat(span("notice","You remove \the [battery.name] from \the [src.name]."))
			battery.update_sprite()
			battery = null
		else
			caller.to_chat(span("warning","You can't seem to remove \the [battery.name] from \the [src.name]!"))
		update_sprite()
		return TRUE

	if(istype(object,/obj/item/powercell))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/item/PC = object
		if(PC.size > SIZE_3) //Only fits size 3.
			caller.to_chat(span("warning","\The [PC.name] is too large to be put into \the [src.name]!"))
			return TRUE
		if(battery)
			caller.to_chat(span("notice","You replace \the [battery.name] in \the [src.name] with \the [object.name] in your hand."))
			battery.update_sprite()
			battery.drop_item(get_turf(caller))
		else
			caller.to_chat(span("notice","You add \the [PC.name] to \the [src.name]."))
		PC.drop_item(src)
		battery = PC
		update_sprite()
		return TRUE

	return ..()

/obj/item/hand_teleporter/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src is used on the object

	INTERACT_CHECK
	INTERACT_DELAY(10)

	var/obj/item/powercell/PC = get_battery()

	if(ispath(PC))
		caller.to_chat(span("danger","Warning: This item is bugged. Tell burger how you obtained this item."))
		return FALSE

	if(!PC || PC.charge_current < teleport_cost)
		caller.to_chat(span("warning","\The [src.name] beeps, indicating a lack of charge!"))
		return FALSE

	var/turf/simulated/T = get_turf(object)

	if(!istype(T))
		caller.to_chat(span("danger","It's not safe to teleport here!"))
		return TRUE

	if(!T.is_safe_teleport())
		caller.to_chat(span("danger","It's not safe to teleport here!"))
		return FALSE

	var/area/A = T.loc

	if(A && A.flags_area & FLAGS_AREA_NO_TELEPORT)
		caller.to_chat(span("danger","It's not safe to teleport here!"))
		return FALSE

	caller.force_move(T)
	PC.charge_current -= teleport_cost

	update_sprite()

	return TRUE

/obj/item/hand_teleporter/get_examine_list(var/mob/caller)
	return ..() + div("notice","Teleports Remaining: [FLOOR(battery.charge_current/30000,1)]")
