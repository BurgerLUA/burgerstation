/obj/item/crafting/
	name = "crafting table"
	inventories = list(
		/obj/hud/inventory/crafting/slotA1,
		/obj/hud/inventory/crafting/slotA2,
		/obj/hud/inventory/crafting/slotA3,

		/obj/hud/inventory/crafting/slotB1,
		/obj/hud/inventory/crafting/slotB2,
		/obj/hud/inventory/crafting/slotB3,

		/obj/hud/inventory/crafting/slotC1,
		/obj/hud/inventory/crafting/slotC2,
		/obj/hud/inventory/crafting/slotC3,

		/obj/hud/inventory/crafting/result
	)

	is_container = TRUE

	icon_state = "workbench"

	crafting_id = "workbench"

/obj/item/crafting/click_self(caller,location,control,params)

	if(!is_advanced(caller))
		return ..()

	var/mob/living/advanced/A = caller

	var/opening = FALSE

	for(var/obj/hud/inventory/crafting/I in A.inventory)
		if(I in inventories)
			continue
		I.alpha = 0
		I.mouse_opacity = 0

	for(var/obj/hud/inventory/I in inventories)
		I.update_owner(A)
		if(opening || !I.alpha)
			animate(I,alpha=255,time=4)
			I.mouse_opacity = 2
			opening = TRUE
		else
			animate(I,alpha=0,time=4)
			I.mouse_opacity = 0
			opening = FALSE

	for(var/obj/hud/button/crafting/B in A.buttons)
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