/obj/item/clothing/head/helmet/full/blob_spore
	name = "blob spore"
	icon = 'icons/obj/item/clothing/hats/blob.dmi'
	desc = "OH GOD ITS EATING MY BRAINS."
	desc_extended = "A very dangerous blob spore that appears attached to a head. Should probably remove this before your brains get eaten."

	worn_layer = LAYER_MOB_BLOB

	size = SIZE_5

	value = -1

	item_slot_layer = 3

	var/next_feed = 0

	var/damage_ramp = 0

	can_save = FALSE

	var/inert = FALSE

	no_drop = TRUE

/obj/item/clothing/head/helmet/full/blob_spore/can_be_dragged(var/mob/caller)
	return FALSE

/obj/item/clothing/head/helmet/full/blob_spore/proc/can_remove_blob(var/mob/caller)
	INTERACT_CHECK_NO_DELAY(src)
	return TRUE

/obj/item/clothing/head/helmet/full/blob_spore/proc/remove_blob(var/mob/caller,var/messsage=TRUE)
	if(messsage && caller) caller.visible_message(span("notice","\The [caller.name] successfully removes \the [src.name]!"),span("notice","You sucessfully remove \the [src.name]!"))
	var/turf/T = get_turf(caller ? caller : src)
	if(T)
		var/mob/living/simple/blob_spore/BS = new(T)
		INITIALIZE(BS)
		GENERATE(BS)
		FINALIZE(BS)
		if(caller)
			BS.ai.set_objective(caller)
		else
			BS.ai.set_active(TRUE)
		BS.add_status_effect(STUN,30,30,stealthy=TRUE) //So it doesn't latch immediately after being removed.
	qdel(src)
	return TRUE

/obj/item/clothing/head/helmet/full/blob_spore/click_self(var/mob/caller)
	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(5),.proc/remove_blob,caller)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_remove_blob,caller)
	return TRUE

/obj/item/clothing/head/helmet/full/blob_spore/think()

	if(!is_inventory(src.loc))
		remove_blob()
		return FALSE

	var/obj/hud/inventory/I = src.loc

	if(!is_advanced(I.owner) || !is_organ(I.loc))
		remove_blob()
		return FALSE

	var/mob/living/advanced/A = I.owner
	var/obj/item/organ/O = I.loc

	if(O.id != BODY_HEAD)
		remove_blob()
		return FALSE

	if(A.has_status_effect(ZOMBIE))
		remove_blob()
		return FALSE

	if(inert)
		if(next_feed <= world.time)
			A.add_status_effect(ZOMBIE,100,-1)
			remove_blob()
		return TRUE

	if(next_feed <= world.time)
		var/turf/T = get_turf(src)
		if(O.health.adjust_loss_smart(brute=damage_ramp))
			damage_ramp += 2
			play_sound('sound/effects/blob_infection.ogg',T)
			if(A.blood_type)
				var/reagent/R = REAGENT(A.blood_type)
				for(var/i=1,i<=2,i++)
					create_blood(/obj/effect/cleanable/blood/splatter,T,R.color,rand(-TILE_SIZE,TILE_SIZE),rand(-TILE_SIZE,TILE_SIZE))
		next_feed = world.time + SECONDS_TO_DECISECONDS(1)

	if(A.ai && !A.is_busy() && prob(25))
		click_self(A)

	. = ..()

	if(A.dead)
		inert = TRUE
		next_feed = world.time + SECONDS_TO_DECISECONDS(10)



/obj/item/clothing/head/helmet/full/blob_spore/pre_pickup(var/atom/old_location,var/obj/hud/inventory/new_location)

	. = ..()

	if(inert)
		qdel(src)
		return .

	damage_ramp = 0

	if(new_location && is_advanced(new_location.owner))
		new_location.owner.visible_message(span("warning","\The [src.name] consumes \the [new_location.owner.name]'s [new_location.loc.name]!"),span("danger","\The [src.name] tries to consume your [new_location.loc.name]! GET IT OFF!"))
		start_thinking(src)
	else
		stop_thinking(src)
