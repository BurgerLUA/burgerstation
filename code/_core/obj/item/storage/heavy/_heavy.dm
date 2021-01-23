/obj/item/storage/heavy
	name = "heavy storage"
	desc = "I don't think anyone can pick this up."

	size = 1000

	container_max_size = 999

	dynamic_inventory_count = 12

	anchored = TRUE

/obj/item/storage/heavy/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object
	click_self(caller,location,control,params)
	return TRUE