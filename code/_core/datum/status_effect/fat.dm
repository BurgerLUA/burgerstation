//Purely visual effect for bloated zombies.

/status_effect/fat
	name = "Fat"
	desc = "You're fat."
	id = FAT

	default_magnitude = 100
	default_duration = -1

	affects_dead = TRUE

/status_effect/fat/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	. = ..()

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		var/obj/item/organ/torso/T = A.labeled_organs[BODY_TORSO]
		T.icon_state = "[initial(T.icon_state)]_fat"
		A.update_overlay_tracked("\ref[T]",desired_icon_state=T.icon_state)


/status_effect/fat/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)

	. = ..()

	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		var/obj/item/organ/torso/T = A.labeled_organs[BODY_TORSO]
		T.icon_state = "[initial(T.icon_state)]_fat"
		A.update_overlay_tracked("\ref[T]",desired_icon_state=T.icon_state)
