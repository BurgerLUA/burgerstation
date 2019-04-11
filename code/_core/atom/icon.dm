/atom/proc/update_icon()
	//icon = new_icon

/atom/proc/initialize_blends()
	return TRUE

/atom/proc/add_blend(var/desired_id,var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_blend, var/desired_type, var/desired_should_save)
	if(blend_exists(desired_id))
		change_blend(desired_id,desired_icon,desired_icon_state,desired_color,desired_blend,desired_type)
		return additional_blends[desired_id]
	else
		var/icon_blend/IB = new(desired_id, desired_icon, desired_icon_state, desired_color, desired_blend, desired_type, desired_should_save)
		additional_blends[desired_id] = IB
		return IB

/atom/proc/change_blend(var/desired_id,var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_blend, var/desired_type)

	world.log << "WE WANT A NEW BLEND FOR [desired_id] WITH THE COLOR [desired_color]."

	if(!additional_blends[desired_id])
		return FALSE

	if(desired_icon)
		additional_blends[desired_id].icon = desired_icon

	if(desired_icon_state)
		additional_blends[desired_id].icon_state = desired_icon_state

	if(desired_color)
		additional_blends[desired_id].color = desired_color

	if(desired_blend)
		additional_blends[desired_id].blend = desired_blend

	if(desired_type)
		additional_blends[desired_id].special_type = desired_type

	return TRUE

/atom/proc/blend_exists(var/desired_id)
	return additional_blends[desired_id]





