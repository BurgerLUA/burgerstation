/obj/item/attachment/undermount
	name = "undermount attachment"

/obj/item/attachment/undermount/vertical_grip
	name = "vertical grip"
	desc = "Firmly grasp it."
	desc_extended = "A simple underbarrel vertical grip designed to reduce recoil and recoil spread, movement spread, and increase accuracy. Difficult to use while prone."
	icon_state = "vertical_grip"

	attachment_stats = list(
		movement_spread = 0.8,
		skill_spread = 1.2,
		view_punch = 0.8,
		heat_spread = 0.8,
		prone_mul = 1.5
	)

	value = 150

/obj/item/attachment/undermount/angled_grip
	name = "angled grip"
	desc = "Firmly grasp it."
	desc_extended = "A special angled grip designed to make it easier to handle the weapon at the cost of higher recoil and higher movement spread."
	icon_state = "angled_grip"

	attachment_stats = list(
		movement_spread = 1.25,
		skill_spread = 0.9,
		heat_spread = 0.8,
		view_punch = 1.25
	)

	value = 150

/obj/item/attachment/undermount/burst_adapter
	name = "burst fire adapter"
	icon_state = "burst_adapter"
	desc = "PewPewPew"
	desc_extended = "A complex underbarrel mechanism that turns any semi-automatic or automatic weapon to shoot in 3 round bursts. Also decreases accuracy loss due to recoil and makes the weapon easier to handle at the cost of higher movement spread."

	attachment_stats = list(
		bursts_to_use = 3,
		shoot_delay = 0.75,
		heat_spread = 0.5,
		skill_spread = 0.75,
		movement_spread = 1.75,
	)

	value = 400

/obj/item/attachment/undermount/bipod
	name = "bipod"
	desc = "Firmly mount it."
	desc_extended = "A simple bipod mount that nearly eliminates recoil and accuracy penalties when used while laying down or on a barricade. The bulkiness of the weapon causes inaccuracy while not prone and further increases movement accuracy penalties."
	icon_state = "bipod"

	attachment_stats = list(
		prone_mod = 0.5,
		movement_spread = 1.5,
		static_spread = 2
	)

	value = 250