proc/is_clothing(var/atom/A)
	return istype(A,/obj/item/clothing)

proc/is_item(var/atom/A)
	return istype(A,/obj/item/)

proc/is_inventory(var/atom/A)
	return istype(A,/obj/inventory/)