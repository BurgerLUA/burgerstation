//Purely visual effect for roided zombies.

/status_effect/buff
	name = "Buff"
	desc = "You're buff."
	id = BUFF

	default_magnitude = 100
	default_duration = -1

	affects_dead = TRUE

/status_effect/buff/on_effect_added(var/mob/living/owner,var/atom/source,var/magnitude,var/duration,var/stealthy)

	. = ..()

	if(is_advanced(owner) && !owner.is_player_controlled())
		var/mob/living/advanced/A = owner
		var/obj/item/organ/L = A.labeled_organs[BODY_ARM_LEFT]
		L.icon_state = "[initial(L.icon_state)]_buff"
		L.handle_overlays(A,worn=TRUE,update=TRUE,icon_state_override=L.icon_state)

		var/obj/item/organ/R = A.labeled_organs[BODY_ARM_RIGHT]
		R.icon_state = "[initial(R.icon_state)]_buff"
		R.handle_overlays(A,worn=TRUE,update=TRUE,icon_state_override=R.icon_state)

		var/obj/item/organ/T = A.labeled_organs[BODY_TORSO]
		T.icon_state = "[initial(T.icon_state)]_buff"
		T.handle_overlays(A,worn=TRUE,update=TRUE,icon_state_override=T.icon_state)

/status_effect/buff/on_effect_removed(var/mob/living/owner,var/magnitude,var/duration)

	. = ..()

	if(is_advanced(owner) && !owner.is_player_controlled())
		var/mob/living/advanced/A = owner
		var/obj/item/organ/L = A.labeled_organs[BODY_ARM_LEFT]
		L.icon_state = "[initial(L.icon_state)]"
		L.handle_overlays(A,worn=TRUE,update=TRUE,icon_state_override=L.icon_state)

		var/obj/item/organ/R = A.labeled_organs[BODY_ARM_RIGHT]
		R.icon_state = "[initial(R.icon_state)]"
		R.handle_overlays(A,worn=TRUE,update=TRUE,icon_state_override=R.icon_state)

		var/obj/item/organ/T = A.labeled_organs[BODY_TORSO]
		T.icon_state = "[initial(T.icon_state)]"
		T.handle_overlays(A,worn=TRUE,update=TRUE,icon_state_override=T.icon_state)