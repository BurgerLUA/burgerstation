/obj/item/fulton_pack
	name = "fulton pack"
	desc = "Makes people fly."
	desc_extended = "A pack containing a bluespace parachute that sends the attached object up to be sold for credits. Works on any object or living being not anchored to the floor."
	icon = 'icons/obj/item/fulton.dmi'
	icon_state = "inventory"

	amount_max = 3

	value = 200

	rarity = RARITY_UNCOMMON

	size = SIZE_3
	weight = 20

/obj/item/fulton_pack/Generate()
	amount = 3
	. = ..()

/obj/item/fulton_pack/Finalize()
	. = ..()
	update_sprite()

/obj/item/fulton_pack/update_icon()
	. = ..()
	icon_state = "[initial(icon_state)]_[min(amount,3)]"

/obj/item/fulton_pack/proc/can_attach_fulton(var/mob/activator,var/atom/movable/object,var/value_check = FALSE,var/turf_check=FALSE)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(object)

	if(turf_check)
		if(!is_turf(activator.loc))
			activator.to_chat(span("warning","We couldn't get your signal!"))
			return FALSE
		if(!is_turf(object.loc))
			activator.to_chat(span("warning","We couldn't get the object's signal!"))
			return FALSE
		if(object.anchored)
			activator.to_chat(span("warning","\The [object.name] is anchored to the floor!"))
			return FALSE

	if(activator == object)
		activator.to_chat(span("warning","You can't extract yourself!"))
		return FALSE

	if(is_living(object))
		var/mob/living/L = object
		if(L.minion_master)
			activator.to_chat(span("warning","Minions cannot be fultoned!"))
			return FALSE
		if(is_turf(L.loc) && !L.horizontal)
			activator.to_chat(span("warning","\The [L.name] must be laying on the ground to allow a successful extraction!"))
			return FALSE
		if(L.dead)
			activator.to_chat(span("warning","\The [L.name] is dead!"))
			return FALSE
		if(is_living(activator))
			var/mob/living/L2 = activator
			if(!allow_hostile_action(L2.loyalty_tag,L))
				activator.to_chat(span("warning","Your loyalty tag prevents you from extracting \the [L.name]!"))
				return FALSE
		if(L.boss)
			activator.to_chat(span("warning","\The [L.name] is too large to be extracted!"))
			return FALSE

	if(istype(object,/obj/structure/interactive/crate/))
		var/obj/structure/interactive/crate/C = object
		if(istype(object,/obj/structure/interactive/crate/secure))
			var/obj/structure/interactive/crate/secure/S = object
			if(S.locked)
				activator.to_chat(span("warning","\The [S.name] needs to be unlocked in order to be fultoned!"))
				return FALSE
		for(var/k in C.contents)
			var/atom/movable/M = k
			if(!can_attach_fulton(activator,M,FALSE,FALSE))
				return FALSE

	if(value_check && object.get_value() <= 0)
		activator.to_chat(span("warning","\The [object.name] cannot be sold as it has no value!"))
		return FALSE

	return TRUE

/obj/item/fulton_pack/proc/attach_fulton(var/mob/activator,var/atom/movable/M)

	var/obj/structure/interactive/fulton/F = new(get_turf(M))
	INITIALIZE(F)
	GENERATE(F)
	FINALIZE(F)
	F.add_movable(activator,M)

	activator.visible_message(span("warning","\The [activator.name] attaches \the [src.name] to \the [M.name]!"))
	activator.to_chat(span("notice","You have [amount-1] fulton packs left."))

	add_item_count(-1)

	return TRUE


/obj/item/fulton_pack/click_on_object(var/mob/activator,var/atom/object,location,control,params)

	if(!ismovable(object))
		return ..()

	if(!is_turf(object.loc))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(10)

	if(!can_attach_fulton(activator,object,TRUE,TRUE))
		return TRUE

	activator.visible_message(span("warning","\The [activator.name] begins to attach \the [src.name] to \the [object.name]!"),span("warning","You begin to attach \the [src.name] to \the [object.name]."))

	PROGRESS_BAR(activator,src,SECONDS_TO_DECISECONDS(2),src::attach_fulton(),activator,object)
	PROGRESS_BAR_CONDITIONS(activator,src,src::can_attach_fulton(),activator,object)

	return TRUE


