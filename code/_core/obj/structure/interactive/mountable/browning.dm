/obj/structure/interactive/mountable/browning
	name = "browning emplacement"
	desc = "The Old Reliable."
	desc_extended = "A heavy-duty machine gun. Definitely not what you want to have staring at you. Alt-click while on it to grab the firing handles."
	icon = 'icons/obj/structure/mountable/browning.dmi'
	icon_state = "unloaded"

	plane = PLANE_MOB
	layer = LAYER_MOB_ABOVE

	density = TRUE

	bullet_block_chance = 15	//it's pretty big and chairs literally have 25

	var/obj/item/weapon/ranged/bullet/magazine/misc/browning/stored_weapon
	var/obj/item/magazine/browning_127/stored_magazine
	var/obj/item/browning_handle/stored_handle

/obj/structure/interactive/mountable/browning/Destroy()
	QDEL_NULL(stored_weapon)
	QDEL_NULL(stored_magazine)
	QDEL_NULL(stored_handle)
	. = ..()

//prototyped from barricades, gun sprite shifted to position around player sprites
/obj/structure/interactive/mountable/browning/PostInitialize()

	update_sprite()

	. = ..()

/obj/structure/interactive/mountable/browning/update_sprite()

	mag_check(src)

	if(dir == NORTH)
		pixel_x = 0
		pixel_y = 16
		layer = LAYER_MOB_BELOW
	else if(dir == EAST)
		pixel_x = 16
		pixel_y = -3
	else if(dir == SOUTH)
		pixel_x = 0
		pixel_y = -17
	else if(dir == WEST)
		pixel_x = -16
		pixel_y = -3

	. = ..()

//prototyped from turret
/obj/structure/interactive/mountable/browning/Finalize()

	stored_weapon = new /obj/item/weapon/ranged/bullet/magazine/misc/browning(src)
	INITIALIZE(stored_weapon)
	GENERATE(stored_weapon)
	FINALIZE(stored_weapon)

	stored_weapon.linked_gun = src

	stored_handle = new /obj/item/browning_handle(src)
	INITIALIZE(stored_handle)
	GENERATE(stored_handle)
	FINALIZE(stored_handle)

	stored_handle.linked_gun = src

	mag_check(src)

/obj/item/browning_handle
	name = "browning handles"
	desc = "Keep 'em steady."
	desc_extended = "You'll need to wield them with both hands to fire the gun properly."
	icon = 'icons/obj/item/browning_handle.dmi'

	var/obj/structure/interactive/mountable/browning/linked_gun

	should_save = FALSE
	throwable = FALSE
	can_wield = TRUE

	size = 99

	weight = 2

/obj/item/browning_handle/Destroy()
	QDEL_NULL(linked_gun)
	. = ..()

//prototyped from defib paddles
/obj/item/browning_handle/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_inventory(object))
		return ..()

	if(caller.is_busy())
		return TRUE

	if(!linked_gun)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(10)
		caller.to_chat(span("danger","Unlinked handle error detected. Report at #bug-reports on Discord on how you encountered this bug."))
		drop_item(get_turf(src))
		return TRUE

	if(object == linked_gun)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		drop_item(get_turf(src))
		return TRUE

	//shoot gun
	else if(wielded)
		if(angle2dir_cardinal(get_angle(caller,object)+90)==linked_gun.dir)
			linked_gun.stored_weapon.shoot(caller,object,location,params,damage_multiplier=1)
		else
			caller.to_chat(span("warning","You can't turn the gun that far!"))

	return ..()

/obj/item/browning_handle/on_drop(var/obj/hud/inventory/old_inventory,var/atom/new_loc,var/silent=TRUE)
	if(!istype(new_loc, /obj/hud/inventory/organs/)) //juggling between hands 'drops' and fucks it
		wielded = FALSE
		if(old_inventory.child_inventory) //from weapons, deals with dropping the wield
			old_inventory.child_inventory.parent_inventory = null
			old_inventory.child_inventory.update_sprite()
			old_inventory.child_inventory = null
		if(linked_gun == null)
			qdel(src)
		else
			src.force_move(linked_gun)
		return TRUE
	return ..()

//taken from chairs, sits down if you move onto it, but only once
/obj/structure/interactive/mountable/browning/Crossed(atom/movable/O)

	. = ..()

	if(is_living(O))
		CALLBACK("sit_down_\ref[src]",SECONDS_TO_DECISECONDS(1),src,.proc/mount_your_ass,O)


/obj/structure/interactive/mountable/browning/proc/mount_your_ass(var/mob/living/L)

	if(L.loc != src.loc)
		return FALSE

	L.set_dir(src.dir)

	return TRUE

/obj/structure/interactive/mountable/browning/proc/mag_check(var/structure/interactive/mountable/browning/M)
	if(stored_magazine)
		if(length(stored_magazine.stored_bullets) < 1)
			icon_state = "empty"
		else
			icon_state = "loaded"
		return TRUE
	else
		icon_state = "unloaded"

	return TRUE

//pack 'em up, from turret
/obj/structure/interactive/mountable/browning/proc/can_pack_up(var/mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(qdeleting || !isturf(src.loc))
		caller.to_chat(span("warning","You can't pack up \the [src.name] here!"))
		return FALSE

	return TRUE

/obj/structure/interactive/mountable/browning/proc/pack_up(var/mob/caller)

	caller.visible_message(span("warning","\The [caller.name] packs up \the [src.name]."),span("notice","You pack up \the [src.name]."))

	var/mob/living/advanced/A = caller

	if(istype(A.left_item, /obj/item/browning_handle))
		A.left_item.drop_item()
	if(istype(A.right_item, /obj/item/browning_handle))
		A.right_item.drop_item()

	if(stored_magazine)
		stored_magazine.drop_item(get_turf(src))
		stored_magazine = null

	var/obj/item/deployable/mountable/browning/D = new(get_turf(src))
	INITIALIZE(D)
	FINALIZE(D)

	qdel(src)

	return TRUE

/obj/structure/interactive/mountable/browning/drop_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(caller != object)
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(10)

	if(can_pack_up(caller))
		caller.visible_message(span("warning","\The [caller.name] starts to pack up \the [src.name]..."),span("notice","You start to pack up \the [src.name]..."))
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(5),.proc/pack_up,caller)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_pack_up,caller)

	return TRUE

//shows ammo count
/obj/structure/interactive/mountable/browning/get_examine_list(var/mob/examiner)
	. = ..()
	if(stored_magazine)
		. += div("notice","It has a magazine latched on, with [length(stored_magazine.stored_bullets)]/[stored_magazine.bullet_count_max] bullets left.")
	else
		. += div("warning","It is missing a magazine.")

//clickies by player on the gun
/obj/structure/interactive/mountable/browning/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	if(istype(object,/obj/item/magazine/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(2)

		var/obj/item/magazine/M = object
		var/obj/item/weapon/ranged/bullet/magazine/W = stored_weapon

		if(!M.weapon_whitelist[W.type])
			caller.to_chat(span("warning","This turret doesn't accept this type of magazine!"))
			return FALSE

		if(stored_magazine)
			caller.to_chat(span("notice","You swap out the magazine of \the [src.name]."))
			stored_magazine.update_icon()
			stored_magazine.drop_item(get_turf(src))
			stored_magazine = null
		else
			caller.to_chat(span("notice","You insert a new magazine into \the [src.name]."))

		M.drop_item(src)
		stored_magazine = M
		play_sound(M.get_magazine_insert_sound(),get_turf(src),range_max=VIEW_RANGE*0.25)

		mag_check(src)

		return TRUE

	if(istype(object,/obj/item/browning_handle/))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		var/obj/item/browning_handle/H = object
		H.drop_item(src)

		return TRUE

	if(caller.attack_flags & CONTROL_MOD_DISARM && is_inventory(object) && is_advanced(caller) && (get_dist(caller,src)<1))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		caller.visible_message(span("notice","\The [caller.name] grabs hold of the handles..."),span("notice","You grab the handles..."))
		var/obj/hud/inventory/I = object
		I.add_object(stored_handle)

		return TRUE

	return ..()

//drops handles when moved off the gun
/obj/structure/interactive/mountable/browning/Uncrossed(atom/movable/O)
	if(is_advanced(O))
		var/mob/living/advanced/A = O
		if(istype(A.left_item, /obj/item/browning_handle))
			A.left_item.drop_item(get_turf(src))
		if(istype(A.right_item, /obj/item/browning_handle))
			A.right_item.drop_item(get_turf(src))
		return ..()