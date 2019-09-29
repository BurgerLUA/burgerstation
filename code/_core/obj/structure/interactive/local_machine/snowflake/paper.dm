/obj/structure/interactive/localmachine/snowflake/paper

	name = "paper"

	icon = 'icons/obj/items/paper.dmi'
	icon_state = "normal"

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	opacity = 0


/obj/structure/interactive/localmachine/snowflake/paper/chargen
	name = "skillsheet"
	icon_state = "none"

/obj/structure/interactive/localmachine/snowflake/paper/chargen/clicked_on_by_object(caller,object,location,control,params)

	if(!is_player(caller))
		return TRUE

	INTERACT_CHECK

	//var/mob/living/advanced/player/P = caller




