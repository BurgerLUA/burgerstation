/obj/item/weapon/ranged/energy/pump
	charge_cost = 100
	battery = /obj/item/powercell/dummy

	var/charge_per_pump = 100
	var/pump_sound = 'sound/weapons/ranged/generic/shotgun_pump.ogg'
	var/action_name = "pump"

	var/pump_delay = 1


/obj/item/weapon/ranged/energy/pump/get_charge_cost()
	return initial(charge_cost)

/obj/item/weapon/ranged/energy/pump/click_self(var/mob/caller,location,control,params)

	if(next_shoot_time > world.time + 1)
		return TRUE

	INTERACT_CHECK
	INTERACT_DELAY(1)

	pump()

	next_shoot_time = max(next_shoot_time,world.time + pump_delay)

	return TRUE

/obj/item/weapon/ranged/energy/pump/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_CROWBAR)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(battery)
				caller.to_chat(span("warning","You are unable to pry out \the [battery.name]."))
			else
				caller.to_chat(span("warning","There is nothing to pry out of \the [src.name]!"))
			return TRUE

	. = ..()

/obj/item/weapon/ranged/energy/pump/proc/pump(var/mob/caller,var/silent=FALSE)

	var/turf/T = get_turf(src)

	caller?.to_chat(span("notice","You [action_name] \the [src]."))

	if(istype(battery))
		battery.charge_current = min(battery.charge_max,battery.charge_current+charge_per_pump)

	if(!silent && pump_sound)
		play_sound(pump_sound,T,range_max=VIEW_RANGE)
	update_sprite()

	return TRUE