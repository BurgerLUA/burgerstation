/obj/item/storage/wallet
	name = "wallet"
	desc = "How do I attach this to my chest?"
	desc_extended = "A plain old faux leather wallet. For storing small objects."

	icon = 'icons/obj/item/storage/wallet.dmi'
	icon_state = "wallet"

	size = SIZE_1

	is_container = TRUE
	container_max_size = SIZE_0

	dynamic_inventory_count = 4

	value = 40

var/global/list/single_cigs = subtypesof(/obj/item/container/cigarette)
var/global/list/single_patches = subtypesof(/obj/item/container/healing/patch)
var/global/list/single_syringes = subtypesof(/obj/item/container/syringe/medipen) - /obj/item/container/syringe/medipen/adminomnizine
var/global/list/single_pills = subtypesof(/obj/item/container/edible/pill)

/obj/item/storage/wallet/random_colonist/fill_inventory()

	//ID
	if(prob(90))
		new /obj/item/id/colonist(src)

	//Base currency
	var/obj/item/currency/dosh/D = new(src)
	D.amount = rand(5,20)

	//Extra currency
	if(prob(10))
		var/obj/item/currency/gold_coin/G = new(src)
		G.amount = rand(1,5)
	else if(prob(5))
		var/obj/item/currency/credits/C = new(src)
		C.amount = rand(5,50)
	else if(prob(1))
		new /obj/item/coin/cursed(src)

	//Medicine
	if(prob(10))
		var/obj/item/container/cigarette/C = pick(single_cigs)
		C = new C(src)
	else if(prob(5))
		var/obj/item/container/healing/patch/P = pick(single_patches)
		P = new P(src)
		P.amount = 1
	else if(prob(5))
		var/obj/item/container/syringe/medipen/P = pick(single_syringes)
		P = new P(src)
	else if(prob(5))
		var/obj/item/container/edible/pill/P = pick(single_pills)
		P = new P(src)

	. = ..()