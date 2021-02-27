/obj/item/fulton_pack
	name = "fulton pack"
	desc = "Makes people fly."
	desc_extended = "Fultons objects up to be sold."
	icon = 'icons/obj/item/clothing/back/fulton.dmi'
	icon_state = "inventory"

	item_count_max = 20

	value = 200

/obj/item/fulton_pack/Generate()
	item_count_current = item_count_max
	return ..()

/obj/item/fulton_pack/proc/can_attach_fulton(var/mob/caller,var/atom/movable/object,var/value_check = FALSE,var/turf_check=FALSE)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(object)

	if(turf_check)
		if(!isturf(caller.loc))
			return FALSE

		if(!isturf(object.loc))
			return FALSE

	if(object.anchored)
		caller.to_chat(span("warning","\The [object.name] is anchored to the floor!"))
		return FALSE

	if(caller == object)
		caller.to_chat(span("warning","You can't extract yourself!"))
		return FALSE

	if(is_living(object))
		var/mob/living/L = object
		if(L.master)
			caller.to_chat(span("warning","Minions cannot be fultoned!"))
			return FALSE
		if(isturf(L.loc) && !L.horizontal)
			caller.to_chat(span("warning","\The [L.name] must be laying on the ground to allow a successful extraction!"))
			return FALSE
		if(L.dead)
			caller.to_chat(span("warning","\The [L.name] is dead!"))
			return FALSE
		if(is_living(caller))
			var/mob/living/L2 = caller
			if(L2.loyalty_tag == L.loyalty_tag)
				caller.to_chat(span("warning","Your loyalty tag prevents you from extracting \the [L.name]!"))
				return FALSE
		if(L.boss)
			caller.to_chat(span("warning","\The [L.name] is too large to be extracted!"))
			return FALSE

	if(istype(object,/obj/structure/interactive/crate/))
		var/obj/structure/interactive/crate/C = object
		if(istype(object,/obj/structure/interactive/crate/secure))
			var/obj/structure/interactive/crate/secure/S = object
			if(S.locked)
				caller.to_chat(span("warning","\The [S.name] needs to be open in order to be sold!"))
				return FALSE
		for(var/k in C.contents)
			var/atom/movable/M = k
			if(!can_attach_fulton(caller,M,FALSE,FALSE))
				return FALSE

	if(value_check && object.get_value() <= 0)
		caller.to_chat(span("warning","\The [object.name] cannot be sold!"))
		return FALSE

	return TRUE

/obj/item/fulton_pack/proc/attach_fulton(var/mob/caller,var/atom/movable/M)

	var/obj/structure/interactive/fulton/F = new(get_turf(M))
	INITIALIZE(F)
	GENERATE(F)
	FINALIZE(F)
	F.add_movable(caller,M)

	caller.visible_message(span("warning","\The [caller.name] attaches \the [src.name] to \the [M.name]!"))
	caller.to_chat(span("notice","You have [item_count_current-1] fulton packs left."))

	add_item_count(-1)

	return TRUE


/obj/item/fulton_pack/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(!ismovable(object))
		return ..()

	if(object.plane >= PLANE_HUD)
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(10)

	if(!can_attach_fulton(caller,object,TRUE,TRUE))
		return TRUE

	caller.visible_message(span("warning","\The [caller.name] begins to attach \the [src.name] to \the [object.name]!"),span("warning","You begin to attach \the [src.name] to \the [object.name]."))

	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(2),.proc/attach_fulton,caller,object)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_attach_fulton,caller,object)

	return TRUE


