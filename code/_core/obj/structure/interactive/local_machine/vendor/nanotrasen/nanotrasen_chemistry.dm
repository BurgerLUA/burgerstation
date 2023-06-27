/obj/structure/interactive/vending/nanotrasen/chemistry
	icon = 'icons/obj/structure/vending_new.dmi'

/obj/structure/interactive/vending/nanotrasen/chemistry/wardrobe
	name = "chemist wardrobe vendor"
	icon_state = "chemistry_clothing"

	stored_types = list(
		/obj/item/clothing/back/storage/satchel/poly/chemistry,
		/obj/item/clothing/belt/storage/colored/chemistry,
		/obj/item/clothing/mask/gas/poly/chemistry,
		/obj/item/clothing/shirt/normal/uniform/chemistry,
		/obj/item/clothing/pants/normal/chemistry,
		/obj/item/clothing/overwear/coat/labcoat/chemist,
		/obj/item/storage/shoebox/colored/,
		/obj/item/storage/glovebox/white
	)


/obj/structure/interactive/vending/nanotrasen/chemistry/equipment
	name = "chemistry equipment vendor"
	icon_state = "chemistry_equipment"
	stored_types = list(
		/obj/item/paper/book/chemistry,
		/obj/item/storage/bags/chemistry,
		/obj/item/crafting_bench/alchemy,
		/obj/item/crafting_bench/filter,
		/obj/item/crafting_bench/grinder,
		/obj/item/crafting_bench/pill_press,
		/obj/item/crafting_bench/smelter,
		/obj/item/container/simple/beaker/bottle/tiny,
		/obj/item/container/simple/beaker/bottle,
		/obj/item/container/simple/beaker/bottle/medium,
		/obj/item/container/simple/beaker/bottle/large,
		/obj/item/container/simple/beaker/vial,
		/obj/item/container/simple/beaker,
		/obj/item/container/simple/beaker/large,
		/obj/item/container/simple/beaker/bucket,
		/obj/item/container/simple/beaker/bluespace,
		/obj/item/container/spray,
		/obj/item/container/syringe/hypodermic,
		/obj/item/container/syringe/medipen,
		/obj/item/grenade/device,
		/obj/item/grenade/device/large,
		/obj/item/device/timer,
		/obj/item/device/signaller,
		/obj/item/device/proximity,
		/obj/item/weapon/melee/tool/wrench,
		/obj/item/weapon/melee/tool/screwdriver
	)


/obj/structure/interactive/vending/nanotrasen/chemistry/reagents
	name = "smart chemical vendor"
	icon_state = "chemistry_smartfridge"
	stored_types = list(
		/obj/item/container/simple/chemistry/ammonia,
		/obj/item/container/simple/chemistry/sodium_chloride,
		/obj/item/container/simple/chemistry/sulfur,
		/obj/item/container/simple/chemistry/silicon,
		/obj/item/container/simple/chemistry/acetone,
		/obj/item/container/simple/chemistry/phenol,
		/obj/item/storage/pillbottle/consumer/chlorine,
		/obj/item/storage/pillbottle/consumer/carbon,
		/obj/item/storage/pillbottle/consumer/charcoal,
		/obj/item/storage/pillbottle/iron,
		/obj/item/container/simple/baking/sugar,
		/obj/item/container/simple/alcohol/ethanol,
		/obj/item/container/simple/beaker/fuel_cell/oxygen,
		/obj/item/container/simple/beaker/fuel_cell/nitrogen,
		/obj/item/container/simple/beaker/fuel_cell/phoron,
		/obj/item/container/simple/beaker/fuel_cell/hydrogen,
		/obj/item/container/simple/beaker/potassium,
		/obj/item/container/simple/beaker/phosphorous,
		/obj/item/container/simple/beaker/vial/enzymes
	)

	//Missing
	/*
		/reagent/fuel/welding
		/reagent/ash
		/reagent/silver
		/reagent/aluminium
		/reagent/acid/sulphuric
		/reagent/fuel/diethylamine
		/reagent/copper
		/reagent/sodium
	*/

/obj/structure/interactive/vending/nanotrasen/chemistry/reagents/Finalize()
	. = ..()
	if(length(stored_objects))
		sort_tim(stored_objects,/proc/cmp_name_asc)
