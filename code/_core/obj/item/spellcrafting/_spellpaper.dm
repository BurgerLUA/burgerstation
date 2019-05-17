/obj/item/spellpaper
	name = "spellcasting paper"

	icon = 'icons/obj/items/paper.dmi'
	icon_state = "clean_blank"

	var/stored_buff
	var/stored_buff_color

	var/stored_effect
	var/stored_effect_color

	var/stored_modifier
	var/stored_modifier_color

/obj/item/spellpaper/New(var/desired_loc)
	if(!stored_buff_color)
		stored_buff_color = random_color()

	if(!stored_effect_color)
		stored_effect_color = random_color()

	if(!stored_modifier_color)
		stored_modifier_color = random_color()

	if(stored_effect)
		filters += filter(type="drop_shadow", x=0, y=0, size=6, offset=0, color=stored_effect_color)
	else if(stored_modifier)
		filters += filter(type="drop_shadow", x=0, y=0, size=6, offset=0, color=stored_modifier_color)
	else if(stored_buff)
		filters += filter(type="drop_shadow", x=0, y=0, size=6, offset=0, color=stored_buff_color)

	..()
	update_icon()

/obj/item/spellpaper/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/new_icon = new /icon(icon,icon_state)

	if(stored_buff)
		var/spellcraft/buff/B = all_buffs[stored_buff]
		var/icon/I = new /icon(B.icon,B.icon_state)
		I.Scale(16,16)
		I.Blend(stored_buff_color,ICON_MULTIPLY)
		new_icon.Blend(I,ICON_OVERLAY)

	if(stored_effect)
		var/spellcraft/effect/E = all_effects[stored_effect]
		var/icon/I = new /icon(E.icon,E.icon_state)
		I.Scale(16,16)
		I.Blend(stored_effect_color,ICON_MULTIPLY)
		new_icon.Blend(I,ICON_OVERLAY)

	if(stored_modifier)
		var/spellcraft/modifier/M = all_modifiers[stored_modifier]
		var/icon/I = new /icon(M.icon,M.icon_state)
		I.Scale(16,16)
		I.Blend(stored_modifier_color,ICON_MULTIPLY)
		new_icon.Blend(I,ICON_OVERLAY)

	icon = new_icon