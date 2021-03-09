/obj/item/weapon/ranged/bow

	requires_bullets = TRUE

	empty_sounds = list(

	)

	automatic = FALSE

	var/stage_per_decisecond = 2 //There are 40 stages. 40 is max.
	var/current_stage = 0

	var/mob/living/advanced/current_shooter

	override_icon_state = TRUE

	heat_per_shot = 0.01
	heat_max = 0.03

	inaccuracy_modifier = 0.1
	movement_spread_base = 1

/obj/item/weapon/ranged/bow/get_static_spread()
	return 0

/obj/item/weapon/ranged/bow/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bow/on_mouse_up(var/mob/caller as mob, var/atom/object,location,control,params) //Release. This fires the bow.
	if(current_stage > 0 )
		shoot(caller,object,location,params,max(current_stage/40,0.25))
		current_stage = 0
		update_sprite()
	return TRUE

/obj/item/weapon/ranged/bow/click_on_object(var/mob/caller,var/atom/object,location,control,params)
	if(!is_advanced(caller))
		return TRUE
	current_shooter = caller
	start_thinking(src)
	return TRUE

/obj/item/weapon/ranged/bow/update_icon()
	var/icon_num = FLOOR(current_stage/10,1)
	icon_state = "[initial(icon_state)]_[icon_num]"
	. = ..()

/obj/item/weapon/ranged/bow/think()

	var/held_down = current_shooter && !current_shooter.qdeleting && ((current_shooter.attack_flags & CONTROL_MOD_LEFT) || (current_shooter.attack_flags & CONTROL_MOD_RIGHT)) && !(current_shooter.attack_flags & CONTROL_MOD_ALT)

	if(held_down)
		current_stage += stage_per_decisecond

		if(current_stage > 40)
			current_stage = 40
		else if(!(current_stage % 10))
			update_sprite()

		. = TRUE
	else
		current_stage = 0

	. = ..() || . //weirdest statement I ever wrote.


/obj/item/weapon/ranged/bow/get_base_spread()
	return 0.1

/obj/item/weapon/ranged/bow/wood
	name = "wood bow"
	icon = 'icons/obj/item/weapons/ranged/bow/wood.dmi'
	icon_state = "inventory"

/obj/item/weapon/ranged/bow/handle_ammo(var/mob/caller)

	if(!is_advanced(caller))
		return null

	var/mob/living/advanced/A = caller

	var/obj/item/I
	if(A.right_item == src)
		I = A.left_item
	else if(A.left_item == src)
		I = A.right_item

	if(!istype(I,/obj/item/bullet_cartridge/arrow))
		if(I && caller) caller.to_chat(span("warning","You can't fire \the [I.name] with \the [src.name]!"))
		return null

	var/obj/item/bullet_cartridge/arrow/BC = I

	return BC.spend_bullet(caller,0)

/obj/item/weapon/ranged/bow/handle_empty(var/mob/caller)
	return FALSE