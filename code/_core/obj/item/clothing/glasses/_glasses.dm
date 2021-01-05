/obj/item/clothing/glasses/
	worn_layer = LAYER_MOB_CLOTHING_EYE
	item_slot = SLOT_EYES

	protected_limbs = list(BODY_HEAD)

	size = SIZE_0


	var/vision_mod = FLAG_VISION_NONE
	var/sight_mod = 0x0
	var/see_invisible = 0
	var/see_in_dark = 0

	blocks_clothing = SLOT_EYES | SLOT_FACE_WRAP


/obj/item/clothing/glasses/get_base_value()

	. = ..()

	if(vision_mod & FLAG_VISION_MEDICAL)
		. += 100
	if(vision_mod & FLAG_VISION_SECURITY)
		. += 200
	if(vision_mod & FLAG_VISION_DIAGNOSTIC)
		. += 100
	if(vision_mod & FLAG_VISION_MEDICAL_ADVANCED)
		. += 200

	if(sight_mod & SEE_MOBS)
		. += 500
	if(sight_mod & SEE_OBJS)
		. += 200
	if(sight_mod & SEE_TURFS)
		. += 200
	if(sight_mod & SEE_THRU)
		. += 500
	if(sight_mod & BLIND)
		. += 50

	. += see_invisible*10

	. += (see_in_dark/VIEW_RANGE)*500

	return .