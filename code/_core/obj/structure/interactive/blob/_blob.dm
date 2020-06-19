/obj/structure/interactive/blob/
	name = "blob piece"
	icon = 'icons/obj/structure/blob.dmi'
	health = /health/blob
	var/has_damaged_state = FALSE
	var/obj/structure/interactive/blob/core/linked_core
	color = "#00D100"

	health_base = 250

/obj/structure/interactive/blob/New(var/desired_loc,var/obj/structure/interactive/blob/core/desired_owner)
	. = ..()
	if(desired_owner)
		linked_core = desired_owner
	return .

/obj/structure/interactive/blob/Initialize()
	. = ..()
	update_sprite()
	return .

/obj/structure/interactive/blob/update_icon()

	. = ..()

	if(has_damaged_state)
		if(health && health.health_current <= health.health_max*0.5)
			icon_state = "[initial(icon_state)]_damaged"
		else
			icon_state = initial(icon_state)

	return .

/obj/structure/interactive/blob/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"[icon_state]_glow")
	I.appearance_flags = KEEP_TOGETHER | RESET_COLOR
	I.plane = PLANE_LIGHTING
	I.layer = 99
	I.blend_mode = BLEND_MULTIPLY
	I.alpha = 150
	add_overlay(I)
	return .

#define GROWTH_AMOUNT 100

/obj/structure/interactive/blob/core
	name = "blob core"
	icon_state = "blob_core"
	health_base = 1000
	var/list/obj/structure/interactive/blob/wall/linked_walls = list()
	var/list/obj/structure/interactive/blob/node/linked_nodes = list()
	var/growth_value = 0


/obj/structure/interactive/blob/core/Initialize()
	. = ..()
	start_thinking(src)
	return .

/obj/structure/interactive/blob/core/proc/get_valid_turfs() //Should only be used by nodes and cores.

	. = list()

	for(var/d in DIRECTIONS_CARDINAL)
		var/turf/T = get_step(src,d)
		var/obj/structure/interactive/blob/B = locate() in T.contents
		if(!B && !is_wall(T))
			. += T

	return .

/obj/structure/interactive/blob/node/proc/get_valid_turfs() //Should only be used by nodes and cores.

	. = list()

	if(length(linked_walls))
		for(var/list/obj/structure/interactive/blob/wall/W in linked_walls)
			for(var/d in DIRECTIONS_CARDINAL)
				var/turf/T = get_step(W,d)
				var/obj/structure/interactive/blob/B = locate() in T.contents
				if(!B && !is_wall(T))
					. += T

	for(var/d in DIRECTIONS_CARDINAL)
		var/turf/T = get_step(src,d)
		var/obj/structure/interactive/blob/B = locate() in T.contents
		if(!B && !is_wall(T))
			. += T

	return .

/obj/structure/interactive/blob/node/proc/grow()

	var/list/valid_turfs = get_valid_turfs()
	if(length(valid_turfs))
		var/turf/simulated/floor/F = pick(valid_turfs)
		var/obj/structure/interactive/blob/node/N = locate() in range(5,F)
		if(!N)
			var/obj/structure/interactive/blob/node/B = new(F,linked_core)
			INITIALIZE(B)
			linked_nodes += B
		else
			var/obj/structure/interactive/blob/wall/B = new(F,linked_core)
			INITIALIZE(B)
			linked_walls += B

	return ..()

/obj/structure/interactive/blob/core/think()

	growth_value += 1

	desc = "Growth: [growth_value]."

	if(growth_value >= GROWTH_AMOUNT)
		var/list/valid_turfs = get_valid_turfs()
		if(length(valid_turfs))
			var/turf/simulated/floor/F = pick(valid_turfs)
			var/obj/structure/interactive/blob/node/N = locate() in range(5,F)
			if(!N)
				var/obj/structure/interactive/blob/node/B = new(F,src)
				INITIALIZE(B)
				linked_nodes += B
			else
				var/obj/structure/interactive/blob/wall/B = new(F,src)
				INITIALIZE(B)
				linked_walls += B
		growth_value = 0
		for(var/obj/structure/interactive/blob/node/N in linked_nodes)
			N.grow()

	return ..()

/obj/structure/interactive/blob/core/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"blob_core_overlay")
	I.appearance_flags = KEEP_TOGETHER | RESET_COLOR
	I.plane = PLANE_EFFECT
	I.layer = 99
	add_overlay(I)
	return .

/obj/structure/interactive/blob/node
	name = "blob node"
	icon_state = "blob_node"
	has_damaged_state = TRUE

	health_base = 500

	var/list/obj/structure/interactive/blob/wall/linked_walls = list()
	var/list/obj/structure/interactive/blob/node/linked_nodes = list()

/obj/structure/interactive/blob/node/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"blob_node_overlay")
	I.appearance_flags = KEEP_TOGETHER | RESET_COLOR
	I.plane = PLANE_EFFECT
	I.layer = 99
	add_overlay(I)
	return .

/obj/structure/interactive/blob/wall
	name = "blob wall"
	icon_state = "blob"
	has_damaged_state = TRUE