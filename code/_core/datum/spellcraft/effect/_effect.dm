/spellcraft/effect/
	name = "EFFECT ERROR"
	id = "effect_none"
	icon = 'icons/obj/items/weapons/ranged/magic/spellcraft/sigil.dmi'
	icon_state = "cult_1"
	var/can_be_held = FALSE

/spellcraft/effect/proc/on_cast(var/turf/cast_loc,var/mob/living/caster,var/atom/target,var/effect_color,var/spell_mod_id,var/spell_buff_id)
	return TRUE

/spellcraft/effect/proc/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params,var/obj/item/weapon/ranged/magic/rune/R)
	return TRUE