/spellcraft/effect/teleport
	name = "Teleport"
	id = "effect_teleport"
	icon_state = "cult_teleport"

/spellcraft/effect/teleport/on_cast(var/turf/cast_loc,var/mob/living/caster,var/atom/target,var/effect_color,var/spell_mod_id,var/spell_buff_id)

	if(!is_advanced(caster))
		return FALSE

	var/mob/living/advanced/A = caster

	var/spellcraft/modifier/M = all_modifiers[spell_mod_id]
	var/final_x = M.teleport_center_x
	var/final_y = M.teleport_center_y
	var/list/hsv = ReadHSV(RGBtoHSV(effect_color))
	var/offset_x = sin(hsv[1])
	var/offset_y = cos(hsv[1])
	var/strength = hsv[3]*0.01*WORLD_SIZE_SEGMENT*0.5 - WORLD_SIZE_SEGMENT

	final_x += FLOOR(offset_x*strength, 1)
	final_y += FLOOR(offset_y*strength, 1)

	var/turf/selected_turf = locate(final_x,final_y,1)

	if(!selected_turf || !selected_turf.is_safe_teleport())
		A.to_chat(span("warning","The rune fizzes weakly as you touch it..."))
		return FALSE

	var/list/callback_list = list()
	callback_list["start_turf"] = get_turf(A)
	callback_list["end_turf"] = selected_turf
	add_progress_bar(A,"teleport",SECONDS_TO_DECISECONDS(10),callback_list)

	return ..()

/spellcraft/effect/teleport/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params,var/obj/item/weapon/ranged/magic/rune/R)

	if(caller.loc != R.loc)
		caller.to_chat(span("notice","\The [R] doesn't seem to react."))
		return FALSE

	on_cast(R.loc,caller,caller,R.stored_effect_color,R.stored_modifier,R.stored_buff)

	return TRUE