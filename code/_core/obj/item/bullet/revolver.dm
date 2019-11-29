/obj/item/bullet/revolver_38
	name = "\improper .38 special bullet"
	desc = "For revolvers that require .38 ammo."
	id = ".38"
	icon = 'icons/obj/items/bullet/38.dmi'

	item_count_max = 6
	item_count_max_icon = 6

	projectile = /obj/projectile/bullet/revolver/
	damage_type = ".38"

	bullet_speed = BULLET_SPEED_PISTOL_LIGHT


/obj/item/bullet/revolver_357
	name = "\improper .357 bullet"
	desc = "For revolvers that require .357 ammo."
	id = ".357"
	icon = 'icons/obj/items/bullet/357.dmi'

	damage_type = ".357"

	item_count_max = 6
	item_count_max_icon = 6

	projectile = /obj/projectile/bullet/revolver/

	bullet_speed = BULLET_SPEED_PISTOL_HEAVY

/obj/item/bullet/revolver_357/surplus
	name = "\improper .357 surplus bullet"
	desc = "For revolvers that require .357 ammo. Surplus round."

	icon = 'icons/obj/items/bullet/357_surplus.dmi'
	damage_type = ".357_surplus"

	bullet_speed = BULLET_SPEED_PISTOL_HEAVY * SURPLUS_PENALTY

/obj/item/bullet/revolver_44
	name = "\improper .44 magnum bullet"
	desc = "For revolvers that require .44 magnum ammo."
	id = ".44"
	icon = 'icons/obj/items/bullet/44.dmi'

	damage_type = ".44"

	item_count_max = 6
	item_count_max_icon = 6

	projectile = /obj/projectile/bullet/revolver/

	bullet_speed = BULLET_SPEED_PISTOL_HEAVY

/obj/item/bullet/revolver_44/surplus
	name = "\improper surplus .44 magnum bullet"
	desc = "For revolvers that require .44 magnum ammo. Surplus ammo."
	id = ".44"
	icon = 'icons/obj/items/bullet/44_surplus.dmi'

	damage_type = ".44_surplus"

	item_count_max = 6
	item_count_max_icon = 6

	projectile = /obj/projectile/bullet/revolver/

	bullet_speed = BULLET_SPEED_PISTOL_HEAVY * SURPLUS_PENALTY

/obj/item/bullet/revolver_22
	name = "\improper .22 LR"
	desc = "For revolvers that require .22 LR ammo."
	id = ".22"
	icon = 'icons/obj/items/bullet/22.dmi'

	damage_type = ".22"

	item_count_max = 6
	item_count_max_icon = 6

	projectile = /obj/projectile/bullet/revolver/

	bullet_speed = BULLET_SPEED_PISTOL_LIGHT

/obj/item/bullet/revolver_22/surplus
	name = "\improper .22 LR surplus"
	damage_type = ".22_surplus"

	item_count_max = 6
	item_count_max_icon = 6

	bullet_speed = BULLET_SPEED_PISTOL_LIGHT * SURPLUS_PENALTY

/obj/item/bullet/revolver_22/surplus/on_spawn()
	item_count_current = 6