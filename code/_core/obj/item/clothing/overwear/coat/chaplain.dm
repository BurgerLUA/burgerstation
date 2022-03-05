/obj/item/clothing/overwear/coat/chaplain
	name = "priest garb"
	icon = 'icons/obj/item/clothing/suit/religious.dmi'

	desc = "Ultra fancy!"
	desc_extended = "Protects against magic attacks."

	armor = /armor/holy/garb
	size = SIZE_3


	value = 90

/obj/item/clothing/overwear/coat/chaplain/witchunter
	name = "witchunter garb"
	icon = 'icons/obj/item/clothing/suit/witchunter.dmi'

	desc = "Do not react."
	desc_extended = "Once worn by those driven by zealous delusion, this suit has felt more than its fair share of warmth."

	dynamic_inventory_count = 1 //to store your bible
	armor = /armor/leather/antimage


	protected_limbs = list(BODY_TORSO,BODY_GROIN,BODY_ARM_LEFT,BODY_ARM_RIGHT) //visibly covers these parts. Adding more would increase the weight TOO much.
	size = SIZE_3


	value = 2000
