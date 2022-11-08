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

/obj/item/crafting/click_self(var/mob/caller,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)

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
	for(var/obj/hud/inventory/crafting/I in A.inventories_by_id) //Hide other inventory buttons
		CHECK_TICK_SAFE(100,FPS_SERVER*0.5)
		I.alpha = 0
		I.mouse_opacity = 0

	for(var/obj/hud/inventory/crafting/I in inventories)
		CHECK_TICK_SAFE(100,FPS_SERVER*0.5)
		I.update_owner(A)
		if(opening || !I.alpha)
			animate(I,alpha=initial(I.alpha),time=4)
			I.mouse_opacity = initial(I.mouse_opacity)
			opening = TRUE
		else
			animate(I,alpha=0,time=4)
			I.mouse_opacity = 0
			opening = FALSE

	if(opening)
		play_sound(pick(inventory_sounds),get_turf(src),range_max=VIEW_RANGE*0.25)

	for(var/obj/hud/button/crafting/B in A.buttons)
		if(opening)
			animate(B,alpha=initial(B.alpha),time=4)
			B.mouse_opacity = initial(B.mouse_opacity)
			B.stored_crafting_table = src
		else
			animate(B,alpha=0,time=4)
			B.mouse_opacity = 0
			B.stored_crafting_table = null

	inventory_user = caller

	return TRUE

/obj/item/crafting/proc/attempt_to_craft(var/mob/living/advanced/caller)

	var/obj/hud/inventory/crafting/result/product_slot

	for(var/obj/hud/inventory/crafting/result/R in inventories)
		if(R.get_top_object())
			caller.to_chat(span("warning","Remove the already completed item in the product slot before doing this!"))
			return FALSE
		else
			product_slot = R
			break

	if(!product_slot)
		caller.to_chat(span("warning","No product slot detected. Report this bug to burger on Discord."))
		return FALSE

	var/list/item_table = generate_crafting_table(caller,src)

	for(var/k in SSrecipe.all_recipes)
		var/recipe/R = k
		if(R.recipe_type != crafting_type && crafting_type)
			continue
		var/list/recipe_check = R.check_recipe(item_table,src)
		if(length(recipe_check)) //We can craft
			for(var/i = 1, i <= length(R.product),i++)
				var/product_id = R.product[i]
				if(prob(R.product[product_id])) // If craft succeeds.
					var/obj/item/product = text2path_safe(product_id)
					var/obj/item/I3 = new product(caller.loc)
					INITIALIZE(I3)
					GENERATE(I3)
					FINALIZE(I3)
					if(istype(I3,/obj/item/container) && length(R.reagents_to_add))
						var/obj/item/container/IC3 = I3
						for(var/reagent_text in R.reagents_to_add)
							var/reagent/reagent = text2path_safe(reagent_text)
							IC3.reagents.add_reagent(reagent,R.reagents_to_add[reagent_text])
					if(!(product_slot.get_top_object()))
						product_slot.add_object(I3,caller,FALSE,TRUE)
					if(R.amount[i] > 1 && I3.amount_max > 1)
						I3.amount = R.amount[i]
					for(var/obj/item/I in recipe_check)
						if(recipe_check[I])
							continue
						else
							I.add_item_count(-1)
					R.on_create(caller,src,I3)
					return I3
				else //Craft fails.
					caller.to_chat(span("warning","You make a mistake..."))
					if(R.fail_product)
						var/IFP_P = pickweight(R.fail_product)
						var/obj/item/IFP = new IFP_P(caller.loc)
						INITIALIZE(IFP)
						GENERATE(IFP)
						FINALIZE(IFP)
						if(istype(IFP,/obj/item/container) && length(R.fail_reagents_to_add))
							var/obj/item/container/IC3 = IFP
							for(var/reagent_text in R.fail_reagents_to_add)
								var/reagent/reagent = text2path_safe(reagent_text)
								IC3.reagents.add_reagent(reagent,R.fail_reagents_to_add[reagent_text])
						product_slot.add_object(IFP,caller,FALSE,TRUE)
						if(R.fail_amount > 1 && IFP.amount_max > 1)
							IFP.amount = R.fail_amount
						for(var/obj/item/I in recipe_check)
							if(recipe_check[I])
								continue
							else
								I.add_item_count(-1)
						R.on_fail(caller,src,IFP)	
						return IFP
	caller.to_chat(span("warning","You fail to craft anything..."))
	return FALSE
