/obj/structure/interactive/vending/clothes
	name = "clothes vendor"
	icon_state = "clothes"
	icon_state_broken = null
	icon_state_off = null
	icon_state_mask = null
	icon_state_panel = null

/obj/structure/interactive/vending/clothes/dye
	name = "dye vendor"
	icon_state = "dye"
	stored_types = list(
		/obj/item/slime_core/red,
		/obj/item/slime_core/green,
		/obj/item/slime_core/blue,
		/obj/item/slime_core/black/weak,
		/obj/item/slime_core/white/weak,
		/obj/item/slime_core/white/strong
	)

/obj/structure/interactive/vending/clothes/shirt
	name = "shirt vendor"
	icon_state = "shirt"
	stored_types = list(
		/obj/item/clothing/shirt/normal,
		/obj/item/clothing/shirt/normal/striped,
		/obj/item/clothing/shirt/normal/uniform,
		/obj/item/clothing/shirt/blouse,
		/obj/item/clothing/shirt/blouse/frill,
		/obj/item/clothing/shirt/blouse/uniform,
		/obj/item/clothing/undertop/underwear/shirt
	)

/obj/structure/interactive/vending/clothes/shirt/soccer
	name = "soccer uniform vendor"
	stored_types = list(
		/obj/item/clothing/pants/shorts/red_soccer,
		/obj/item/clothing/shirt/normal/tee/soccer/red,
		/obj/item/clothing/pants/shorts/blue_soccer,
		/obj/item/clothing/shirt/normal/tee/soccer/blue,
		/obj/item/clothing/pants/shorts/ref_soccer,
		/obj/item/clothing/shirt/normal/tee/soccer/ref,
		/obj/item/clothing/feet/socks/knee,
		/obj/item/storage/shoebox/colored,
		/obj/item/whistle
	)


/obj/structure/interactive/vending/clothes/overshirt
	name = "overwear vendor"
	icon_state = "overshirt"
	stored_types = list(
		/obj/item/clothing/overwear/coat/hoodie,
		/obj/item/clothing/overwear/coat/labcoat,
		/obj/item/clothing/overwear/coat/polymorphic,
		/obj/item/clothing/overwear/coat/wizard
	)


/obj/structure/interactive/vending/clothes/underwear
	name = "underwear vendor"
	icon_state = "underwear"
	stored_types = list(
		/obj/item/clothing/feet/socks/ankle,
		/obj/item/clothing/feet/socks/knee,
		/obj/item/clothing/feet/socks/knee/striped,
		/obj/item/clothing/feet/socks/thigh,
		/obj/item/clothing/feet/socks/thigh/striped,
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/underbottom/underwear/panty,
		/obj/item/clothing/underbottom/underwear/thong,
		/obj/item/clothing/undertop/underwear/bra,
		/obj/item/clothing/undertop/underwear/bra/sport
	)


/obj/structure/interactive/vending/clothes/pants
	name = "pants vendor"
	icon_state = "pants"
	stored_types = list(
		/obj/item/clothing/pants/normal,
		/obj/item/clothing/pants/normal/chaps,
		/obj/item/clothing/pants/normal/striped,
		/obj/item/clothing/pants/skirt,
		/obj/item/clothing/pants/skirt/striped,
		/obj/item/clothing/pants/kilt,

	)

/obj/structure/interactive/vending/clothes/shoes
	name = "shoes vendor"
	icon_state = "shoe"
	stored_types = list(
		/obj/item/storage/shoebox/black,
		/obj/item/storage/shoebox/colored,
		/obj/item/storage/shoebox/jackboot
	)

/obj/structure/interactive/vending/clothes/accessories
	name = "accessories vendor"
	icon_state = "accessories"
	stored_types = list(
		/obj/item/clothing/back/storage/satchel/poly,
		/obj/item/clothing/back/storage/backpack/poly,
		/obj/item/clothing/back/storage/dufflebag/poly,
		/obj/item/clothing/belt/storage/colored,
		/obj/item/clothing/head/hat/bandana,
		/obj/item/clothing/head/hat/skimask,
		/obj/item/clothing/neck/cape,
		/obj/item/clothing/neck/cloak,
		/obj/item/clothing/neck/tie,
		/obj/item/clothing/glasses/sun,
		/obj/item/storage/glovebox/white,
		/obj/item/clothing/glasses/eyepatch,
		/obj/item/clothing/head/hat/headband
	)

/obj/structure/interactive/vending/clothes/hat
	name = "hat vendor"
	icon_state = "hat"
	stored_types = list(
		/obj/item/clothing/head/hat/beret,
		/obj/item/clothing/head/hat/cat,
		/obj/item/clothing/head/hat/top,
		/obj/item/clothing/head/hat/wizard
	)