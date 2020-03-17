/obj/item/container/food/package/junkfood
	name = "junk food"
	icon = 'icons/obj/items/consumable/food/processed.dmi'

/obj/item/container/food/package/junkfood/chips
	name = "chippy crisps"
	icon_state = "chips"

/obj/item/container/food/package/junkfood/chips/Initialize()
	name = pick("chippy crisps","cripsy chips")
	return ..()

/obj/item/container/food/package/junkfood/chips/on_spawn()
	reagents.add_reagent("chips",20)
	reagents.add_reagent("salt",10)
	return ..()


/obj/item/container/food/package/junkfood/candy
	name = "getmore candy bar"
	icon_state = "candy"

/obj/item/container/food/package/junkfood/candy/on_spawn()
	reagents.add_reagent("low_chocolate",10)
	reagents.add_reagent("sugar",5)
	return ..()



/obj/item/container/food/package/junkfood/jerky
	name = "sos jerky"
	icon_state = "jerky"

/obj/item/container/food/package/junkfood/jerky/on_spawn()
	reagents.add_reagent("soy_jerky",15)
	reagents.add_reagent("salt",5)
	return ..()

/obj/item/container/food/package/junkfood/rasins
	name = "4no raisins"
	icon_state = "raisins"

/obj/item/container/food/package/junkfood/rasins/on_spawn()
	reagents.add_reagent("raisins",10)
	reagents.add_reagent("salt",5)
	reagents.add_reagent("sugar",5)
	return ..()


/obj/item/container/food/package/junkfood/cake
	name = "space cream cake"
	icon_state = "cake"

/obj/item/container/food/package/junkfood/cake/on_spawn()
	reagents.add_reagent("yellow_cake",10)
	reagents.add_reagent("cream_filling",5)
	reagents.add_reagent("sugar",5)
	return ..()


/obj/item/container/food/package/junkfood/syndicate
	name = "syndi-cakes"
	icon_state = "syndicate"

/obj/item/container/food/package/junkfood/syndicate/on_spawn()
	reagents.add_reagent("yellow_cake",10)
	reagents.add_reagent("omnizine",10)
	return ..()

/obj/item/container/food/package/junkfood/cheese_chips
	name = "cheese honkers"
	icon_state = "cheesie_honkers"

/obj/item/container/food/package/junkfood/cheese_chips/on_spawn()
	reagents.add_reagent("chips",10)
	reagents.add_reagent("salt",5)
	reagents.add_reagent("cheese_powder",15)
	return ..()