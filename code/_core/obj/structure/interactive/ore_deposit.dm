/obj/structure/interactive/ore_deposit/

	name = "ore deposit"
	desc = ""
	desc_extended = "Chonky"

	icon = 'icons/obj/structure/ore.dmi'
	icon_state = "deposit"

	initialize_type = INITIALIZE_LATE
	mouse_opacity = 0

	var/ore_amount = 1 //How much ore is in the vein?

	anchored = 2

/obj/structure/interactive/ore_deposit/Finalize()
	. = ..()
	update_sprite()

/obj/structure/interactive/ore_deposit/update_icon()
	. = ..()
	var/material/M = MATERIAL(material_id)
	if(M.icon_state_ore_deposit)
		icon_state = M.icon_state_ore_deposit
	else if(M.color)
		color = M.color

/obj/structure/interactive/ore_deposit/update_sprite()
	. = ..()
	if(prob(75))
		var/matrix/M = get_base_transform()
		M.Turn(pick(90,180,270))
		transform = M

/obj/structure/interactive/ore_deposit/proc/create_ore(var/atom/caller,var/atom/drop_location,var/ore_to_create = 1)

	ore_to_create = CEILING(ore_to_create,1) //Round up.
	ore_to_create = min(ore_to_create,ore_amount) //Don't make more than what is possible.

	if(ore_to_create <= 0)
		return TRUE

	if(!drop_location)
		return FALSE

	if(drop_location.type == /obj/structure/interactive/ore_box)
		var/obj/structure/interactive/ore_box/OB = drop_location
		OB.contained_ore[src.material_id] += ore_to_create
	else
		for(var/i=1,i<=CEILING(ore_to_create/3,1),i++)
			if(ore_to_create <= 0) //Possible race condition.
				break
			var/obj/item/material/ore/TO = new(get_turf(src))
			TO.material_id = material_id
			INITIALIZE(TO)
			TO.amount = min(ore_amount,3)
			FINALIZE(TO)
			ore_to_create -= TO.amount
			if(drop_location) TO.drop_item(drop_location)
			ore_amount -= TO.amount

	if(ore_amount <= 0)
		qdel(src) //Empty!

	return TRUE



//FLOOR ORE
/obj/structure/interactive/ore_deposit/floor
	name = "deep ore deposit"
	layer = LAYER_FLOOR_PLATING
	ore_amount = 5
	anchored = 2
	plane = PLANE_FLOOR_ATTACHMENT

/obj/structure/interactive/ore_deposit/floor/Finalize()
	. = ..()
	if(.)
		update_alpha()

/obj/structure/interactive/ore_deposit/floor/create_ore(var/atom/caller,var/atom/drop_location,var/ore_to_create = 1)
	. = ..()
	if(.)
		update_alpha()

/obj/structure/interactive/ore_deposit/floor/proc/update_alpha()
	alpha = clamp(ore_amount*(1/100),75,255)
	return TRUE


//WALL ORE
/obj/structure/interactive/ore_deposit/wall
	name = "ore deposit"
	layer = LAYER_WALL_DECAL
	plane = PLANE_WALL_ATTACHMENT

/obj/structure/interactive/ore_deposit/wall/Finalize()
	. = ..()
	var/turf/simulated/T = get_turf(src)
	if(T && is_simulated(T))
		T.attach(src)