/obj/item/attachment/barrel
	name = "barrel attachment"

/obj/item/attachment/barrel/charger
	name = "magnetic barrel charger"
	desc = "SUPERCHARGE."
	desc_extended = "A supermagnetic barrel charger that uses the power of MAGNETS to launch bullets faster than what could normally occur with gunpowder. Increases damage at the cost of reduced accuracy, increased recoil, and decreased firerate for safety reasons."
	icon_state = "barrel_charger"

	stats_attachment_mul = list(
		damage_multiplier = 1.25,
		projectile_speed = 1.25,
		bullet_spread = 1.25,
		heat_spread = 1.25,
		view_punch = 2,
		shoot_delay = 1.5,
		bullet_color = COLOR_ORANGE
	)

	value = 600

/obj/item/attachment/barrel/laser_charger
	name = "modular laser charger"
	desc = "SUPERCHARGE."
	desc_extended = "Supercharges a laser weapon's damage by increasing the amount of capacitors used with no extra energy cost. Increases damage at the cost of greater recoil and a much higher delay."
	icon_state = "laser_charger"

	stats_attachment_mul = list(
		damage_multiplier = 1.25,
		projectile_speed = 1.25,
		bullet_spread = 1.25,
		heat_spread = 1.25,
		view_punch = 2,
		shoot_delay = 1.5,
	)

	value = 800

/obj/item/attachment/barrel/suppressor
	name = "suppressor"
	desc = "Shhh."
	desc_extended = "A special noise-damping tube designed to trap gas and slow the speed of the bullet to sub-sonic levels to prevent the sonic crack from bullets and noise from releasing gas. Makes shooting quieter at the cost of reduced accuracy and damage."
	icon_state = "suppressor"

	stats_attachment_mul = list(
		damage_multiplier = 0.5,
		projectile_speed = 0.75,
		bullet_spread = 0.9,
		heat_spread = 1.1,
		view_punch = 0.9
	)

	stats_attachment_set = list(
		shoot_alert = ALERT_LEVEL_NONE,
		shoot_sounds = list('sound/weapons/10/shoot_mod.ogg')
	)

	//attachment_shoot_alert = ALERT_LEVEL_NONE
	//attachment_shoot_sound = 'sound/weapons/10/shoot_mod.ogg'

	value = 150

/obj/item/attachment/barrel/extended
	name = "extended barrel"
	desc = "Extendong."
	desc_extended = "A silly barrel attachment that increases the barrel length of a gun. Better for accuracy, but poor for damage and recoil."
	icon_state = "extended_barrel"

	stats_attachment_mul = list(
		projectile_speed = 1.1,
		view_punch = 1.5,
		bullet_spread = 0.75,
		movement_spread = 1.5,
		inaccuracy_modifer = 0.5,
		static_spread = 0.9,
		skill_spread = 1.25,
		heat_spread = 1.1
	)

	value = 100

/obj/item/attachment/barrel/compensator
	name = "recoil compensator"
	desc = "Compensating for something."
	desc_extended = "A special muzzle attachment that redirects gas upwards and sideways to reduce the vertical and horizontal recoil of the weapon."
	icon_state = "recoil_compensator"

	stats_attachment_mul = list(
		projectile_speed = 0.9,
		skill_spread = 0.9,
		heat_spread = 0.9,
		movement_spread = 1.25,
		view_punch = 0.5
	)

	value = 300


/obj/item/attachment/barrel/gyro
	name = "gyroscope attachment"
	desc = "Compensating for something."
	desc_extended = "A special muzzle attachment that redirects gas upwards and sideways to reduce the vertical and horizontal recoil of the weapon."
	icon_state = "gyro"

	stats_attachment_mul = list(
		movement_spread = 0.25,
		static_spread = 0.9,
		heat_spread = 1.25,
		view_punch = 0.5
	)

	value = 300