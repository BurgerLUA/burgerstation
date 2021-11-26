/obj/item/clothing/head/helmet/full/blob_spore
	name = "blob spore"
	icon = 'icons/obj/item/clothing/hats/blob.dmi'
	desc = "Oh no."
	desc_extended = "A very dangerous blob spore that appears attached to a head. Should probably remove this before things get worse."

	worn_layer = LAYER_MOB_HAIR_ABOVE

	defense_rating = list()

	size = SIZE_5

	value = -1

	item_slot_layer = 3

/obj/item/clothing/head/helmet/full/blob_spore/can_be_dragged(var/mob/caller)
	return FALSE

/obj/item/clothing/head/helmet/full/blob_spore/proc/can_remove_blob(var/mob/caller)
	INTERACT_CHECK_NO_DELAY(src)
	return TRUE

/obj/item/clothing/head/helmet/full/blob_spore/proc/remove_blob(var/mob/caller)
	caller.visible_message(span("notice","\The [caller.name] successfully removes \the [src.name]!"),span("notice","You sucessfully remove \the [src.name]!"))
	var/turf/T = get_turf(caller)
	if(T)
		var/mob/living/simple/blob_spore/BS = new(T)
		INITIALIZE(BS)
		GENERATE(BS)
		FINALIZE(BS)
		BS.ai.set_active(TRUE)
	qdel(src)
	return TRUE

/obj/item/clothing/head/helmet/full/blob_spore/click_self(var/mob/caller)
	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(5),.proc/remove_blob,caller)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_remove_blob,caller)
	return TRUE

/obj/item/clothing/head/helmet/full/blob_spore/think()

	if(!is_inventory(src.loc))
		return FALSE

	var/obj/hud/inventory/I = src.loc

	if(!is_advanced(I.owner) || !is_organ(I.loc))
		return FALSE

	var/mob/living/advanced/A = I.owner
	var/obj/item/organ/O = I.loc

	if(A.has_status_effect(ZOMBIE))
		return FALSE

	if(prob(10))
		O.health.adjust_loss_smart(tox=5,brute=5)

	. = ..()

	if(A.dead)
		A.add_status_effect(ZOMBIE,100,-1)
		return FALSE

/obj/item/clothing/head/helmet/full/blob_spore/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	if(new_location && is_advanced(new_location.owner))
		start_thinking(src)
	else
		stop_thinking(src)
