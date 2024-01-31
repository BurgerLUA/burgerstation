/obj/item/weapon/melee/hierophant_staff
	name = "staff of the hierophant"
	desc = "No longer living, I think."
	desc_extended = "A magical staff belonging to the late Hierophant. Allows for teleportation."

	icon = 'icons/obj/item/heirophant_staff.dmi'

	damage_type = /damagetype/melee/club/mace

	size = SIZE_3

	weight = 8

	value = 5000

	held_pixel_x = -16
	held_pixel_y = -16

	var/next_teleport_command = 0

	item_slot = SLOT_TORSO_BACK

	rarity = RARITY_MYTHICAL

/obj/item/weapon/melee/hierophant_staff/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(object.plane >= PLANE_HUD)
		return ..()

	if(next_teleport_command <= world.time)
		var/turf/T = get_turf(object)
		if(T)
			var/area/A = T.loc
			if(A.flags_area & FLAG_AREA_NO_TELEPORT)
				caller.to_chat(span("danger","\The [src.name]'s magic doesn't seem to work here!"))
				return TRUE
			var/obj/effect/temp/hazard/hierophant/targeted/H = new(get_turf(caller),7,caller)
			H.dir = caller.dir
			H.target = T
			H.should_teleport = TRUE
			next_teleport_command = world.time + SECONDS_TO_DECISECONDS(5)
			INITIALIZE(H)
			return TRUE

	return ..()
