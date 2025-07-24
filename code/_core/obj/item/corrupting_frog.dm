/obj/item/corrupting_frog
	name = "corrupting frog"
	icon = 'icons/obj/item/corrupting_frog.dmi'
	icon_state = "inventory"
	desc = "One frog was harmed in the making of this item."
	desc_extended = "A magical wooden frog doll that has the abiltity to randomize the quality of an object between 1% and 200%. Single use."
	rarity = RARITY_LEGENDARY
	value = 4000
	value_burgerbux = 1
	var/can_use = TRUE

/obj/item/corrupting_frog/click_on_object(var/mob/activator, var/atom/object, location, control, params)

	if(!can_use || !is_item(object))
		return ..()

	var/obj/item/I = object

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT

	if(!I.can_save)
		activator.to_chat(span("warning","You can't temper \the [I.name] with \the [src.name]! Try tempering the main part of this clothing set."))
		return FALSE

	if(!I.can_adjust_quality())
		activator.to_chat(span("warning","\The [src.name] cannot be used with \the [I.name]!"))
		return FALSE

	var/choice = input("Are you sure you want to corrupt \the [I.name]?","Corrupting Frog") as null|anything in list("Yes","No","Cancel")
	if(choice != "Yes")
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT

	if(!can_use) //Prevents race conditions.
		return FALSE

	can_use = FALSE

	I.adjust_quality(rand(1, I.quality_max) - I.quality, 200)
	play_sound('sound/weapons/magic/zap_large.ogg',get_turf(src))

	qdel(src)

	return TRUE
