/obj/item/weapon/ranged/bullet/magazine/rifle/pkm
	name = "\improper 7.62x54mmR PKA light machine gun"
	desc = "Killa's weapon of choice."
	desc_extended = "Not to be confused with the personal kinetic accelerator, the PKA light machine gun is a lightweight beast of a gun designed to lay down suppressive fire on a target, or rather, the general direction of a target."
	icon = 'icons/obj/item/weapons/ranged/rifle/rev/762_lmg.dmi'
	icon_state = "inventory"
	value = 4000

	company_type = "Slavic"

	tier_type = "heavy weapon"

	tier = 3

	shoot_delay = 1.6

	automatic = TRUE

	damage_mod = 1

	firemodes = list("automatic","semi-automatic")

	shoot_sounds = list('sound/weapons/ranged/rifle/pkm/shoot.ogg')

	can_wield = TRUE


	size = SIZE_5
	weight = 20

	heat_max = 0.5

	bullet_length_min = 53
	bullet_length_best = 54
	bullet_length_max = 55

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.62

	ai_heat_sensitivity = 1.5

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = TRUE,
		/obj/item/attachment/stock_mod/reinforced_stock = TRUE,
		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 22 - 15
	attachment_undermount_offset_y = 18 - 16

	dan_mode = TRUE

	inaccuracy_modifier = 1
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.1

	override_icon_state = TRUE

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bullet/magazine/rifle/pkm/update_icon()

	icon_state = initial(icon_state)

	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		icon_state = "[icon_state]_[min(6,M.get_ammo_count())]"
	else
		icon_state = "[icon_state]_open"

	..()

/obj/item/weapon/ranged/bullet/magazine/rifle/pkm/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/rifle/pkm/get_skill_spread(var/mob/living/L)
	return max(0,0.1 - (0.11 * L.get_skill_power(SKILL_RANGED)))