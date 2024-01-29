//Purely visual effect for bloated zombies.

/status_effect/fat
	name = "Fat"
	desc = "You're fat."
	id = FAT

	default_magnitude = 100
	default_duration = -1

	affects_dead = TRUE

/status_effect/fat/on_effect_added(mob/living/owner,atom/source,magnitude,duration,stealthy)

	. = ..()

	if(is_advanced(owner) && !owner.is_player_controlled())
		var/mob/living/advanced/A = owner
		var/obj/item/organ/torso/T = A.labeled_organs[BODY_TORSO]
		T.icon_state = "[initial(T.icon_state)]_fat"
		T.handle_overlays(A,worn=TRUE,update=TRUE)


/status_effect/fat/on_effect_removed(mob/living/owner,magnitude,duration)

	. = ..()

	if(is_advanced(owner) && !owner.is_player_controlled())
		var/mob/living/advanced/A = owner
		var/obj/item/organ/torso/T = A.labeled_organs[BODY_TORSO]
		T.icon_state = "[initial(T.icon_state)]"
		T.handle_overlays(A,worn=TRUE,update=TRUE)

