/loadout/syndicate/
	id = "syndicate"
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/shirt/syndicate,
		/obj/item/clothing/pants/syndicate,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left
	)

/loadout/syndicate/pre_add(var/mob/living/advanced/A,var/obj/item/I)
	if(istype(I,/obj/item/weapon/ranged/))
		var/obj/item/weapon/ranged/R = I
		R.firing_pin = /obj/item/firing_pin/electronic/iff/syndicate
	return ..()


/loadout/syndicate/soldier
	id = "syndicate_soldier"
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
		/obj/item/clothing/glasses/sun,
		/obj/item/clothing/belt/storage/colored/black/filled/syndicate/pistol,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie,
		/obj/item/weapon/melee/energy/sword/katana

	)

/loadout/syndicate/hardsuit
	id = "syndicate_hardsuit"
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/shirt/syndicate,
		/obj/item/clothing/pants/syndicate,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/overwear/armor/hardsuit/syndie
	)

/loadout/syndicate/hardsuit/advanced
	id = "syndicate_hardsuit_advanced"
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/shirt/syndicate,
		/obj/item/clothing/pants/syndicate,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/overwear/armor/hardsuit/syndie/advanced
	)

/loadout/syndicate/hardsuit/elite
	id = "syndicate_hardsuit_elite"
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/shirt/syndicate,
		/obj/item/clothing/pants/syndicate,
		/obj/item/clothing/feet/shoes/black_boots,
		/obj/item/clothing/feet/shoes/black_boots/left,
		/obj/item/clothing/overwear/armor/hardsuit/syndie/elite
	)