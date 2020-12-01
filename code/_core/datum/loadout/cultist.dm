/loadout/cultist
	spawning_items = list(
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/pants/brown,
		/obj/item/clothing/feet/shoes/brown,
		/obj/item/clothing/feet/shoes/brown/left,
		/obj/item/clothing/overwear/armor/cult
	)

	var/list/random_tome = list(
		/obj/item/weapon/ranged/magic/tome/cult
	)

	var/list/random_weapon = list(
		/obj/item/weapon/melee/sword/claymore/cult

	)

/loadout/cultist/get_spawning_items()
	. = ..()
	. += pick(random_weapon)
	if(prob(25)) . += pick(random_tome)
	return .


/loadout/cultist/old
	spawning_items = list(
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/pants/brown,
		/obj/item/clothing/feet/shoes/brown,
		/obj/item/clothing/feet/shoes/brown/left,
		/obj/item/clothing/overwear/armor/cult/old
	)

	random_weapon = list(
		/obj/item/weapon/melee/sword/claymore
	)

/loadout/cultist/hard
	spawning_items = list(
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/pants/brown,
		/obj/item/clothing/feet/shoes/brown,
		/obj/item/clothing/feet/shoes/brown/left,
		/obj/item/clothing/overwear/armor/cult/hard
	)

