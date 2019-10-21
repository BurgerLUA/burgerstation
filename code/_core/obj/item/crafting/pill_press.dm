/obj/item/crafting/pill_press
	name = "portable pill press table"
	icon = 'icons/obj/items/ore.dmi'
	icon_state = "pill_press"

	inventories = list(

		/obj/hud/inventory/crafting/slotB1,
		/obj/hud/inventory/crafting/slotB3,

		/obj/hud/inventory/crafting/result
	)

	crafting_id = "pill_press"

/obj/item/crafting/pill_press/attempt_to_craft(var/mob/living/advanced/caller)

	var/obj/hud/inventory/crafting/result/product_slot
	var/obj/item/product_container

	for(var/obj/hud/inventory/crafting/result/R in caller.inventory)
		var/obj/item/I = R.get_top_held_object()
		if(I)
			if(I.is_container)
				product_container = I
			else
				caller.to_chat(span("notice","Remove the already completed item in the product slot before doing this!"))
				return FALSE
		else
			product_slot = R

	var/list/item_table = generate_crafting_table(caller)

	world.log << "HELLO: [item_table["b1"]]"

	if(!item_table["b1"] || !is_container(item_table["b1"]))
		caller.to_chat(span("notice","There must be a reagent container in the left slot in order to make a pill!"))
		return FALSE

	if(item_table["b2"] && !is_container(item_table["b2"]))
		caller.to_chat(span("notice","There must be a reagent container in the right slot in order to make a double pill!"))
		return FALSE

	var/obj/item/container/I1 = item_table["b1"]
	var/obj/item/container/I2 = item_table["b3"]
	var/is_double = I1 && I2

	if(I1 && !I1.reagents.volume_current)
		caller.to_chat(span("notice","There is no matter in the left slot to make a pill from!"))
		return FALSE

	if(I2 && !I2.reagents.volume_current)
		caller.to_chat(span("notice","There is no matter in the right slot to make a double pill from!"))
		return FALSE

	var/obj/item/container/pill/P = new/obj/item/container/pill(get_turf(src),is_double)
	I1.reagents.transfer_reagents_to(P.reagents,10)
	if(I2)
		I2.reagents.transfer_reagents_to(P.reagents_2,10)

	P.update_icon()

	if(product_container)
		product_container.add_to_inventory(caller,P,TRUE)
	else
		P.transfer_item(product_slot)



	return TRUE




