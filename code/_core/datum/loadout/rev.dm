/loadout/rev/
	spawning_items = list(
		/obj/item/clothing/pants/normal/grey,
		/obj/item/clothing/feet/shoes/winter,
		/obj/item/clothing/feet/shoes/winter/left,
		/obj/item/clothing/back/storage/backpack/explorer,
		/obj/item/clothing/belt/storage/tool/full,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm
	)

/loadout/rev/pre_add(var/mob/living/advanced/A,var/obj/item/I)

	if(istype(I,/obj/item/weapon/ranged/))
		var/obj/item/weapon/ranged/R = I
		R.firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

	if(istype(I,/obj/item/weapon/ranged/bullet/magazine))
		var/obj/item/weapon/ranged/bullet/magazine/M = I
		if(SSweapons.weapon_to_magazine[M.type])
			M.stored_magazine = pick(SSweapons.weapon_to_magazine[M.type])

	return ..()

/loadout/rev/olution
	spawning_items = list(
		/obj/item/clothing/pants/normal/grey,
		/obj/item/clothing/overwear/armor/bulletproof,
		/obj/item/clothing/overwear/coat/brown,
		/obj/item/clothing/mask/gas,
		/obj/item/clothing/head/hat/ushanka,
		/obj/item/clothing/hands/gloves/colored/insulated,
		/obj/item/clothing/hands/gloves/colored/insulated/left,
		/obj/item/clothing/feet/shoes/winter,
		/obj/item/clothing/feet/shoes/winter/left,
		/obj/item/clothing/back/storage/backpack/explorer,
		/obj/item/clothing/belt/storage/tool/full,
		/obj/item/weapon/ranged/bullet/magazine/rifle/russian,
		/obj/item/magazine/rifle_762_short,
		/obj/item/magazine/rifle_762_short,
		/obj/item/magazine/rifle_762_short,
		/obj/item/magazine/rifle_762_short
	)

/loadout/rev/pre_add(var/mob/living/advanced/A,var/obj/item/I)

	if(istype(I,/obj/item/weapon/ranged/))
		var/obj/item/weapon/ranged/R = I
		R.firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

	if(istype(I,/obj/item/weapon/ranged/bullet/magazine))
		var/obj/item/weapon/ranged/bullet/magazine/M = I
		if(SSweapons.weapon_to_magazine[M.type])
			M.stored_magazine = pick(SSweapons.weapon_to_magazine[M.type])

	return ..()

/loadout/rev/medium_heavy
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/uniform/slav,
		/obj/item/clothing/overwear/armor/slavticool,
		/obj/item/clothing/head/helmet/security/slavticool,
		/obj/item/clothing/hands/gloves/colored/combat,
		/obj/item/clothing/hands/gloves/colored/combat/left,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/back/storage/satchel,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/weapon/ranged/bullet/magazine/rifle/abakan,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie,
		/obj/item/weapon/melee/energy/sword/red,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/rifle_545mm,
		/obj/item/magazine/rifle_545mm,
		/obj/item/magazine/rifle_545mm,
		/obj/item/magazine/rifle_545mm
	)

/loadout/rev/scout_sniper
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/uniform/slav,
		/obj/item/clothing/overwear/armor/slavticool,
		/obj/item/clothing/head/helmet/security/slavticool,
		/obj/item/clothing/hands/gloves/colored/combat,
		/obj/item/clothing/hands/gloves/colored/combat/left,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/back/storage/satchel,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie,
		/obj/item/weapon/melee/energy/sword/red,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/rifle_939mm/vintorez,
		/obj/item/magazine/rifle_939mm/vintorez,
		/obj/item/magazine/rifle_939mm/vintorez,
		/obj/item/magazine/rifle_939mm/vintorez
	)

/loadout/rev/heavy
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/uniform/slav,
		/obj/item/clothing/overwear/hardsuit/exosuit,
		/obj/item/clothing/hands/gloves/colored/combat,
		/obj/item/clothing/hands/gloves/colored/combat/left,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/back/storage/satchel,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/weapon/ranged/bullet/magazine/rifle/val,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie,
		/obj/item/weapon/melee/energy/sword/red,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/rifle_939mm/val,
		/obj/item/magazine/rifle_939mm/val,
		/obj/item/magazine/rifle_939mm/val,
		/obj/item/magazine/rifle_939mm/val,
		/obj/item/grenade/timed/explosive/,
		/obj/item/grenade/timed/explosive/
	)

/loadout/rev/special_forces
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/uniform/slav,
		/obj/item/clothing/overwear/hardsuit/psz,
		/obj/item/clothing/hands/gloves/colored/combat,
		/obj/item/clothing/hands/gloves/colored/combat/left,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/back/storage/satchel,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/weapon/ranged/bullet/magazine/rifle/groza,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie,
		/obj/item/weapon/melee/energy/sword/red,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/rifle_939mm/groza,
		/obj/item/magazine/rifle_939mm/groza,
		/obj/item/magazine/rifle_939mm/groza,
		/obj/item/magazine/rifle_939mm/groza,
		/obj/item/grenade/timed/explosive/,
		/obj/item/grenade/timed/explosive/
	)

/loadout/rev/player_antagonist
	spawning_items = list(
		/obj/item/clothing/ears/headset,
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/uniform/slav,
		/obj/item/clothing/glasses/security_hud,
		/obj/item/clothing/overwear/hardsuit/psz,
		/obj/item/clothing/overwear/coat/vest,
		/obj/item/clothing/neck/cloak/red,
		/obj/item/clothing/hands/gloves/colored/padded/black,
		/obj/item/clothing/hands/gloves/colored/padded/black/left,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/back/storage/satchel,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/weapon/ranged/bullet/magazine/rifle/groza,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie,
		/obj/item/weapon/melee/energy/sword/red,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/pistol_10mm,
		/obj/item/magazine/rifle_939mm/groza,
		/obj/item/magazine/rifle_939mm/groza,
		/obj/item/magazine/rifle_939mm/groza,
		/obj/item/magazine/rifle_939mm/groza,
		/obj/item/magazine/rifle_939mm/groza,
		/obj/item/magazine/rifle_939mm/groza,
		/obj/item/grenade/timed/explosive/,
		/obj/item/grenade/timed/explosive/
	)
