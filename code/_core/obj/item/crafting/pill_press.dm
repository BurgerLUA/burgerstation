/obj/item/crafting/pill_press
	name = "portable pill press table"
	icon = 'icons/obj/item/ore.dmi'
	icon_state = "pill_press"

	inventories = list(

		/obj/hud/inventory/crafting/slotB1,
		/obj/hud/inventory/crafting/slotB3,

		/obj/hud/inventory/crafting/result
	)

	crafting_id = "pill_press"

	crafting_type = null //This actually doesn't make anything.

	value = 40

/obj/item/crafting/pill_press/attempt_to_craft(var/mob/living/advanced/caller)

	var/obj/hud/inventory/crafting/result/product_slot
	var/obj/item/product_container

	for(var/obj/hud/inventory/crafting/result/R in caller.inventory)
		var/obj/item/I = R.get_top_object()
		if(I)
			if(I.is_container)
				product_container = I
			else
				caller.to_chat(span("warning","Remove the already completed item in the product slot before doing this!"))
				return FALSE
		else
			product_slot = R

	var/list/item_table = generate_crafting_table(caller,src)

	if(!item_table["b1"] || !is_beaker(item_table["b1"]))
		caller.to_chat(span("warning","There must be a beaker in the left-most slot in order to make a pill!"))
		return FALSE

	if(item_table["b3"] && !is_beaker(item_table["b3"]))
		caller.to_chat(span("warning","There must be a beaker in the right-most slot in order to make a double pill!"))
		return FALSE

	var/obj/item/container/beaker/I1 = item_table["b1"]
	var/obj/item/container/beaker/I2 = item_table["b3"]

	if(I1 && (!I1.reagents || !I1.reagents.volume_current))
		caller.to_chat(span("warning","There is no matter in the left slot to make a pill from!"))
		return FALSE

	if(I2 && (!I2.reagents || !I2.reagents.volume_current))
		caller.to_chat(span("warning","There is no matter in the right slot to make a double pill from!"))
		return FALSE

	var/obj/item/container/pill/P = new(get_turf(src))
	INITIALIZE(P)
	GENERATE(P)
	FINALIZE(P)

	I1.reagents.transfer_reagents_to(P.reagents,I1.transfer_amount, caller = caller)
	if(I2) I2.reagents.transfer_reagents_to(P.reagents,I2.transfer_amount, caller = caller)

	if(product_container)
		product_container.add_to_inventory(caller,P,TRUE)
	else
		product_slot.add_object(P)



	return TRUE




