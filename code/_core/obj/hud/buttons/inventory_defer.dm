//This mimicks an inventory object. Used for examing mob's items.

/obj/hud/button/inventory_defer
	name = "inventory"
	icon_state = "square_round"
	var/obj/hud/inventory/referencing
	var/obj/hud/button/close_inventory_defers/assoc_button
	layer = 0

/obj/hud/button/inventory_defer/PreDestroy()
	if(assoc_button)
		assoc_button.update_owner(null)
		assoc_button = null
	if(referencing)
		HOOK_REMOVE("update_stats","update_stats_\ref[src]",referencing)
		referencing = null
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

	if(!referencing) CRASH("Referenced inventory not found!")

	if(!is_inventory(object))
		return FALSE

	var/obj/hud/inventory/I = object //We clicked on this.

	update_vis_contents()

	var/obj/item/top_object = get_top_vis_object()
	if(!top_object)
		caller.to_chat(span("warning","There is nothing to remove!"))
		return FALSE

	if(is_organ(referencing.loc))
		if(referencing.owner && referencing.owner.ckey_owner == caller.ckey_owner)
			I.add_object(top_object)
			return TRUE
		top_object.try_strip(caller)
		return TRUE

	if(get_dist(caller,top_object) <= 1)
		I.add_object(top_object)
		return TRUE

	return FALSE

/obj/hud/button/inventory_defer/proc/update_vis_contents()

	vis_contents.Cut()

	if(referencing)
		for(var/k in referencing.contents)
			vis_contents += k

	return TRUE

/obj/hud/button/inventory_defer/proc/update()

	if(get_dist(owner,referencing) >= 3)
		update_owner(null)
		return TRUE

	if(referencing)
		clone(referencing)
	else
		name = initial(name)
		desc_extended = initial(desc_extended)

	tooltip_text = initial(tooltip_text)
	if(!tooltip_text)
		tooltip_text = generate_tooltip_text()

	return TRUE

var/global/list/greyscale = list(
	0.5,0.25,0.25,0,
	0.25,0.5,0.25,0,
	0.25,0.25,0.5,0,
	0,0,0,1
)

var/global/list/redscale = list(
	0.5,0.25,0.25,0,
	0.33,0.5,0.25,0,
	0.33,0.25,0.5,0,
	0,0,0,1
)


/obj/hud/button/inventory_defer/proc/clone(var/obj/hud/inventory/I)

	referencing = I

	name = referencing.name
	desc = referencing.desc
	desc_extended = referencing.desc_extended

	update_vis_contents()

	var/desired_color = "#FFFFFF"
	var/obj/item/top_object = src.get_top_vis_object()
	if(top_object)
		if(is_organ(top_object.loc))
			if(!top_object.can_strip(owner))
				desired_color = greyscale
			else
				desired_color = "#FFFFFF"
		else
			if(get_dist(owner,top_object) > 1)
				desired_color = greyscale
			else
				desired_color = "#FFFFFF"

	animate(src,color=desired_color,time=SECONDS_TO_DECISECONDS(1))

	HOOK_ADD("update_stats","update_stats_\ref[src]",I,src,src::update()) //This doesn't need to be removed in another call.

	return TRUE

/obj/hud/button/inventory_defer/update_owner(var/mob/desired_owner)

	assoc_button?.update_owner(desired_owner)

	var/owner_changed = owner != desired_owner

	if(owner_changed && is_advanced(owner)) //Old owner
		var/mob/living/advanced/A = owner
		A.inventory_defers -= src
		HOOK_REMOVE("grab_changed","grab_changed_\ref[src]",A)
		HOOK_REMOVE("post_move","update_stats_\ref[src]",A)

	. = ..()

	if(owner_changed && is_advanced(owner)) //New owner
		var/mob/living/advanced/A = owner
		A.inventory_defers += src
		HOOK_ADD("grab_changed","grab_changed_\ref[src]",A,src,src::update())
		HOOK_ADD("post_move","update_stats_\ref[src]",A,src,src::update())