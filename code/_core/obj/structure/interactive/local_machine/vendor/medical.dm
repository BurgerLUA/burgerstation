/obj/structure/interactive/vending/medical/
	name = "medicine vendor"
	icon_state = "med"


/obj/structure/interactive/vending/medical/medicine
	name = "medicine vendor"
	icon_state = "med"
	stored_types = list(
		/obj/item/analyzer/health,
		/obj/item/container/healing/bandage,
		/obj/item/container/healing/ointment,
		/obj/item/container/healing/trauma_kit,
		/obj/item/container/healing/burn_kit,
		/obj/item/container/spray/silver_sulfadiazine,
		/obj/item/container/spray/styptic_powder,
		/obj/item/container/syringe,
		/obj/item/container/simple/beaker/bottle/epinephrine,
		/obj/item/container/simple/beaker/bottle/calomel,
		/obj/item/container/simple/beaker/bottle/charcoal,
		/obj/item/container/simple/beaker/bottle/morphine,
		/obj/item/container/simple/beaker/vial/zombie_antidote,
		/obj/item/storage/pillbottle/bicaridine_small,
		/obj/item/storage/pillbottle/kelotane_small,
		/obj/item/storage/pillbottle/dylovene_small,
		/obj/item/storage/pillbottle/iron_small,
		/obj/item/storage/pillbottle/antihol_small,
		/obj/item/storage/pillbottle/assprin,
		/obj/item/container/blood_pack/full/o_negative,
		/obj/item/container/blood_pack/full/reptile,
		/obj/item/container/healing/nanopaste,
		/obj/item/container/blood_pack/full/rad_be_gone,
	)

/obj/structure/interactive/vending/medical/basic
	name = "emergency medicine vendor"
	icon_state = "med"
	stored_types = list(
		/obj/item/analyzer/health,
		/obj/item/container/healing/bandage,
		/obj/item/container/healing/ointment,
		/obj/item/container/healing/trauma_kit,
		/obj/item/container/healing/burn_kit,
		/obj/item/container/healing/nanopaste,
		/obj/item/container/blood_pack/full/rad_be_gone,
	)


/obj/structure/interactive/vending/medical/chemistry
	name = "chemistry vendor"
	icon_state = "chem"
	stored_types = list(
		/obj/item/paper/book/chemistry,
		/obj/item/storage/bags/chemistry,
		/obj/item/storage/pillbottle,
		/obj/item/container/syringe,
		/obj/item/container/spray,
		/obj/item/weapon/ranged/reagent_sprayer/spray_bottle,
		/obj/item/container/simple/beaker/vial,
		/obj/item/container/simple/beaker/bottle/large,
		/obj/item/container/simple/beaker/bottle,
		/obj/item/container/simple/beaker,
		/obj/item/container/simple/beaker/large,
		/obj/item/container/blood_pack/
	)

/obj/structure/interactive/vending/medical/wardrobe
	name = "medical wardrobe vendor"
	icon_state = "medidrobe"
	stored_types = list(
		/obj/item/clothing/underbottom/underwear/boxers/medical,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/shirt/normal/medical,
		/obj/item/clothing/pants/normal/medical,
		/obj/item/clothing/uniform/utility/medical,
		/obj/item/clothing/overwear/coat/labcoat/medical,
		/obj/item/storage/glovebox/white,
		/obj/item/defib/belt
	)