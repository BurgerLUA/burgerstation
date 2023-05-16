/obj/structure/interactive/slime_wall
	name = "slime wall"
	icon = 'icons/obj/effects/slime_tile.dmi'
	icon_state = "block"

	plane = PLANE_MOVABLE
	layer = LAYER_LARGE_OBJ

	density = 1
	anchored = 1

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC
	collision_dir = NORTH | EAST | SOUTH | WEST

	bullet_block_chance = 100

	health = /health/construction
	health_base = 500

	color = "#0094FF"

	mouse_opacity = 2

	alpha = 220

	var/permanent = FALSE

/obj/structure/interactive/slime_wall/permanent
	permanent = TRUE

/obj/structure/interactive/slime_wall/Cross(atom/movable/O,atom/oldloc)

	if(is_living(O))
		var/mob/living/L = O
		if(L.loyalty_tag == "Slime")
			return TRUE //Allow slimes to cross.

	return ..()

/obj/structure/interactive/slime_wall/on_destruction(var/damage = TRUE)
	. = ..()
	qdel(src)

/obj/structure/interactive/slime_wall/update_underlays()
	. = ..()
	var/image/I = new/image(icon,"tile")
	I.appearance_flags = src.appearance_flags | KEEP_APART
	I.plane = PLANE_WIRE
	I.layer = LAYER_FLOOR_CARPET + 10
	I.alpha = 200
	add_underlay(I)

/obj/structure/interactive/slime_wall/Finalize()
	. = ..()
	update_sprite()
	var/original_color = color
	var/matrix/M = matrix()
	M.Scale(0)
	transform = M
	color = "#FFFFFF"
	animate(
		src,
		transform=get_base_transform(),
		color=original_color,
		pixel_z = 6,
		time=10
	)
	animate(
		pixel_z = 0,
		time = 5
	)
	if(!permanent)
		CALLBACK("\ref[src]_telegraph_delete",300,src,src::telegraph_delete())


/obj/structure/interactive/slime_wall/proc/telegraph_delete()
	if(src.qdeleting)
		return FALSE
	var/matrix/M = matrix()
	M.Scale(0)
	animate(src,transform=M,alpha=0,time=20)
	CALLBACK("\ref[src]_timed_destruction",20,src,src::do_delete())

/obj/structure/interactive/slime_wall/proc/do_delete()
	if(src.qdeleting)
		return FALSE
	qdel(src)
	return TRUE