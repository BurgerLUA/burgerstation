/obj/item/attachment
	name = "weapon attachment"
	desc = "Modular!"
	desc_extended = "Attach this to your weapon for EXTRA POWER."
	icon = 'icons/obj/item/attachments.dmi'

	//These are all multipliers
	var/attachment_accuracy_mod
	var/attachment_damage_mod
	var/attachment_recoil_mod
	var/attachment_delay_mod
	var/attachment_inaccuracy_mod

	var/attachment_burst_add
	var/attachment_shoot_alert //Should really only be used by barrels.
	var/attachment_shoot_sound

	var/attachment_force_automatic

	var/attachment_offset_x = 0
	var/attachment_offset_y = 0

	value = 200

/obj/item/attachment/barrel
	name = "barrel attachment"

/obj/item/attachment/barrel/charger
	name = "magnetic barrel charger"
	desc = "SUPERCHARGE."
	desc_extended = "A supermagnetic barrel charger that uses the power of MAGNETS to launch bullets faster than what could normally occur with gunpowder. Increases damage at the cost of reduced accuracy, increased recoil, and decreased firerate for safety reasons."
	icon_state = "barrel_charger"
	attachment_damage_mod = 1.25
	attachment_accuracy_mod = 1.25
	attachment_recoil_mod = 1.5
	attachment_delay_mod = 1.1
	value = 1000

/obj/item/attachment/barrel/laser_charger
	name = "modular laser charger"
	desc = "SUPERCHARGE."
	desc_extended = "Supercharges a laser weapon's damage by increasing the amount of capacitors used with no extra energy cost. Increases damage at the cost of greater recoil and a much higher delay."
	icon_state = "laser_charger"
	attachment_damage_mod = 1.5
	attachment_recoil_mod = 2
	attachment_delay_mod = 2
	value = 1200

/obj/item/attachment/barrel/suppressor
	name = "suppressor"
	desc = "Shhh."
	desc_extended = "A special noise-damping tube designed to trap gas and slow the speed of the bullet to sub-sonic levels to prevent the sonic crack from bullets and noise from releasing gas. Makes shooting quieter at the cost of reduced accuracy and damage."
	icon_state = "suppressor"
	attachment_damage_mod = 0.85
	attachment_accuracy_mod = 1.1
	attachment_recoil_mod = 0.9
	attachment_shoot_alert = ALERT_LEVEL_NONE
	attachment_shoot_sound = 'sound/weapons/10/shoot_mod.ogg'
	value = 150

/obj/item/attachment/barrel/extended
	name = "extended barrel"
	desc = "Extendong."
	desc_extended = "A silly barrel attachment that increases the barrel length of a gun. Better for accuracy, but poor for damage and recoil."
	icon_state = "extended_barrel"
	attachment_accuracy_mod = 0.9
	attachment_recoil_mod = 1.1
	attachment_damage_mod = 0.95
	value = 100

/obj/item/attachment/barrel/compensator
	name = "recoil compensator"
	desc = "Compensating for something."
	desc_extended = "A special muzzle attachment that redirects gas upwards and sideways to reduce the vertical and horizontal recoil of the weapon."
	icon_state = "recoil_compensator"
	attachment_recoil_mod = 0.5
	value = 300

/obj/item/attachment/sight
	name = "sight attachment"

/obj/item/attachment/sight/red_dot
	name = "red dot sight"
	desc = "What's wrong with ironsights?"
	desc_extended = "A red dot sight finely adjusted to increase accuracy by giving a clear sightline to the target, decreasing base spread."
	icon_state = "red_dot_sight"
	attachment_accuracy_mod = 0.75
	value = 200

/obj/item/attachment/sight/laser_sight
	name = "laser sight"
	desc = "Laser beams!"
	desc_extended = "A high power laser sight used for increasing the precision of the gun. Does what it says; increases precision and accuracy."
	icon_state = "laser_sight"
	attachment_inaccuracy_mod = 0.75
	attachment_accuracy_mod = 0.85
	value = 300

/obj/item/attachment/sight/quickfire_adapter
	name = "quickfire adapter"
	desc = "Pew faster."
	desc_extended = "A complex weapon attachment that increases the fire rate of the gun at the cost of accuracy."
	icon_state = "quickfire_adapter"
	attachment_accuracy_mod = 1.1
	attachment_delay_mod = 0.75
	value = 800

/obj/item/attachment/undermount
	name = "undermount attachment"

/obj/item/attachment/undermount/vertical_grip
	name = "vertical grip"
	desc = "Firmly grasp it."
	desc_extended = "A simple underbarrel vertical grip designed to reduce recoil and increase accuracy."
	icon_state = "vertical_grip"
	attachment_accuracy_mod = 0.85
	attachment_recoil_mod = 0.75
	value = 150

/obj/item/attachment/undermount/burst_adapter
	name = "burst fire adapter"
	icon_state = "burst_adapter"
	desc = "PewPewPew"
	desc_extended = "A complex underbarrel mechanism that turns any semi-automatic or automatic weapon to shoot in 3 round bursts. If the weapon already fires in 3 round bursts, it will increase the amount of bursts by 3."
	attachment_burst_add = 3
	attachment_delay_mod = 0.75
	attachment_accuracy_mod = 1.1
	attachment_recoil_mod = 1.2
	attachment_force_automatic = TRUE
	value = 400