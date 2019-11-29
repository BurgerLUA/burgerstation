/obj/item/weapon/ranged/laser/rifle
	name = "laser rifle"
	icon = 'icons/obj/items/weapons/ranged/modular_laser.dmi'

	projectile = /obj/projectile/bullet/laser
	damage_type = "laser_rifle"

	bullet_speed = 31
	shoot_delay = 4

	automatic = FALSE

	bullet_color = "#FF0000"

	override_icon_state = TRUE
	override_icon_state_held = FALSE //TODO: FIX THIS

	charge_max = 70000
	charge_current = 70000
	charge_cost = 1000

	view_punch = 6

/obj/item/weapon/ranged/laser/rifle/New(var/desired_loc)
	. = ..()
	update_icon()
	return .

/obj/item/weapon/ranged/laser/rifle/update_icon()

	var/ammo_string = "ammo[floor( (charge_current/charge_max)*7 )]"

	var/icon/I = new/icon(initial(icon),initial(icon_state))
	var/icon/I2 = new/icon(initial(icon),ammo_string)
	var/icon/I3 = new/icon(initial(icon),"barrel")

	I2.Blend(bullet_color,ICON_MULTIPLY)
	I3.Blend(bullet_color,ICON_MULTIPLY)

	I.Blend(I2,ICON_OVERLAY)
	I.Blend(I3,ICON_OVERLAY)

	icon = I

	return ..()

/obj/item/weapon/ranged/laser/rifle/hardlight
	name = "hardlight laser rifle"
	bullet_color = "#FFFF00"
	damage_type = "laser_rifle_hardlight"

	bullet_speed = 26
	shoot_delay = 8

	charge_cost = 2000

	view_punch = 8

/obj/item/weapon/ranged/laser/rifle/xray
	name = "xray laser rifle"
	bullet_color = "#00FF00"
	damage_type = "laser_rifle_xray"

	bullet_speed = 20
	shoot_delay = 6

	charge_cost = 2000

	view_punch = 8