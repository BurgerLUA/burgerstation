/spellcraft/effect/damage
	name = "Bloodboil"
	id = "effect_damage"
	icon_state = "cult_bloodboil"
	var/base_damage = 20

//TODO: REDO THIS
/spellcraft/effect/damage/on_cast(var/turf/cast_loc,var/mob/living/caster,var/atom/target,var/effect_color,var/spell_mod_id,var/spell_buff_id)
	/*
	var/spellcraft/modifier/M = all_modifiers[spell_mod_id]
	var/damage_type = M.damage_type
	var/damage_mod = 1 + (GetRedPart(effect_color) + GetGreenPart(effect_color) + GetBluePart(effect_color))/(255*3)
	damage_mod *= 1 + caster.get_skill_power(SKILL_MAGIC)
	//target.adjust_loss(damage_type,base_damage * damage_mod)
	*/