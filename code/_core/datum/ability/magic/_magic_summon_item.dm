/ability/magic/summon_item

	var/obj/item/item_to_summon

/ability/magic/summon_item/on_cast(mob/caller,atom/target,location,params)

	. = ..()

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/obj/item/I = new item_to_summon(get_turf(caller))
		I.can_save = FALSE //Just in case.
		INITIALIZE(I)
		GENERATE(I)
		FINALIZE(I)
		if(A.put_in_hands(I))
			I.delete_on_drop = TRUE
		else
			qdel(I)
