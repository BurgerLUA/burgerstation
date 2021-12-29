#define MERC_ESSENTIALS \
/obj/item/analyzer/health, \
/obj/item/attachment/barrel/suppressor, \
/obj/item/container/beaker/can/grey_bull, \
/obj/item/container/beaker/vial/zombie_antidote, \
/obj/item/container/blood_pack/full/o_negative, \
/obj/item/container/blood_pack/full/o_negative, \
/obj/item/container/food/package/junkfood/jerky, \
/obj/item/container/food/package/junkfood/jerky, \
/obj/item/deployable/barricade/filled, \
/obj/item/firing_pin/electronic/iff/mercenary, \
/obj/item/fulton_pack, \
/obj/item/weapon/melee/tool/screwdriver,\
/obj/item/firing_pin/electronic/iff/mercenary, \
/obj/item/storage/kit/advanced/filled, \
/obj/item/weapon/melee/torch/flashlight/maglight, \
/obj/item/supply_remote/ammo,


/loadout/mercenary/pre_add(var/mob/living/advanced/A,var/obj/item/I)

	if(!I.value_burgerbux) //Prevents antagonists from selling their own items.
		I.value_burgerbux = 1

	. = ..()

/loadout/mercenary/rat
	spawning_items = list(
		/obj/item/clothing/ears/headset/mercenary,

		/obj/item/clothing/shirt/normal/reinforced/merc_alt,
		/obj/item/clothing/pants/normal/reinforced/merc_alt,
		/obj/item/clothing/overwear/armor/medium_armor/merc,
		/obj/item/clothing/overwear/coat/vest/colored/merc,

		/obj/item/clothing/feet/shoes/workboot,
		/obj/item/clothing/feet/shoes/workboot/left,

		/obj/item/clothing/hands/gloves/colored/padded/merc_alt,
		/obj/item/clothing/hands/gloves/colored/padded/merc_alt/left,

		/obj/item/clothing/back/storage/satchel/poly/merc_alt_alt,
		/obj/item/clothing/belt/storage/colored/merc_alt,

		/obj/item/storage/pouch/triple/black,
		/obj/item/storage/pouch/triple/black,

		/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper,

		/obj/item/weapon/ranged/bullet/magazine/pistol/deagle/mod,

		/obj/item/weapon/ranged/bullet/magazine/pistol/brown/mod/silenced,

		MERC_ESSENTIALS

		/obj/item/magazine/pistol_50/heartbreaker,
		/obj/item/magazine/pistol_50/heartbreaker,
		/obj/item/magazine/pistol_50/heartbreaker,
		/obj/item/magazine/pistol_50/heartbreaker,

		/obj/item/magazine/pistol_40/tranq,
		/obj/item/magazine/pistol_40/tranq,
		/obj/item/magazine/pistol_40/tranq,

		/obj/item/magazine/sniper_50,
		/obj/item/magazine/sniper_50,
		/obj/item/magazine/sniper_50/ap,
		/obj/item/magazine/sniper_50/ap,
		/obj/item/magazine/sniper_50/explosive,
		/obj/item/magazine/sniper_50/incendiary,

	)




/loadout/mercenary/virtual_suit
	spawning_items = list(
		//No underwear

		/obj/item/clothing/uniform/stealth/dyeable/virtual,
		/obj/item/clothing/feet/shoes/colored/merc,
		/obj/item/clothing/feet/shoes/colored/merc/left,
		/obj/item/clothing/hands/gloves/colored/padded/merc,
		/obj/item/clothing/hands/gloves/colored/padded/merc/left,

		/obj/item/clothing/ears/headset/mercenary,

		/obj/item/clothing/belt/storage/colored/merc,
		/obj/item/clothing/back/storage/satchel/poly/merc_alt,

		/obj/item/weapon/melee/energy/sword/katana/merc,

		/obj/item/storage/pouch/triple/black,
		/obj/item/storage/pouch/triple/black,

		/obj/item/weapon/ranged/bullet/magazine/pistol/brown/mod/silenced,

		MERC_ESSENTIALS

		/obj/item/magazine/pistol_40/tranq,
		/obj/item/magazine/pistol_40/tranq,
		/obj/item/magazine/pistol_40/tranq,
		/obj/item/magazine/pistol_40/tranq,
		/obj/item/magazine/pistol_40/tranq,

		/obj/item/magazine/pistol_40,
		/obj/item/magazine/pistol_40,
		/obj/item/magazine/pistol_40,
		/obj/item/magazine/pistol_40,
		/obj/item/magazine/pistol_40,
		/obj/item/magazine/pistol_40,
		/obj/item/magazine/pistol_40,
		/obj/item/magazine/pistol_40,
	)

/loadout/mercenary/stealth_suit
	spawning_items = list(
		/obj/item/clothing/feet/socks/ankle,
		/obj/item/clothing/feet/socks/ankle,
		/obj/item/clothing/underbottom/underwear/boxers/heart,

		/obj/item/clothing/uniform/stealth/dyeable/merc,
		/obj/item/clothing/overwear/armor/sneaking,
		/obj/item/clothing/overwear/coat/vest/poly/pockets_only,

		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/hands/gloves/colored/padded/black,
		/obj/item/clothing/hands/gloves/colored/padded/black/left,

		/obj/item/clothing/ears/headset/mercenary,
		/obj/item/clothing/head/hat/headband/dark_grey,

		/obj/item/clothing/belt/storage/colored/black,

		/obj/item/clothing/back/storage/satchel/poly/merc,

		/obj/item/weapon/ranged/bullet/magazine/rifle/burst/mod,

		/obj/item/storage/pouch/triple/black,
		/obj/item/storage/pouch/triple/black,

		/obj/item/weapon/ranged/bullet/magazine/pistol/brown/mod/silenced,

		MERC_ESSENTIALS

		/obj/item/magazine/pistol_40/tranq,
		/obj/item/magazine/pistol_40/tranq,
		/obj/item/magazine/pistol_40/tranq,
		/obj/item/magazine/pistol_40/tranq,
		/obj/item/magazine/pistol_40/tranq,

		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,

	)

/loadout/mercenary/olive_drab
	spawning_items = list(
		/obj/item/clothing/feet/socks/ankle,
		/obj/item/clothing/feet/socks/ankle,
		/obj/item/clothing/underbottom/underwear/boxers/heart,

		/obj/item/clothing/pants/normal/reinforced/merc,
		/obj/item/clothing/shirt/normal/reinforced/merc,
		/obj/item/clothing/overwear/coat/vest/poly/merc,

		/obj/item/clothing/neck/cloak/mercenary,

		/obj/item/clothing/feet/shoes/boot_colored/merc,
		/obj/item/clothing/feet/shoes/boot_colored/merc/left,

		/obj/item/clothing/hands/gloves/colored/padded/black,
		/obj/item/clothing/hands/gloves/colored/padded/black/left,


		/obj/item/clothing/ears/headset/mercenary,
		/obj/item/clothing/glasses/eyepatch,

		/obj/item/clothing/belt/storage/colored/black,

		/obj/item/clothing/back/storage/satchel/poly/brown,

		/obj/item/weapon/ranged/bullet/magazine/rifle/merc/equipped,

		/obj/item/storage/pouch/triple/black,
		/obj/item/storage/pouch/triple/black,

		/obj/item/weapon/ranged/bullet/magazine/pistol/tranq,

		MERC_ESSENTIALS

		/obj/item/magazine/pistol_tranq_11m,
		/obj/item/magazine/pistol_tranq_11m,
		/obj/item/magazine/pistol_tranq_11m,
		/obj/item/magazine/pistol_tranq_11m,
		/obj/item/magazine/pistol_tranq_11m,

		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,
		/obj/item/magazine/rifle_556,
	)