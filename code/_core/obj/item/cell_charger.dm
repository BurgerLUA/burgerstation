/obj/item/cell_charger
	name = "device charger"
	desc = "Wow, technology!"
	desc_extended = "A powerful device charger that recharges any battery powered object that it sits on, as long as there is a battery inside. Just lay the device on the floor, and put a device on it. Batteries not included."
	layer = LAYER_OBJ_ITEM - 1
	icon = 'icons/obj/item/cell_charger.dmi'
	value = 300

	var/obj/item/powercell/battery
	var/obj/item/charging_device


	var/sprite_update_delay = 20 //Decisecond interval used in sprite updating.

	density = TRUE

	weight = 6

/obj/item/cell_charger/get_battery()
	return battery

/obj/item/cell_charger/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("battery")
	return .

/obj/item/cell_charger/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("battery")
	return .

/obj/item/cell_charger/Finalize()
	update_sprite()
	return ..()

/obj/item/cell_charger/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	if(battery && is_inventory(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		var/obj/hud/inventory/I = object
		if(I.add_object(battery))
			caller.to_chat(span("warning","You remove \the [battery.name] from \the [src.name]."))
			battery.update_sprite()
			battery = null
		else
			caller.to_chat(span("warning","You can't seem to remove \the [battery.name] from \the [src.name]!"))
		update_sprite()
		return TRUE

	if(istype(object,/obj/item/powercell))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
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

/obj/item/cell_charger/update_icon()
	. = ..()
	if(battery || istype(loc,/obj/structure/interactive/shop/))
		icon_state = "inventory"
	else
		icon_state = "inventory_open"
	return .

/obj/item/cell_charger/proc/check_device_move()

	if(charging_device.loc != src.loc)
		visible_message(span("warning","\The [src.name] beeps as \the [charging_device.name] is disconnected."))
		charging_device.update_sprite()
		HOOK_REMOVE("post_move","cell_charger_post_move_\ref[src]",charging_device)
		charging_device = null
		stop_thinking(src)
		sprite_update_delay = initial(sprite_update_delay)
		return FALSE

	return TRUE

/obj/item/cell_charger/Crossed(atom/movable/O)

	. = ..()

	if(!charging_device && is_item(O) && isturf(src.loc))
		var/obj/item/I = O
		var/obj/item/powercell/B = I.get_battery()
		if(istype(B))
			charging_device = I
			HOOK_ADD("post_move","cell_charger_post_move_\ref[src]",I,src,.proc/check_device_move)
			visible_message(span("notice","\The [src.name] dings as \the [I.name] is placed on top of it."))
			start_thinking(src)

	return .

/obj/item/cell_charger/think()

	. = ..()

	var/obj/item/powercell/B = src.get_battery()
	if(istype(B))
		var/obj/item/powercell/B2 = charging_device.get_battery()
		if(!istype(B2))
			visible_message(span("notice","\The [src.name] gives a high double beep."))
			return FALSE
		if(B.charge_current > 0)
			var/charge_to_add = min(100,B.charge_current,B2.charge_max - B2.charge_current)
			B2.charge_current += charge_to_add
			B.charge_current -= charge_to_add
			sprite_update_delay--
			if(sprite_update_delay <= 0)
				charging_device.update_sprite()
				sprite_update_delay = initial(sprite_update_delay)
		else
			visible_message(span("warning","\The [src.name] gives a low beep."))
			return FALSE
	else
		visible_message(span("warning","\The [src.name] gives a low double beep."))
		return FALSE

	if(!charging_device)
		visible_message(span("notice","\The [src.name] emits a bright ding."))
		return FALSE

	return .

/obj/item/cell_charger/get_examine_list(var/mob/caller)

	. = ..()

	if(battery)
		. += div("notice","Charge Remaining: [battery.charge_current]")

	return .
