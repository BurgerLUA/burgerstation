/obj/item/organ/
	name = "ORGAN"
	desc = "An organ."

	icon = 'icons/mob/living/advanced/species/human.dmi'
	icon_state = null
	var/has_dropped_icon = FALSE
	var/has_dropped_icon_underlay = FALSE

	var/damage_icon = 'icons/mob/living/advanced/overlays/damage_organs.dmi'

	var/flags_organ = FLAG_ORGAN_NONE

	health_max = 10
	var/break_threshold = 0 //0 Means it doesn't break. Other values means it breaks.

	//appearance_flags = LONG_GLIDE | KEEP_TOGETHER | RESET_COLOR

	var/attach_flag //The organ type that it wishes to attach to. Use FLAG_ORGAN_ flags.
	var/obj/item/organ/attached_organ //The organ that it is attached to.
	var/list/obj/item/organ/attached_organs //The organs that are attached to it.
	var/attach_method = 0 //0 Means it's attached to it. 1 means inside it. TODO: Flags.

	var/style

	color = "#FFFFFF"

	no_held_draw = TRUE

	var/enable_skin = TRUE
	var/enable_glow = FALSE
	var/enable_detail = FALSE
	var/enable_wounds = FALSE

/obj/item/organ/get_examine_text(var/mob/examiner)
	. = ..()
	for(var/wound/W in wounds)
		W.update_name()
		. += span("notice",W.name)

	return .

/obj/item/organ/initialize_blends()

	if(enable_skin)
		add_blend("skin", desired_color = "#FF0000", desired_blend = ICON_MULTIPLY, desired_type = ICON_BLEND_COLOR, desired_should_save = TRUE)

	if(enable_glow)
		add_blend("skin_glow", desired_icon = icon, desired_icon_state = "[icon_state]_glow", desired_color = "#888888", desired_blend = ICON_MULTIPLY, desired_type = ICON_BLEND_COLOR, desired_should_save = TRUE)

	if(enable_detail)
		add_blend("skin_detail", desired_icon = icon, desired_icon_state = "[icon_state]_detail", desired_color = "#888888", desired_blend = ICON_MULTIPLY, desired_type = ICON_BLEND_COLOR, desired_should_save = TRUE)

	if(enable_wounds)
		add_blend("skin_bruises", desired_icon = damage_icon, desired_icon_state = "0", desired_color = "#FFFFFF", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_MASK | ICON_BLEND_OVERLAY)
		//add_blend("skin_cuts", desired_icon = damage_icon, desired_icon_state = "cuts", desired_color = "#888888", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_COLOR | ICON_BLEND_MASK | ICON_BLEND_EXTERNAL_ONLY)
		//add_blend("skin_burns", desired_icon = damage_icon, desired_icon_state = "burns", desired_color = "#888888", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_COLOR | ICON_BLEND_MASK | ICON_BLEND_EXTERNAL_ONLY)


	..()

/obj/item/organ/New()
	..()
	attached_organs = list()
	wounds = list()
	initialize_blends()

/obj/item/organ/proc/attach_to(var/obj/item/organ/O)
	attached_organ = O
	O.attached_organs += src

/obj/item/organ/proc/unattach_from_parent(var/turf/T)

	if(inventories)
		for(var/v in inventories)
			var/obj/inventory/I = v
			I.drop_all_objects(T)

	if(attached_organ)
		attached_organ.attached_organs -= src
		attached_organ = null

	for(var/obj/item/organ/O in attached_organs)
		O.unattach_from_parent(T)

	if(T)
		if(is_advanced(src.loc))
			var/mob/living/advanced/A = src.loc
			A.remove_organ(src,FALSE,FALSE)
		src.force_move(T)

	update_icon()
	queue_delete(src,600)

/obj/item/organ/proc/unattach_children(var/turf/T)
	for(var/obj/item/organ/O in attached_organs)
		O.unattach_from_parent(T)

/obj/item/organ/proc/gib()
	var/turf/T = get_turf(src.loc)
	var/mob/living/advanced/A

	if(is_advanced(src.loc))
		A = src.loc
		A.remove_organ(src,TRUE,FALSE)

	unattach_from_parent(T)
	unattach_children(T)

	if(A) //A might've gotten removed here
		A.update_icon()

	//new /obj/effect/gibs/random/(T,"#FF0000",color_secondary) TODO COLOR
	qdel(src)

/obj/item/organ/update_icon()
	var/is_attached_to = is_advanced(src.loc)
	if(!is_attached_to && has_dropped_icon)
		icon_state = "[initial(icon_state)]_inventory"
		if(has_dropped_icon_underlay)
			var/icon/I = new /icon(icon,icon_state)
			var/icon/U = new /icon(icon,"[icon_state]_underlay")
			I.Blend(U,ICON_UNDERLAY)
			icon = I

/obj/item/organ/update_health(var/damage_dealt)

	var/brute_loss = get_brute_loss()

	/*
	if(health_max - brute_loss <= 0 && damage_dealt >= health_max*0.5 && flags_organ & flags_organ )
		gib()
		return
	*/

	if(enable_wounds && src.loc)
		var/scale = floor((brute_loss/health_max)*5)
		change_blend("skin_bruises", desired_icon_state = "[scale]")
		update_icon()
		src.loc.update_icon()

	if(break_threshold)
		if(!(flags_organ & FLAG_ORGAN_BROKEN) && brute_loss >= break_threshold)
			if(src.loc)
				src.loc.visible_message(\
					span("danger","You hear a cracking sound coming from \the [src.loc]'s [name]!"),\
					span("danger","You hear a cracking sound coming from your [name]!"),\
					span("danger","You hear a cracking sound!")\
				)
			flags_organ |= FLAG_ORGAN_BROKEN

	..()

