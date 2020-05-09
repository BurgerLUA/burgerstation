/obj/item/weapon/ranged/energy/rifle
	name = "laser rifle"
	icon = 'icons/obj/items/weapons/ranged/modular_laser.dmi'

	projectile = /obj/projectile/bullet/laser
	damage_type = /damagetype/ranged/laser/rifle

	projectile_speed = 31
	shoot_delay = 3

	automatic = TRUE

	override_icon_state = TRUE
	override_icon_state_held = FALSE //TODO: FIX THIS

	charge_max = CELL_SIZE_ADVANCED
	charge_current = CELL_SIZE_ADVANCED
	charge_cost = CELL_SIZE_ADVANCED / 40

	view_punch = 6

	shoot_sounds = list('sounds/weapons/laser_rifle/shoot.ogg')

	heat_per_shot = 0.04
	heat_max = 0.2

	polymorphs = list(
		"base" = COLOR_WHITE,
		"barrel" = "#FF0000"
	)

/obj/item/weapon/ranged/energy/rifle/Initialize()
	bullet_color = polymorphs["barrel"]
	return ..()

/obj/item/weapon/ranged/energy/rifle/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/energy/rifle/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.02 - (0.3 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/rifle/New(var/desired_loc)
	. = ..()
	update_sprite()
	return .

/obj/item/weapon/ranged/energy/rifle/update_overlays()
	var/image/I = new/image(initial(icon),"ammo[FLOOR((charge_current/charge_max) * 7, 1)]")
	I.color = polymorphs["barrel"]
	overlays += I
	return ..()

/obj/item/weapon/ranged/energy/rifle/hardlight
	name = "hardlight laser rifle"
	damage_type = /damagetype/ranged/laser/rifle/hardlight

	projectile_speed = 26
	shoot_delay = 6

	charge_cost = 2000

	view_punch = 8

	polymorphs = list(
		"base" = COLOR_WHITE,
		"barrel" = "#FFFF00"
	)

/obj/item/weapon/ranged/energy/rifle/xray
	name = "xray laser rifle"
	damage_type = /damagetype/ranged/laser/rifle/xray

	projectile_speed = 20
	shoot_delay = 4

	charge_cost = 2000

	view_punch = 8

	polymorphs = list(
		"base" = COLOR_WHITE,
		"barrel" = "#00FF00"
	)
