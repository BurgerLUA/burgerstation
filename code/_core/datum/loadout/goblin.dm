/loadout/goblin
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/loincloth/brown,
		/obj/item/clothing/pants/cloth,
		/obj/item/clothing/belt/skull_codpiece,
		/obj/item/clothing/neck/miner_talisman,
		/obj/item/clothing/overwear/coat/vest/webbing

	)

	var/list/possible_weapon = list()
/loadout/goblin/get_spawning_items()

	. = ..()

	if(length(possible_weapon))
		. += pickweight(possible_weapon)

/loadout/goblin/mage
	spawning_items = list(
		/obj/item/clothing/overwear/coat/sorcerer
	)

	possible_weapon = list(
		/obj/item/weapon/ranged/wand/branch = 20,
		/obj/item/weapon/ranged/wand/quartz = 15,
		/obj/item/weapon/ranged/wand/twisted = 5,
		/obj/item/weapon/ranged/spellgem/flame = 10,
		/obj/item/weapon/ranged/spellgem/inferno = 10,
		/obj/item/weapon/ranged/spellgem/ice_spear = 10,
		/obj/item/weapon/ranged/spellgem/fire_spear = 10,
		/obj/item/weapon/ranged/spellgem/shock = 10,
		/obj/item/weapon/ranged/spellgem/frost = 10
	)

	possible_gems = list(
		/obj/item/weapon/ranged/spellgem/flame = 1,
		/obj/item/weapon/ranged/spellgem/ice_spear = 1,
		/obj/item/weapon/ranged/spellgem/fire_spear = 1,
		/obj/item/weapon/ranged/spellgem/shock = 1,
		/obj/item/weapon/ranged/spellgem/frost = 1
	)

/loadout/goblin/warrior
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/loincloth/brown,
		/obj/item/clothing/pants/cloth,
		/obj/item/clothing/belt/skull_codpiece,
		/obj/item/clothing/overwear/armor/knight/goblin,
		/obj/item/clothing/head/helmet/polymorphic/goblin,
	)

	possible_weapon = list(
		/obj/item/weapon/melee/mace = 10,
		/obj/item/weapon/melee/goedendag = 1,
		/obj/item/weapon/melee/sword/claymore = 1
	)