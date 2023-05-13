/obj/structure/interactive/vending/smart_fridge
	name = "smart fridge"
	icon_state = "smartfridge"
	plane = PLANE_MOVABLE
	pixel_y = 4

/obj/structure/interactive/vending/smart_fridge/kitchen
	name = "kitchen smart fridge"
	stored_types = list(
		/obj/item/container/simple/beaker/vial/enzymes,
		/obj/item/container/simple/baking/flour,
		/obj/item/container/simple/baking/sugar,
		/obj/item/container/simple/baking/milk,
		/obj/item/container/simple/baking/cream,
		/obj/item/container/simple/baking/corn_flour,
		/obj/item/storage/egg_carton,
		/obj/item/container/edible/dynamic/meat/raw,
		/obj/item/container/simple/beaker/bottle/large/water,
		/obj/item/container/simple/beaker/large/ice,
		/obj/item/container/edible/plant/tomato,
		/obj/item/container/edible/plant/lettuce
	)

/obj/structure/interactive/vending/smart_fridge/kitchen/solarian
	accepts_item = /obj/item/currency/dosh

/obj/structure/interactive/vending/smart_fridge/bar
	name = "bar smart fridge"
	icon_state = "boozeomat"
	stored_types = list(
		/obj/item/container/simple/beaker/glass,
		/obj/item/container/simple/beaker/shot,
		/obj/item/container/simple/beaker/flask,
		/obj/item/container/simple/alcohol/absinthe,
		/obj/item/container/simple/alcohol/ale,
		/obj/item/container/simple/alcohol/beer,
		/obj/item/container/simple/alcohol/brandy,
		/obj/item/container/simple/alcohol/cider,
		/obj/item/container/simple/alcohol/coffee_liqueur,
		/obj/item/container/simple/alcohol/fernet,
		/obj/item/container/simple/alcohol/gin,
		/obj/item/container/simple/alcohol/grappa,
		///obj/item/container/simple/alcohol/hearty_punch, this is craftable now 2u ethanol, 1u heal juice, 1u sugar
		/obj/item/container/simple/alcohol/nothing,
		/obj/item/container/simple/alcohol/rum,
		/obj/item/container/simple/alcohol/tequila,
		/obj/item/container/simple/alcohol/vodka,
		/obj/item/container/simple/alcohol/whiskey,
		/obj/item/container/simple/alcohol/wine,
		/obj/item/container/simple/alcohol/wine/vermouth,
		/obj/item/container/simple/can/cola,
		/obj/item/container/simple/can/dr_gibb,
		/obj/item/container/simple/can/grape_soda,
		/obj/item/container/simple/can/grey_bull,
		/obj/item/container/simple/can/iced_tea,
		/obj/item/container/simple/can/mountain_wind,
		/obj/item/container/simple/can/orange_soda,
		/obj/item/container/simple/can/space_up,
		/obj/item/container/simple/beaker/large/ice
	)

/obj/structure/interactive/vending/smart_fridge/bar/solarian
	stored_types = list(
		/obj/item/container/simple/beaker/glass,
		/obj/item/container/simple/beaker/shot,
		/obj/item/container/simple/beaker/flask,
		/obj/item/container/simple/alcohol/beer,
		/obj/item/container/simple/alcohol/whiskey,
	)

	accepts_item = /obj/item/currency/dosh
