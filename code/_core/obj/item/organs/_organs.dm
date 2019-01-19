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

	color = "#FFFFFF"
	var/color_skin = "#FFFFFF"
	var/color_secondary = "#FFFFFF"
	var/color_glow = "#FFFFFF"

	var/enable_color = FALSE
	var/enable_glow = FALSE

	no_held_draw = TRUE

/obj/item/organ/New()
	..()
	attached_organs = list()

/obj/item/organ/proc/attach_to(var/obj/item/organ/O)
	attached_organ = O
	O.attached_organs += src

/obj/item/organ/proc/unattach_from_parent(var/turf/T)
	if(attached_organ)
		attached_organ.attached_organs -= src
		attached_organ = null

	for(var/obj/item/organ/O in attached_organs)
		O.unattach_from_parent(T)

	if(T)
		if(is_advanced(src.loc))
			var/mob/living/advanced/A = src.loc
			A.remove_organ(src,FALSE,FALSE)
		src.loc = T

	update_icon()

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

	new /obj/effect/gibs/random/(T,"#FF0000",color_skin)
	del(src)

/obj/item/organ/update_icon()
	. = ..()

	var/is_attached_to = is_advanced(src.loc)

	if(!is_attached_to && has_dropped_icon)
		icon_state = "[initial(icon_state)]_inventory"

	icon = initial(icon)
	var/icon/base_icon = new /icon(icon,icon_state)
	base_icon.Blend(color_skin,ICON_MULTIPLY)

	if(enable_color)
		var/icon/color_mask = new /icon(icon,"[icon_state]_color")
		color_mask.Blend(color_secondary,ICON_MULTIPLY)
		base_icon.Blend(color_mask,ICON_OVERLAY)

	if(enable_glow)
		var/icon/glow_mask = new /icon(icon,"[icon_state]_glow")
		glow_mask.Blend(color_glow,ICON_MULTIPLY)
		base_icon.Blend(glow_mask,ICON_OVERLAY)

	var/brute_loss = get_brute_loss()
	var/burn_loss = get_burn_loss()

	var/brute_mod = clamp(round((brute_loss/health_max) * 5),0,5)
	var/burn_mod = clamp(round((burn_loss/health_max) * 5),0,5)

	var/icon/limb_mask = new /icon(icon,icon_state)
	limb_mask.Blend("#FFFFFF",ICON_SUBTRACT)

	var/icon/brute_overlay = new /icon(damage_icon,"[brute_mod]")
	brute_overlay.Blend(limb_mask,ICON_ADD)
	brute_overlay.Blend("#FF0000",ICON_MULTIPLY) //Blood color

	var/icon/burn_overlay = new /icon(damage_icon,"[burn_mod]")
	burn_overlay.Blend(limb_mask,ICON_ADD)
	burn_overlay.Blend("#666666",ICON_MULTIPLY) //Burn color

	base_icon.Blend(brute_overlay,ICON_OVERLAY)
	base_icon.Blend(burn_overlay,ICON_OVERLAY)

	if(!is_attached_to && has_dropped_icon_underlay)
		var/icon/underlay = new /icon(icon,"[initial(icon_state)]_inventory_underlay")
		base_icon.Blend(underlay,ICON_UNDERLAY)

	icon = base_icon

	return TRUE

/obj/item/organ/update_health(var/damage_dealt)

	var/brute_loss = get_brute_loss()

	if(break_threshold)
		if(!(flags_organ & FLAG_ORGAN_BROKEN) && brute_loss >= break_threshold)
			if(src.loc)
				src.loc.visible_message(\
					span("danger","You hear a cracking sound coming from \the [src.loc]'s [name]!"),\
					span("danger","You hear a cracking sound coming from your [name]!"),\
					span("danger","You hear a cracking sound!")\
				)
			flags_organ |= FLAG_ORGAN_BROKEN


	if(health_max - brute_loss <= 0 && damage_dealt > health_max)
		gib()
		return

	..()

