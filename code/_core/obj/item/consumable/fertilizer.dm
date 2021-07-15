/obj/item/consumable/fertilizer
	name = "Plant-2-Grow"
	desc = "Weird space fertilizer"
	desc_extended = "Apply to a plant to increase its potency."
	icon = 'icons/obj/item/container/spray_bottle.dmi'
	icon_state = "inventory"
	value = 50

/obj/item/consumable/fertilizer/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)
	if (!istype(object,/obj/structure/interactive/plant))
		return

	var/obj/structure/interactive/plant/O = object

	O.potency += 1
	caller.visible_message(span("notice","\The [caller.name] fertilizes the [O.name]."),span("notice","You fertilize the [O.name]."))
	delete()
