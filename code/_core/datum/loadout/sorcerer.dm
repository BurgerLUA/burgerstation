/loadout/sorcerer
	spawning_items = list(
		/obj/item/clothing/feet/shoes/sandal,
		/obj/item/clothing/feet/shoes/sandal/left,
		/obj/item/clothing/pants/normal,
		/obj/item/clothing/shirt/normal,
		/obj/item/clothing/overwear/coat/sorcerer,
	)

	var/list/random_tome = list(
		/obj/item/weapon/ranged/magic/tome/chaos,
		/obj/item/weapon/ranged/magic/tome/crystal,
		/obj/item/weapon/ranged/magic/tome/fireball,
		/obj/item/weapon/ranged/magic/tome/ice,
		/obj/item/weapon/ranged/magic/tome/lightning,
		/obj/item/weapon/ranged/magic/tome/missile,
		/obj/item/weapon/ranged/magic/staff/basic,
		/obj/item/weapon/ranged/magic/staff/chaos,
		/obj/item/weapon/ranged/magic/staff/fire
	)

	var/list/random_weapon = list(
		/obj/item/weapon/melee/sword/claymore/cult,
		/obj/item/weapon/melee/sword/claymore,
		/obj/item/weapon/melee/null_rod,
		/obj/item/weapon/melee/null_rod/dagger,
		/obj/item/weapon/melee/null_rod/staff,
		/obj/item/weapon/melee/torch/lantern,
		/obj/item/weapon/melee/torch //Also flashlights.
	)

/loadout/sorcerer/get_spawning_items()
	. = ..()
	. += pick(random_weapon)
	. += pick(random_tome)
	return .
