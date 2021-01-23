/turf/simulated/floor/carpet
	name = "carpet"
	icon = 'icons/turf/floor/carpet.dmi'
	desc = "A nice carpet floor."
	icon_state = "floor"
	corner_icons = TRUE
	corner_category = "carpet"
	desc = "A carpeted floor"
	desc_extended = "A carpet with an awesomesauce design that has no flaws whatsoever"

	footstep = /footstep/carpet

	destruction_turf = /turf/simulated/floor/plating

/turf/simulated/floor/carpet/office
	name = "office carpet"
	icon = 'icons/turf/floor/carpet_office.dmi'
	desc = "Office flooring"
	desc_extended = "Boring office floor; may or may not smell vaguely of urine"
	icon_state = "1"

/turf/simulated/floor/carpet/office/New(var/desired_loc)
	. = ..()
	icon_state = "[rand(1,4)]"
	return .
