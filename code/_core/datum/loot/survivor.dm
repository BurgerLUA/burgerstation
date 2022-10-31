/loot/survivor
	var/chance_blood = 0
	var/chance_quality = 0
	var/apply_poly = FALSE

/loot/survivor/pre_spawn(var/atom/movable/M)

	if(istype(M,/obj/item/clothing/))
		var/obj/item/clothing/C = M
		if(apply_poly)
			var/p_length = length(C.polymorphs)
			if(p_length)
				var/turf/T = get_turf(M)
				var/pseudo_rand_num = T.x + T.y + T.z + p_length + length(C.desc)
				for(var/k in C.polymorphs)
					switch(C.item_slot_layer)
						if(1) //Underwear
							C.polymorphs[k] = rgb(PSUEDO_RAND(pseudo_rand_num + T.x*pseudo_rand_num,150,255),PSUEDO_RAND(pseudo_rand_num + T.y*pseudo_rand_num,150,255),PSUEDO_RAND(pseudo_rand_num + (T.x + T.y)*pseudo_rand_num,150,255))
						if(2) //Regular shirt
							C.polymorphs[k] = rgb(PSUEDO_RAND(pseudo_rand_num + T.x*pseudo_rand_num,75,150),PSUEDO_RAND(pseudo_rand_num + T.y*pseudo_rand_num,75,150),PSUEDO_RAND(pseudo_rand_num + (T.x + T.y)*pseudo_rand_num,75,150))
						if(3) //Coat
							C.polymorphs[k] = rgb(PSUEDO_RAND(pseudo_rand_num + T.x*pseudo_rand_num,50,75),PSUEDO_RAND(pseudo_rand_num + T.y*pseudo_rand_num,50,75),PSUEDO_RAND(pseudo_rand_num + (T.x + T.y)*pseudo_rand_num,50,75))
		if(prob(chance_quality))
			C.adjust_quality(rand(0,-50))
		if(prob(chance_blood))
			C.set_bloodstain(rand(2,5),"#880000")

	. = ..()


/loot/survivor/reward
	loot_table = list(
		/obj/item/container/simple/beaker/flask/onion = 50,
		/obj/item/tempering/quality/melee = 70,
		/loot/misc/food = 40,
		/loot/misc/drink = 40,
		/loot/misc/baking = 20,
		/obj/item/container/healing/bandage = 25,
		/obj/item/container/healing/ointment = 25,
		/obj/item/storage/pillbottle/dylovene_small = 25,
		/obj/item/storage/pillbottle/assprin = 25,
		/obj/item/storage/kit/small/filled = 65,
		/obj/item/grenade/fuse/flashbang = 40,
		/loot/scroll/lesser = 20
	)
	loot_count = 4


/loot/survivor/head //hats, masks, ect.
	loot_table = list(
		/obj/item/clothing/head/hat/bandana/red = 100,
		/obj/item/clothing/head/hat/beret/red = 10,
		/obj/item/clothing/head/hat/detective = 10,
		/obj/item/clothing/head/hat/headband/crimson = 20,
		/obj/item/clothing/head/hat/skimask/black = 50,
		/obj/item/clothing/head/helmet/full/cardborg = 1,
		/obj/item/clothing/head/helmet/welding = 50,
		/obj/item/clothing/mask/clown = 10,
		/obj/item/clothing/mask/emoji = 1,
		/obj/item/clothing/mask/gas = 50,
		/obj/item/clothing/mask/gas/glass = 50,
		/obj/item/clothing/mask/sterile = 50
	)
	chance_none = 20
	apply_poly = TRUE
	chance_blood = 50
	chance_quality = 50

/loot/survivor/armor
	loot_table = list(
		/obj/item/clothing/overwear/armor/bulletproof = 100,
		/obj/item/clothing/overwear/armor/medium_armor/black = 50,
		/obj/item/clothing/overwear/armor/molded_armor/black = 50,
		/obj/item/clothing/overwear/armor/shit_armor = 200,
		/obj/item/clothing/overwear/armor/space_cop = 100,
	)
	chance_none = 0
	apply_poly = FALSE
	chance_blood = 50
	chance_quality = 50

/loot/survivor/coat
	loot_table = list(
		/obj/item/clothing/overwear/coat/apron/blue = 10,
		/obj/item/clothing/overwear/coat/apron/blacksmith = 20,
		/obj/item/clothing/overwear/coat/apron = 10,
		/obj/item/clothing/overwear/coat/blazer_blue = 20,
		/obj/item/clothing/overwear/coat/brown = 30,
		/obj/item/clothing/overwear/coat/hoodie/black = 20,
		/obj/item/clothing/overwear/coat/hoodie/grey = 200,
		/obj/item/clothing/overwear/coat/labcoat = 10,
		/obj/item/clothing/overwear/coat/vest/colored/black = 40,
		/obj/item/clothing/overwear/coat/vest/colored/brown = 40,
		/obj/item/clothing/overwear/coat/vest/webbing = 100,
		/obj/item/clothing/overwear/coat/vest/sleeveless_leather_jacket = 20,
		/obj/item/clothing/overwear/coat/winter = 20,
		/obj/item/clothing/overwear/coat/winter/bomber = 20,
	)
	chance_none = 20
	apply_poly = FALSE
	chance_blood = 50
	chance_quality = 50

/loot/survivor/pants/male
	loot_table_guaranteed = list(
		/obj/item/clothing/underbottom/underwear/boxers,
	)
	loot_table = list(
		/obj/item/clothing/pants/normal = 100,
		/obj/item/clothing/pants/normal/striped = 5,
		/obj/item/clothing/pants/shorts = 50,
	)
	chance_none = 0
	apply_poly = TRUE
	chance_blood = 50
	chance_quality = 50

/loot/survivor/pants/female
	loot_table_guaranteed = list(
		/obj/item/clothing/underbottom/underwear/panty,
	)
	loot_table = list(
		/obj/item/clothing/pants/skirt = 25,
		/obj/item/clothing/pants/normal = 100,
		/obj/item/clothing/pants/normal/striped = 5,
		/obj/item/clothing/pants/shorts = 50,
	)
	chance_none = 0
	apply_poly = TRUE
	chance_blood = 50
	chance_quality = 50

/loot/survivor/shirt/male
	loot_table_guaranteed = list(
		/obj/item/clothing/undertop/underwear/shirt
	)
	loot_table = list(
		/obj/item/clothing/shirt/normal = 100,
		/obj/item/clothing/shirt/normal/tee = 50,
		/obj/item/clothing/shirt/normal/uniform = 20,
		/obj/item/clothing/shirt/normal/tee/soccer = 20
	)
	chance_none = 20
	apply_poly = TRUE
	chance_blood = 50
	chance_quality = 50

/loot/survivor/shirt/female
	loot_table_guaranteed = list(
		/obj/item/clothing/undertop/underwear/bra
	)
	loot_table = list(
		/obj/item/clothing/shirt/blouse = 100,
		/obj/item/clothing/shirt/blouse/frill = 50,
		/obj/item/clothing/shirt/blouse/uniform = 20,
		/obj/item/clothing/shirt/normal = 100,
		/obj/item/clothing/shirt/normal/tee = 50,
		/obj/item/clothing/shirt/normal/uniform = 20,
		/obj/item/clothing/shirt/normal/tee/soccer = 20
	)
	chance_none = 0
	apply_poly = FALSE
	chance_blood = 50
	chance_quality = 50


/loot/survivor/socks/male
	loot_table = list(
		/obj/item/clothing/feet/socks/ankle = 100,
		/obj/item/clothing/feet/socks/knee = 20
	)
	loot_count = 2
	chance_none = 5
	apply_poly = FALSE
	chance_blood = 0
	chance_quality = 50

/loot/survivor/socks/female
	loot_table = list(
		/obj/item/clothing/feet/socks/ankle = 100,
		/obj/item/clothing/feet/socks/knee = 20,
		/obj/item/clothing/feet/socks/thigh = 10,
	)
	loot_count = 2
	chance_none = 5
	apply_poly = TRUE
	chance_blood = 0
	chance_quality = 50

/loot/survivor/shoes
	loot_table = list(
		list(/obj/item/clothing/feet/shoes/colored/black,/obj/item/clothing/feet/shoes/colored/black/left) = 100,
		list(/obj/item/clothing/feet/shoes/boot_colored/brown,/obj/item/clothing/feet/shoes/boot_colored/brown/left) = 50,
		list(/obj/item/clothing/feet/shoes/winter,/obj/item/clothing/feet/shoes/winter/left) = 50
	)
	chance_none = 0
	apply_poly = FALSE
	chance_blood = 100
	chance_quality = 50

/loot/survivor/back_storage
	loot_table = list(
		/obj/item/clothing/back/storage/backpack/poly = 100,
		/obj/item/clothing/back/storage/dufflebag/poly = 50,
		/obj/item/clothing/back/storage/satchel/poly = 50

	)
	chance_none = 0
	apply_poly = TRUE
	chance_blood = 0
	chance_quality = 0

/loot/survivor/belt_storage
	loot_table = list(
		/obj/item/clothing/belt/storage/colored/black = 100,
		/obj/item/clothing/belt/storage/colored/brown = 100,
		/obj/item/clothing/belt/storage/medical/filled = 10,
		/obj/item/clothing/belt/storage/tool/filled = 10
	)
	chance_none = 0
	apply_poly = FALSE
	chance_blood = 0
	chance_quality = 0


/loot/survivor/melee
	loot_table = list(
		/obj/item/weapon/melee/axe/fireaxe = 75,
		/obj/item/weapon/melee/energy/chainsaw = 25,
		/obj/item/weapon/melee/spear = 100,
		/obj/item/weapon/melee/sword/butcher_cleaver = 75,
	)
	chance_none = 0
	apply_poly = FALSE
	chance_blood = 100
	chance_quality = 0


/loot/survivor/melee/small
	loot_table = list(
		/obj/item/weapon/unarmed/brass_knuckles = 50,
		/obj/item/weapon/melee/sword/combat_knife = 25,
		/obj/item/weapon/melee/sword/chef_knife = 75,
		/obj/item/weapon/melee/null_rod/dagger = 25,
	)
