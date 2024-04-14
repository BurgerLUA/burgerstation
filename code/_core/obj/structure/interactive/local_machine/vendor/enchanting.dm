/obj/structure/interactive/vending/magic/enchanting
	name = "enchanting vendor"
	desc = "Absolutely magic!"
	desc_extended = "An almost cartoonish vendor of magical equipment and gear for the aspiring enchanter."
	icon_state = "enchanting"

	stored_types = list(
		/obj/item/paper/book/enchanting_guide,
		/obj/item/paper/book/enchanting/soul_trap,
		/obj/item/enchanting_chalk,
		/obj/item/soulgem/common,
		/obj/item/weapon/melee/sword/cult_dagger,
		/obj/item/ability_learner/soul_trap
	)

	accepts_item = /obj/item/currency/gold_coin


/obj/structure/interactive/vending/magic/spellgem
	name = "spellgem vendor"
	desc = "Absolutely magic!"
	desc_extended = "An almost cartoonish vendor of magical equipment and gear for the aspiring wizard. Only accepts gold coins!"
	icon_state = "MagiVend"

	stored_types = list(
		/obj/item/weapon/ranged/wand/branch{sockets=2}
	)

	accepts_item = /obj/item/currency/gold_coin

/obj/structure/interactive/vending/magic/spellgem/Initialize() //Adds all the cheap support and spellgems.

	. = ..()

	for(var/k in subtypesof(/obj/item/weapon/ranged/spellgem))
		var/obj/item/weapon/ranged/spellgem/S = k
		if(rarity_to_number[initial(S.rarity)] > rarity_to_number[RARITY_UNCOMMON])
			continue
		if(SSbalance.stored_value[S] && SSbalance.stored_value[S] <= 1500)
			stored_types += S

	for(var/k in subtypesof(/obj/item/supportgem))
		var/obj/item/supportgem/S = k
		if(rarity_to_number[initial(S.rarity)] > rarity_to_number[RARITY_UNCOMMON])
			continue
		if(SSbalance.stored_value[S] && SSbalance.stored_value[S] <= 1500)
			stored_types += S


/obj/structure/interactive/vending/magic/magicdrobe
	name = "magicdrobe vendor"
	desc = "Absolutely magic!"
	desc_extended = "An almost cartoonish vendor of magical equipment and gear for the aspiring wizard."
	icon_state = "wizard_drobe"

	stored_types = list(
		/obj/item/clothing/feet/socks/knee,
		/obj/item/clothing/underbottom/underwear/boxers/heart,
		/obj/item/clothing/undertop/underwear/shirt,
		/obj/item/clothing/pants/shorts/brown,
		/obj/item/clothing/shirt/normal/tee,
		/obj/item/storage/shoebox/sandal/,
		/obj/item/clothing/back/storage/satchel/poly/grey,
		/obj/item/clothing/back/storage/dufflebag/poly/grey,
		/obj/item/clothing/back/storage/backpack/poly/grey,
		/obj/item/storage/pouch/single/brown,
		/obj/item/storage/pouch/double/brown,
		/obj/item/storage/pouch/triple/brown,
		/obj/item/clothing/belt/storage/colored/brown,
		/obj/item/clothing/head/hat/wizard/brown,
		/obj/item/clothing/overwear/coat/wizard/blue,
		/obj/item/clothing/neck/tie/red,
		/obj/item/weapon/melee/sword/allium,
		/obj/item/weapon/melee/torch,
		/obj/item/crafting_bench/alchemy
	)

	accepts_item = /obj/item/currency/gold_coin
