/obj/item/bullet/revolver_38
	name = "\improper .38 special bullet"
	desc = "For revolvers that require .38 ammo."
	id = ".38"
	icon = 'icons/obj/items/bullet/38.dmi'

	item_count_max = 6
	item_count_max_icon = 6

	projectile = /obj/projectile/bullet/revolver/
	damage_type = ".38"


/obj/item/bullet/revolver_44
	name = "\improper .44 magnum"
	desc = "For revolvers that require .44 magnum ammo."
	id = ".44"
	icon = 'icons/obj/items/bullet/44.dmi'

	damage_type = ".44"

	projectile = /obj/projectile/bullet/revolver/

/obj/item/bullet/revolver_22
	name = "\improper .22 LR"
	desc = "For revolvers that require .22 LR ammo."
	id = ".22"
	icon = 'icons/obj/items/bullet/22.dmi'

	damage_type = ".22"

	item_count_max = 6
	item_count_max_icon = 6

	projectile = /obj/projectile/bullet/revolver/

/obj/item/bullet/revolver_22/surplus
	name = "\improper .22 LR surplus"
	damage_type = ".22_surplus"

	item_count_max = 6
	item_count_max_icon = 6

/obj/item/bullet/revolver_22/surplus/on_spawn()
	item_count_current = 6