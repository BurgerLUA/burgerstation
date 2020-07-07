var/global/list/possible_hostage_types = list(
	/mob/living/advanced/npc/unique/hostage/clown,
	/mob/living/advanced/npc/unique/hostage/assistant,
	/mob/living/advanced/npc/unique/hostage/scientist
)

/mob/living/advanced/npc/unique/hostage/
	ai = /ai/advanced/hostage
	health_base = 300 //Extra health so the escort mission isn't fucking hell.
	var/hostage = TRUE
	queue_delete_on_death = FALSE

/mob/living/advanced/npc/unique/hostage/post_move()

	. = ..()

	if(SShorde && hostage && src.z == 2 && src.x > 119)

		hostage = FALSE
		SShorde.queue_objectives_update()
		ai.set_move_objective(null)
		dialogue_id = null

		var/obj/marker/map_node/N_start = find_closest_node(src)
		if(N_start)
			var/obj/marker/hostage_rest/HR = get_turf(pick(possible_hostage_rest_markers))
			var/obj/marker/map_node/N_end = find_closest_node(HR)
			if(N_end)
				var/obj/marker/map_node/list/found_path = N_start.find_path(N_end)
				if(found_path)
					ai.set_path(found_path)

	return .

/mob/living/advanced/npc/unique/hostage/Initialize()
	. = ..()
	src.add_organ(/obj/item/organ/internal/implant/hand/left/iff/nanotrasen)
	src.add_organ(/obj/item/organ/internal/implant/head/loyalty/nanotrasen)
	return .

/mob/living/advanced/npc/unique/hostage/bar_shaleez
	name = "Bar-Shaleez"
	species = "reptile_advanced"
	sex = FEMALE
	gender = FEMALE
	dialogue_id = /dialogue/hostage/bar_shaleez

/mob/living/advanced/npc/unique/hostage/bar_shaleez/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#779922")
	change_organ_visual("eyes", desired_color = "#F2F200")
	change_organ_visual("hair_head", desired_color = "#779922", desired_icon_state = "frills_short")
	update_all_blends()
	equip_loadout(/loadout/shaleez)
	return .

/mob/living/advanced/npc/unique/hostage/diamond_with_flaw
	name = "Diamond with Flaw"
	desc = "Fucking trees."
	species = "diona"
	sex = NEUTER
	gender = MALE
	dialogue_id = /dialogue/hostage/diamond_with_flaw

/mob/living/advanced/npc/unique/hostage/diamond_with_flaw/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#BC9D58")
	change_organ_visual("skin_detail", desired_color = "#719333")
	change_organ_visual("skin_glow", desired_color = "#B2F861")
	update_all_blends()
	equip_loadout(/loadout/diamond_with_flaw)
	return .

/mob/living/advanced/npc/unique/hostage/marwani
	name = "Ilaeza Marwani"
	species = "reptile_advanced"
	sex = FEMALE
	gender = FEMALE
	dialogue_id = /dialogue/hostage/marwani

/mob/living/advanced/npc/unique/hostage/marwani/Initialize()
	. = ..()
	change_organ_visual("skin", desired_color = "#8CA73E")
	change_organ_visual("hair_head", desired_color = "#fff0be", desired_icon_state = "frills")
	update_all_blends()
	equip_loadout(/loadout/marwani)
	return .

/mob/living/advanced/npc/unique/hostage/assistant
	name = "Urist McRobust"
	sex = MALE
	gender = MALE
	dialogue_id = /dialogue/hostage/assistant

/mob/living/advanced/npc/unique/hostage/assistant/Initialize()
	. = ..()
	update_all_blends()
	equip_loadout(/loadout/new_player)
	return .


/mob/living/advanced/npc/unique/hostage/clown
	name = "Charles the Clown"
	sex = MALE
	gender = MALE
	dialogue_id = /dialogue/hostage/assistant

/mob/living/advanced/npc/unique/hostage/clown/Initialize()
	. = ..()
	update_all_blends()
	equip_loadout(/loadout/clown)
	return .


/mob/living/advanced/npc/unique/hostage/scientist
	name = "Chad Thundercock"
	sex = MALE
	gender = MALE
	dialogue_id = /dialogue/hostage/assistant

/mob/living/advanced/npc/unique/hostage/scientist/Initialize()
	. = ..()
	update_all_blends()
	equip_loadout(/loadout/scientist)
	return .