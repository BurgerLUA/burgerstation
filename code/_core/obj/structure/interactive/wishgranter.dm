var/list/all_wishgranters = list()


obj/structure/interactive/wishgranter
	name = "wishgranter"
	desc = "What secrets does this hold?"
	density = 0
	icon = 'icons/obj/structure/future/wishgranter.dmi'
	icon_state = "wishgranter"


	light_range = 5
	light_power = 4
	light_color = "#FFFFFF"

obj/structure/interactive/wishgranter/fake/New()
	//Do literally nothing.


obj/structure/interactive/wishgranter/New()
	..()
	all_wishgranters += src

obj/structure/interactive/wishgranter/spawn_and_join_faction
	var/faction_to_join

obj/structure/interactive/wishgranter/spawn_and_join_faction/clicked_by_object(caller,object,location,control,params)

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
	P.update_faction_icons()

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



obj/structure/interactive/wishgranter/normal/village
	name = "village wishgranter"
	id = "village"