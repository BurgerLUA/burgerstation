/obj/item/magazine/m13_762
	name = "\improper 7.62mm en bloc clip"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/308_clip.dmi'
	icon_state = "bullet"
	bullet_count_max = 8

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/m13 = TRUE
	)

	ammo = /obj/item/bullet_cartridge/rifle_308
	ammo_surplus = /obj/item/bullet_cartridge/rifle_308/surplus

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_2

	icon_states = 4

	value = 10


/obj/item/magazine/m13_762/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(istype(object,/obj/item/weapon/ranged/bullet/magazine/rifle/m13))
		var/obj/item/weapon/ranged/bullet/magazine/rifle/m13/W = object
		if(W.stored_magazine)
			caller.to_chat(span("notice","\The [W.name] already has a clip inserted!"))
			return TRUE
		src.drop_item(W)
		W.stored_magazine = src
		W.open = FALSE
		play_sound(get_magazine_insert_sound(),get_turf(src),range_max=VIEW_RANGE*0.25)
		W.load_new_bullet_from_magazine(caller)
		W.update_sprite()

		return TRUE

	. = ..()


