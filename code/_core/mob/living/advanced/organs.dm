/mob/living/advanced/proc/remove_organ(var/obj/item/organ/O,var/do_delete = FALSE)

	if(length(O.inventories))
		for(var/k in O.inventories)
			var/obj/hud/inventory/I = k
			I.delete_objects()
			I.remove_from_owner()

	if(is_tail(O))
		remove_overlay("tail_behind")
		remove_overlay("tail_front")
	else
		remove_overlay("\ref[O]")
	organs -= O
	labeled_organs -= O.id

	if(do_delete)
		qdel(O)

	O.on_organ_remove(src)

/mob/living/advanced/proc/remove_all_organs(var/do_delete=TRUE)

	for(var/k in organs)
		var/obj/item/organ/O = k
		remove_organ(O,do_delete)

/mob/living/advanced/proc/add_species_organs()

	var/species/S = SPECIES(species)

	if(!S)
		log_error("WARNING: INVALID SPECIES: [species].")
		return FALSE

	var/obj/hud/screen/B
	var/initially_disabled = FALSE
	if(client)
		initially_disabled = client.disable_controls
		client.disable_controls = TRUE
		B = new()
		B.icon = 'icons/hud/discovery.dmi' //320x320
		B.icon_state = "black"
		B.screen_loc = "CENTER-4.5,CENTER-4.5"
		B.client = src.client
		B.maptext = "<font size='4'>Loading...</font>"
		B.maptext_width = 320
		B.maptext_height = 300
		B.maptext_y = 20
		B.mouse_opacity = 0
		B.layer = 99 //I DON'T GIFE A FUKC
		client.screen += B
		client.update_zoom(3)
	if(sex == FEMALE) //I wonder when feminism will leak into programming. In about 99% of games, females are the exception in games while males are the default.
		for(var/key in S.spawning_organs_female)
			add_organ(S.spawning_organs_female[key])
			if(world_state == STATE_RUNNING) sleep(world.tick_lag)
	else
		for(var/key in S.spawning_organs_male)
			add_organ(S.spawning_organs_male[key])
			if(world_state == STATE_RUNNING) sleep(world.tick_lag)

	if(client)
		if(B)
			client.screen -= B
			qdel(B)
			client.update_zoom(2)
		if(!initially_disabled)
			client.disable_controls = FALSE

/mob/living/advanced/proc/add_organ(var/obj/item/organ/O)
	O = new O(src)
	return attach_organ(O)

/mob/living/advanced/proc/attach_organ(var/obj/item/organ/O,var/initialize=TRUE)

	if(labeled_organs[O.attach_flag])
		var/obj/item/organ/A = labeled_organs[O.attach_flag]
		O.attach_to(A)

	organs += O
	labeled_organs[O.id] = O
	O.update_owner(src) //This updates inventories.

	if(initialize)
		INITIALIZE(O)
		FINALIZE(O)

	if(is_tail(O))
		add_overlay_tracked("tail_behind",O,desired_layer = LAYER_MOB_TAIL_BEHIND, desired_icon_state = "tail_behind")
		add_overlay_tracked("tail_front",O,desired_layer = LAYER_MOB_TAIL_FRONT, desired_icon_state = "tail_front")
	else
		add_overlay_tracked("\ref[O]",O,desired_layer = O.worn_layer)

	O.on_organ_add(src)

	return O