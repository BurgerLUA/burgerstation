//This is basically a holder of spellcraft casting. There should be no variations of it since that's held somewhere else.
/obj/item/weapon/ranged/magic/rune
	name = "magic rune"

	var/stored_buff
	var/stored_buff_color

	var/stored_effect
	var/stored_effect_color

	var/stored_modifier
	var/stored_modifier_color

/obj/item/weapon/ranged/magic/rune/New(var/new_loc,var/mob/owner,var/desired_effect,var/desired_modifer,var/desired_buff,var/desired_effect_color,var/desired_modifier_color,var/desired_buff_color)

	stored_effect = desired_effect
	stored_effect_color = desired_effect_color

	stored_modifier = desired_modifer
	stored_modifier_color = desired_modifier_color

	stored_buff = desired_buff
	stored_buff_color = desired_buff_color

	filters += filter(type="drop_shadow", x=0, y=0, size=6, offset=0, color=stored_effect_color)

	..()
	update_icon()

/obj/item/weapon/ranged/magic/rune/update_icon()

	var/icon/new_icon = ICON_INVISIBLE

	if(stored_effect)
		var/spellcraft/effect/E = all_effects[stored_effect]
		var/icon/I = new /icon(E.icon,E.icon_state)
		I.Blend(stored_effect_color,ICON_MULTIPLY)
		new_icon.Blend(I,ICON_OVERLAY)

	if(stored_modifier)
		var/spellcraft/modifier/M = all_modifiers[stored_modifier]
		var/icon/I = new /icon(M.icon,M.icon_state)
		I.Blend(stored_modifier_color,ICON_MULTIPLY)
		new_icon.Blend(I,ICON_OVERLAY)

	if(stored_buff)
		var/spellcraft/buff/B = all_buffs[stored_buff]
		var/icon/I = new /icon(B.icon,B.icon_state)
		I.Blend(stored_buff_color,ICON_MULTIPLY)
		new_icon.Blend(I,ICON_OVERLAY)

	icon = new_icon

/obj/item/weapon/ranged/magic/rune/on_drop(var/obj/hud/inventory/old_inventory,var/atom/new_loc)
	if(!is_inventory(new_loc) || is_dynamic_inventory(new_loc))
		qdel(src)
		return

/obj/item/weapon/ranged/magic/rune/shoot(var/mob/caller as mob,var/atom/object,location,params)

	var/spellcraft/effect/E = all_effects[stored_effect]

	//TODO: Average the colors
	E.on_cast(get_turf(src),caller,object,stored_effect_color,stored_modifier,stored_buff)

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		A.mana_regen_delay = max(A.mana_regen_delay,30)

	return TRUE

/obj/item/weapon/ranged/magic/rune/can_be_held(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	var/spellcraft/effect/E = all_effects[stored_effect]
	return E.can_be_held

/obj/item/weapon/ranged/magic/rune/can_be_worn(var/mob/living/advanced/owner,var/obj/hud/inventory/I)
	return FALSE

/obj/item/weapon/ranged/magic/rune/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!can_be_held(caller,object))
		var/spellcraft/effect/E = all_effects[stored_effect]
		if(E.clicked_on_by_object(caller,object,location,control,params,src))
			return TRUE

	return ..()