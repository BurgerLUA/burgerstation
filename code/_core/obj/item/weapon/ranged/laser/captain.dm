/obj/item/weapon/ranged/energy/captain
	name = "\improper Captain's laser pistol"
	desc = "All craftsmanship is of the highest quality."
	desc_extended = "A fancier version of the laser rifle that self-charges. It has become innacurate due to its age."
	icon = 'icons/obj/item/weapons/ranged/laser/captain.dmi'
	rarity = RARITY_MYTHICAL
	value = 4000

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/carbine

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 2

	automatic = FALSE

	shoot_sounds = list('sound/weapons/laser_carbine/kill.ogg')

	charge_cost = CELL_SIZE_BASIC / 80

	override_icon_state = TRUE

	heat_max = 0.05

	size = SIZE_3
	weight = 10

	battery = /obj/item/powercell/recharging

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.5
	movement_spread_base = 0.02

/obj/item/weapon/ranged/energy/captain/update_overlays()
	. = ..()
	var/obj/item/powercell/PC = get_battery()
	if(!istype(PC))
		var/image/I = new/icon(initial(icon),"charge0")
		add_overlay(I)
	else
		var/image/I = new/icon(initial(icon),"charge[FLOOR((PC.charge_current/PC.charge_max) * 4, 1)]")
		add_overlay(I)


/obj/item/weapon/ranged/energy/captain/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/captain/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/captain/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

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
