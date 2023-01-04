#define LAZY_BEAKER(x) /obj/item/container/simple/beaker/vendor{reagent=x}

/obj/structure/interactive/vending/nanotrasen/chemistry
	icon = 'icons/obj/structure/vending_new.dmi'

/obj/structure/interactive/vending/nanotrasen/chemistry/equipment
	name = "chemistry equipment vendor"
	icon_state = "chemistry_equipment"
	stored_types = list(
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
		/obj/item/container/spray,
		/obj/item/container/syringe/hypodermic,
		/obj/item/container/syringe/medipen,
		/obj/item/grenade,
		/obj/item/device/timer
	)


/obj/structure/interactive/vending/nanotrasen/chemistry/reagents
	name = "smart chemical vendor"
	icon_state = "chemistry_smartfridge"
	stored_types = list(
		LAZY_BEAKER(/reagent/nutrition/water),
		LAZY_BEAKER(/reagent/carbon),
		LAZY_BEAKER(/reagent/iron),
		LAZY_BEAKER(/reagent/copper),
		LAZY_BEAKER(/reagent/silver),
		LAZY_BEAKER(/reagent/aluminium),
		LAZY_BEAKER(/reagent/nitrogen),
		LAZY_BEAKER(/reagent/silicon),
		LAZY_BEAKER(/reagent/potassium),
		LAZY_BEAKER(/reagent/salt/sodium_chloride),
		LAZY_BEAKER(/reagent/ammonia),
		LAZY_BEAKER(/reagent/sulfur),
		LAZY_BEAKER(/reagent/chlorine),
		LAZY_BEAKER(/reagent/phenol),
		LAZY_BEAKER(/reagent/sodium),
		LAZY_BEAKER(/reagent/phosphorous),
		LAZY_BEAKER(/reagent/fuel/oxygen),
		LAZY_BEAKER(/reagent/fuel/oil/carbon),
		LAZY_BEAKER(/reagent/fuel/hydrogen),
		LAZY_BEAKER(/reagent/fuel/phoron),
		LAZY_BEAKER(/reagent/fuel/acetone),
		LAZY_BEAKER(/reagent/nutrition/ethanol),
		LAZY_BEAKER(/reagent/toxin/mercury)
	)

/obj/structure/interactive/vending/nanotrasen/chemistry/reagents/Finalize()
	. = ..()
	sortTim(stored_objects,/proc/cmp_name_asc)

#undef LAZY_BEAKER