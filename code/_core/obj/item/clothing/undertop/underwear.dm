/obj/item/clothing/undertop/underwear/
	name = "undertop"
	desc = "Shirt that goes under your shirt."
	desc_extended = "You can also not wear another shirt over this, but you'll look like an idiot, or an Australian."
	size = SIZE_2


/obj/item/clothing/undertop/underwear/bra
	name = "brassiere"
	desc = "For bits that need extra support."
	desc_extended = "A bra. Does not actually stand for Battle Ready Armor."
	icon = 'icons/obj/item/clothing/underwear/bra.dmi'

	defense_rating = list(
		ARCANE = AP_DAGGER,
		COLD = AP_DAGGER
	)

	dyeable = TRUE

	value = 10

/obj/item/clothing/undertop/underwear/bra/alt
	icon = 'icons/obj/item/clothing/underwear/bra_alt.dmi'

/obj/item/clothing/undertop/underwear/bra/alt/black
	color = "#111111"

/obj/item/clothing/undertop/underwear/bra/alt/red
	color = "#8E0000"

/obj/item/clothing/undertop/underwear/bra/strapless
	icon = 'icons/obj/item/clothing/underwear/bra_strapless.dmi'

/obj/item/clothing/undertop/underwear/bra/strapless/brown
	color = "#603A20"

/obj/item/clothing/undertop/underwear/bra/sport
	icon = 'icons/obj/item/clothing/underwear/bra_sports.dmi'

/obj/item/clothing/undertop/underwear/bra/sport/pink
	color = "#FF9BC6"

/obj/item/clothing/undertop/underwear/bra/pink
	color = "#ff66ff"

/obj/item/clothing/undertop/underwear/bra/red
	color = "#8E0000"

/obj/item/clothing/undertop/underwear/bra/brown
	color = "#603A20"

/obj/item/clothing/undertop/underwear/bra/random/Generate()
	color = random_color()
	return ..()

/obj/item/clothing/undertop/underwear/shirt
	desc = "Shirt that goes under your shirt."
	desc_extended = "Slightly more acceptable to wear alone in public than the Undertop.."
	icon = 'icons/obj/item/clothing/underwear/undershirt.dmi'

	defense_rating = list(
		ARCANE = AP_DAGGER,
		COLD = AP_DAGGER
	)

	dyeable = TRUE

	value = 20

/obj/item/clothing/undertop/underwear/shirt/security
	desc = "Shirt that goes under your shirt."
	desc_extended = "Slightly more acceptable to wear alone in public than the Undertop. Black Version for Security to show off how manly and not insecure you are."
	name = "security undershirt"
	color = COLOR_BLACK

/obj/item/clothing/undertop/underwear/shirt/random/Generate()
	color = random_color()
	return ..()
