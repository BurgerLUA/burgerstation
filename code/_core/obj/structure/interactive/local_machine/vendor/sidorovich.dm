/obj/structure/interactive/vending/sidorovich

	accepts_item = /obj/item/currency/dosh
	markup = 1.5

	stored_types = list(
		/obj/item/contract/players/low,
        /obj/item/contract/players/mid,
        /obj/item/contract/players/high,
		/obj/item/container/healing/trauma_kit,
		/obj/item/container/healing/burn_kit,
  		/obj/item/weapon/ranged/bullet/revolver/nagant,
        /obj/item/storage/ammo/bullet_762,
        /obj/item/weapon/ranged/bullet/magazine/rifle/ak47,
        /obj/item/magazine/rifle_762_short,
		/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun,
		/obj/item/magazine/gauss_gun,
		/obj/item/magazine/gauss_gun/explosive,
		/obj/item/magazine/gauss_gun/ion,
		/obj/item/magazine/gauss_gun/incendiary,
		/obj/item/magazine/gauss_gun/ap,
   		/obj/item/weapon/ranged/bullet/pump/shotgun/ks23,
		/obj/item/storage/ammo/buckshot_23,
		/obj/item/storage/ammo/slug_23,
		/obj/item/storage/ammo/fire_23,
		/obj/item/storage/ammo/rubber_23,
		/obj/item/weapon/ranged/bullet/magazine/shotgun/saiga_20,
		/obj/item/magazine/shotgun_auto,
		/obj/item/magazine/shotgun_auto/slug,
        /obj/item/weapon/ranged/bullet/pump/gm94,
		/obj/item/storage/ammo/grenade_40mm,
        /obj/item/tempering/quality/greater,
		/obj/item/grenade/fuse/he,
        /obj/item/clothing/overwear/armor/seva/mono,
        /obj/item/clothing/overwear/hardsuit/skat/antag
	)

	health = null

	apc_powered = FALSE //Does not require power.

	interact_distance = VIEW_RANGE

	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_NO_HORIZONTAL | FLAG_INTERACTION_NO_TURF_CHECKING

/obj/structure/interactive/vending/exchange
	name = "currency exchange machine"
	desc = "Capitalism at its finest."
	desc_extended = "A handy conversion machine capable of exchanging credits for dosh for a significant fee."
	icon_state = "atm"
	icon_state_broken = "atm"
	icon_state_off = "atm"
	icon_state_mask = "atm"
	icon_state_panel = "atm"
	markup = 2
	stored_types = list(
		/obj/item/currency/dosh
	)
