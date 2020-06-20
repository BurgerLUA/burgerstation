#define GROWTH_AMOUNT 100

/obj/structure/interactive/blob/
	name = "blob piece"
	icon = 'icons/obj/structure/blob.dmi'
	health = /health/blob
	var/has_damaged_state = FALSE
	var/obj/structure/interactive/blob/core/linked_core
	color = "#80CC2A"

	plane = PLANE_WALL_ATTACHMENTS

	health_base = 250

	anchored = TRUE

	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC
	collision_dir = NORTH | EAST | SOUTH | WEST

	var/health_states = 0


/obj/structure/interactive/blob/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/stealthy=FALSE)

	. = ..()

	if(. && linked_core && damage_amount > 0)
		linked_core.damaged_walls += src

	return .

/obj/structure/interactive/blob/Cross(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	if(istype(O,/mob/living/simple/npc/blobbernaught))
		return TRUE
	return ..()

/obj/structure/interactive/blob/can_be_attacked()
	return TRUE

/obj/structure/interactive/blob/Destroy()
	if(linked_core)
		linked_core.linked_walls -= src
		linked_core.linked_nodes -= src
		linked_core = null
	return ..()

/obj/structure/interactive/blob/New(var/desired_loc,var/obj/structure/interactive/blob/core/desired_owner)
	. = ..()
	if(desired_owner)
		linked_core = desired_owner
		linked_core.linked_walls += src

	return .

/obj/structure/interactive/blob/Initialize()
	. = ..()
	var/matrix/M = matrix()
	M.Turn(pick(0,90,180,270))
	transform = M
	transform *= 0.1
	animate(src,transform = M,time = 10)

	update_sprite()
	return .

/obj/structure/interactive/blob/update_icon()

	. = ..()

	var/icon_mul = health_states ? FLOOR( (health.health_current / health.health_max) * health_states,1) : 0
	icon_state = "[initial(icon_state)]_[icon_mul]"

	return .

/obj/structure/interactive/blob/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"[icon_state]")
	I.appearance_flags = KEEP_TOGETHER | RESET_COLOR
	I.plane = PLANE_LIGHTING
	I.blend_mode = BLEND_MULTIPLY
	add_overlay(I)
	return .