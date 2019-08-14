/obj/item/crafting/
	name = "crafting table"
	inventories = list(
		/obj/inventory/crafting/slotA1,
		/obj/inventory/crafting/slotA2,
		/obj/inventory/crafting/slotA3,

		/obj/inventory/crafting/slotB1,
		/obj/inventory/crafting/slotB2,
		/obj/inventory/crafting/slotB3,

		/obj/inventory/crafting/slotC1,
		/obj/inventory/crafting/slotC2,
		/obj/inventory/crafting/slotC3,

		/obj/inventory/crafting/result
	)

	is_container = TRUE

	icon_state = "workbench"

	crafting_id = "workbench"

/obj/item/crafting/click_self(caller,location,control,params)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller

	var/opening = FALSE

	for(var/obj/inventory/crafting/I in A.inventory)
		if(I in inventories)
			continue
		I.alpha = 0
		I.mouse_opacity = 0

	for(var/obj/inventory/I in inventories)
		I.update_owner(A)
		if(opening || !I.alpha)
			animate(I,alpha=255,time=4)
			I.mouse_opacity = 2
			opening = TRUE
		else
			animate(I,alpha=0,time=4)
			I.mouse_opacity = 0
			opening = FALSE

	for(var/obj/button/crafting/B in A.buttons)
		B.stored_crafting_table = src
		if(opening || !B.alpha)
			animate(B,alpha=255,time=4)
			B.mouse_opacity = 2
			opening = TRUE
		else
			animate(B,alpha=0,time=4)
			B.mouse_opacity = 0
			opening = FALSE

	return TRUE