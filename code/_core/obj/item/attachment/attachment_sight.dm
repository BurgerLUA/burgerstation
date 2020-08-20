/obj/item/attachment/sight
	name = "sight attachment"

/obj/item/attachment/sight/red_dot
	name = "red dot sight"
	desc = "What's wrong with ironsights?"
	desc_extended = "A red dot sight finely adjusted to increase accuracy by giving a clear sightline to the target, making the gun easier to handle while also increasing precision, at the cost of higher movement spread and recoil."
	icon_state = "red_dot_sight"

	attachment_stats = list(
		skill_spread = 0.75,
		movement_spread = 1.25,
		inaccuracy_modifer = 0.75,
		view_punch = 1.1
	)

	value = 200

/obj/item/attachment/sight/laser_sight
	name = "laser sight"
	desc = "Laser beams!"
	desc_extended = "A high power laser sight used for increasing the precision of the gun. Reduces movement spread and increases precision at the cost of making the gun a little more difficult to handle."
	icon_state = "laser_sight"

	attachment_stats = list(
		movement_spread = 0.75,
		inaccuracy_modifer = 0.75,
		skill_spread = 1.25
	)

	value = 300

/obj/item/attachment/sight/quickfire_adapter
	name = "quickfire adapter"
	desc = "Pew faster."
	desc_extended = "A complex weapon attachment that significantly increases the fire rate of the gun at the cost of decreasesd precision and increased recoil and recoil spread."
	icon_state = "quickfire_adapter"

	value = 800

	attachment_stats = list(
		inaccuracy_modifer = 1.25,
		heat_spread = 1.25,
		view_punch = 1.25,
		shoot_delay = 0.75
	)

/obj/item/attachment/sight/scope
	name = "rifle scope (x2)"
	desc = "What's wrong with ironsights?"
	desc_extended = "A bulky rifle scope that increases the zoom range of the weapon, making the weapon more precise. Significantly increases movement spread and heat spread as a penalty."
	icon_state = "x2_scope"

	attachment_stats = list(
		zoom_mul = 2,
		movement_spread = 2,
		heat_spread = 1.25,
		inaccuracy_modifer = 0.5,
	)

	value = 400

/obj/item/attachment/sight/scope/large
	name = "sniper scope (x4)"
	desc = "What's wrong with ironsights?"
	desc_extended = "A bulky sniper scope that increases the zoom range of the weapon, making the weapon more precise. Significantly increases movement spread and heat spread as a penalty."
	icon_state = "x4_scope"

	attachment_stats  = list(
		zoom_mul = 4,
		movement_spread = 3,
		heat_spread = 1.25,
		inaccuracy_modifer = 0.25,
	)

	value = 800


/obj/item/attachment/sight/targeting_computer
	name = "targeting computer"
	desc = "For nerds."
	desc_extended = "A series of complex and expensive circuits all packed into a metal holographic display triangle that does nearly all the complex calculations for you. Decreases accuracy penalties from low skill."
	icon_state = "targeting_device"

	value = 800

	attachment_stats = list(
		skill_spread = 0
	)
