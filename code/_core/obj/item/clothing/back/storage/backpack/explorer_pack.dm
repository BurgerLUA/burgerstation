obj/item/clothing/back/storage/backpack/explorer
	name = "explorer's pack"
	desc = "Lightweight and reliable!"
	desc_extended = "A small gear harness designed to carry a small amount of large items. Perfect for looters of the battlefield."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/clothing/back/backpack/explorer_pack.dmi'

	dynamic_inventory_count = MAX_INVENTORY_X*2

	size = MAX_INVENTORY_X*2*SIZE_3
	container_max_size = SIZE_4

	value = 160

obj/item/clothing/back/storage/backpack/explorer/rev
	name = "standard explorer's pack"

obj/item/clothing/back/storage/backpack/explorer/rev/fill_inventory()
	//7 Combat shit
	new /obj/item/grenade(src)
	new /obj/item/grenade(src)
	new /obj/item/grenade/landmine(src)
	new /obj/item/grenade/landmine(src)
	new /obj/item/deployable/barricade/filled(src)
	new /obj/item/storage/kit/filled(src)
	new /obj/item/supply_crate/russian(src)

	//1 Weapon
	new /obj/item/weapon/ranged/bullet/magazine/rifle/ak12(src)

	//7 mags
	new /obj/item/magazine/rifle_545(src)
	new /obj/item/magazine/rifle_545(src)
	new /obj/item/magazine/rifle_545(src)
	new /obj/item/magazine/rifle_545(src)
	new /obj/item/magazine/rifle_545(src)
	new /obj/item/magazine/rifle_545(src)

	//1 Vodka
	new /obj/item/container/beaker/alcohol/vodka(src)

	return ..()

/obj/item/clothing/back/storage/backpack/explorer/medical
	name = "medical explorer's pack"
	icon = 'icons/obj/item/clothing/back/backpack/explorer_pack_medical.dmi'

/obj/item/clothing/back/storage/backpack/explorer/medical/fill_inventory()
	//7 Medical shit
	new /obj/item/analyzer/health(src)
	new /obj/item/defib(src)
	new /obj/item/storage/kit/brute/filled(src)
	new /obj/item/storage/kit/burn/filled(src)
	new /obj/item/storage/kit/toxin/filled(src)
	new /obj/item/storage/kit/syndicate/filled(src)
	new /obj/item/implanter/od_purge(src)

	//1 Weapon
	new /obj/item/weapon/ranged/bullet/magazine/rifle/abakan(src)

	//7 mags
	new /obj/item/magazine/rifle_545(src)
	new /obj/item/magazine/rifle_545(src)
	new /obj/item/magazine/rifle_545(src)
	new /obj/item/magazine/rifle_545(src)
	new /obj/item/magazine/rifle_545(src)
	new /obj/item/magazine/rifle_545(src)
	new /obj/item/magazine/rifle_545(src)

	//1 Vodka
	new /obj/item/container/beaker/alcohol/vodka(src)

	return ..()


/obj/item/clothing/back/storage/backpack/explorer/sniper
	name = "sniper explorer's pack"
	icon = 'icons/obj/item/clothing/back/backpack/explorer_pack_sniper.dmi'


/obj/item/clothing/back/storage/backpack/explorer/sniper/fill_inventory()
	//7 Combat shit
	new /obj/item/grenade/landmine/proximity/explosive(src)
	new /obj/item/grenade/landmine/proximity/explosive(src)
	new /obj/item/grenade/landmine/proximity/explosive(src)
	new /obj/item/grenade/landmine/proximity/explosive(src)
	new /obj/item/deployable/barricade/filled(src)
	new /obj/item/storage/kit/filled(src)
	new /obj/item/supply_crate/russian(src)

	//1 Weapon
	new /obj/item/weapon/ranged/bullet/magazine/rifle/svd(src)

	//7 mags
	new /obj/item/magazine/rifle_762_long(src)
	new /obj/item/magazine/rifle_762_long(src)
	new /obj/item/magazine/rifle_762_long(src)
	new /obj/item/magazine/rifle_762_long(src)
	new /obj/item/magazine/rifle_762_long(src)
	new /obj/item/magazine/rifle_762_long(src)
	new /obj/item/magazine/rifle_762_long(src)

	//1 Vodka
	new /obj/item/container/beaker/alcohol/vodka(src)

	return ..()

/obj/item/clothing/back/storage/backpack/explorer/black //I LOVE it - Stalk.
	name = "black explorer's pack"
	icon = 'icons/obj/item/clothing/back/backpack/explorer_pack_sniper.dmi'