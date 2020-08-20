/obj/item/attachment/sight
	name = "sight attachment"

/obj/item/attachment/sight/red_dot
	name = "red dot sight"
	desc = "What's wrong with ironsights?"
	desc_extended = "A red dot sight finely adjusted to increase accuracy by giving a clear sightline to the target, decreasing base spread."
	icon_state = "red_dot_sight"

	stats_attachment_mul = list(
		skill_spread = 0.75,
		movement_spread = 1.25,
		inaccuracy_modifer = 0.75,
		view_punch = 1.1
	)

	value = 200

/obj/item/attachment/sight/laser_sight
	name = "laser sight"
	desc = "Laser beams!"
	desc_extended = "A high power laser sight used for increasing the precision of the gun. Does what it says; increases precision and accuracy."
	icon_state = "laser_sight"

	stats_attachment_mul = list(
		movement_spread = 0.75,
		inaccuracy_modifer = 0.75,
		skill_spread = 1.25
	)

	value = 300

/obj/item/attachment/sight/quickfire_adapter
	name = "quickfire adapter"
	desc = "Pew faster."
	desc_extended = "A complex weapon attachment that increases the fire rate of the gun at the cost of accuracy."
	icon_state = "quickfire_adapter"

	value = 800

	stats_attachment_mul = list(
		damage_multiplier = 0.9,
		skill_spread = 1.5,
		heat_spread = 0.9,
		inaccuracy_modifer = 1.25,
		view_punch = 1.25,
		shoot_delay = 0.75
	)

/obj/item/attachment/sight/scope
	name = "x2 rifle scope"
	desc = "What's wrong with ironsights?"
	desc_extended = "A bulky rifle scope that increases the zoom range of the weapon. The weight and size increases recoil as a penalty."
	icon_state = "x2_scope"

	stats_attachment_set(
		zoom_mul = 2
	)

	stats_attachment_mul = list(
		movement_spread = 2,
		heat_spread = 1.25,
		inaccuracy_modifer = 0.5,
	)

	value = 400

/obj/item/attachment/sight/scope/large
	name = "x4 sniper scope"
	desc = "What's wrong with ironsights?"
	desc_extended = "A bulky sniper scope that increases the zoom range of the weapon. The weight and size increases recoil as a penalty."
	icon_state = "x4_scope"

	stats_attachment_set(
		zoom_mul = 4
	)

	stats_attachment_mul = list(
		movement_spread = 3,
		heat_spread = 1.25,
		inaccuracy_modifer = 0.25,
	)

	value = 800