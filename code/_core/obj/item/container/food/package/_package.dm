/obj/item/container/food/package
	name = "packaged food"
	desc = "Edible reagent that you can grab with a hand."
	desc_extended = "Edible."

	scale_sprite = FALSE

	var/obj/item/trash/packaging //The object created when you unwrap it.
	var/obj/item/trash/trash //The object created when there is nothing left to eat from it.

/obj/item/container/food/package/on_consumed(var/mob/caller,var/mob/living/target) //When there are no reagents left.

	var/obj/hud/inventory/I

	if(is_inventory(src.loc))
		I = src.loc

	. = ..()

	if(trash)
		var/obj/item/trash/T = create_trash(caller)
		if(I) I.add_object(T,silent=TRUE)
		trash = null

	return TRUE

/obj/item/container/food/package/proc/create_trash(var/mob/caller)
	var/obj/item/trash/T = new trash(get_turf(caller))
	INITIALIZE(T)
	GENERATE(T)
	FINALIZE(T)
	return T

/obj/item/container/food/package/proc/create_packaging(var/mob/caller)
	var/obj/item/trash/T = new packaging(get_turf(caller))
	INITIALIZE(T)
	GENERATE(T)
	FINALIZE(T)
	return T


/obj/item/container/food/package/feed(var/mob/caller,var/mob/living/target)

	if(packaging)
		caller.to_chat(span("warning","You must unwrap \the [src.name] before eating it!"))
		return FALSE

	return ..()


/obj/item/container/food/package/proc/unwrap(var/mob/caller,var/obj/hud/inventory/I)

	var/obj/item/trash/T = create_packaging(caller)

	caller.visible_message(span("notice","\The [caller.name] unwraps \the [src.name]."),span("notice","You unwrap \the [src.name]."))

	if(I)
		I.add_object(T)

	packaging = null

	return TRUE


/obj/item/container/food/package/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_inventory(object) && packaging)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		unwrap(caller,object)
		return TRUE

	return ..()
