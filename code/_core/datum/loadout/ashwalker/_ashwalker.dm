/loadout/ashwalker
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/loincloth/brown,
		/obj/item/clothing/neck/cloak/brown
	)

	var/list/random_weapon = list(
		/obj/item/weapon/melee/mace,
		/obj/item/weapon/melee/sword/gladius,
		/obj/item/weapon/melee/goedendag,
		/obj/item/weapon/melee/mezzaluna,
		/obj/item/weapon/melee/spear,
		/obj/item/weapon/melee/null_rod/dagger,
		/obj/item/weapon/melee/null_rod/staff,
		/obj/item/weapon/melee/sword/allium,
		/obj/item/weapon/melee/sword/curvedsword,
		/obj/item/weapon/melee/sword/gladius,
		/obj/item/weapon/melee/sword/skana
	)

/loadout/ashwalker/get_spawning_items()
	. = ..()
	. += pick(random_weapon)
	return .

/loadout/ashwalker/female
	spawning_items = list(
		/obj/item/clothing/undertop/underwear/bra/strapless/brown,
		/obj/item/clothing/underbottom/underwear/panty/brown,
		/obj/item/clothing/neck/cloak/brown
	)

/loadout/ashwalker/hunter
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/loincloth/brown,
		/obj/item/clothing/neck/mantle/brown
	)

/loadout/ashwalker/hunter/female
	spawning_items = list(
		/obj/item/clothing/undertop/underwear/bra/strapless/brown,
		/obj/item/clothing/underbottom/underwear/panty/brown,
		/obj/item/clothing/neck/mantle/brown
	)

/loadout/ashwalker/warrior
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/loincloth/red,
		/obj/item/clothing/overwear/armor/gladiator/brass,
		/obj/item/clothing/neck/cloak/red,
		/obj/item/clothing/belt/skull_codpiece
	)

/loadout/ashwalker/warrior/female
	spawning_items = list(
		/obj/item/clothing/undertop/underwear/bra/alt/red,
		/obj/item/clothing/underbottom/underwear/panty/red,
		/obj/item/clothing/overwear/armor/gladiator/brass,
		/obj/item/clothing/neck/cloak/red,
		/obj/item/clothing/belt/skull_codpiece
	)

/loadout/ashwalker/assassin
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/loincloth/red,
		/obj/item/clothing/neck/cape/goliath,
		/obj/item/clothing/belt/skull_codpiece
	)

/loadout/ashwalker/assassin/female
	spawning_items = list(
		/obj/item/clothing/undertop/underwear/bra/alt/red,
		/obj/item/clothing/underbottom/underwear/panty/red,
		/obj/item/clothing/neck/cape/goliath,
		/obj/item/clothing/belt/skull_codpiece
	)