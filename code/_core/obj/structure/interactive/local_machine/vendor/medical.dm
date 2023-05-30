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
		/obj/item/container/healing/bone_gel,
		/obj/item/container/spray/silver_sulfadiazine,
		/obj/item/container/spray/styptic_powder,
		/obj/item/container/simple/beaker/bottle/epinephrine,
		/obj/item/container/simple/beaker/bottle/calomel,
		/obj/item/container/simple/beaker/bottle/charcoal,
		/obj/item/container/simple/beaker/bottle/morphine,
		/obj/item/storage/pillbottle/bicaridine_small,
		/obj/item/storage/pillbottle/kelotane_small,
		/obj/item/storage/pillbottle/dylovene_small,
		/obj/item/storage/pillbottle/iron_small,
		/obj/item/storage/pillbottle/antihol_small,
		/obj/item/storage/pillbottle/consumer/painkillers,
		/obj/item/container/blood_pack/full/o_negative,
		/obj/item/container/blood_pack/full/reptile,
		/obj/item/container/blood_pack/full/rad_be_gone,
		/obj/item/container/healing/nanopaste
	)

/obj/structure/interactive/vending/medical/basic
	name = "emergency medicine vendor"
	icon_state = "wallmed"
	stored_types = list(
		/obj/item/analyzer/health,
		/obj/item/container/healing/bandage,
		/obj/item/container/healing/ointment,
		/obj/item/container/healing/trauma_kit,
		/obj/item/container/healing/burn_kit,
		/obj/item/container/healing/bone_gel,
		/obj/item/container/blood_pack/full/rad_be_gone,
		/obj/item/container/healing/nanopaste
	)
	pixel_x = 0
	pixel_y = 0
	dir_offset = TILE_SIZE - 8
	density = FALSE

/obj/structure/interactive/vending/medical/basic/Initialize()
	. = ..()
	setup_dir_offsets()
	dir = SOUTH

/obj/structure/interactive/vending/medical/basic/update_icon()
	. = ..()
	if(icon_state == initial(icon_state))
		icon_state = "wallmed_nomap"

/obj/structure/interactive/vending/medical/wardrobe
	name = "medical wardrobe vendor"
	icon_state = "medidrobe"
	stored_types = list(
		/obj/item/clothing/underbottom/underwear/boxers/medical,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/feet/socks/knee,
		/obj/item/clothing/shirt/normal/medical,
		/obj/item/clothing/pants/normal/medical,
		/obj/item/clothing/overwear/coat/labcoat/medical,
		/obj/item/clothing/neck/tie/red,
		/obj/item/storage/glovebox/white,
		/obj/item/storage/shoebox/colored,
		/obj/item/clothing/belt/storage/medical,
		/obj/item/clothing/back/storage/satchel/poly/medical,
		/obj/item/clothing/back/storage/backpack/poly/medical,
		/obj/item/clothing/back/storage/dufflebag/poly/medical,
		/obj/item/clothing/mask/sterile,
		/obj/item/clothing/mask/gas/poly/medical,
		/obj/item/clothing/head/hat/beret/medical,
		/obj/item/clothing/head/helmet/polymorphic/medical,

	)

/obj/structure/interactive/vending/medical/equipment
	name = "medical equipment vendor"
	icon_state = "medquip"
	stored_types = list(
		/obj/item/clothing/ears/headset/nanotrasen/medical,
		/obj/item/pinpointer/crew,
		/obj/item/pinpointer/crew/death,
		/obj/item/analyzer/health,
		/obj/item/clothing/glasses/medical_hud,
		/obj/item/defib,
		/obj/item/defib/belt,
		/obj/item/deployable/bodybag,
		/obj/item/container/syringe/hypodermic,
		/obj/item/storage/kit/filled,
		/obj/item/storage/kit/brute/filled,
		/obj/item/storage/kit/burn/filled,
		/obj/item/storage/kit/toxin/filled,
		/obj/item/storage/kit/advanced/filled,
		/obj/item/storage/kit/rad/filled,
		/obj/item/implanter/death_alarm
	)
