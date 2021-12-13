/obj/structure/interactive/vending/junk
	name = "snack vendor"
	icon_state = "snack"

/obj/structure/interactive/vending/junk/New(var/desired_loc)
	icon_state = pick("snack","snackblue","snackorange","snackgreen","snackteal")
	return ..()

/obj/structure/interactive/vending/junk/full
	stored_types = list(
		/obj/item/container/food/package/junkfood/halloween/coconut_joy,
		/obj/item/container/food/package/junkfood/halloween/credit,
		/obj/item/container/food/package/junkfood/halloween/elon_musk_bar,
		/obj/item/container/food/package/junkfood/halloween/hurr_bar,
		/obj/item/container/food/package/junkfood/halloween/kit_catgirl_metaclique_bar,
		/obj/item/container/food/package/junkfood/halloween/malf_way,
		/obj/item/container/food/package/junkfood/halloween/candy_bar,
		/obj/item/container/food/package/junkfood/halloween/triggerfinger,
		/obj/item/container/food/package/junkfood/halloween/twink_bar,
		/obj/item/container/food/package/junkfood/cake,
		/obj/item/container/food/package/junkfood/candy,
		/obj/item/container/food/package/junkfood/cheese_chips,
		/obj/item/container/food/package/junkfood/chips,
		/obj/item/container/food/package/junkfood/jerky,
		/obj/item/container/food/package/junkfood/raisins
	)