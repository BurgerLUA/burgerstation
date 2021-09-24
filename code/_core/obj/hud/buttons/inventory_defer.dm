//This mimicks an inventory object. Used for examing mob's items.

/obj/hud/button/inventory_defer
	name = "inventory"
	var/obj/hud/inventory/referencing
	var/obj/hud/button/close_inventory_defers/assoc_button
	layer = 0

/obj/hud/button/inventory_defer/Destroy()
	referencing = null
	if(assoc_button)
		assoc_button.update_owner(null)
		assoc_button = null
	. = ..()

/obj/hud/button/inventory_defer/proc/get_top_vis_object()

	var/contents_length = length(vis_contents)

	if(!contents_length)
		return null

	return vis_contents[contents_length]

/obj/hud/button/inventory_defer/get_examine_list(var/mob/examiner)
	var/obj/item/I = get_top_vis_object()
	if(I)
		return I.get_examine_list(examiner)
	else if(referencing)
		return referencing.get_examine_list(examiner)
	. = ..()

/obj/hud/button/inventory_defer/get_examine_details_list(var/mob/examiner)
	var/obj/item/I = get_top_vis_object()
	if(I)
		return I.get_examine_details_list(examiner)
	else if(referencing)
		return referencing.get_examine_details_list(examiner)
	. = ..()

/obj/hud/button/inventory_defer/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!referencing)
		CRASH_SAFE("Warning: Referenced item not detected!")
		return TRUE

	update_vis_contents()

	var/obj/item/top_object = get_top_vis_object()
	if(!top_object)
		caller.to_chat(span("warning","There is nothing to strip!"))
		return FALSE

	top_object.try_strip(caller)

	return TRUE

/obj/hud/button/inventory_defer/proc/update_vis_contents()

	vis_contents.Cut()

	if(referencing)
		for(var/k in referencing.contents)
			vis_contents += k

	return TRUE

/obj/hud/button/inventory_defer/proc/update()
	if(referencing) clone(referencing)
	return TRUE


/obj/hud/button/inventory_defer/proc/clone(var/obj/hud/inventory/I)

	referencing = I

	name = referencing.name
	desc = referencing.desc
	desc_extended = referencing.desc_extended

	update_vis_contents()

	HOOK_ADD("update_stats","update_stats_\ref[src]",I,src,.proc/update)

	return TRUE


/obj/hud/button/inventory_defer/update_owner(var/mob/desired_owner)

	assoc_button?.update_owner(desired_owner)

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.inventory_defers -= src

	. = ..()

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		A.inventory_defers |= src