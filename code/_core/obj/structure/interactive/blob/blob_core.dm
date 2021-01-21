/obj/structure/interactive/blob/core
	name = "blob core"
	icon_state = "core"
	health_base = 500
	var/list/obj/structure/interactive/blob/linked_walls = list()
	var/list/obj/structure/interactive/blob/node/linked_nodes = list()
	var/list/obj/structure/interactive/blob/damaged_walls = list()
	var/growth_value = 0

	health_states = 0

	var/resources_to_spend = 36 //Early growth.
	var/blob_limit = 640

/obj/structure/interactive/blob/core/proc/get_nodes_to_create()
	return FLOOR(length(linked_walls)*(1/18),1) - length(linked_nodes)

/obj/structure/interactive/blob/core/Initialize()

	for(var/d in DIRECTIONS_ALL)
		var/turf/T = get_step(src,d)
		var/obj/structure/interactive/blob/node/N = new(T,src)
		INITIALIZE(N)
		FINALIZE(N)
		linked_nodes += N

	return ..()

/obj/structure/interactive/blob/core/PostInitialize()
	. = ..()
	start_thinking(src)
	return .

/obj/structure/interactive/blob/core/Destroy()

	for(var/k in linked_walls)
		var/obj/structure/interactive/blob/B = k
		B.health.adjust_loss_smart(brute=max(0,B.health.health_current - 1))
		B.health.update_health()
		B.color = null

	linked_walls.Cut()
	linked_nodes.Cut()
	return ..()

/obj/structure/interactive/blob/core/proc/get_valid_turfs() //Should only be used by nodes and cores.

	. = list()

	if(length(linked_walls))
		for(var/k in linked_walls)
			var/list/obj/structure/interactive/blob/B = k
			for(var/d in DIRECTIONS_CARDINAL)
				var/turf/T = get_step(B,d)
				if(!T)
					continue
				var/obj/structure/interactive/blob/B2 = locate() in T.contents
				if(!B2 && !is_wall(T) && !istype(T,/turf/simulated/hazard/))
					. += T

	for(var/d in DIRECTIONS_CARDINAL)
		var/turf/T = get_step(src,d)
		if(!T)
			continue
		var/obj/structure/interactive/blob/B = locate() in T.contents
		if(!B && !is_wall(T) && !istype(T,/turf/simulated/hazard/))
			. += T

	return .

/obj/structure/interactive/blob/core/think()

	growth_value += 1
	desc = "Growth: [growth_value]. Resources: [resources_to_spend]."

	if((growth_value >= GROWTH_AMOUNT) && length(linked_nodes))
		resources_to_spend += 0 + FLOOR((world.time/10)/120,1) //1 extra point every 120 seconds.
		growth_value = 0
		if(resources_to_spend <= 0)
			return ..()
		var/list/valid_turfs = get_valid_turfs()
		for(var/i=1,i<=CEILING(length(linked_nodes),1),i++)
			CHECK_TICK(75,0)
			var/obj/structure/interactive/blob/node/N = linked_nodes[i]
			if(N.check_jugs())
				resources_to_spend -= 5
			if(resources_to_spend <= 0)
				break
			if(!length(valid_turfs))
				break
			if(length(linked_walls) > blob_limit)
				break
			var/turf/simulated/floor/F = pick(valid_turfs)
			var/obj/structure/interactive/blob/node/N2 = locate() in range(5,F)
			if(!N2 || get_nodes_to_create() >= 1)
				var/obj/structure/interactive/blob/node/B = new(F,src)
				resources_to_spend -= 5
				INITIALIZE(B)
				FINALIZE(B)
			else
				var/obj/structure/interactive/blob/wall/B = new(F,src)
				resources_to_spend -= 1
				INITIALIZE(B)
				FINALIZE(B)
			valid_turfs -= F

	return ..()

/obj/structure/interactive/blob/core/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"core_overlay")
	I.appearance_flags = KEEP_TOGETHER | RESET_COLOR
	add_overlay(I)
	return .