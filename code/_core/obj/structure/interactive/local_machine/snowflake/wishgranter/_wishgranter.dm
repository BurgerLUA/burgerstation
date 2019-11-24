

/obj/structure/interactive/localmachine/snowflake/wishgranter/
	name = "wishgranter"
	id = "null"

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	icon = 'icons/obj/structure/wishgranter.dmi'
	icon_state = "wishgranter_off"

	desired_light_range = 10
	desired_light_power = 0.5
	desired_light_color = "#FFFFFF"

/obj/structure/interactive/localmachine/snowflake/wishgranter/New(var/desired_loc)

	if(desired_light_range && desired_light_power && desired_light_color)
		set_light(desired_light_range,desired_light_power,desired_light_color)

	return ..()


/obj/structure/interactive/localmachine/snowflake/wishgranter/clicked_on_by_object(caller,object,location,control,params)

	if(!is_player(caller))
		return FALSE

	var/mob/living/advanced/player/P = caller

	if(!P.client)
		return FALSE

	if(!id)
		P.to_chat(span("notice","This wishgranter doesn't seem to work..."))
		return FALSE

	var/savedata/client/mob/U = P.mobdata

	if(!(id in U.loaded_data["known_wishgranters"]))
		INTERACT_CHECK
		U.loaded_data["known_wishgranters"] += id
		set_icon_state_mob(P,"wishgranter_on")
		P.to_chat(span("notice","You have learned the location of this wishgranter. You may teleport between here and any other wishgranters you know."))

	return TRUE


/obj/structure/interactive/localmachine/snowflake/wishgranter/Crossed(var/atom/crosser)

	if(!is_player(crosser))
		return FALSE

	var/mob/living/advanced/player/P = crosser

	if(!P.client)
		return FALSE

	if(id == "main")
		P.show_hud(TRUE,FLAGS_HUD_TELEPORT,FLAGS_HUD_NONE,speed=1)
		return TRUE

	var/turf/desired_turf = get_turf(all_wishgranters["main"])
	desired_turf = get_step(desired_turf,SOUTH)

	var/list/callback_list = list()
	callback_list["start_turf"] = get_turf(P)
	callback_list["end_turf"] = desired_turf
	if(add_progress_bar(P,"teleport",SECONDS_TO_DECISECONDS(3),callback_list))
		P.to_chat(span("notice","You begin walking into the light..."))
		P.show_hud(FALSE,FLAGS_HUD_TELEPORT,FLAGS_HUD_NONE,speed=1)

	return TRUE


/obj/structure/interactive/localmachine/snowflake/wishgranter/Uncrossed(var/atom/crosser)

	if(!is_player(crosser))
		return TRUE

	var/mob/living/advanced/player/P = crosser

	if(id == "main")
		P.show_hud(FALSE,FLAGS_HUD_TELEPORT,FLAGS_HUD_NONE,speed=1)

	return TRUE