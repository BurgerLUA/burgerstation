/obj/item/paper/recipe
	name = "Recipe for disaster"
	desc = "A used piece of paper"
	desc_extended = "A recipe for something, obscured by time."
	data = list("Its just garbled text and scribbles.")
/obj/item/paper/recipe/Generate()
	. = ..()
	var/a1 = "-"
	var/a2 = "-"
	var/a3 = "-"

	var/b1 = "-"
	var/b2 = "-"
	var/b3 = "-"

	var/c1 = "-"
	var/c2 = "-"
	var/c3 = "-"
	var/recipe/stored_recipe
	var/max = SSrecipe.all_recipes.len
	stored_recipe = SSrecipe.all_recipes[rand(1,max)]
	if(!(stored_recipe.secret))
		if(stored_recipe.required_item_grid.len >= 1)
			for(var/i = 1, i <= 9, i++)
				var/tocheck
				switch(i) //This is stupid and bad.
					if(1)
						tocheck = "a1"
					if(2)
						tocheck = "a2"
					if(3)
						tocheck = "a3"
					if(4)
						tocheck = "b1"
					if(5)
						tocheck = "b2"
					if(6)
						tocheck = "b3"
					if(7)
						tocheck = "c1"
					if(8)
						tocheck = "c2"
					if(9)
						tocheck = "c3"
				var/recipe_item_text = stored_recipe.required_item_grid[tocheck]
				if(recipe_item_text == null)
					continue
				var/obj/item/recipe_item = text2path_safe(recipe_item_text)
				var/recipe_item_name = initial(recipe_item.name) //I hate this. But it's the only way to get a name from a path...
				switch(i) //This is SO stupid and bad.
					if(1)
						a1 = recipe_item_name
					if(2)
						a2 = recipe_item_name
					if(3)
						a3 = recipe_item_name
					if(4)
						b1 = recipe_item_name
					if(5)
						b2 = recipe_item_name
					if(6)
						b3 = recipe_item_name
					if(7)
						c1 = recipe_item_name
					if(8)
						c2 = recipe_item_name
					if(9)
						c3 = recipe_item_name
			data += list("Top: [a1],[a2],[a3].","Middle: [b1],[b2],[b3].","Bottom: [c1],[c2],[c3].")
		if(stored_recipe.required_items.len >= 1)
			for(var/any_item in stored_recipe.required_items)
				var/obj/item/item_path = text2path_safe(any_item)
				var/item_name = initial(item_path.name)
				data += list("Anywhere: [item_name] x [stored_recipe.required_items[any_item]]")	
		if(stored_recipe.no_consume_ids.len >= 1)
			for(var/unconsumed in stored_recipe.no_consume_ids)
				var/obj/item/item_path = text2path_safe(unconsumed)
				var/item_name = initial(item_path.name)
				data += list("Unconsumed: [item_name]")
		if(stored_recipe.reagents_to_add.len >= 1)
			for(var/reagent_path in stored_recipe.reagents_to_add)
				var/reagent/reagent = text2path_safe(reagent_path)
				data += list("Product reagent: [initial(reagent.name)] x [stored_recipe.reagents_to_add[reagent_path]]")
		if(length(stored_recipe.product) == 1)
			var/product_path = stored_recipe.product[1]
			var/product_name = initial(stored_recipe.product[product_path].name)
			var/product_chance = stored_recipe.product[product_path]
			name = "Recipe for [product_name]"
			desc = "Some sort of recipe?"
			desc_extended = "Looks like a recipe for a [product_name],whatever that is.Made in the [stored_recipe.recipe_type], it makes [stored_recipe.amount[1]] at a [product_chance]% chance."
		else
			for(var/i = 1,i <= length(stored_recipe.product),i++)
				var/product_path = stored_recipe.product[i]
				var/product_name = initial(stored_recipe.product[product_path].name)
				var/product_chance = stored_recipe.product[product_path]
				name = "Recipe for Many"
				desc = "Thats a lot of items."
				desc_extended += "It looks like it makes [product_name], at a [product_chance]% chance. Makes [stored_recipe.amount[i]]."
		
		
