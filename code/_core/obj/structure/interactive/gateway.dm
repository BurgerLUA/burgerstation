/obj/structure/interactive/gateway
	name = "gateway"
	desc = "Brings you to places!"
	icon = 'icons/obj/structure/gateway.dmi'
	icon_state = "gateway"
	pixel_x = -32
	pixel_y = -32

	plane = PLANE_OBJ

	var/enabled = FALSE

	var/obj/structure/interactive/gateway/linked_gateway

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
	bullet_block_chance = 0

	density = TRUE

/obj/structure/interactive/gateway/Destroy()
	set_active(FALSE)
	if(linked_gateway)
		linked_gateway.linked_gateway = null
		linked_gateway = null
	. = ..()

/obj/structure/interactive/gateway/Initialize()
	. = ..()
	if(!linked_gateway)
		for(var/obj/structure/interactive/gateway/G in world)
			if(G == src)
				continue
			if(G.linked_gateway)
				continue
			linked_gateway = G
			G.linked_gateway = src
			break

/obj/structure/interactive/gateway/proc/set_active(var/active=TRUE,var/recursive=TRUE)
	if(!linked_gateway)
		active = FALSE
	enabled = active
	update_sprite()
	if(recursive && linked_gateway)
		linked_gateway.set_active(active,recursive=FALSE)
	return TRUE

/obj/structure/interactive/gateway/update_icon()
	. = ..()
	icon_state = initial(icon_state)
	if(enabled)
		icon_state = "[icon_state]_on"


/obj/structure/interactive/gateway/Crossed(atom/movable/O)

	. = ..()

	if(enabled && linked_gateway && is_player(O))
		var/mob/living/advanced/player/P = O
		if(P.loyalty_tag == "NanoTrasen")
			O.force_move(get_step(linked_gateway,SOUTH))


