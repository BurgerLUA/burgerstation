/spellcraft/effect/
	id = null
	icon = 'icons/obj/items/weapons/ranged/magic/spellcraft/sigil.dmi'
	icon_state = ""

/spellcraft/effect/proc/on_cast(var/turf/cast_loc,var/mob/living/caster,var/atom/target,var/effect_color,var/spell_mod_id,var/spell_buff_id)
	return TRUE