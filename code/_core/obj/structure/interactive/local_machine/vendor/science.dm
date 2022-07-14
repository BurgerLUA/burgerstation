/obj/structure/interactive/vending/science/wardrobe
	name = "science wardrobe vendor"
	icon_state = "scidrobe"
	stored_types = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/feet/socks/knee,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/shirt/normal/uniform/science,
		/obj/item/clothing/pants/normal,
		/obj/item/storage/shoebox/black,
		/obj/item/storage/glovebox/white,
		/obj/item/clothing/back/storage/satchel/poly/science,
		/obj/item/clothing/back/storage/backpack/poly/science,
		/obj/item/clothing/back/storage/dufflebag/poly/science,
		/obj/item/clothing/belt/storage/colored,
		/obj/item/storage/pouch/single/black,
		/obj/item/storage/pouch/double/black,
		/obj/item/storage/pouch/triple/black,
		/obj/item/clothing/overwear/coat/labcoat/science,
		/obj/item/clothing/mask/gas/poly/science,
		/obj/item/clothing/head/hat/beret/science,
	)

/obj/structure/interactive/vending/science/equipment
	name = "science equipment vendor"
	icon_state = "robotics"
	stored_types = list(
		/obj/item/weapon/melee/torch/flashlight,
		/obj/item/emf,
		/obj/item/light_sensor,
		/obj/item/ghost_box,
		/obj/item/paper/book/ghost
	)

/obj/structure/interactive/vending/experimental
	name = "experimental vendor"
	icon_state = "experimental"
	desc = "For science! (And balance.)"
	desc_extended = "An experimental vendor that vends even more experimental weapons, armor, and clothing. Use at your own risk!"

	stored_types = list(


	)


/obj/structure/interactive/vending/genetic
	name = "genetic vendor"
	icon_state = "cart"
	desc = "For science! (And balance.)"
	desc_extended = "An experimental vendor that vends genetic disks."

	stored_types = list(
		/obj/item/disk/genetic/dash,
		/obj/item/disk/genetic/dash/controlled,
		/obj/item/disk/genetic/dash/targeted,
		/obj/item/disk/genetic/dash/random,
		/obj/item/disk/genetic/dash/fleeting,
		/obj/item/disk/genetic/quick_draw,
		/obj/item/disk/genetic/quick_draw/plus
	)