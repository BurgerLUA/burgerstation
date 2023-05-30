/obj/structure/interactive/vending/nanotrasen/medical
	icon = 'icons/obj/structure/vending_new.dmi'

/obj/structure/interactive/vending/nanotrasen/medical/clothing
	name = "medical clothing vendor"
	icon_state = "medical_clothing"

	stored_types = list(

		//Socks and Underwear
		/obj/item/storage/underwear,

		//Pants and Shirt
		/obj/item/clothing/pants/normal/medical,
		/obj/item/clothing/shirt/normal/medical,

		//Shoes and gloves.
		/obj/item/storage/shoebox/colored,
		/obj/item/storage/glovebox/white,


		//Headset and Accessories
		/obj/item/clothing/ears/headset/nanotrasen/medical,
		/obj/item/clothing/glasses/medical_hud,


		//Helmets and masks
		/obj/item/clothing/head/hat/beret/medical,
		/obj/item/clothing/head/helmet/polymorphic/medical,
		/obj/item/clothing/mask/sterile,
		/obj/item/clothing/mask/gas/poly/medical,

		//Armor
		/obj/item/clothing/overwear/armor/molded_armor,
		/obj/item/clothing/overwear/armor/medium_armor/black,

		//Belt and pockets.
		/obj/item/clothing/belt/storage/colored/medical,
		/obj/item/storage/pouch/single,
		/obj/item/storage/pouch/double,
		/obj/item/storage/pouch/triple,
		/obj/item/defib/belt,

		//Satchel, Backpack, Duffleback.
		/obj/item/defib,
		/obj/item/clothing/back/storage/satchel/poly/medical,
		/obj/item/clothing/back/storage/backpack/poly/medical,
		/obj/item/clothing/back/storage/dufflebag/poly/medical,

		//Bonus
		/obj/item/clothing/overwear/hardsuit/medical,

	)


/obj/structure/interactive/vending/nanotrasen/medical/equipment
	name = "medical equipment vendor"
	icon_state = "medical_equipment"

	stored_types = list(
		/obj/item/analyzer/health,
		/obj/item/container/healing/bandage,
		/obj/item/container/healing/ointment,
		/obj/item/container/healing/burn_kit,
		/obj/item/container/healing/trauma_kit,
		/obj/item/container/healing/patch/brute,
		/obj/item/container/healing/patch/burn,
		/obj/item/container/spray/styptic_powder,
		/obj/item/container/spray/silver_sulfadiazine,
		/obj/item/container/healing/bone_gel,
		/obj/item/container/healing/nanopaste,
		/obj/item/container/blood_pack/full/rad_be_gone,
		/obj/item/container/blood_pack/full/o_negative,
		/obj/item/container/blood_pack/full/reptile,
		/obj/item/container/blood_pack/full/synthblood,
		/obj/item/container/simple/beaker/bottle/epinephrine,
		/obj/item/container/simple/beaker/bottle/bicaridine,
		/obj/item/container/simple/beaker/bottle/kelotane,
		/obj/item/container/simple/beaker/bottle/dylovene,
		/obj/item/container/simple/beaker/bottle/charcoal,
		/obj/item/container/simple/beaker/bottle/calomel,
		/obj/item/container/simple/beaker/bottle/antihol,
		/obj/item/storage/pillbottle/consumer/painkillers,
		/obj/item/storage/pillbottle/bicaridine,
		/obj/item/storage/pillbottle/kelotane,
		/obj/item/storage/pillbottle/dylovene,
		/obj/item/storage/pillbottle/charcoal,
		/obj/item/storage/pillbottle/iron
	)

/obj/structure/interactive/vending/nanotrasen/medical/kits
	name = "medical first aid kits vendor"
	icon_state = "medical_kits"

	stored_types = list(
		/obj/item/storage/kit/filled,
		/obj/item/storage/kit/brute/filled,
		/obj/item/storage/kit/burn/filled,
		/obj/item/storage/kit/toxin/filled,
		/obj/item/storage/kit/oxy/filled,
		/obj/item/storage/kit/rad/filled,
		/obj/item/storage/kit/advanced/filled,
	)