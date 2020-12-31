/obj/item/enchanting_chalk
	name = "enchanting chalk"
	desc = "It's just like preschool!"
	desc_extended = "Draw enchanting runes with this magical chalk. Has a limited amount of uses."
	icon = 'icons/obj/item/drawing_chalk.dmi'
	icon_state = "inventory"

	value = 700

	var/uses_left = 7


/obj/item/enchanting_chalk/update_icon()

	icon_state = "[initial(icon_state)]_[uses_left]"

	return ..()

/obj/item/enchanting_chalk/get_value()
	. = ..()

	. *= uses_left/initial(uses_left)

	. = CEILING(.,1)

	return .

/obj/item/enchanting_chalk/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(istype(object,/obj/structure/interactive/enchantment_circle/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		caller.visible_message(span("warning","\The [caller.name] clears \the [object.name] with \the [src.name]."),span("notice","You clear \the [object.name] with \the [src.name]."))
		qdel(object)
		return TRUE

	if(isturf(object))

		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)

		if(caller.loc != object)
			caller.to_chat(span("warning","You must draw the rune at your feet!"))
			return TRUE

		var/turf/T = object
		for(var/k in DIRECTIONS_ALL)
			var/turf/T2 = get_step(T,k)
			var/atom/occupied = T2.is_occupied(PLANE_DECAL)
			if(occupied)
				caller.to_chat(span("warning","You can't draw an enchantment circle here, \the [occupied.name] is in the way!"))
				return TRUE

		var/obj/structure/interactive/enchantment_circle/EC = new(T)
		INITIALIZE(EC)
		GENERATE(EC)
		FINALIZE(EC)
		caller.visible_message(span("notice","\The [caller.name] touches \the [T.name] with \the [src.name], magically creating \a [EC.name]."),span("notice","You touch \the [T.name] with \the [src.name], magically creating \a [EC.name]."))
		uses_left--
		if(uses_left <= 0)
			qdel(src)
		else
			update_sprite()

		return TRUE

	return ..()

