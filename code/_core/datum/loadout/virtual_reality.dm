/loadout/virtual_reality/


/loadout/virtual_reality/on_add(var/mob/living/advanced/A,var/obj/item/I) //added before initialize and spawn
	. = ..()
	if(is_clothing(I))
		var/obj/item/clothing/C = I
		C.defense_rating = list()
		C.anchored = TRUE

/loadout/virtual_reality/syndicate
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers/random,
		/obj/item/clothing/undertop/underwear/shirt/random,
		/obj/item/clothing/feet/socks/knee,
		/obj/item/clothing/feet/socks/knee,
		/obj/item/clothing/pants/syndicate,
		/obj/item/clothing/shirt/syndicate,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/hands/gloves/colored/padded/black,
		/obj/item/clothing/hands/gloves/colored/padded/black/left,
		/obj/item/clothing/ears/headset/virtual_reality,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/clothing/back/storage/satchel/poly/syndicate,
		/obj/item/clothing/neck/cloak/red,
		/obj/item/pinpointer/landmark,
		/obj/item/weapon/melee/combat_knife

	)


/loadout/virtual_reality/nanotrasen
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers/random,
		/obj/item/clothing/undertop/underwear/shirt/random,
		/obj/item/clothing/feet/socks/knee,
		/obj/item/clothing/feet/socks/knee,
		/obj/item/clothing/pants/normal/striped/nanotrasen,
		/obj/item/clothing/shirt/normal/uniform/nanotrasen,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/hands/gloves/colored/padded/black,
		/obj/item/clothing/hands/gloves/colored/padded/black/left,
		/obj/item/clothing/ears/headset/virtual_reality,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/clothing/back/storage/satchel/poly/nanotrasen,
		/obj/item/clothing/neck/cloak/nanotrasen,
		/obj/item/pinpointer/landmark,
		/obj/item/weapon/melee/combat_knife
	)