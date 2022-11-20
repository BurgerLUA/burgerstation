/loadout/cultist
	spawning_items = list(
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/pants/brown,
		/obj/item/clothing/feet/shoes/brown,
		/obj/item/clothing/feet/shoes/brown/left,
		/obj/item/clothing/overwear/armor/cult
	)

	var/list/random_tome = list(
		/obj/item/weapon/ranged/spellgem/chaos = 20,
		/obj/item/weapon/ranged/spellgem/cult = 20,
		/obj/item/weapon/ranged/spellgem/blackflame = 20,
		/obj/item/weapon/ranged/wand/twisted = 20,
		/obj/item/weapon/ranged/wand/profane = 10,
		/obj/item/weapon/ranged/wand/sage = 5
	)

	var/list/random_weapon = list(
		/obj/item/weapon/melee/sword/claymore/cult,
		/obj/item/weapon/unarmed/holy/spiked
	)
	possible_gems = list(
		/obj/item/weapon/ranged/spellgem/blackflame = 1,
		/obj/item/weapon/ranged/spellgem/chaos = 2,
		/obj/item/weapon/ranged/spellgem/cult = 2
	)

/loadout/cultist/get_spawning_items()
	. = ..()
	. += pickweight(random_weapon)
	if(prob(25)) . += pick(random_tome)

/loadout/cultist/old
	spawning_items = list(
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/pants/brown,
		/obj/item/clothing/feet/shoes/brown,
		/obj/item/clothing/feet/shoes/brown/left,
		/obj/item/clothing/overwear/armor/cult/old
	)

	random_weapon = list(
		/obj/item/weapon/melee/sword/claymore,
		/obj/item/weapon/unarmed/holy/spiked
	)

/loadout/cultist/hard
	spawning_items = list(
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/pants/brown,
		/obj/item/clothing/feet/shoes/brown,
		/obj/item/clothing/feet/shoes/brown/left,
		/obj/item/clothing/overwear/armor/cult/hard
	)

