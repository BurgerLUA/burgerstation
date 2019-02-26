/* OLD MOVEMENT
/mob/living/advanced/do_step(var/turf/new_loc, var/movement_override = 0)

	. = ..()

	var/movement_delay = get_movement_delay()

	if(left_hand)
		left_hand.do_drag(.,movement_override ? movement_override : movement_delay)

	if(right_hand)
		right_hand.do_drag(.,movement_override ? movement_override : movement_delay)
*/


/mob/living/advanced/on_sprint()
	if(adjust_stamina(-3))
		update_health_elemement_icons()
	return ..()
