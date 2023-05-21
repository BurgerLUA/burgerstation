/loadout/citizen

	var/list/possible_pants = list()
	var/list/possible_shirt = list()
	var/list/possible_coat = list()
	var/list/possible_eyewear = list()

	spawning_items = list(
		/obj/item/storage/wallet/random_colonist,
		/loot/random/citizen,
		/loot/currency/dosh/survivor
	)

	var/list/possible_shirt_colors = list(
		COLOR_BLACK = 200,
		COLOR_GREY = 200,
		COLOR_WHITE = 200,
		COLOR_BLUE = 50,
		COLOR_GREEN = 50,
		COLOR_RED = 50,
		COLOR_BLUE_DARK = 25,
		COLOR_GREEN_DARK = 25,
		COLOR_BLUE_LIGHT = 25
	)

	var/list/possible_pant_colors = list(
		COLOR_WHITE = 100,
		COLOR_BLACK = 100,
		COLOR_GREY = 100,
		"#F7F8EF" = 25,
		"#EAE3CA" = 25,
		"#E8DFCD" = 25,
		"#9B8A80" = 25,
		"#CFC1AA" = 25,
		"#A79078" = 100,
		"#A47F5C" = 25,
		"#6F6E48" = 25,
		"#6C6F5C" = 25,
		"#7C7865" = 25
	)

	spawn_on_loot_fail = /obj/item/clothing/back/storage/satchel/poly

/loadout/citizen/pre_add(var/mob/living/advanced/A,var/obj/item/I) //added before initialize and spawn
	. = ..()
	if(is_clothing(I) && length(I.polymorphs) && !(I.item_slot_mod & (SLOT_MOD_LEFT | SLOT_MOD_RIGHT)))
		var/obj/item/clothing/C = I
		var/did_first = (C.item_slot != SLOT_TORSO) || prob(20)
		for(var/p_id in I.polymorphs)
			I.polymorphs[p_id]	= did_first ? pickweight(possible_pant_colors) : pickweight(possible_shirt_colors)
			did_first = TRUE

/loadout/citizen/get_spawning_items()
	. = ..()

	//Pants
	if(length(possible_pants))
		. += pick(possible_pants)

	//Shirt
	if(length(possible_shirt))
		. += pick(possible_shirt)

	//Coat
	if(length(possible_coat) && prob(20))
		. += pick(possible_coat)

	//Eyewear
	if(length(possible_eyewear) && prob(10))
		. += pick(possible_eyewear)

	//Shoes and socks.
	if(prob(20))
		. += /obj/item/clothing/feet/socks/knee
		. += /obj/item/clothing/feet/socks/knee
		. += /obj/item/clothing/feet/shoes/boot_colored
		. += /obj/item/clothing/feet/shoes/boot_colored/left
	if(prob(20))
		. += /obj/item/clothing/feet/shoes/sandal
		. += /obj/item/clothing/feet/shoes/sandal/left
	else
		. += /obj/item/clothing/feet/socks/ankle
		. += /obj/item/clothing/feet/socks/ankle
		. += /obj/item/clothing/feet/shoes/colored/black
		. += /obj/item/clothing/feet/shoes/colored/black/left

	if(prob(80))
		. += /obj/item/clothing/ring/gold/wedding
	else if(prob(20))
		. += /obj/item/clothing/ring/silver

/loadout/citizen/male
	possible_pants = list(
		/obj/item/clothing/pants/normal,
		/obj/item/clothing/pants/shorts,
	)
	possible_shirt = list(
		/obj/item/clothing/shirt/normal,
		/obj/item/clothing/shirt/normal/striped,
		/obj/item/clothing/shirt/normal/tee,
		/obj/item/clothing/shirt/normal/tee/soccer,
		/obj/item/clothing/shirt/normal/uniform,
		/obj/item/clothing/undertop/underwear/shirt
	)
	possible_coat = list(

	)
	possible_eyewear = list(
		/obj/item/clothing/glasses/sun,
		/obj/item/clothing/glasses/prescription,
		/obj/item/clothing/glasses/prescription/blue,
		/obj/item/clothing/glasses/prescription/circle,
	)
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/storage/wallet/random_colonist
	)



/loadout/citizen/female
	possible_pants = list(
		/obj/item/clothing/pants/normal,
		/obj/item/clothing/pants/shorts,
		/obj/item/clothing/pants/skirt,
	)
	possible_shirt = list(
		/obj/item/clothing/shirt/normal,
		/obj/item/clothing/shirt/blouse,
		/obj/item/clothing/shirt/blouse/frill,
		/obj/item/clothing/shirt/normal/tee,
	)
	possible_coat = list(
		/obj/item/clothing/overwear/coat/polymorphic,
	)
	possible_eyewear = list(
		/obj/item/clothing/glasses/sun,
		/obj/item/clothing/glasses/prescription,
		/obj/item/clothing/glasses/prescription/blue,
		/obj/item/clothing/glasses/prescription/circle
	)
	spawning_items = list(
		/obj/item/clothing/undertop/underwear/bra,
		/obj/item/clothing/underbottom/underwear/panty,
		/obj/item/storage/wallet/random_colonist
	)