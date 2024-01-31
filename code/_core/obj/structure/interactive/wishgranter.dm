var/list/obj/structure/interactive/wishgranter/all_wishgranters = list()
var/obj/structure/interactive/wishgranter/main_wishgranter


obj/structure/interactive/wishgranter
	name = "wishgranter"
	desc = "What secrets does this hold?"
	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE


	icon = 'icons/obj/structure/wishgranter.dmi'
	icon_state = "wishgranter"


	desired_light_range = 10
	desired_light_power = 0.5
	desired_light_color = "#FFFFFF"

obj/structure/interactive/wishgranter/New()
	. = ..()
	all_wishgranters[id] = src
	if(desired_light_range && desired_light_power && desired_light_color)
		set_light(desired_light_range,desired_light_power,desired_light_color)


obj/structure/interactive/wishgranter/fake/New()
	//Do literally nothing.
	return TRUE

obj/structure/interactive/wishgranter/spawn_and_join_faction
	var/faction_to_join

obj/structure/interactive/wishgranter/spawn_and_join_faction/clicked_on_by_object(caller,object,location,control,params)

	if(!is_observer(caller))
		return FALSE

	var/mob/abstract/observer/O = caller
	var/mob/living/advanced/player/P = new(src.loc,O.client)
	P.Initialize()
	if(P.client)
		P.client.eye = P
		P.client.update_zoom(-1)
	P.factions = list()

	P.initialize_factions()

	var/faction/F = all_factions[faction_to_join]
	P.factions += faction_to_join
	//P.update_faction_icons()

	P.to_chat(span(F.icon_state,"You have joined \the [F.name]! Note that friendly fire is currently <b>[F.friendly_fire ? "ON" : "OFF"]</b>."))
	P.to_chat(span("notice","Use the mirror to change your apperance. Your appearance, worn items, and equipped items will be saved when you enter the white light."))
	P.to_chat(span("danger","Be sure to equip everything you can! Once you enter the white light, you cannot return unless you die!"))

	qdel(O)

obj/structure/interactive/wishgranter/spawn_and_join_faction/red
	name = "red team wishgranter"
	faction_to_join = "arena_red"

obj/structure/interactive/wishgranter/spawn_and_join_faction/blue
	name = "blue team wishgranter"
	faction_to_join = "arena_blue"

obj/structure/interactive/wishgranter/spawn_and_join_faction/green
	name = "green team wishgranter"
	faction_to_join = "arena_green"

obj/structure/interactive/wishgranter/spawn_and_join_faction/yellow
	name = "yellow team wishgranter"
	faction_to_join = "arena_yellow"


obj/structure/interactive/wishgranter/normal
	name = "tutorial wishgranter"
	id = "tutorial"
	var/main = FALSE

obj/structure/interactive/wishgranter/normal/New(var/desired_loc)

	if(main)
		main_wishgranter = src

	return ..()


obj/structure/interactive/wishgranter/normal/Crossed(var/atom/crosser)

	if(!is_player(crosser))
		return FALSE

	var/mob/living/advanced/player/P = crosser

	if(!P.client)
		return FALSE

	if(main)
		P.show_hud(TRUE,FLAGS_HUD_TELEPORT,FLAGS_HUD_SPECIAL,speed=1)
		return TRUE

	var/turf/desired_turf = get_turf(main_wishgranter)
	desired_turf = get_step(desired_turf,SOUTH)

	var/list/callback_list = list()
	callback_list["start_turf"] = get_turf(P)
	callback_list["end_turf"] = desired_turf
	if(add_progress_bar(P,"teleport",SECONDS_TO_DECISECONDS(3),callback_list))
		P.to_chat(span("notice","You begin walking into the light..."))
		P.show_hud(FALSE,FLAGS_HUD_TELEPORT,FLAGS_HUD_SPECIAL|FLAGS_HUD_WIDGET,speed=1)

	return TRUE


obj/structure/interactive/wishgranter/normal/Uncrossed(var/atom/crosser)

	if(!is_player(crosser))
		return TRUE

	var/mob/living/advanced/player/P = crosser

	if(main)
		P.show_hud(FALSE,FLAGS_HUD_TELEPORT,FLAGS_HUD_SPECIAL|FLAGS_HUD_WIDGET,speed=1)

	return TRUE

/*
obj/structure/interactive/wishgranter/normal/Crossed(var/atom/crosser)
	if(is_player(crosser))
		var/mob/living/advanced/player/P = crosser
		if(P.client)
			var/choice = input("Which Wishgranter would you like to teleport to?","Teleport Destination") as anything|null in all_wishgranters
			if(!choice)
				return
			var/list/callback_list = list()
			callback_list["start_turf"] = get_turf(P)
			callback_list["end_turf"] = all_wishgranters[choice]
			if(add_progress_bar(P,"teleport",SECONDS_TO_DECISECONDS(10),callback_list))
				P.to_chat(span("notice","Now teleporting..."))

	return ..()
*/

obj/structure/interactive/wishgranter/normal/main
	name = "the first wishgranter"
	id = "first"
	main = TRUE

/obj/structure/interactive/wishgranter/normal/village
	name = "village wishgranter"
	id = "village"

/obj/structure/interactive/wishgranter/normal/northern_heights
	name = "northern heights bar wishgranter"
	id = "northern_heights"

/obj/structure/interactive/wishgranter/normal/jungle
	name = "jungle wishgranter"
	id = "jungle"

/obj/structure/interactive/wishgranter/normal/clockwork
	name = "clockwork wishgranter"
	id = "clockwork"

/obj/structure/interactive/wishgranter/normal/clockwork/boss
	name = "clockwork bosh wishgranter"
	id = "clockwork_boss"


/obj/structure/interactive/wishgranter/normal/caves/
	name = "caves wishgranter"
	id = "caves"

/obj/structure/interactive/wishgranter/normal/caves/hidden
	name = "hidden caves wishgranter"
	id = "caves_hidden"

/obj/structure/interactive/wishgranter/normal/caves/nymph
	name = "nymph caves wishgranter"
	id = "caves_nymph"

/obj/structure/interactive/wishgranter/normal/cult_hideout/
	name = "cult hideout wishgranter"
	id = "cult_hideout"


/obj/structure/interactive/wishgranter/normal/hell/
	name = "hell wishgranter"
	id = "hell"

/obj/structure/interactive/wishgranter/normal/hell/chapel
	name = "hell chapel wishgranter"
	id = "hell_chapel"