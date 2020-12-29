/obj/structure/interactive/computer/console/mech_fabricator
	name = "mech fabricator console"
	desc = "Print the rights to mechs here."
	desc_extended = "Use this console if you wish to purchase the rights and insurance to your very own mech! Some assembly required."
	computer_type = "mecha"
	keyboard_type = "tech_key"

	var/obj/marker/mech_fabricator/linked_marker


/obj/structure/interactive/computer/console/mech_fabricator/PostInitialize()

	. = ..()

	linked_marker = locate() in range(VIEW_RANGE,src)

	if(!linked_marker)
		log_error("WARNING: Could not find a linked mech fabricator marker for [src.get_debug_name()]!")
		qdel(src)

	return .


/obj/structure/interactive/computer/console/mech_fabricator/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_player(caller))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	var/mob/living/advanced/player/P = caller
	P.dialogue_target_id = /dialogue/npc/mech_fabricator/
	open_menu(P,/menu/dialogue/)

	return TRUE