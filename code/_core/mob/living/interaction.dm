mob/living/on_right_down(object,location,control,params)
	return src.attack(src,object,params)

mob/living/on_left_down(object,location,control,params)
	return src.attack(src,object,params)

/mob/living/on_mouse_wheel(var/atom/object,delta_x,delta_y,location,control,params)
	return object.mouse_wheel_on_object(src,delta_x,delta_y,location,control,params)