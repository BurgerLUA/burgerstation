/obj/item/weapon/melee/energy/energy_wrench
	name = " energy wrench"
	desc = "You done fucked up now, boy..."
	desc_extended = "An energy wrench that can fit any bolt in the known universe. For your angry engineer needs."
	icon = 'icons/obj/item/weapons/melee/laser/wrench.dmi'

	damage_type = /damagetype/melee/sword/energy_wrench
	damage_type_on = /damagetype/melee/sword/energy_wrench/on

	value = 1200

	size = SIZE_2
	weight = 3

/obj/item/weapon/melee/energy/energy_wrench/click_self(var/mob/caller)

	. = ..()

	if(.)
		SPAM_CHECK(20)
		if(enabled)
			play_sound('sound/weapons/energy/energy_on.ogg',get_turf(src),range_max=VIEW_RANGE)
		else
			play_sound('sound/weapons/energy/energy_off.ogg',get_turf(src),range_max=VIEW_RANGE)
// cant use both the sounds and the wrench flag code
//obj/item/weapon/melee/energy/energy_wrench/click_self(var/mob/caller)
//
//	INTERACT_CHECK
//	INTERACT_DELAY(1)
//
//	if(enabled)
//		enabled = FALSE
//		update_sprite()
//		stop_thinking(src)
//
//	else
//		enabled = TRUE
//		update_sprite()
//		flags_tool = FLAG_TOOL_WRENCH
//
//
//	return TRUE


