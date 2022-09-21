/mob/living/advanced/proc/perform_specieschange(var/desired_species,var/keep_clothes,var/chargen)

	if(!desired_species)
		return FALSE

	var/list/kept_clothes = pre_perform_change(keep_clothes)

	known_languages.Cut()
	species = desired_species
	var/species/S = SPECIES(species)
	if(S.genderless)
		sex = MALE
		gender = MALE

	post_perform_change(keep_clothes,chargen,kept_clothes)

/mob/living/advanced/proc/perform_sexchange(var/desired_sex,var/keep_clothes,var/chargen)

	if(sex == desired_sex)
		return FALSE

	var/list/kept_clothes = pre_perform_change(keep_clothes)

	sex = desired_sex
	gender = desired_sex
	post_perform_change(keep_clothes,chargen,kept_clothes)

	return TRUE

/mob/living/advanced/proc/pre_perform_change(var/keep_items)

	remove_chargen_buttons()

	var/list/kept_items = list()

	if(keep_items)
		kept_items = drop_all_items(get_turf(src))
	else
		for(var/k in inventories_by_id)
			var/obj/hud/inventory/I = inventories_by_id[k]
			I.delete_objects()

	remove_all_organs()

	return kept_items

/mob/living/advanced/proc/post_perform_change(var/keep_items,var/chargen,var/list/kept_items = list())

	if(chargen) add_chargen_buttons()

	species_initialize(set_default=TRUE)

	if(length(kept_items))
		equip_objects_in_list(kept_items)
	else
		equip_loadout(/loadout/new_player,TRUE)

	show_hud(TRUE,FLAG_HUD_ALL,FLAG_HUD_SPECIAL,speed=SECONDS_TO_DECISECONDS(3))

	for(var/obj/hud/button/hide_show_inventory/B in buttons)
		B.update_sprite()

	QUEUE_HEALTH_UPDATE(src)


