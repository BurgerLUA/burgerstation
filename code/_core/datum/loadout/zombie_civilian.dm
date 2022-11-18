/loadout/zombie/civilian
	var/list/possible_shirt = list()
	var/list/possible_pants = list()
	var/list/possible_socks = list()
	var/seed = 0

/loadout/zombie/civilian/male
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/boxers,
		/obj/item/clothing/feet/shoes/colored,
		/obj/item/clothing/feet/shoes/colored/left,
		/obj/item/clothing/back/storage/satchel/poly/zombie,
		/obj/item/storage/wallet/random_colonist
	)
	possible_shirt = list(
		/obj/item/clothing/shirt/normal = 8,
		/obj/item/clothing/undertop/underwear/shirt = 2
	)
	possible_pants = list(
		/obj/item/clothing/pants/normal = 1
	)
	possible_socks = list(
		/obj/item/clothing/feet/socks/ankle = 7,
		/obj/item/clothing/feet/socks/knee = 2
	)

/loadout/zombie/civilian/female
	spawning_items = list(
		/obj/item/clothing/underbottom/underwear/panty,
		/obj/item/clothing/undertop/underwear/bra,
		/obj/item/clothing/feet/shoes/colored,
		/obj/item/clothing/feet/shoes/colored/left,
		/obj/item/clothing/back/storage/satchel/poly/zombie,
		/obj/item/storage/wallet/random_colonist
	)
	possible_shirt = list(
		/obj/item/clothing/shirt/normal = 8,
		/obj/item/clothing/shirt/blouse = 2
	)
	possible_pants = list(
		/obj/item/clothing/pants/normal = 8,
		/obj/item/clothing/pants/skirt = 2
	)
	possible_socks = list(
		/obj/item/clothing/feet/socks/ankle = 7,
		/obj/item/clothing/feet/socks/knee = 2,
		/obj/item/clothing/feet/socks/thigh = 1
	)


/loadout/zombie/civilian/get_spawning_items()

	. = list()

	if(length(possible_socks))
		var/chosen_sock = pickweight(possible_socks)
		. += chosen_sock
		. += chosen_sock

	. += ..()

	if(length(possible_shirt))
		. += pickweight(possible_shirt)

	if(length(possible_pants))
		. += pickweight(possible_pants)

	if(prob(20))
		. += /obj/item/clothing/overwear/coat/polymorphic

/loadout/zombie/civilian/pre_add(var/mob/living/advanced/A,var/obj/item/I)
	. = ..()
	var/p_length = length(I.polymorphs)
	if(p_length && I.item_slot_layer > 1)
		var/turf/T = get_turf(I)
		var/pseudo_rand_num = T.x + T.y + T.z + p_length + length(I.desc)
		for(var/k in I.polymorphs)
			I.polymorphs[k] = rgb(PSUEDO_RAND(pseudo_rand_num + T.x*pseudo_rand_num,0,255),PSUEDO_RAND(pseudo_rand_num + T.y*pseudo_rand_num,0,255),PSUEDO_RAND(pseudo_rand_num + (T.x + T.y)*pseudo_rand_num,0,255))
