/ability/magic/summon_item

	var/obj/item/item_to_summon

/ability/magic/summon_item/on_cast(var/mob/activator,var/atom/target,location,params)

	. = ..()

	if(is_advanced(activator))
		var/mob/living/advanced/A = activator
		var/obj/item/I = new item_to_summon(get_turf(activator))
		I.can_save = FALSE //Just in case.
		INITIALIZE(I)
		GENERATE(I)
		FINALIZE(I)
		if(A.put_in_hands(I))
			I.delete_on_drop = TRUE
		else
			qdel(I)
