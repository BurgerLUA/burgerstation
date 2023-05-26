/obj/item/clothing/mask/
	worn_layer = LAYER_MOB_CLOTHING_MASK
	item_slot = SLOT_FACE


	protected_limbs = list(BODY_HEAD)

	item_slot_layer = 3

	uses_until_condition_fall = 300


/obj/item/clothing/mask/proc/mod_speech(var/mob/living/advanced/caller,var/text_to_say,var/talk_type_to_use = TEXT_TALK, var/talk_range=TALK_RANGE,var/language_to_use=null)
	return text_to_say