/obj/item/weapon/ranged/energy/iongun
	name = "AM-ION Cannon"
	desc = "The solution to all those mechanized units."
	desc_extended = "A powerful energy weapon that shoots strong ionized bursts of electricity. Excellent for destroying mechs."
	icon = 'icons/obj/item/weapons/ranged/laser/ion.dmi'
	rarity = RARITY_RARE

	projectile = /obj/projectile/bullet/laser/ion
	ranged_damage_type = /damagetype/ranged/laser/ion

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 4

	automatic = FALSE

	bullet_color = "#00FFFF"

	charge_cost = CELL_SIZE_BASIC / 30

	view_punch = 15

	shoot_sounds = list('sound/weapons/ion/shoot.ogg')

	override_icon_state = TRUE

	heat_per_shot = 0.015
	heat_max = 0.03

	size = SIZE_4
	weight = 18

	value = 2000

	dan_mode = TRUE

	can_wield = TRUE

/obj/item/weapon/ranged/energy/iongun/get_static_spread()
	if(wielded) return 0
	return 0.001

/obj/item/weapon/ranged/energy/iongun/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/iongun/update_icon()

	var/obj/item/powercell/PC = get_battery()

	if(!istype(PC) || charge_cost > PC.charge_current)
		icon_state = "inventory_0"
	else
		icon_state = "inventory_[FLOOR((PC.charge_current/PC.charge_max) * 4, 1)]"

	return ..()
