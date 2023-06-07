/obj/item/clothing/overwear/armor/spec_ops
	name = "special operative vest"
	desc = "Lightweight and durable."
	desc_extended = "A composite kevlar durathread weave used only by the best of the best in tactical operations."

	icon = 'icons/obj/item/clothing/suit/stealth.dmi'

	size = SIZE_4

	armor = /armor/military/heavy

	protected_limbs = list(BODY_TORSO,BODY_ARM_LEFT,BODY_ARM_RIGHT)

	dyeable = TRUE

	rarity = RARITY_RARE

/obj/item/clothing/overwear/armor/spec_ops/calculate_weight()
	. = ..()
	. *= 0.5
	. = CEILING(.,1)

/obj/item/clothing/overwear/armor/spec_ops/get_base_value()
	. = ..()
	. *= 1.5
	. = CEILING(.,1)

/obj/item/clothing/overwear/armor/spec_ops/black
	color = COLOR_BLACK

