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

	heat_per_shot = 0
	heat_max = 0

	size = SIZE_3
	weight = 10

	value = 2000

	battery = /obj/item/powercell/recharging

/obj/item/weapon/ranged/energy/captain/update_overlays()
	. = ..()
	var/obj/item/powercell/PC = get_battery()
	if(!PC)
		var/image/I = new/icon(initial(icon),"charge0")
		add_overlay(I)
	else
		var/image/I = new/icon(initial(icon),"charge[FLOOR((PC.charge_current/PC.charge_max) * 4, 1)]")
		add_overlay(I)
	return .


/obj/item/weapon/ranged/energy/captain/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/captain/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))
