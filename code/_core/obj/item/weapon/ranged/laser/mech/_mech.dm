/obj/item/weapon/ranged/laser/mech
	name = "mech gun"
	icon = 'icons/obj/vehicles/mech_equipment.dmi'

	projectile = /obj/projectile/bullet/laser
	damage_type = "chronogun"
	projectile_speed = 8
	shoot_delay = 20
	automatic = FALSE
	bullet_color = "#0000FF"

	charge_max = 100000
	charge_current = 100000
	charge_cost = 1000

	view_punch = 0

	shoot_sounds = list('sounds/weapons/laser_rifle/shoot.ogg')

	mech_only = TRUE

/obj/item/weapon/ranged/laser/mech/can_gun_shoot(var/mob/caller)

	if(!istype(caller,/mob/living/vehicle/))
		return FALSE

	return ..()

/obj/item/weapon/ranged/laser/mech/smg/mk1
	name = "mk1 machine gun"
	icon_state = "bullet_mk1"
	bullet_color = "#FFFFFF"

	automatic = TRUE

	shoot_delay = 3

	charge_max = 250*60
	charge_current = 250*60
	charge_cost = 250

	projectile = /obj/projectile/bullet/pistol
	damage_type = "9mm"

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	shoot_sounds = list('sounds/weapons/pistol/shoot.ogg')

/obj/item/weapon/ranged/laser/mech/smg/mk2
	name = "mk2 machine gun"
	icon_state = "bullet_mk2"
	bullet_color = "#FFFFFF"

	automatic = TRUE

	shoot_delay = 4

	charge_max = 500*30
	charge_current = 500*30
	charge_cost = 500

	projectile = /obj/projectile/bullet/rifle
	damage_type = ".223"

	projectile_speed = BULLET_SPEED_RIFLE_LIGHT

	shoot_sounds = list('sounds/weapons/pistol_medium/shoot.ogg')

/obj/item/weapon/ranged/laser/mech/smg/mk3
	name = "mk3 machine gun"
	icon_state = "bullet_mk3"
	bullet_color = "#FFFFFF"

	automatic = TRUE

	shoot_delay = 5

	charge_max = 1000*20
	charge_current = 1000*20
	charge_cost = 1000

	projectile = /obj/projectile/bullet/rifle
	damage_type = "7.62"

	projectile_speed = BULLET_SPEED_RIFLE_HEAVY

	shoot_sounds = list('sounds/weapons/assault_rifle/assault_rifle.ogg')