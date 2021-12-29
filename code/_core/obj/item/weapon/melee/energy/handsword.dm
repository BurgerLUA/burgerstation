/obj/item/weapon/melee/energy/handsword
	name = "energy handsword"
	desc = "A strangely made handsword."
	desc_extended = "A strangely made handsword meant to be welded in hand-to-hand combat. Uses a hybrid of the user's melee and unarmed skill."
	icon = 'icons/obj/item/weapons/melee/laser/handsword.dmi'
	damage_type = /damagetype/unarmed/fists
	damage_type_on = /damagetype/melee/sword/handsword

	value = 500

	size = SIZE_2

	dan_mode = TRUE

/obj/item/weapon/melee/energy/handsword/click_self(var/mob/caller)

	. = ..()

	if(.)
		if(enabled)
			play_sound(pick('sound/weapons/handsword/deploy.ogg'),get_turf(src),range_max=VIEW_RANGE*0.5)
		else
			play_sound(pick('sound/weapons/handsword/retract.ogg'),get_turf(src),range_max=VIEW_RANGE*0.5)
