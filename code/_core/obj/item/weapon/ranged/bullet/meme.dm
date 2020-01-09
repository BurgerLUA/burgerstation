/obj/item/weapon/ranged/meme
	name = "meme test"
	icon = 'icons/obj/items/weapons/ranged/tf2_guns_v2b.dmi'
	icon_state = "minigun_icon"
	icon_state_held_single = "minigun_inhand"


/obj/item/weapon/ranged/meme/click_self(var/mob/caller)
	icon_state_held_single = pick("widowmaker_1h_inhand","widowmaker_2h_inhand","axtinguisher_2h_inhand")
	update_icon()
	update_held_icon()
	return TRUE