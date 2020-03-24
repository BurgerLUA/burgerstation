/obj/item/clothing/undertop/underwear/
	name = "undertop"

	size = SIZE_2
	weight = WEIGHT_1

/obj/item/clothing/undertop/underwear/bra
	name = "brassiere"
	icon = 'icons/obj/items/clothing/underwear/bra.dmi'

	defense_rating = list(
		MAGIC = ARMOR_D,
		COLD = ARMOR_E
	)

/obj/item/clothing/undertop/underwear/bra/alt
	icon = 'icons/obj/items/clothing/underwear/bra_alt.dmi'

/obj/item/clothing/undertop/underwear/bra/alt/black
	color = "#111111"

/obj/item/clothing/undertop/underwear/bra/alt/red
	color = "#8E0000"

/obj/item/clothing/undertop/underwear/bra/strapless
	icon = 'icons/obj/items/clothing/underwear/bra_strapless.dmi'

/obj/item/clothing/undertop/underwear/bra/strapless/brown
	color = "#603A20"

/obj/item/clothing/undertop/underwear/bra/sport
	icon = 'icons/obj/items/clothing/underwear/bra_sports.dmi'

/obj/item/clothing/undertop/underwear/bra/sport/pink
	color = "#FF9BC6"

/obj/item/clothing/undertop/underwear/bra/pink
	color = "#ff66ff"

/obj/item/clothing/undertop/underwear/bra/red
	color = "#8E0000"

/obj/item/clothing/undertop/underwear/bra/brown
	color = "#603A20"

/obj/item/clothing/undertop/underwear/bra/random/on_spawn()
	color = random_color()
	return ..()

/obj/item/clothing/undertop/underwear/shirt
	icon = 'icons/obj/items/clothing/underwear/undershirt.dmi'

	defense_rating = list(
		MAGIC = ARMOR_D,
		COLD = ARMOR_D
	)

/obj/item/clothing/undertop/underwear/shirt/security
	name = "security undershirt"
	color = COLOR_BLACK

/obj/item/clothing/undertop/underwear/shirt/random/on_spawn()
	color = random_color()
	return ..()
