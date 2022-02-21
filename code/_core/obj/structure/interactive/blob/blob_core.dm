/obj/structure/interactive/blob/core
	name = "blob core"
	icon_state = "core"
	health_base = 500
	var/list/obj/structure/interactive/blob/linked_walls = list()
	var/list/obj/structure/interactive/blob/node/linked_nodes = list()
	var/current_node = 1

	health_states = 0

	var/next_grow = 0

/obj/structure/interactive/blob/core/New(var/desired_loc,var/desired_owner)
	color = random_color()
	. = ..()

/obj/structure/interactive/blob/core/Destroy()

	for(var/k in linked_walls)
		var/obj/structure/interactive/blob/B = k
		B.health.adjust_loss_smart(brute=max(0,B.health.health_current - 1))
		B.health.update_health()
		B.color = null

	linked_walls?.Cut()
	linked_nodes?.Cut()

	return ..()

/obj/structure/interactive/blob/core/Initialize()

	for(var/d in DIRECTIONS_ALL)
		var/turf/T = get_step(src,d)
		var/obj/structure/interactive/blob/node/N = new(T,src)
		N.color = color
		INITIALIZE(N)
		FINALIZE(N)
		GENERATE(N)
		linked_nodes += N

	return ..()

/obj/structure/interactive/blob/core/PostInitialize()
	. = ..()
	start_thinking(src)

/obj/structure/interactive/blob/core/think()

	if(next_grow <= world.time)
		var/node_count = length(linked_nodes)
		if(node_count > 0)
			if(current_node > node_count)
				current_node = 1
			var/obj/structure/interactive/blob/node/N = linked_nodes[current_node]
			var/obj/effect/blob_grow/grow_effect = new(N.loc)
			N.grow_charge(src,grow_effect)
			current_node++
		next_grow = world.time + CEILING(SECONDS_TO_DECISECONDS(10)/max(1,node_count),1)

	. = ..()

/obj/structure/interactive/blob/core/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"core_overlay")
	I.appearance_flags = RESET_COLOR | KEEP_APART
	add_overlay(I)
