/obj/item/weapon/ranged/energy/freezegun
	name = "freeze ray"
	desc = "Get iced, dummy."
	desc_extended = "A gun that shoots beams that freeze the opponent."
	icon = 'icons/obj/item/weapons/ranged/laser/freezegun.dmi'

	projectile = /obj/projectile/bullet/laser/strong
	ranged_damage_type = /damagetype/ranged/laser/freezegun

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 3

	automatic = FALSE

	bullet_color = "#00FFFF"

	charge_cost = CELL_SIZE_BASIC / 30

	view_punch = 8

	shoot_sounds = list('sound/weapons/chronogun/fire.ogg')

	override_icon_state = TRUE

	heat_per_shot = 0.015
	heat_max = 0.04

	size = SIZE_4
	weight = 15

	value = 1500

/obj/item/weapon/ranged/energy/freezegun/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/energy/freezegun/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/freezegun/update_icon()

	var/obj/item/powercell/PC = get_battery()

	if(!istype(PC) || charge_cost > PC.charge_current)
		icon_state = "inventory_0"
	else
		icon_state = "inventory_[FLOOR((PC.charge_current/PC.charge_max) * 4, 1)]"

	return ..()