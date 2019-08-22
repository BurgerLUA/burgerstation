/obj/item/weapon/ranged/laser/recharging/captain
	name = "captain's laser pistol"
	icon = 'icons/obj/items/weapons/ranged/captain_laser.dmi'

	projectile = /obj/projectile/bullet/laser
	damage_type = "laser_pistol"

	bullet_speed = 31
	shoot_delay = 2

	automatic = FALSE

	shoot_sounds = list('sounds/weapons/laser_carbine/kill.ogg')


/obj/item/weapon/ranged/laser/recharging/captain/update_icon()


	icon_state = initial(icon_state)
	icon = initial(icon)


	var/icon/I = new/icon(icon,icon_state)




	var/icon/I2







	return ..()
