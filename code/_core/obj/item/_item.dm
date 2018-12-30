/obj/item/
	name = "item"
	desc = "Oh my god it's an item."

	var/size = 1 //Size in.. uh...
	var/weight = 1 //Weight in kg

	var/obj/inventory/inventory //Inherint Inventory

/obj/item/New(var/desired_loc)
	src.loc = desired_loc
	if(inventory)
		inventory = new inventory(src)
	. = ..()
