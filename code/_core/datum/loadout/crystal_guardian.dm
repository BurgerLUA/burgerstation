/loadout/crystal_guardian/
	spawning_items = list(
		/obj/item/clothing/pants/normal,
		/obj/item/clothing/shirt/normal,
		/obj/item/clothing/overwear/hardsuit/crystal_guardian,
		/obj/item/clothing/head/helmet/hardsuit/crystal_guardian
	)

	var/list/random_weapon = list(
		/obj/item/weapon/melee/crystal/longsword,
		/obj/item/weapon/melee/crystal/rapier
	)

/loadout/crystal_guardian/get_spawning_items()
	. = ..()
	. += pick(random_weapon)
	