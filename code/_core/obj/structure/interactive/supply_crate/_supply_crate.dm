/obj/structure/interactive/supply_crate
	name = "supply crate"
	desc = "I wonder what is inside?"
	desc_extended = "An old, ancient military supply crate used by various corporations to send shipments across colonies."
	icon = 'icons/obj/structure/supply_crate.dmi'
	icon_state = "supply"

	health = /health/construction/

	health_base = 25

	bullet_block_chance = 25

	initialize_type = INITIALIZE_LATE

/obj/structure/interactive/supply_crate/on_destruction(var/atom/caller,var/damage = FALSE)

	for(var/i=1,i<=5,i++)
		new /obj/effect/temp/crate_gib/(src.loc,30)

	for(var/atom/movable/M in contents)
		M.force_move(src.loc)
		animate(M,pixel_x = rand(-16,16),pixel_y = rand(-16,16),time = 10)

	qdel(src)

	return TRUE