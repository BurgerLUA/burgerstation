/loadout/pirate/pre_add(var/mob/living/advanced/A,var/obj/item/I)

	if(istype(I,/obj/item/weapon/ranged/))
		var/obj/item/weapon/ranged/R = I
		R.firing_pin = /obj/item/firing_pin/electronic/iff/bone

	return ..()


/loadout/pirate/captain
	spawning_items = list(
		/obj/item/clothing/uniform/captain/formal,
		/obj/item/clothing/feet/shoes/colored/brown,
		/obj/item/clothing/feet/shoes/colored/brown/left,
		/obj/item/clothing/hands/gloves/captain,
		/obj/item/clothing/hands/gloves/captain/left,
		/obj/item/clothing/head/hat/captain,
		/obj/item/weapon/ranged/energy/recharging/captain,
		/obj/item/weapon/melee/sword/sabre
	)

/loadout/pirate/mate
	spawning_items = list(
		/obj/item/clothing/pants/syndicate,
		/obj/item/clothing/overwear/coat/hos,
		/obj/item/clothing/glasses/sun,
		/obj/item/clothing/head/hat/beret/black,
		/obj/item/clothing/hands/gloves/colored/padded/black,
		/obj/item/clothing/hands/gloves/colored/padded/black/left,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/belt/storage/colored/gold,
		/obj/item/weapon/ranged/bullet/magazine/pistol/deagle,
		/obj/item/weapon/melee/energy/stunbaton,
		/obj/item/magazine/pistol_50,
		/obj/item/magazine/pistol_50,
		/obj/item/magazine/pistol_50,
		/obj/item/magazine/pistol_50,
		/obj/item/magazine/pistol_50,
		/obj/item/magazine/pistol_50
	)



/loadout/pirate/crew/melee
	spawning_items = list(
		/obj/item/clothing/pants/brown,
		/obj/item/clothing/hands/gloves/colored/padded/brown,
		/obj/item/clothing/hands/gloves/colored/padded/brown/left,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/weapon/melee/sword/sabre
	)


/loadout/pirate/crew/ranged
	spawning_items = list(
		/obj/item/clothing/pants/syndicate,
		/obj/item/clothing/head/hat/beret/shaleez,
		/obj/item/clothing/hands/gloves/colored/padded/brown,
		/obj/item/clothing/hands/gloves/colored/padded/brown/left,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/weapon/melee/sword/sabre,
		/obj/item/weapon/ranged/energy/rifle
	)

/loadout/pirate/crew/magic
	spawning_items = list(
		/obj/item/clothing/pants/brown,
		/obj/item/clothing/head/hat/wizard/red,
		/obj/item/clothing/hands/gloves/colored/padded/brown,
		/obj/item/clothing/hands/gloves/colored/padded/brown/left,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/weapon/melee/null_rod,
		/obj/item/weapon/ranged/magic/staff/fire,
		/obj/item/weapon/ranged/magic/tome/crystal,
	)