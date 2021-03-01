/obj/item/weapon/ranged/energy/captain
	name = "\improper Captain's laser pistol"
	desc = "All craftsmanship is of the highest quality."
	desc_extended = "A fancier version of the laser rifle that self-charges. It has become innacurate due to its age."
	icon = 'icons/obj/item/weapons/ranged/laser/captain.dmi'
	rarity = RARITY_MYTHICAL

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/carbine

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 2

	automatic = FALSE

	shoot_sounds = list('sound/weapons/laser_carbine/kill.ogg')

	charge_cost = CELL_SIZE_BASIC / 80

	override_icon_state = TRUE

	view_punch = 4

	heat_per_shot = 0.01
	heat_max = 0.05

	size = SIZE_3
	weight = 10

	value = 2000

	battery = /obj/item/powercell/recharging

	inaccuracy_modifier = 0.75
	movement_spread_base = 0.02

/obj/item/weapon/ranged/energy/captain/update_overlays()
	. = ..()
	var/obj/item/powercell/PC = get_battery()
	if(!PC)
		var/image/I = new/icon(initial(icon),"charge0")
		add_overlay(I)
	else
		var/image/I = new/icon(initial(icon),"charge[FLOOR((PC.charge_current/PC.charge_max) * 4, 1)]")
		add_overlay(I)


/obj/item/weapon/ranged/energy/captain/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/captain/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)



	if(istype(object,/obj/item/))

		var/obj/item/I = object

		if(I.flags_tool & FLAG_TOOL_CROWBAR)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(battery)
				caller.to_chat(span("warning","You are unable to pry out \the [battery.name]."))
			else
				caller.to_chat(span("warning","There is nothing to pry out of \the [src.name]!"))
			return
