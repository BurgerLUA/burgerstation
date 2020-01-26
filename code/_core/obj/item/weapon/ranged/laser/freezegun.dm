/obj/item/weapon/ranged/laser/freezegun
	name = "freeze ray"
	icon = 'icons/obj/items/weapons/ranged/freezegun.dmi'

	projectile = /obj/projectile/bullet/laser
	damage_type = "freezegun"

	projectile_speed = 8
	shoot_delay = 7

	automatic = FALSE

	bullet_color = "#00FFFF"

	charge_max = CELL_SIZE_ADVANCED
	charge_current = CELL_SIZE_ADVANCED
	charge_cost = CELL_SIZE_ADVANCED / 30

	view_punch = 15

	shoot_sounds = list('sounds/weapons/chronogun/fire.ogg')

	override_icon_state = TRUE

/obj/item/weapon/ranged/laser/freezegun/update_icon()

	if(charge_cost < charge_current)
		icon_state = "inventory_0"
	else
		icon_state = "inventory_[floor((charge_current/charge_max)*4)]"

	return ..()