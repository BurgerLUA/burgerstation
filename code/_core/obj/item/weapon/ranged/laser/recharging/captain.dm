/obj/item/weapon/ranged/laser/recharging/captain
	name = "captain's laser pistol"
	icon = 'icons/obj/items/weapons/ranged/laser/captain.dmi'

	projectile = /obj/projectile/bullet/laser
	damage_type = "laser_carbine_kill"

	projectile_speed = 31
	shoot_delay = 5

	automatic = FALSE

	shoot_sounds = list('sounds/weapons/laser_carbine/kill.ogg')

	charge_max = 8000
	charge_current = 8000
	charge_cost = 1000

	override_icon_state = TRUE

	view_punch = 4

/obj/item/weapon/ranged/laser/recharging/captain/update_icon()

	icon_state = initial(icon_state)
	icon = initial(icon)

	var/icon/I = new/icon(icon,icon_state)
	var/icon/I2 = new/icon(icon,"charge[floor((charge_current/charge_max)*4)]")

	I.Blend(I2,ICON_OVERLAY)

	icon = I

	return ..()
