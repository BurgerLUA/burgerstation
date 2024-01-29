/spellcraft/effect/
	name = "EFFECT ERROR"
	id = "effect_none"
	icon = 'icons/obj/items/weapons/ranged/magic/spellcraft/sigil.dmi'
	icon_state = "cult_1"
	var/can_be_held = FALSE

/spellcraft/effect/proc/on_cast(turf/cast_loc,mob/living/caster,atom/target,effect_color,spell_mod_id,spell_buff_id)
	return TRUE

/spellcraft/effect/proc/clicked_on_by_object(mob/caller as mob,atom/object,location,control,params,obj/item/weapon/ranged/magic/rune/R)
	return TRUE