/obj/item/attachment/barrel
	name = "barrel attachment"

/obj/item/attachment/barrel/charger
	name = "magnetic barrel charger"
	desc = "SUPERCHARGE."
	desc_extended = "A supermagnetic barrel charger that uses the power of MAGNETS to launch bullets faster and stronger than what could normally occur with gunpowder. Increases damage and projectile speed, at the cost of reduced accuracy, increased recoil, and decreased firerate."
	icon_state = "barrel_charger"

	attachment_stats = list(
		damage_multiplier = 1.25,
		projectile_speed = 1.25,
		bullet_spread = 1.25,
		heat_spread = 1.25,
		view_punch = 2,
		shoot_delay = 1.5,
		bullet_color = COLOR_ORANGE
	)

	value = 600


/obj/item/attachment/barrel/charger/advanced
	name = "advanced barrel charger"
	desc = "SUPERCHARGE TO THE MAX."
	desc_extended = "A supermagnetic barrel charger that uses the power of MAGNETS to launch bullets faster and stronger than what could normally occur with gunpowder. Increases damage and projectile speed, at the cost of reduced accuracy, increased recoil, and decreased firerate."
	icon_state = "barrel_charger_advanced"

	attachment_stats = list(
		damage_multiplier = 1.5,
		projectile_speed = 1.5,
		bullet_spread = 1.25,
		heat_spread = 1.25,
		view_punch = 3,
		shoot_delay = 1.5,
		bullet_color = COLOR_CYAN
	)

	value = 600

/obj/item/attachment/barrel/laser_charger
	name = "modular laser charger"
	desc = "SUPERCHARGE."
	desc_extended = "Supercharges a laser weapon's damage by increasing the amount of capacitors used with no extra energy cost. Increases damage and projectile speed at the cost of greater recoil, higher spread, and a greater delay."
	icon_state = "laser_charger"

	attachment_stats = list(
		damage_multiplier = 1.25,
		projectile_speed = 1.25,
		heat_spread = 1.25,
		view_punch = 2,
		shoot_delay = 1.5,
	)

	value = 800

/obj/item/attachment/barrel/suppressor
	name = "suppressor"
	desc = "Shhh."
	desc_extended = "A special noise-damping tube designed to trap gas and slow the speed of the bullet to sub-sonic levels to prevent the sonic crack from bullets and noise from releasing gas. Makes shooting quieter at the cost of reduced damage and projectile speed."
	icon_state = "suppressor"

	attachment_stats = list(
		damage_multiplier = 0.75,
		projectile_speed = 0.75,
		view_punch = 0.75,
		shoot_alert = ALERT_LEVEL_NONE,
		shoot_sounds = list('sound/weapons/10/shoot_mod.ogg')
	)

	//attachment_shoot_alert = ALERT_LEVEL_NONE
	//attachment_shoot_sound = 'sound/weapons/10/shoot_mod.ogg'

	value = 150

/obj/item/attachment/barrel/extended
	name = "extended barrel"
	desc = "Extendong."
	desc_extended = "A silly barrel attachment that increases the barrel length of a gun. Increases projectile speed, bullet accuracy, precision, and weapon accuracy at the cost of higher recoil, movement spread, recoil spread, and spread from inexperience."
	icon_state = "extended_barrel"

	attachment_stats = list(
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
	desc_extended = "A special muzzle attachment that redirects gas upwards and sideways to reduce the vertical and horizontal recoil of the weapon. Makes the gun easier to handle and reduces recoil spread at the cost of a higher movement spread and reduced projectile speed."
	icon_state = "recoil_compensator"

	attachment_stats = list(
		projectile_speed = 0.9,
		skill_spread = 0.9,
		heat_spread = 0.9,
		movement_spread = 1.25,
		view_punch = 0.5
	)

	value = 300


/obj/item/attachment/barrel/gyro
	name = "gyroscope attachment"
	desc = "Normally found on old spaceships!"
	desc_extended = "A special angular gyroscope mounted on the barrel that significantly reduces movement spread, general weapon spread, and recoil at the cost of a higher recoil spread."
	icon_state = "gyro"

	attachment_stats = list(
		movement_spread = 0.25,
		static_spread = 0.9,
		heat_spread = 1.25,
		view_punch = 0.5
	)

	value = 300
	
/obj/item/attachment/barrel/laser_charger/advanced
	name = "experimental laser charger"
	desc = "HYPERCHARGE."
	desc_extended = "Supercharges a laser weapon's damage by increasing the amount of capacitors used with no extra energy cost. Increases damage and projectile speed at the cost of greater recoil, higher spread, and a greater delay. This seems to be a prototype designed to increase damage and projectile speed above the original design."
	icon_state = "laser_charger_advanced"

	attachment_stats = list(
		damage_multiplier = 1.5,
		projectile_speed = 1.5,
		heat_spread = 1.25,
		view_punch = 3,
		shoot_delay = 1.5,
	)

	value = 800
