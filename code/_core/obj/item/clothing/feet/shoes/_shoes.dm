/obj/item/clothing/feet/shoes/
	name = "shoes"
	desc = "Look at my kicks, bro! Sick kicks!"
	desc_extended = "Protects your feet from the harsh enviroment in the world."

	flags_clothing = FLAG_CLOTHING_NOBEAST_FEET

	worn_layer = LAYER_MOB_CLOTHING_SHOES

	drop_sound = 'sound/items/drop/boots.ogg'

	speed_bonus = 0.05 //5% faster per shoe.

	//By default, it's a right foot item.
	item_slot = SLOT_FOOT
	item_slot_mod = SLOT_MOD_RIGHT
	protected_limbs = list(BODY_FOOT_RIGHT)

	item_slot_layer = 2

