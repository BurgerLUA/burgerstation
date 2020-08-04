/loadout/syndicate/ //Operative.
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/shirt/syndicate,
		/obj/item/clothing/pants/syndicate,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/back/storage/satchel,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/weapon/melee/energy/sword/green,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm
	)

/loadout/syndicate/pre_add(var/mob/living/advanced/A,var/obj/item/I)

	if(istype(I,/obj/item/weapon/ranged/))
		var/obj/item/weapon/ranged/R = I
		if(R.firing_pin)
			R.firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

	if(istype(I,/obj/item/weapon/ranged/bullet/magazine))
		var/obj/item/weapon/ranged/bullet/magazine/M = I
		if(SSweapons.weapon_to_magazine[M.type])
			M.stored_magazine = pick(SSweapons.weapon_to_magazine[M.type])

	return ..()

/loadout/syndicate/soldier
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/shirt/syndicate,
		/obj/item/clothing/pants/syndicate,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/hands/gloves/colored/padded/black,
		/obj/item/clothing/hands/gloves/colored/padded/black/left,
		/obj/item/clothing/head/helmet/security/tactical_helmet2,
		/obj/item/clothing/head/hood/skimask/black,
		/obj/item/clothing/overwear/armor/molded_armor/security,
		/obj/item/clothing/back/storage/satchel,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/weapon/ranged/bullet/magazine/rifle/carbine,
		/obj/item/weapon/melee/energy/sword/green,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie,
		/obj/item/magazine/carbine_223,
		/obj/item/magazine/carbine_223,
		/obj/item/magazine/carbine_223,
		/obj/item/magazine/carbine_223,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
	)

/loadout/syndicate/basic
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/shirt/syndicate,
		/obj/item/clothing/pants/syndicate,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/overwear/hardsuit/syndie,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/standard,
		/obj/item/weapon/melee/energy/sword/green,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/mod,
		/obj/item/magazine/carbine_223,
		/obj/item/magazine/carbine_223,
		/obj/item/magazine/carbine_223,
		/obj/item/magazine/carbine_223,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm
	)

/loadout/syndicate/advanced
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/shirt/syndicate,
		/obj/item/clothing/pants/syndicate,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/overwear/hardsuit/syndie/advanced,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/weapon/ranged/bullet/magazine/rifle/marksman,
		/obj/item/weapon/melee/energy/sword/green,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre,
		/obj/item/magazine/rifle_308,
		/obj/item/magazine/rifle_308,
		/obj/item/magazine/rifle_308,
		/obj/item/magazine/rifle_308,
		/obj/item/magazine/pistol_12mm,
		/obj/item/magazine/pistol_12mm,
		/obj/item/magazine/pistol_12mm,
		/obj/item/magazine/pistol_12mm
	)

/loadout/syndicate/elite
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/shirt/syndicate,
		/obj/item/clothing/pants/syndicate,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/overwear/hardsuit/syndie/elite,
		/obj/item/clothing/back/storage/satchel,
		/obj/item/storage/pouch/single/black,
		/obj/item/storage/pouch/single/black,
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg,
		/obj/item/magazine/lmg_223,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/weapon/melee/energy/sword/red
	)

/loadout/syndicate/player_antagonist
	spawning_items = list(
		/obj/item/clothing/ears/headset,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/feet/socks/ankle,
		/obj/item/clothing/feet/socks/ankle,
		/obj/item/clothing/shirt/syndicate,
		/obj/item/clothing/pants/syndicate,
		/obj/item/clothing/glasses/security_hud/red,
		/obj/item/clothing/head/hat/beret/armored/syndicate,
		/obj/item/clothing/mask/gas/mining,
		/obj/item/clothing/overwear/armor/bulletproof,
		/obj/item/clothing/neck/cloak/red,
		/obj/item/clothing/hands/gloves/colored/padded/black,
		/obj/item/clothing/hands/gloves/colored/padded/black/left,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/storage/pouch/triple/black/,
		/obj/item/storage/pouch/triple/black/,
		/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/standard,
		/obj/item/magazine/smg_45,
		/obj/item/magazine/smg_45,
		/obj/item/magazine/smg_45,
		/obj/item/magazine/smg_45,
		/obj/item/magazine/smg_45,
		/obj/item/magazine/smg_45,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/mod,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/weapon/melee/energy/sword/green,
		/obj/item/pinpointer/crew/syndicate,
		/obj/item/container/food/package/junkfood/syndicate,
		/obj/item/container/beaker/can/dr_gibb
	)