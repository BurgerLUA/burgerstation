
/obj/structure/interactive/vending/security/gundrobe/halo/odst
	name = "gun vendor"
	icon_state = "gundrobe"

	stored_types = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m41,
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m739,
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs,

		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/ma5b,
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/br55,
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m395,

		/obj/item/weapon/ranged/bullet/pump/shotgun/halo/m90,

		/obj/item/weapon/ranged/bullet/magazine/pistol/halo/socom,
		/obj/item/weapon/ranged/bullet/magazine/smg/halo/m7
	)

/obj/structure/interactive/vending/security/gundrobe/halo/soe
	name = "gun vendor"
	icon_state = "gundrobe"

	stored_types = list(
		/obj/item/weapon/ranged/bullet/revolver/halo/acl55,
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/cal30,
		/obj/item/weapon/ranged/energy/halo/cov_pistol/insurrection,
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs/insurrection,

		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/ma5b/insurrection,
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m395/insurrection,

		/obj/item/weapon/ranged/bullet/pump/shotgun/halo/m45,
		/obj/item/weapon/ranged/bullet/revolver/halo/handcannon,


		/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_2,
		/obj/item/weapon/ranged/bullet/magazine/smg/halo/m7/insurrection
	)

/obj/structure/interactive/vending/security/ammo/halo/odst
	name = "ammo vendor"
	icon_state = "ammodrobe"

	stored_types = list(
		/obj/item/magazine/halo/m739,
		/obj/item/magazine/halo/m41,
		/obj/item/magazine/halo/srs,
		/obj/item/magazine/halo/srs/explosive,
		/obj/item/magazine/halo/srs/incendiary,
		/obj/item/magazine/halo/srs/ap,



		/obj/item/magazine/halo/kv32,

		/obj/item/magazine/halo/magnum_socom,
		/obj/item/magazine/halo/m7,

		/obj/item/magazine/halo/ma5b,
		/obj/item/magazine/halo/br55,
		/obj/item/magazine/halo/m395
	)

/obj/structure/interactive/vending/security/ammo/halo/soe
	name = "ammo vendor"
	icon_state = "ammodrobe"

	stored_types = list(
		/obj/item/magazine/halo/cal30,
		/obj/item/bullet_cartridge/halo/m25,
		/obj/item/magazine/halo/srs,
		/obj/item/magazine/halo/srs/explosive,
		/obj/item/magazine/halo/srs/incendiary,
		/obj/item/magazine/halo/srs/ap,




		/obj/item/bullet_cartridge/sniper_50,

		/obj/item/magazine/halo/magnum_police,
		/obj/item/magazine/halo/m7,

		/obj/item/magazine/halo/ma5b,
		/obj/item/magazine/halo/m395
	)

/obj/structure/interactive/vending/security/wardrobe/halo/odst
	name = "security wardrobe vendor"
	icon_state = "secdrobe_new"

	stored_types = list(
		/obj/item/halo/kit/odst/cqb,
		/obj/item/halo/kit/odst/medic,
		/obj/item/halo/kit/odst/sl,
		/obj/item/halo/kit/odst/soldier,
		/obj/item/halo/kit/odst/engineer,
		/obj/item/halo/kit/odst/sharp
	)

/obj/structure/interactive/vending/security/wardrobe/halo/soe
	name = "security wardrobe vendor"
	icon_state = "secdrobe_new"

	stored_types = list(
		/obj/item/halo/kit/soe/cqb,
		/obj/item/halo/kit/soe/medic,
		/obj/item/halo/kit/soe/leader,
		/obj/item/halo/kit/soe/rifleman,
		/obj/item/halo/kit/soe/engineer,
		/obj/item/halo/kit/soe/sharp
	)

/obj/structure/interactive/vending/security/gundrobe/halo/cov
	name = "gun vendor"
	icon_state = "covendor"

	stored_types = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/covenant/fuel_rod,
		/obj/item/weapon/ranged/energy/halo/cov_lmg,


		/obj/item/weapon/ranged/energy/halo/cov_rifle,
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/covenant/needlerifle,

		/obj/item/weapon/ranged/energy/halo/cov_pistol,
		/obj/item/weapon/ranged/bullet/magazine/smg/halo/covenant/needler,

		/obj/item/weapon/melee/energy/halo/esword,
		/obj/item/weapon/melee/energy/halo/edagger,

	)

/obj/structure/interactive/vending/security/wardrobe/halo/cov
	name = "wardrobe vendor"
	icon_state = "covarmorvendor"

	stored_types = list(
		/obj/item/halo/kit/cov/minor,
		/obj/item/halo/kit/cov/major,
		/obj/item/halo/kit/cov/ultra
	)

//empty
/obj/structure/interactive/vending/security/gundrobe/halo/cov/empty
	name = "battery"
	icon_state = "covendor"
	stored_types = null

/obj/structure/interactive/vending/security/ammo/halo/cov
	name = "ammo vendor"
	icon_state = "covammovendor"

	stored_types = list(
		/obj/item/magazine/halo/covenant/fuel,
		/obj/item/magazine/halo/covenant/needler
	)

//empty
/obj/structure/interactive/vending/security/ammo/halo/cov/empty
	name = "battery"
	icon_state = "covammovendor"
	stored_types = null
