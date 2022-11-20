/obj/item/storage/recipe_binder
	name = "Recipe Binder"
	desc = "Holds your trading cards; err, recipes."
	icon = 'icons/obj/item/book.dmi'
	icon_state = "book_template"

	container_whitelist = list(
		/obj/item/paper/recipe
	)

	size = SIZE_3

	is_container = TRUE
	container_max_size = SIZE_1

	dynamic_inventory_count = 32

	drop_sound = 'sound/items/drop/box.ogg'

	weight = 2

	can_rename = TRUE

	value = 100