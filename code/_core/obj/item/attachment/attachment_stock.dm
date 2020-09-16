/obj/item/attachment/stock/
	name = "stock attachment"


/obj/item/attachment/stock/c20r
	name = "c20r stock"
	desc_extended = "A stock attachment for the c20r. Comes standard with it."
	icon_state = "c20r_stock"

	attachment_stats = list(
		movement_spread = 1.25,
		heat_spread = 0.75,
		inaccuracy_modifer = 0.75,
		view_punch = 0.75
	)

/obj/item/attachment/stock/sniper_127 //Actually not a stock but whatever. Players won't know this.
	name = "12.7mm barrel"
	desc = "Extendong."
	desc_extended = "A silly barrel attachment that increases the barrel length of a 12.7mm gun. Increases projectile speed, bullet accuracy, precision, and weapon accuracy at the cost of higher recoil, movement spread, recoil spread, and spread from inexperience."
	icon_state = "barrel_sniper"

	attachment_stats = list()

	value = 100

	removable = FALSE