/mob/living/advanced/player/virtual
	name = "virtual avatar"
	allow_save = FALSE


/mob/living/advanced/player/virtual/initialize_attributes()

	if(!is_player(fallback_mob))
		return ..()

	var/mob/living/advanced/player/P = fallback_mob

	attributes = P.attributes

/mob/living/advanced/player/virtual/initialize_skills()

	if(!is_player(fallback_mob))
		return ..()

	var/mob/living/advanced/player/P = fallback_mob

	skills = P.skills

/mob/living/advanced/player/virtual/post_death()

	. = ..()

	if(SSvirtual_reality.current_virtual_reality)
		SSvirtual_reality.current_virtual_reality.player_post_death(src)