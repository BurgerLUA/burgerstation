/obj/item/weapon/ranged/laser/freezegun
	name = "freeze ray"
	icon = 'icons/obj/items/weapons/ranged/freezegun.dmi'

	projectile = /obj/projectile/bullet/laser
	damage_type = "freezegun"

	projectile_speed = 8
	shoot_delay = 7

	automatic = FALSE

	bullet_color = "#00FFFF"

	charge_max = 20000
	charge_current = 20000
	charge_cost = 2000

	view_punch = 15

	shoot_sounds = list('sounds/weapons/chronogun/fire.ogg')

	override_icon_state = TRUE

/obj/item/weapon/ranged/laser/freezegun/update_icon()

	icon_state = "inventory_[floor((charge_current/charge_max)*4)]"

	return ..()