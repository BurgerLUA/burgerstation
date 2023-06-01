/obj/structure/interactive/vending/nanotrasen/clown/
	icon = 'icons/obj/structure/vending_new.dmi'


/obj/structure/interactive/vending/nanotrasen/clown/clothing
	name = "costume vendor"
	icon_state = "clown_theatre"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		//Clown stuff.
		/obj/item/clothing/pants/clown,
		/obj/item/clothing/shirt/clown,
		/obj/item/clothing/mask/clown,
		/obj/item/clothing/back/storage/backpack/clown,

		//Mime stuff.
		/obj/item/clothing/pants/normal/black,
		/obj/item/clothing/shirt/normal/striped,
		/obj/item/clothing/mask/mime,
		/obj/item/clothing/belt/suspenders,

		//Miner
		/obj/item/clothing/head/helmet/full/miner,
		/obj/item/clothing/overwear/coat/miner,

		//Union
		/obj/item/clothing/overwear/coat/union,
		/obj/item/clothing/head/hat/union,

		//Xeno
		/obj/item/clothing/overwear/armor/xeno,
		/obj/item/clothing/head/helmet/full/xeno,

		//Witch
		/obj/item/clothing/overwear/coat/witch,
		/obj/item/clothing/head/hat/witch,

		//Dracula
		/obj/item/clothing/pants/dracula,
		/obj/item/clothing/shirt/dracula,

		//Draculass
		/obj/item/clothing/pants/draculass,
		/obj/item/clothing/shirt/draculass,

		//Ghost
		/obj/item/clothing/overwear/coat/ghost_sheet,
	)


/obj/structure/interactive/vending/nanotrasen/clown/fun
	name = "fun! vendor"
	icon_state = "clown_fun"

	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

	stored_types = list(
		//Misc stuff.
		/obj/item/clothing/head/hat/bunny,
		/obj/item/clothing/head/hat/cat,
		/obj/item/clothing/head/hat/headslime,
		/obj/item/clothing/head/hat/pirate,
		/obj/item/clothing/head/hat/sombrero,
		/obj/item/clothing/mask/emoji,
		/obj/item/coin/bananium
	)