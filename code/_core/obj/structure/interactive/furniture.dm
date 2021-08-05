/obj/structure/interactive/chair/furniture //everything under this file can be picked back up, one way or another, and is intended for furnishing. See deployable/furniture for the... deployment.
	name = "chair"
	desc = "This one isn't bolted down, therefore it should be swiped."
	desc_extended = "A chair is a piece of furniture with a raised surface supported by legs, commonly used to seat a single person. Buckling is automatic and will be attempted upon walking over something you can buckle into. <br>This one can also be picked up with an open hand."

	flags_placement = FLAGS_PLACEMENT_DIRECTIONAL

/obj/structure/interactive/chair/furniture/proc/can_pack_up(var/mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(get_dist(caller,src) > 1)
		caller.to_chat(span("warning","You're too far away to pack up \the [src.name]!"))
		return FALSE

	if(qdeleting || !isturf(src.loc))
		caller.to_chat(span("warning","You can't pack up \the [src.name] here!"))
		return FALSE

	return TRUE

/obj/structure/interactive/chair/furniture/proc/pack_up(var/mob/caller)

	caller.visible_message(span("warning","\The [caller.name] packs up \the [src.name]."),span("notice","You pack up \the [src.name]."))

	var/obj/item/deployable/furniture/chair/C = new(get_turf(src))
	INITIALIZE(C)
	FINALIZE(C)
	qdel(src)

	return TRUE

/obj/structure/interactive/chair/furniture/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!istype(object,/obj/hud/inventory))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(1)

	if(can_pack_up(caller))
		caller.visible_message(span("warning","\The [caller.name] starts to pack up \the [src.name]..."),span("notice","You start to pack up \the [src.name]..."))
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(1),.proc/pack_up,caller)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_pack_up,caller)

	return TRUE

/obj/structure/interactive/bed/furniture
	name = "bed"
	desc = "Everyone needs sleep. Even clones."
	desc_extended = "You can use a wrench on this to pack it up. There's not much else you can/should do with this, for now."
	icon = 'icons/obj/structure/bed.dmi'
	icon_state = "bed"
	secondary_color = COLOR_BLACK

/obj/structure/interactive/bed/furniture/proc/can_pack_up(var/mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(get_dist(caller,src) > 1)
		caller.to_chat(span("warning","You're too far away to pack up \the [src.name]!"))
		return FALSE

	if(qdeleting || !isturf(src.loc))
		caller.to_chat(span("warning","You can't pack up \the [src.name] here!"))
		return FALSE

	return TRUE

/obj/structure/interactive/bed/furniture/update_overlays()

	. = ..()

	var/image/sheets = new(icon,"bed_padding")
	sheets.color = secondary_color
	add_overlay(sheets)

/obj/structure/interactive/bed/furniture/proc/pack_up(var/mob/caller)

	caller.visible_message(span("warning","\The [caller.name] unscrews the bolts holding \the [src.name] together."),span("notice","You unscrew the bolts holding \the [src.name] together."))

	var/obj/item/deployable/furniture/table/C = new(get_turf(src))
	INITIALIZE(C)
	FINALIZE(C)
	qdel(src)

	return TRUE

/obj/structure/interactive/bed/furniture/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!istype(object,/obj/item/weapon/melee/tool/wrench))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(1)

	if(can_pack_up(caller))
		caller.visible_message(span("warning","\The [caller.name] start unscrewing \the [src.name]'s bolts..."),span("notice","You start unscrewing \the [src.name]'s bolts..."))
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(2),.proc/pack_up,caller)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_pack_up,caller)

	return TRUE

/obj/structure/smooth/table/furniture //May need to copypaste procs from above, because... well, this is a structure. But it works like the chair.
	name = "table"
	desc = "A table for placing objects down or taking them. Or in this case, taking."
	desc_extended = "To place items on a table, press Q + Left/Right click depending on if the item is in your left or right hand. Climbing over tables is automatic; Walk into a table for long enough to climb over it. <br>Use a wrench on this table to pack it up."
	icon = 'icons/obj/structure/smooth/table/normal.dmi'
	icon_state = "table" //todo: implement updating

/obj/structure/smooth/table/furniture/proc/can_pack_up(var/mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(get_dist(caller,src) > 1)
		caller.to_chat(span("warning","You're too far away to pack up \the [src.name]!"))
		return FALSE

	if(qdeleting || !isturf(src.loc))
		caller.to_chat(span("warning","You can't pack up \the [src.name] here!"))
		return FALSE

	return TRUE

/obj/structure/smooth/table/furniture/proc/pack_up(var/mob/caller)

	caller.visible_message(span("warning","\The [caller.name] unscrews the bolts holding \the [src.name] together."),span("notice","You unscrew the bolts holding \the [src.name] together."))

	var/obj/item/deployable/furniture/table/C = new(get_turf(src))
	INITIALIZE(C)
	FINALIZE(C)
	qdel(src)

	return TRUE

/obj/structure/smooth/table/furniture/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!istype(object,/obj/item/weapon/melee/tool/wrench))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(1)

	if(can_pack_up(caller))
		caller.visible_message(span("warning","\The [caller.name] start unscrewing \the [src.name]'s bolts..."),span("notice","You start unscrewing \the [src.name]'s bolts..."))
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(2),.proc/pack_up,caller)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_pack_up,caller)

	return TRUE