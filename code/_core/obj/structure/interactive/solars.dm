/obj/structure/interactive/solar_panel
	name = "solar panel"
	desc = "Green energy from a blue square. You can't make this up."
	desc_extended = "A solar panel is an collection of photo-voltaic cells for use in converting natural sunlight into usable energy."
	icon = 'icons/obj/structure/solar.dmi'
	icon_state = "solar"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	value = 200

	density = TRUE
	anchored = TRUE

	layer = 9999

	//health = /health/construction/
	//health_base = 100

	wire_powered = TRUE

	pixel_z = 6

/obj/structure/interactive/solar_panel/power_process(var/power_multiplier=1)
	update_power_supply(get_power_supply())
	. = ..()

/obj/structure/interactive/solar_panel/get_power_supply()
	var/turf/T = loc
	if(!istype(loc))
		return 5
	return CEILING(10 + T.lightness * 290,1)