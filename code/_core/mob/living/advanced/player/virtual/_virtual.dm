/mob/living/advanced/player/virtual
	name = "virtual avatar"
	allow_save = FALSE
	damage_received_multiplier = 0.25

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



/mob/living/advanced/player/virtual/try_logout()

	if(!is_player(fallback_mob))
		return FALSE

	if(!istype(fallback_mob.loc,/obj/structure/interactive/vr_pod/))
		return FALSE

	var/choice = input("Are you sure you want to quit virtual reality? You won't be able to reenter until the current virtual reality round is over.","Quit Virtual Reality Round","Cancel") as null|anything in list("Yes","No","Cancel")
	if(choice != "Yes")
		return FALSE

	if(!is_player(fallback_mob))
		return FALSE

	if(!istype(fallback_mob.loc,/obj/structure/interactive/vr_pod/))
		return FALSE

	var/obj/structure/interactive/vr_pod/VR = fallback_mob.loc
	VR.exit_virtual_reality()

	return TRUE