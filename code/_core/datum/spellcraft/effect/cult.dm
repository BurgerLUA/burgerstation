/spellcraft/effect/cult/teleport
	id = "teleport"

/spellcraft/effect/cult/teleport/on_cast(var/turf/cast_loc,var/mob/living/caster,var/atom/target,var/effect_color,var/spell_mod_id,var/spell_buff_id)

	var/spellcraft/modifier/M = all_modifers[spell_mod_id]
	var/final_x = M.teleport_center_x
	var/final_y = M.teleport_center_y
	var/list/hsv = ReadHSV(RGBtoHSV(effect_color))
	var/offset_x = sin(hsv[1])
	var/offset_y = sin(hsv[1])
	var/strength = hsv[3]*0.005*WORLD_SIZE_SEGMENT

	final_x += floor(offset_x*strength)
	final_y += floor(offset_y*strength)


	var/turf/selected_turf = locate(final_x,final_y,1)





