/obj/item/magazine/pistol_12mm/nt
	icon = 'icons/obj/item/magazine/12mmpistol2.dmi'

/obj/item/magazine/pistol_12mm/nt/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets)]"
