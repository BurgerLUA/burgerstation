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
		var/obj/item/container/simple/beaker/B = new(T)
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
		/obj/item/container/simple/beaker/vial/enzymes,
		/obj/item/container/edible/pourable/flour,
		/obj/item/container/edible/pourable/sugar,
		/obj/item/container/edible/pourable/milk,
		/obj/item/container/edible/pourable/cream,
		/obj/item/container/edible/pourable/corn_flour,
		/obj/item/storage/egg_carton,
		/obj/item/container/edible/dynamic/meat/raw,
		/obj/item/container/simple/beaker/bottle/large/water,
		/obj/item/container/simple/beaker/large/ice,
		/obj/item/container/edible/plant/tomato,
		/obj/item/container/edible/plant/lettuce
	)


/obj/structure/interactive/vending/smart_fridge/bar
	name = "bar smart fridge"
	icon_state = "boozeomat"
	stored_types = list(
		/obj/item/container/simple/beaker/glass,
		/obj/item/container/simple/beaker/shot,
		/obj/item/container/simple/absinthe,
		/obj/item/container/simple/ale,
		/obj/item/container/simple/beer,
		/obj/item/container/simple/brandy,
		/obj/item/container/simple/cider,
		/obj/item/container/simple/coffee_liqueur,
		/obj/item/container/simple/fernet,
		/obj/item/container/simple/gin,
		/obj/item/container/simple/grappa,
		/obj/item/container/simple/hearty_punch,
		/obj/item/container/simple/nothing,
		/obj/item/container/simple/rum,
		/obj/item/container/simple/tequila,
		/obj/item/container/simple/vodka,
		/obj/item/container/simple/whiskey,
		/obj/item/container/simple/wine,
		/obj/item/container/simple/wine/vermouth,
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