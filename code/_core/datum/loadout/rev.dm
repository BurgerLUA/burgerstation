/loadout/rev/
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

	return ..()