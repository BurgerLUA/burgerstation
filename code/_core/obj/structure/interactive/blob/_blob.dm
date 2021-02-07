#define GROWTH_AMOUNT 100

/obj/structure/interactive/blob/
	name = "blob piece"
	icon = 'icons/obj/structure/blob.dmi'
	var/has_damaged_state = FALSE
	var/obj/structure/interactive/blob/core/linked_core
	color = "#80CC2A"

	plane = PLANE_OBJ

	anchored = TRUE

	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC
	collision_dir = NORTH | EAST | SOUTH | WEST

	damage_type = /damagetype/blob_attack/

	health = /health/construction/
	health_base = 125

	density = TRUE

	var/health_states = 0

/obj/structure/interactive/blob/on_destruction(var/mob/caller,var/damage = FALSE)
	. = ..()
	qdel(src)
	return .

/obj/structure/interactive/blob/can_attack(var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(!health || health.health_current <= 0 || !color || color == "#FFFFFF")
		return FALSE

	if(is_living(victim))
		if(istype(victim,/mob/living/simple/blobbernaught))
			return FALSE
		var/mob/living/L = victim
		if(L.dead)
			return FALSE
		if(L.loyalty_tag == "Blob")
			return FALSE

	return ..()

/obj/structure/interactive/blob/proc/check_mobs()

	. = FALSE

	for(var/mob/living/L in range(1,src))
		if(!src.can_attack(L,src,null,damage_type))
			continue
		if(!L.can_be_attacked(src,src,null,damage_type))
			continue
		src.attack(src,L,precise = TRUE)
		if(L.loc != src.loc && src.loc.Enter(L,L.loc) && get_dist(linked_core,L) >= get_dist(linked_core,src))
			L.force_move(src.loc)
		. = TRUE

	if(. && !CALLBACK_EXISTS("check_mobs_\ref[src]"))
		CALLBACK("check_mobs_\ref[src]",30,src,.proc/check_mobs)

/obj/structure/interactive/blob/Crossed(atom/movable/O)
	if(is_living(O))
		check_mobs()
	return ..()

/obj/structure/interactive/blob/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(. && linked_core && damage_amount > 0)
		linked_core.damaged_walls += src

	if(health && health.health_current <= 0)
		qdel(src)
	else
		update_sprite()

	if(damage_amount > 0 && get_dist(attacker,src) <= 1 && !CALLBACK_EXISTS("check_mobs_\ref[src]"))
		CALLBACK("check_mobs_\ref[src]",10,src,.proc/check_mobs)

	return .

/obj/structure/interactive/blob/Cross(atom/movable/O)
	if(istype(O,/mob/living/simple/blobbernaught))
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

/obj/structure/interactive/blob/PostInitialize()
	. = ..()
	var/matrix/M = matrix()
	M.Turn(pick(0,90,180,270))
	transform = M
	transform *= 0.1
	animate(src,transform = M,time = 10)

	update_sprite()

	CALLBACK("check_mobs_\ref[src]",10,src,.proc/check_mobs)

	return .

/obj/structure/interactive/blob/update_icon()

	. = ..()

	var/turf/T = get_turf(src)

	if(T)
		var/icon_mul = health && health_states ? FLOOR( (health.health_current / health.health_max) * health_states,1) : 0
		var/desired_state = "[initial(icon_state)]_[icon_mul]"
		if(desired_state != icon_state)
			if(icon_state != initial(icon_state))
				play_sound(pick('sound/effects/impacts/flesh_01.ogg','sound/effects/impacts/flesh_02.ogg','sound/effects/impacts/flesh_03.ogg'),T)
			icon_state = desired_state

	return .

/obj/structure/interactive/blob/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"[icon_state]")
	I.appearance_flags = KEEP_TOGETHER | RESET_COLOR
	I.plane = PLANE_LIGHTING
	I.blend_mode = BLEND_MULTIPLY
	add_overlay(I)
	return .