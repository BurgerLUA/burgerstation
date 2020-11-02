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

	var/crafting_type = null

	weight = 10

/obj/item/crafting/click_self(caller,location,control,params)

	if(!length(inventories))
		return FALSE

	var/mob/living/advanced/A = caller

	if(inventory_user && is_advanced(inventory_user))
		var/mob/living/advanced/A2 = inventory_user
		for(var/obj/hud/button/crafting/B in A2.buttons)
			B.alpha = 0
			B.mouse_opacity = 0
			B.stored_crafting_table = null

	if(inventory_user != A)
		for(var/obj/hud/button/crafting/B in A.buttons)
			B.alpha = 0
			B.mouse_opacity = 0
			B.stored_crafting_table = null

	var/opening = FALSE
	for(var/obj/hud/inventory/crafting/I in A.inventory)
		CHECK_TICK(100,FPS_SERVER*0.5)
		I.alpha = 0
		I.mouse_opacity = 0

	for(var/obj/hud/inventory/crafting/I in inventories)
		CHECK_TICK(100,FPS_SERVER*0.5)
		I.update_owner(A)
		if(opening || !I.alpha)
			animate(I,alpha=255,time=4)
			I.mouse_opacity = 2
			opening = TRUE
		else
			animate(I,alpha=0,time=4)
			I.mouse_opacity = 0
			opening = FALSE

	if(opening)
		play(pick(inventory_sounds),src)

	for(var/obj/hud/button/crafting/B in A.buttons)
		if(opening)
			animate(B,alpha=255,time=4)
			B.mouse_opacity = 2
			B.stored_crafting_table = src
		else
			animate(B,alpha=0,time=4)
			B.mouse_opacity = 0
			B.stored_crafting_table = null

	inventory_user = caller

	return TRUE




/*
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
*/


/obj/item/crafting/proc/attempt_to_craft(var/mob/living/advanced/caller)

	var/obj/hud/inventory/crafting/result/product_slot

	for(var/obj/hud/inventory/crafting/result/R in caller.inventory)
		if(R.get_top_held_object())
			caller.to_chat(span("notice","Remove the already completed item in the product slot before doing this!"))
			return FALSE
		else
			product_slot = R
			break

	var/list/item_table = generate_crafting_table(caller,src)

	for(var/k in SSrecipe.all_recipes)
		var/recipe/R = k

		var/list/recipe_check = R.check_recipe(item_table,src)
		if(length(recipe_check)) //We can craft

			var/obj/item/I3 = new R.product(caller.loc)
			INITIALIZE(I3)
			GENERATE(I3)
			FINALIZE(I3)
			product_slot.add_held_object(I3,caller,FALSE,TRUE)

			for(var/obj/item/I in recipe_check)
				if(R.transfer_reagents && I.reagents && I3.reagents)
					I.reagents.transfer_reagents_to(I3.reagents,I.reagents.volume_current)
					qdel(I)
				else
					I.add_item_count(-1)

			R.on_create(caller,src,I3)

			return I3

	caller.to_chat(span("notice","You fail to craft anything..."))
	return FALSE