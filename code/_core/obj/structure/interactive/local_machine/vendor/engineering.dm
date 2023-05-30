/obj/structure/interactive/vending/engineering
	name = "engineering vendor"
	icon_state = "engivend"
	stored_types = list(
		/obj/item/crafting_bench/workbench,
		/obj/item/crafting_bench/bullet_press,
		/obj/item/crafting/ingredient/part/tape,
		/obj/item/crafting/ingredient/part/electronics,
		/obj/item/crafting/ingredient/part/scrap,
		/obj/item/crafting/ingredient/part/bullet_casings{amount=25} = 2.5,
		/obj/item/crafting/ingredient/part/gunpowder{amount=25} = 2.5,
		/obj/item/weapon/melee/tool/hammer,
		/obj/item/paper/book/crafting_guide
	)

/obj/structure/interactive/vending/engineering/equipment
	name = "engineering equipment vendor"
	icon_state = "engineering"
	stored_types = list(
		/obj/item/weapon/melee/toolbox/blue,
		/obj/item/weapon/melee/toolbox/red,
		/obj/item/weapon/melee/toolbox/green,
		/obj/item/weapon/melee/toolbox/yellow,
		/obj/item/weapon/melee/tool/crowbar,
		/obj/item/weapon/melee/tool/multitool,
		/obj/item/weapon/melee/tool/screwdriver,
		/obj/item/weapon/melee/tool/wirecutters,
		/obj/item/weapon/melee/tool/wrench,
		/obj/item/weapon/melee/tool/welder,
		/obj/item/light_sensor,
		/obj/item/container/healing/cable,
		/obj/item/pinpointer/landmark,
		/obj/item/weapon/melee/torch/flashlight,
		/obj/item/material/sheet{material_id=/material/steel,amount=50} = 2.5,
		/obj/item/material/sheet{material_id=/material/glass,amount=50} = 2.5,
		/obj/item/material/rod{material_id=/material/steel,amount=50} = 2.5,
		/obj/item/deployable/barricade{amount=10},
		/obj/item/diy_construction_kit,
		/obj/item/rcd,
		///obj/item/disk/rcd/glass_window,
		///obj/item/disk/rcd/metal_plating,
		///obj/item/disk/rcd/metal_wall,
		/obj/item/disk/rcd/conveyor,
		/obj/item/disk/rcd/diverter,
		/obj/item/disk/rcd/oresmelter,
		///obj/item/disk/rcd/orestorage,
		/obj/item/disk/rcd/stacker,
		/obj/item/disk/rcd/chair,
		/obj/item/disk/rcd/table,
		/obj/item/disk/rcd/light,
		/obj/item/disk/rcd/tube_light,
		///obj/item/disk/rcd/airlock,
		/obj/item/disk/rcd/flap,
		/obj/item/matter_cartridge,
		/obj/item/cell_charger,
		/obj/item/powercell/industrial,
		/obj/item/weapon/melee/energy/energy_wrench,
		/obj/item/flare
	)

/obj/structure/interactive/vending/engineering/wardrobe
	name = "engineering clothing vendor"
	icon_state = "engidrobe"
	stored_types = list(
		/obj/item/clothing/feet/socks/knee,
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/pants/normal/striped/engineering,
		/obj/item/clothing/shirt/normal/uniform/engineering,
		/obj/item/storage/shoebox/workboot/,
		/obj/item/storage/glovebox/brown_padded/,
		/obj/item/clothing/back/storage/satchel/poly/engineering,
		/obj/item/clothing/back/storage/dufflebag/poly/engineering,
		/obj/item/clothing/back/storage/backpack/poly/engineering,
		/obj/item/storage/pouch/single/brown,
		/obj/item/storage/pouch/double/brown,
		/obj/item/storage/pouch/triple/brown,
		/obj/item/clothing/belt/storage/colored/brown,
		/obj/item/clothing/head/hat/skimask/black,
		/obj/item/clothing/mask/gas/poly/engineering,
		/obj/item/clothing/head/light/hardhat,
		/obj/item/clothing/overwear/coat/vest/colored/brown,
		/obj/item/clothing/glasses/material,
		/obj/item/clothing/overwear/hardsuit/engineering
	)
