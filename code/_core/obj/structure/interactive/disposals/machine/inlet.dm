/obj/structure/interactive/disposals/machine/inlet
	name = "disposals inlet"
	desc = "Express delivery!"
	desc_extended = "Throw various things in here, including yourself."
	icon_state = "intake"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	collision_dir = 0x0

	bullet_block_chance = 50

	density = TRUE

/obj/structure/interactive/disposals/machine/inlet/set_dir(var/desired_dir,var/force = FALSE)

	. = ..()

	if(.)
		var/desired_c_dir = NORTH | EAST | SOUTH | WEST
		desired_c_dir &= ~dir
		update_collisions(c_dir = desired_c_dir)



/obj/structure/interactive/disposals/machine/inlet/Crossed(atom/movable/O,atom/OldLoc)


	if(O.collision_flags & FLAG_COLLISION_ETHEREAL)
		return ..()

	if(istype(O,/obj/disposals_container/))
		return ..()

	var/obj/disposals_container/disposals_container = locate() in src.contents
	if(!disposals_container)
		disposals_container = new(src)
		INITIALIZE(disposals_container)
		GENERATE(disposals_container)
		FINALIZE(disposals_container)
	O.force_move(disposals_container)
	O.glide_size = TILE_SIZE / DECISECONDS_TO_TICKS(1)

	. = ..()