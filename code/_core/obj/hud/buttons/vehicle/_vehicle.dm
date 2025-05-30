/obj/hud/button/vehicle/
	name = "vehicle button"
	desc = ""
	icon = 'icons/hud/vehicle.dmi'
	icon_state = ""
	screen_loc = "CENTER,CENTER"

	flags_hud = FLAG_HUD_VEHICLE

	has_quick_function = FALSE

/obj/hud/button/vehicle/weapon
	name = "left weapon"
	icon = 'icons/hud/vehicle_long.dmi'
	icon_state = "right"
	screen_loc = "CENTER-2.5,BOTTOM:12"
	maptext = "Left Weapon"
	maptext_width = TILE_SIZE*3 - 8
	maptext_x = 4
	var/weapon_slot = 1

/obj/hud/button/vehicle/weapon/proc/set_map_text(var/desired_text)
	maptext = desired_text
	return TRUE

/obj/hud/button/vehicle/weapon/update_owner(var/mob/desired_owner)

	. = ..()

	if(owner && is_advanced(owner))
		var/mob/living/advanced/A = owner
		if(A.driving && length(A.driving.equipment) >= weapon_slot && A.driving.equipment[weapon_slot])
			set_map_text(A.driving.equipment[weapon_slot].name)


/obj/hud/button/vehicle/weapon/right
	name = "right weapon"
	icon_state = "left"
	screen_loc = "CENTER+0.5,BOTTOM:12"
	maptext = "<div style='text-align:right'>Right Weapon</div>"
	maptext_width = TILE_SIZE*3 - 8
	maptext_x = 4
	weapon_slot = 2

/obj/hud/button/vehicle/weapon/right/set_map_text(var/desired_text)
	maptext = "<div style='text-align:right'>[desired_text]</div>"
	return TRUE

//Eject
/obj/hud/button/vehicle/eject
	name = "eject"
	icon_state = "eject"
	screen_loc = "RIGHT,BOTTOM:12+2"

/obj/hud/button/vehicle/eject/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(activator))
		var/mob/living/advanced/A = activator
		if(A.driving)
			A.driving.exit_vehicle(A,get_turf(A.driving))

/*
/obj/hud/button/vehicle/ammo_display
	name = "ammo display"
	icon_state = "none"
	var/weapon_slot = 1
	screen_loc = "CENTER-1.4,BOTTOM:12+0.5"

/obj/hud/button/vehicle/ammo_display/proc/set_map_text(var/desired_text)
	maptext = desired_text
	return TRUE

/obj/hud/button/vehicle/ammo_display/proc/update_ammo()
	if(is_advanced(owner))
		var/mob/living/advanced/A = owner
		if(A.driving && length(A.driving.equipment) >= weapon_slot && istype(A.driving.equipment[weapon_slot],/obj/item/weapon/ranged/))
			var/obj/item/weapon/ranged/E = A.driving.equipment[weapon_slot]
			set_map_text("[E.get_ammo_count()]")

/obj/hud/button/vehicle/ammo_display/right
	name = "ammo display"
	icon_state = "none"
	weapon_slot = 2
	screen_loc = "CENTER+1.4,BOTTOM:12+0.5"

/obj/hud/button/vehicle/ammo_display/right/set_map_text(var/desired_text)
	maptext = "<div style='text-align:right'>[desired_text]</div>"
	return TRUE
*/