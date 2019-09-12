/obj/item/weapon/ranged/bullet/magazine/autopistol
	name = ".45 private security autopistol"
	desc = "What the fuck is this thing?"
	desc_extended = "A severely butchered .45 security pistol forced into a gruesome automatic variant."

	icon = 'icons/obj/items/weapons/ranged/45pistolauto.dmi'
	bullet_speed = 28
	shoot_delay = 2
	bullet_type = ".45"

	shoot_sounds = list('sounds/weapons/pistol_medium/shoot.ogg')

	view_punch = 10

	override_icon_state = TRUE

	automatic = TRUE

/obj/item/weapon/ranged/bullet/magazine/autopistol/update_icon()

	icon = initial(icon)

	var/icon/I = new/icon(icon,"inventory_[length(stored_bullets) ? 1 : 0]")

	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		var/icon/I2 = new/icon(icon,"mag_[length(M.stored_bullets)]")
		I.Blend(I2,ICON_OVERLAY)

	icon = I

	return ..()