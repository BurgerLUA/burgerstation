/mob/living/advanced/pre_death()

	if(client)
		var/obj/item/storage/heavy/corpse/C = new(src.loc)
		var/list/dropped_items = drop_all_items(exclude_soulbound = TRUE,exclude_containers=TRUE)

		var/savedata/client/mob/U = client.savedata
		U.save_current_character()

		for(var/obj/item/I in dropped_items)
			C.add_to_inventory(src,I,FALSE)

		queue_delete(C,3000)

	else
		delete_all_items()


/mob/living/advanced/post_death()
	..()
	new/obj/effect/temp/death(get_turf(src))
	qdel(src)

/mob/living/advanced/handle_status_effects()
	. = ..()
	if(. && status & FLAG_STATUS_CRIT)
		if(stamina_current>=stamina_max*0.50)
			set_hard_crit(FALSE)

	return .

/mob/living/advanced/proc/set_hard_crit(var/hard_crit_enabled = TRUE)

	if(hard_crit_enabled)
		adjust_stamina(-stamina_current)
		status |= FLAG_STATUS_CRIT
		stun_time = -1
	else
		status &= ~FLAG_STATUS_CRIT
		stun_time = 5

	return TRUE

/mob/living/advanced/check_death()
	if(health_current <= 0)
		if(!has_hard_crit || status & FLAG_STATUS_CRIT)
			return TRUE
		else
			set_hard_crit(TRUE)
			return FALSE

	return FALSE