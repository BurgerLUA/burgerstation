#define ICON_BLEND_NONE 0x0
#define ICON_BLEND_COLOR 0x1
#define ICON_BLEND_MASK 0x2
#define ICON_BLEND_OVERLAY 0x4

/icon_blend/
	var/id
	var/icon
	var/icon_state
	var/color
	var/blend
	var/special_type
	var/should_save
	var/layer

/icon_blend/New(var/desired_id, var/desired_icon,var/desired_icon_state,var/desired_color,var/desired_blend, var/desired_type, var/desired_should_save, var/desired_layer)

	if(desired_icon)
		icon = desired_icon

	if(desired_icon_state)
		icon_state = desired_icon_state

	if(desired_color)
		color = desired_color

	if(desired_blend)
		blend = desired_blend

	if(desired_id)
		id = desired_id

	if(desired_type)
		special_type = desired_type

	if(desired_should_save)
		should_save = desired_should_save

	if(desired_layer)
		layer = desired_layer