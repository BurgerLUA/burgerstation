/obj/structure/interactive/vending/junk
	name = "snack vendor"
	icon_state = "snack"

/obj/structure/interactive/vending/junk/New(var/desired_loc)
	icon_state = pick("snack","snackblue","snackorange","snackgreen","snackteal")
	return ..()

/obj/structure/interactive/vending/junk/full
	stored_types = list(
		/obj/item/container/edible/package/junkfood/halloween/coconut_joy,
		/obj/item/container/edible/package/junkfood/halloween/credit,
		/obj/item/container/edible/package/junkfood/halloween/elon_musk_bar,
		/obj/item/container/edible/package/junkfood/halloween/hurr_bar,
		/obj/item/container/edible/package/junkfood/halloween/kit_catgirl_metaclique_bar,
		/obj/item/container/edible/package/junkfood/halloween/malf_way,
		/obj/item/container/edible/package/junkfood/halloween/candy_bar,
		/obj/item/container/edible/package/junkfood/halloween/triggerfinger,
		/obj/item/container/edible/package/junkfood/halloween/twink_bar,
		/obj/item/container/edible/package/junkfood/cake,
		/obj/item/container/edible/package/junkfood/candy,
		/obj/item/container/edible/package/junkfood/cheese_chips,
		/obj/item/container/edible/package/junkfood/chips,
		/obj/item/container/edible/package/junkfood/jerky,
		/obj/item/container/edible/package/junkfood/raisins
	)