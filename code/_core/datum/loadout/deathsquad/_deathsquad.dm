/loadout/deathsquad
	spawning_items = list(
		/obj/item/clothing/uniform/stealth,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/hands/gloves/colored/combat,
		/obj/item/clothing/hands/gloves/colored/combat/left,
		/obj/item/clothing/glasses/sun,
		/obj/item/clothing/belt/storage/colored/black,
		/obj/item/clothing/overwear/armor/carbon/deathsquad,
		/obj/item/clothing/head/helmet/carbon/deathsquad
	)

	var/list/random_primary = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/assault/equipped,
		/obj/item/weapon/ranged/energy/rifle/xray/deathsquad,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper,
		/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten,
		/obj/item/weapon/ranged/bullet/magazine/shotgun/bull
	)

	var/list/random_secondary = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_power,
		/obj/item/weapon/ranged/bullet/magazine/pistol/overseer,
		/obj/item/weapon/ranged/bullet/magazine/pistol/tactical
	)

	var/list/random_melee = list(
		/obj/item/weapon/melee/energy/sword/green
	)

/loadout/deathsquad/get_spawning_items()

	. = ..()

	var/obj/item/chosen_primary = pick(random_primary)
	var/obj/item/chosen_secondary = pick(random_secondary)
	var/obj/item/chosen_melee = pick(random_melee)

	. += chosen_primary
	. += chosen_secondary
	. += chosen_melee

	if(SSweapons.weapon_to_magazine[chosen_primary])
		for(var/i=1,i<=4,i++)
			. += SSweapons.weapon_to_magazine[chosen_primary]

	if(SSweapons.weapon_to_magazine[chosen_secondary])
		for(var/i=1,i<=2,i++)
			. += SSweapons.weapon_to_magazine[chosen_secondary]

	return .

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