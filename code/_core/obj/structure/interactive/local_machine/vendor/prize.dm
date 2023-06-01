/obj/structure/interactive/vending/prize
	name = "prize vendor"
	icon_state = "prize"
	desc = "It's not pointless, I swear."
	desc_extended = "A special prize vendor that converts arcade prize tickets into items."

	accepts_item = /obj/item/currency/prize_ticket

	stored_types = list(
		/obj/item/bikehorn,
		/obj/item/ball/soccer,
		/obj/item/dice/d6,
		/obj/item/dice/d20,
		/obj/item/clothing/mask/mime,
		/obj/item/broom/magic,
		/obj/item/grenade/device/large/timed/lube_smoke,
		/obj/item/clothing/overwear/armor/burger_coat,
		/obj/item/clothing/overwear/armor/burger_coat/courier,
		/obj/item/clothing/overwear/armor/burger_coat/courier/ncr,
		/obj/item/clothing/overwear/armor/burger_coat/courier/legion,
		/obj/item/clothing/overwear/armor/burger_coat/courier/ulysses,
		/obj/item/weapon/melee/flagpole
	)

	ignore_economy = TRUE