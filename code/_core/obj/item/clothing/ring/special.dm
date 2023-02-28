/obj/item/clothing/ring/gold/ring_of_god
	name = "ring of God"
	desc_extended ="A glorious ambrosia ring, crafted by god himself. Increases armor."
	armor = /armor/ring/god
	value_burgerbux = 1

/obj/item/clothing/ring/gold/wedding
	name = "wedding ring"
	desc_extended = "Wuv. Twu Wuv."
	armor = /armor/ring/wedding

//Horsemen rings
/obj/item/clothing/ring/horsemen/death
	name = "ring of Death"
	desc = "I looked, and behold, a pale horse; and he who sat on it had the name Death..."
	desc_extended = "A ring of one of the four horsemen."
	armor = /armor/ring/death

/obj/item/clothing/ring/horsemen/war
	name = "ring of War"
	desc = "Ragnarok is upon ye."
	desc_extended = "A ring of one of the four horsemen."
	armor = /armor/ring/war

/obj/item/clothing/ring/horsemen/conquest
	name = "ring of Conquest"
	desc = "Veni,Vidi,Vici"
	desc_extended = "A ring of one of the four horsemen."
	armor = /armor/ring/conquest

/obj/item/clothing/ring/horsemen/famine
	name = "ring of Famine"
	desc = "Spare change?"
	desc_extended = "A ring of one of the four horsemen."
	armor = /armor/ring/famine

/obj/item/clothing/ring/copper/unarmed_booster
	name = "ring of the unarmed"
	desc = "For one with nothing."
	desc_extended = "A special ring that significantly boosts your unarmed skill."

	mob_values_add = list(
		SKILL_UNARMED = 25
	)

	rarity = RARITY_LEGENDARY

/obj/item/clothing/ring/copper/unarmed_booster/get_base_value()
	. = ..()
	. += 6000