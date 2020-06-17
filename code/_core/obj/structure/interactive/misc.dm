obj/structure/interactive/misc/
	icon = 'icons/obj/structure/misc.dmi'

obj/structure/interactive/misc/tv
	name = "tv"
	icon_state = "tv"
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	bullet_block_chance = 25


obj/structure/interactive/misc/dresser
	name = "dresser"
	icon_state = "dresser"
	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	bullet_block_chance = 50

obj/structure/interactive/misc/dresser/chargen/clicked_on_by_object(caller,object,location,control,params)

	if(!is_advanced(caller))
		return TRUE

	INTERACT_CHECK

	var/mob/living/advanced/A = caller

	if(length(A.worn_objects))
		return TRUE

	A.equip_loadout(/loadout/new_player,TRUE)


	return TRUE


obj/structure/interactive/misc/toilet
	name = "toilet"
	icon_state = "toilet"

obj/structure/interactive/misc/urinal
	name = "urinal"
	icon_state = "urinal"
	plane = PLANE_WALL_ATTACHMENTS



obj/structure/interactive/misc/shower
	name = "shower"
	icon_state = "shower"

obj/structure/interactive/misc/mirror
	name = "mirror"
	icon_state = "mirror"
	plane = PLANE_WALL_ATTACHMENTS


obj/structure/interactive/misc/mirror/chargen/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	if(is_player(O))
		var/mob/living/advanced/player/P = O
		P.add_chargen_buttons()
		P.handle_hairstyle_chargen(-1,update_blends=FALSE)
		P.handle_beardstyle_chargen(-1,update_blends=FALSE)
		P.update_all_blends()
		P.show_hud(TRUE,FLAGS_HUD_CHARGEN,FLAGS_HUD_SPECIAL,speed=3)

	return ..()

obj/structure/interactive/misc/mirror/chargen/Uncrossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	if(is_advanced(O))
		var/mob/living/advanced/player/P = O
		P.remove_chargen_buttons()
		//P.save()
	return ..()

obj/structure/interactive/misc/curtain_open
	name = "curtain"
	icon_state = "curtain_open"
	alpha = 175

obj/structure/interactive/misc/sink
	name = "sink"
	icon_state = "sink"
	plane = PLANE_WALL_ATTACHMENTS
