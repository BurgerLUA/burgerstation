/loadout/deathsquad
	spawning_items = list(
		/obj/item/clothing/uniform/stealth,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/hands/gloves/colored/combat,
		/obj/item/clothing/hands/gloves/colored/combat/left
	)


/loadout/deathsquad/pre_add(var/mob/living/advanced/A,var/obj/item/I)

	if(istype(I,/obj/item/weapon/ranged/))
		var/obj/item/weapon/ranged/R = I
		if(R.firing_pin)
			R.firing_pin = /obj/item/firing_pin/electronic/iff/deathsquad

	if(istype(I,/obj/item/weapon/ranged/bullet/magazine))
		var/obj/item/weapon/ranged/bullet/magazine/M = I
		if(SSweapons.weapon_to_magazine[M.type])
			M.stored_magazine = pick(SSweapons.weapon_to_magazine[M.type])

	return ..()


/loadout/deathsquad/light
	spawning_items = list(
		/obj/item/clothing/uniform/stealth,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/hands/gloves/colored/combat,
		/obj/item/clothing/hands/gloves/colored/combat/left,
		/obj/item/clothing/overwear/armor/nanotrasen/light/deathsquad,
		/obj/item/clothing/head/helmet/nanotrasen/light/deathsquad,
		/obj/item/weapon/ranged/bullet/magazine/smg/p69,
		/obj/item/weapon/ranged/bullet/magazine/pistol/military,
		/obj/item/magazine/smg_40,
		/obj/item/magazine/smg_40,
		/obj/item/magazine/smg_40,
		/obj/item/magazine/smg_40,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm,
		/obj/item/magazine/pistol_9mm
	)

/loadout/deathsquad/medium
	spawning_items = list(
		/obj/item/clothing/uniform/stealth,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/hands/gloves/colored/combat,
		/obj/item/clothing/hands/gloves/colored/combat/left,
		/obj/item/clothing/overwear/armor/nanotrasen/medium/deathsquad,
		/obj/item/clothing/head/helmet/nanotrasen/medium/deathsquad,
		/obj/item/weapon/ranged/bullet/magazine/rifle/assault,
		/obj/item/weapon/ranged/bullet/magazine/pistol/tactical,
		/obj/item/magazine/rifle_308,
		/obj/item/magazine/rifle_308,
		/obj/item/magazine/rifle_308,
		/obj/item/magazine/rifle_308,
		/obj/item/magazine/pistol_45,
		/obj/item/magazine/pistol_45,
		/obj/item/magazine/pistol_45
	)

/loadout/deathsquad/heavy
	spawning_items = list(
		/obj/item/clothing/uniform/stealth,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/hands/gloves/colored/combat,
		/obj/item/clothing/hands/gloves/colored/combat/left,
		/obj/item/clothing/overwear/armor/nanotrasen/heavy/deathsquad,
		/obj/item/clothing/head/helmet/nanotrasen/heavy/deathsquad,
		/obj/item/weapon/ranged/energy/rifle/xray/deathsquad/,
		/obj/item/weapon/ranged/bullet/magazine/pistol/deagle,
		/obj/item/magazine/pistol_50,
		/obj/item/magazine/pistol_50,
		/obj/item/magazine/pistol_50
	)