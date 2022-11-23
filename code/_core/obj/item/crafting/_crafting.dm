/obj/item/crafting_bench/
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

	rarity = RARITY_UNCOMMON

/obj/item/crafting_bench/click_self(var/mob/caller,location,control,params)

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

/obj/item/crafting_bench/proc/attempt_to_craft(var/mob/living/advanced/caller)

	var/obj/hud/inventory/crafting/result/product_slot = locate() in src.inventories

	if(!product_slot)
		caller.to_chat(span("warning","No product slot detected! Report this bug on github!"))
		return FALSE

	var/list/item_table = generate_crafting_table(caller,src)

	for(var/k in SSrecipe.all_recipes)
		var/recipe/R = k
		if(crafting_type && R.recipe_type != crafting_type)
			continue
		var/list/recipe_check = R.check_recipe(item_table,src)
		if(length(recipe_check))
			var/turf/T = get_turf(caller)
			var/obj/item/I = new R.product(T)
			INITIALIZE(I)
			//No generate here.
			FINALIZE(I)
			if(I.reagents && length(R.product_reagents))
				for(var/r_id in R.product_reagents)
					var/volume = R.product_reagents[r_id]
					I.reagents.add_reagent(r_id,volume)
			product_slot.add_object(I,caller,FALSE)
			R.on_create(caller,src,I,recipe_check)
			return I

	caller.to_chat(span("warning","You fail to craft anything..."))
	return FALSE
