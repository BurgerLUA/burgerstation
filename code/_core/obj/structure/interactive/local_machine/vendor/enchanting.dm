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
		/obj/item/weapon/melee/sword/cult_dagger
	)

	accepts_item = /obj/item/currency/gold_coin


/obj/structure/interactive/vending/magic/spellgem
	name = "spellgem vendor"
	desc = "Absolutely magic!"
	desc_extended = "An almost cartoonish vendor of magical equipment and gear for the aspiring wizard."
	icon_state = "MagiVend"

	stored_types = list(
		/obj/item/weapon/ranged/wand/branch{sockets=2},

		/obj/item/weapon/ranged/spellgem/arcblades,
		/obj/item/weapon/ranged/spellgem/chaos,
		/obj/item/weapon/ranged/spellgem/crystal,
		/obj/item/weapon/ranged/spellgem/fire_spear,
		/obj/item/weapon/ranged/spellgem/fireball,
		/obj/item/weapon/ranged/spellgem/flame,
		/obj/item/weapon/ranged/spellgem/fractal,
		/obj/item/weapon/ranged/spellgem/frost,
		/obj/item/weapon/ranged/spellgem/holy_cross,
		/obj/item/weapon/ranged/spellgem/ice_spear,
		/obj/item/weapon/ranged/spellgem/inferno,
		/obj/item/weapon/ranged/spellgem/lightning,
		/obj/item/weapon/ranged/spellgem/magic_missile,
		/obj/item/weapon/ranged/spellgem/shock,
		/obj/item/weapon/ranged/spellgem/tesla,

		/obj/item/weapon/ranged/spellgem/buff_armor,
		/obj/item/weapon/ranged/spellgem/projectile_armor,

		/obj/item/supportgem/cost,
		/obj/item/supportgem/damage,
		/obj/item/supportgem/spread,
		/obj/item/supportgem/overkill,
		/obj/item/supportgem/speed,
		/obj/item/supportgem/precision
	)

	accepts_item = /obj/item/currency/gold_coin


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
