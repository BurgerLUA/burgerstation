/obj/item/clothing/back/storage/dufflebag/poly
	icon = 'icons/obj/item/clothing/back/dufflebag/poly.dmi'
	dyeable = TRUE
	polymorphs = list(
		"body" = COLOR_WHITE,
		"detail" = COLOR_WHITE,
		"straps" = COLOR_WHITE
	)


/obj/item/clothing/back/storage/dufflebag/poly/nanotrasen
	polymorphs = list(
		"body" = COLOR_BLACK,
		"detail" = COLOR_NANOTRASEN,
		"straps" = COLOR_BLACK
	)

/obj/item/clothing/back/storage/dufflebag/poly/engineering
	polymorphs = list(
		"body" = COLOR_BROWN,
		"detail" = COLOR_ENGINEERING,
		"straps" = COLOR_BROWN
	)


/obj/item/clothing/back/storage/dufflebag/poly/grey
	polymorphs = list(
		"body" = COLOR_GREY,
		"straps" = COLOR_GREY_DARK,
		"detail" = COLOR_GREY_DARK
	)

/obj/item/clothing/back/storage/dufflebag/poly/science
	polymorphs = list(
		"body" = COLOR_WHITE,
		"straps" = COLOR_SCIENCE,
		"detail" = COLOR_SCIENCE
	)

/obj/item/clothing/back/storage/dufflebag/poly/ntops
	polymorphs = list(
		"body" = COLOR_WHITE,
		"detail" = COLOR_BLACK,
		"straps" = COLOR_BLACK
	)

/obj/item/clothing/back/storage/dufflebag/poly/wizard
	polymorphs = list(
		"body" = COLOR_PURPLE,
		"detail" = COLOR_BLUE,
		"straps" = COLOR_BLUE
	)

/obj/item/clothing/back/storage/dufflebag/poly/recruit
	vendor_name = "\improper New Recruit's Kit"
	polymorphs = list(
		"body" = COLOR_GREY_DARK,
		"detail" = COLOR_NANOTRASEN,
		"straps" = COLOR_NANOTRASEN
	)
	value_burgerbux = 1

/obj/item/clothing/back/storage/dufflebag/poly/recruit/fill_inventory()
	new /obj/item/clothing/ears/headset(src)
	new /obj/item/storage/underwear(src)

	new /obj/item/clothing/pants/normal/recruit(src)
	new /obj/item/clothing/shirt/normal/recruit(src)

	new /obj/item/storage/glovebox/padded(src)
	new /obj/item/storage/shoebox/jackboot(src)
	new /obj/item/clothing/overwear/armor/medium_armor/black(src)

	new /obj/item/clothing/glasses/sun/security(src)
	new /obj/item/clothing/head/helmet/polymorphic/recruit(src)

	new /obj/item/clothing/belt/storage/colored/recruit(src)
	new /obj/item/storage/pouch/triple/recruit/gun(src)
	new /obj/item/storage/pouch/triple/recruit/ammo(src)

	new /obj/item/weapon/ranged/bullet/magazine/rifle/starter(src)

	new /obj/item/deployable/barricade/filled(src)

	new /obj/item/grenade/timed/explosive(src)
	new /obj/item/grenade/timed/explosive(src)

	new /obj/item/tempering/quality/ranged/lesser(src)

	new /obj/item/pinpointer/landmark(src)
	new /obj/item/map(src)
	new /obj/item/flare(src)
	new /obj/item/weapon/melee/torch/flashlight(src)

	new /obj/item/storage/kit/filled(src)

	new /obj/item/container/food/package/junkfood/jerky(src)
	new /obj/item/container/beaker/alcohol/beer(src)

	. = ..()