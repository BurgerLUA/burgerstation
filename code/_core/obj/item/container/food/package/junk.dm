/obj/item/container/food/package/junkfood
	name = "junk food"
	icon = 'icons/obj/item/consumable/food/processed.dmi'

/obj/item/container/food/package/junkfood/chips
	name = "chippy crisps"
	icon_state = "chips"

/obj/item/container/food/package/junkfood/chips/Initialize()
	name = pick("chippy crisps","cripsy chips")
	return ..()

/obj/item/container/food/package/junkfood/chips/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chips,20)
	reagents.add_reagent(/reagent/salt,10)
	return ..()


/obj/item/container/food/package/junkfood/candy
	name = "getmore candy bar"
	icon_state = "candy"

/obj/item/container/food/package/junkfood/candy/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chocolate,10)
	reagents.add_reagent(/reagent/nutrition/sugar,5)
	return ..()



/obj/item/container/food/package/junkfood/jerky
	name = "sos jerky"
	icon_state = "jerky"

/obj/item/container/food/package/junkfood/jerky/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/jerky,15)
	reagents.add_reagent(/reagent/salt,5)
	return ..()

/obj/item/container/food/package/junkfood/raisins
	name = "4no raisins"
	icon_state = "raisins"

/obj/item/container/food/package/junkfood/raisins/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/raisins,10)
	reagents.add_reagent(/reagent/salt,5)
	reagents.add_reagent(/reagent/nutrition/sugar,5)
	return ..()


/obj/item/container/food/package/junkfood/cake
	name = "space cream cake"
	icon_state = "cake"

/obj/item/container/food/package/junkfood/cake/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/cake,10)
	reagents.add_reagent(/reagent/nutrition/junk/cream_filling,5)
	reagents.add_reagent(/reagent/nutrition/sugar,5)
	return ..()


/obj/item/container/food/package/junkfood/syndicate
	name = "syndi-cakes"
	icon_state = "syndicate"

/obj/item/container/food/package/junkfood/syndicate/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/cake,10)
	reagents.add_reagent(/reagent/medicine/omnizine,10)
	return ..()

/obj/item/container/food/package/junkfood/cheese_chips
	name = "cheese honkers"
	icon_state = "cheesie_honkers"

/obj/item/container/food/package/junkfood/cheese_chips/Generate()
	reagents.add_reagent(/reagent/nutrition/junk/chips,10)
	reagents.add_reagent(/reagent/salt,5)
	reagents.add_reagent(/reagent/nutrition/junk/cheese_powder,15)
	return ..()