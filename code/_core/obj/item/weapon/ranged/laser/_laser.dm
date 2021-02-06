/obj/item/weapon/ranged/energy
	var/charge_cost = 100

	bullet_color = "#FF0000"

	var/mech_only = FALSE

	var/obj/item/powercell/battery = /obj/item/powercell/

/obj/item/weapon/ranged/energy/get_value()

	. = ..()

	if(battery) . += battery.get_value()

	return .


/obj/item/weapon/ranged/energy/save_item_data(var/save_inventory = TRUE)
	. = ..()
	SAVEATOM("battery")
	return .

/obj/item/weapon/ranged/energy/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADATOM("battery")
	return .

/obj/item/weapon/ranged/energy/Finalize()

	. = ..()

	if(!istype(battery))
		battery = null

	return .


/obj/item/weapon/ranged/energy/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	if(istype(object,/obj/item/))

		var/obj/item/I = object

		if(I.flags_tool & FLAG_TOOL_CROWBAR)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(battery)
				battery.drop_item(get_turf(src))
				battery.update_sprite()
				caller.to_chat(span("notice","You pry out \the [battery.name]."))
				battery = null
				update_sprite()
			else
				caller.to_chat(span("warning","There is nothing to pry out of \the [src.name]!"))
			return TRUE

		if(istype(I,/obj/item/powercell/))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(battery)
				caller.to_chat(span("warning","There is already a battery installed in \the [src.name]!"))
				return TRUE
			var/obj/item/powercell/P = I
			if(P.size > SIZE_2) //Only fits size 2.
				caller.to_chat(span("warning","\The [P.name] is too large to be put into \the [src.name]!"))
				return TRUE
			if(battery)
				caller.to_chat(span("notice","You swap out \the [battery.name] for \the [P.name] in \the [src.name]."))
				battery.drop_item(get_turf(caller))
				battery.update_sprite()
				battery = null
			else
				caller.to_chat(span("notice","You insert \the [P.name] into \the [src.name]."))

			battery = P
			P.drop_item(src)

			update_sprite()

			return TRUE

	return ..()

/obj/item/weapon/ranged/energy/Generate()

	if(ispath(battery))
		battery = new battery(src)
		INITIALIZE(battery)
		GENERATE(battery)
		FINALIZE(battery)
		update_sprite()

	return ..()

/obj/item/weapon/ranged/energy/get_battery()
	return battery

/obj/item/weapon/ranged/energy/New(var/desired_loc)
	charge_cost = FLOOR(charge_cost, 1)
	return ..()

/obj/item/weapon/ranged/energy/get_ammo_count()
	var/obj/item/powercell/PC = get_battery()
	if(!istype(PC))
		return 0
	return FLOOR(battery.charge_current/charge_cost, 1)

/obj/item/weapon/ranged/energy/handle_ammo(var/mob/caller,var/bullet_position=1)
	var/obj/item/powercell/PC = get_battery()
	if(istype(PC))
		PC.charge_current -= charge_cost
	return null

/obj/item/weapon/ranged/energy/can_gun_shoot(var/mob/caller)

	if(!..())
		return FALSE

	var/obj/item/powercell/PC = get_battery()

	if(!istype(PC))
		caller.to_chat(span("warning","\The [src.name] doesn't have a battery installed!"))
		return FALSE

	if(PC.charge_current - charge_cost < 0)
		handle_empty(caller)
		return FALSE

	return TRUE

/obj/item/weapon/ranged/energy/get_examine_list(var/mob/caller)
	return ..() + div("notice","[get_ammo_count()] shot\s remaining at the current charge level.")
