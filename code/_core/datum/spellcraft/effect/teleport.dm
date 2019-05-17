/spellcraft/effect/teleport
	name = "Teleport"
	id = "effect_teleport"
	icon_state = "cult_teleport"

/spellcraft/effect/teleport/on_cast(var/turf/cast_loc,var/mob/living/caster,var/atom/target,var/effect_color,var/spell_mod_id,var/spell_buff_id)

	var/spellcraft/modifier/M = all_modifiers[spell_mod_id]
	var/final_x = M.teleport_center_x
	var/final_y = M.teleport_center_y
	var/list/hsv = ReadHSV(RGBtoHSV(effect_color))
	var/offset_x = sin(hsv[1])
	var/offset_y = sin(hsv[1])
	var/strength = hsv[3]*0.01*WORLD_SIZE_SEGMENT*0.5 - WORLD_SIZE_SEGMENT

	final_x += floor(offset_x*strength)
	final_y += floor(offset_y*strength)

	var/turf/selected_turf = locate(final_x,final_y,1)

	if(get_turf(caster) != cast_loc)
		caster.to_chat(span("notice","You need to be standing on the rune in order to cast it!"))
		return FALSE

	if(!selected_turf || !selected_turf.is_safe_teleport())
		caster.to_chat(span("warning","The rune fizzes weakly as you touch it..."))
		return FALSE

	caster.force_move(selected_turf)

	return ..()