obj/structure/interactive/misc/
	icon = 'icons/obj/structure/misc.dmi'

obj/structure/interactive/misc/tv
	name = "tv"
	icon_state = "tv"
	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC


obj/structure/interactive/misc/dresser
	name = "dresser"
	icon_state = "dresser"
	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

obj/structure/interactive/misc/dresser/chargen/clicked_on_by_object(caller,object,location,control,params)

	if(!is_advanced(caller))
		return TRUE

	INTERACT_CHECK

	var/mob/living/advanced/A = caller

	if(length(A.worn_objects))
		return TRUE

	if(A.sex == MALE)
		A.add_outfit("new_male",TRUE)
	else
		A.add_outfit("new_female",TRUE)

	A.add_outfit("assistant",TRUE)


	return TRUE


obj/structure/interactive/misc/toilet
	name = "toilet"
	icon_state = "toilet"


obj/structure/interactive/misc/shower
	name = "shower"
	icon_state = "shower"

obj/structure/interactive/misc/mirror
	name = "mirror"
	icon_state = "mirror"


obj/structure/interactive/misc/mirror/chargen/Crossed(var/atom/crosser)
	if(is_player(crosser))
		var/mob/living/advanced/player/P = crosser
		P.add_chargen_buttons()
		P.handle_hairstyle_chargen(-1,update_blends=FALSE)
		P.handle_beardstyle_chargen(-1,update_blends=FALSE)
		P.update_all_blends()
		P.show_hud(TRUE,FLAGS_HUD_CHARGEN,FLAGS_HUD_SPECIAL,speed=3)

	return ..()

obj/structure/interactive/misc/mirror/chargen/Uncrossed(var/atom/crosser)
	if(is_advanced(crosser))
		var/mob/living/advanced/player/P = crosser
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