/obj/structure/interactive/vending/smart_fridge
	name = "smart fridge"
	icon_state = "smartfridge"
	plane = PLANE_OBJ
	pixel_y = 0

/obj/structure/interactive/vending/smart_fridge/chemistry
	name = "chemistry smart fridge"
	stored_types = list()

	var/list/chemicals_to_make = list(
		/reagent/fuel/acetone,
		/reagent/aluminium,
		/reagent/ammonia,
		/reagent/carbon,
		/reagent/chlorine,
		/reagent/copper,
		/reagent/nutrition/sugar/glucose,
		/reagent/iron,
		/reagent/drug/lithium,
		/reagent/toxin/mercury,
		/reagent/nitrogen,
		/reagent/oxygen,
		/reagent/phenol,
		/reagent/potassium,
		/reagent/silicon,
		/reagent/silver,
		/reagent/sodium,
		/reagent/salt/sodium_chloride,
		/reagent/sulfur,
		/reagent/acid/sulphuric
	)

/obj/structure/interactive/vending/smart_fridge/chemistry/PostInitialize()

	. = ..()

	var/turf/T = get_turf(src)

	for(var/k in chemicals_to_make)
		var/reagent/R = REAGENT(k)
		if(!R) continue
		var/obj/item/container/beaker/B = new(T)
		INITIALIZE(B)
		GENERATE(B)
		B.reagents.add_reagent(R.type,B.reagents.volume_max - B.reagents.volume_current)
		B.name = "beaker of [R.name]"
		FINALIZE(B)


/obj/structure/interactive/vending/smart_fridge/chemistry/purchase_item(var/mob/living/advanced/player/P,var/params,var/obj/item/associated_item,var/item_value=0,var/obj/hud/inventory/I)

	. = ..()


	if(. && associated_item.reagents && length(associated_item.reagents.stored_reagents))
		var/obj/item/I2 = .
		for(var/r_id in associated_item.reagents.stored_reagents)
			var/amount = associated_item.reagents.stored_reagents[r_id]
			I2.reagents.add_reagent(r_id,amount,should_update = FALSE)
		I2.reagents.update_container()


/obj/structure/interactive/vending/smart_fridge/chemistry/Finalize()
	. = ..()
	sortTim(stored_objects, /proc/cmp_name_dsc)

/obj/structure/interactive/vending/smart_fridge/kitchen
	name = "kitchen smart fridge"
	stored_types = list(
		/obj/item/container/beaker/vial/enzymes,
		/obj/item/container/beaker/food/flour,
		/obj/item/container/beaker/food/sugar,
		/obj/item/container/beaker/food/milk,
		/obj/item/container/beaker/food/cream,
		/obj/item/container/beaker/food/corn_flour,
		/obj/item/storage/egg_carton,
		/obj/item/container/food/dynamic/meat/raw,
		/obj/item/container/beaker/bottle/large/water,
		/obj/item/container/beaker/large/ice,
		/obj/item/container/food/plant/tomato,
		/obj/item/container/food/plant/lettuce
	)


/obj/structure/interactive/vending/smart_fridge/bar
	name = "bar smart fridge"
	icon_state = "boozeomat"
	stored_types = list(
		/obj/item/container/beaker/glass,
		/obj/item/container/beaker/shot,
		/obj/item/container/beaker/alcohol/absinthe,
		/obj/item/container/beaker/alcohol/ale,
		/obj/item/container/beaker/alcohol/beer,
		/obj/item/container/beaker/alcohol/brandy,
		/obj/item/container/beaker/alcohol/cider,
		/obj/item/container/beaker/alcohol/coffee_liqueur,
		/obj/item/container/beaker/alcohol/fernet,
		/obj/item/container/beaker/alcohol/gin,
		/obj/item/container/beaker/alcohol/grappa,
		/obj/item/container/beaker/alcohol/hearty_punch,
		/obj/item/container/beaker/alcohol/nothing,
		/obj/item/container/beaker/alcohol/rum,
		/obj/item/container/beaker/alcohol/tequila,
		/obj/item/container/beaker/alcohol/vodka,
		/obj/item/container/beaker/alcohol/whiskey,
		/obj/item/container/beaker/alcohol/wine,
		/obj/item/container/beaker/alcohol/wine/vermouth,
		/obj/item/container/beaker/can/cola,
		/obj/item/container/beaker/can/dr_gibb,
		/obj/item/container/beaker/can/grape_soda,
		/obj/item/container/beaker/can/grey_bull,
		/obj/item/container/beaker/can/iced_tea,
		/obj/item/container/beaker/can/mountain_wind,
		/obj/item/container/beaker/can/orange_soda,
		/obj/item/container/beaker/can/space_up,
		/obj/item/container/beaker/large/ice
	)