/obj/structure/interactive/blob/core
	name = "blob core"
	icon_state = "core"
	health_base = 500
	var/list/obj/structure/interactive/blob/linked_walls = list()
	var/list/obj/structure/interactive/blob/node/linked_nodes = list()
	var/current_node = 1

	health_states = 1

	var/next_grow = 0
	var/fast_grows_left = 100
	var/heal_amount = 10 //How much to heal as well the starting HP of new blob walls.

	var/list/lost_turfs = list()

	var/blob_limit = 700


/obj/structure/interactive/blob/core/New(var/desired_loc,var/obj/structure/interactive/blob/core/desired_owner)
	color = random_color()
	if(!color)
		color = "#00FF00"
	. = ..()

/obj/structure/interactive/blob/core/PreDestroy()

	for(var/k in linked_walls)
		var/obj/structure/interactive/blob/B = k
		B.health.adjust_loss_smart(brute=max(0,B.health.health_current - 1))
		B.color = null
		B.update_health_state()
		B.update_sprite()

	. = ..()


/obj/structure/interactive/blob/core/Destroy()

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
	START_THINKING(src)

/obj/structure/interactive/blob/core/think()

	if(next_grow <= world.time || fast_grows_left > 0)
		var/node_count = length(linked_nodes)
		if(node_count)
			if(health.health_current > 0)
				health.adjust_loss_smart(brute = -node_count) //Core gets HP regen.
			if(current_node > node_count)
				current_node = 1
			var/turf/priority_turf
			if(length(lost_turfs))
				priority_turf = pick(lost_turfs)
			var/obj/structure/interactive/blob/node/N = linked_nodes[current_node]
			N.grow_charge(src,src,1,priority_turf)
			next_grow = world.time + CEILING(SECONDS_TO_DECISECONDS(5)/max(1,node_count),1)
			current_node++
			if(fast_grows_left > 0)
				fast_grows_left--

	. = ..()

/obj/structure/interactive/blob/core/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)
	. = ..()
	if(.)
		fast_grows_left += damage_table[BRUTE] + damage_table[BURN]

/obj/structure/interactive/blob/core/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"core_overlay")
	I.appearance_flags = src.appearance_flags | RESET_COLOR | KEEP_APART
	add_overlay(I)
