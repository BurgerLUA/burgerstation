/obj/item/weapon/ranged/bow

	icon_state = "inventory"

	requires_bullets = TRUE

	shoot_sounds = list(
		'sound/weapons/bow/fire.ogg'
	)
	empty_sounds = list()

	shoot_alert = ALERT_LEVEL_NONE

	automatic = FALSE

	var/stage_per_decisecond = 2 //There are 40 stages. 40 is max.
	var/current_stage = 0

	var/mob/living/advanced/current_shooter

	override_icon_state = TRUE

	heat_per_shot = 0.01
	heat_max = 0.03

	inaccuracy_modifier = 0.1
	movement_spread_base = 1

	var/draw_sound = 'sound/weapons/bow/draw_steel.ogg'

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
	if(object.plane >= PLANE_HUD)
		return ..()
	if(!is_advanced(caller))
		return TRUE
	current_shooter = caller
	start_thinking(src)
	play_sound(draw_sound,get_turf(src))
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



/obj/item/weapon/ranged/bow/wood
	name = "wood bow"
	desc = "For ranged ungas."
	desc_extended = "A classic wooden bow. Overall, it's reliable and has no gimmick."
	icon = 'icons/obj/item/weapons/ranged/bow/wood.dmi'

	stage_per_decisecond = 2

	value = 200

/obj/item/weapon/ranged/bow/steel
	name = "steel bow"
	desc = "For ranged ungas who like steel."
	desc_extended = "An upgraded bow that is harder to pull back, but kicks more of a punch."
	icon = 'icons/obj/item/weapons/ranged/bow/steel.dmi'

	stage_per_decisecond = 1

	value = 300

/obj/item/weapon/ranged/bow/hardlight
	name = "hardlight bow"
	desc = "How can light be hard? :flushed:"
	desc_extended = "A space-age bow that somehow uses the power of light to conjure arrows if none are provided."
	icon = 'icons/obj/item/weapons/ranged/bow/hardlight.dmi'

	stage_per_decisecond = 2

	var/obj/item/bullet_cartridge/arrow/stored_arrow = /obj/item/bullet_cartridge/arrow/hardlight

	draw_sound = 'sound/weapons/bow/draw_hardlight.ogg'

	value = 3000

/obj/item/weapon/ranged/bow/hardlight/Initialize()
	. = ..()
	stored_arrow = new stored_arrow(src)
	INITIALIZE(stored_arrow)
	GENERATE(stored_arrow)
	FINALIZE(stored_arrow)

/obj/item/weapon/ranged/bow/hardlight/handle_ammo(var/mob/caller)
	. = ..()
	if(!.)
		return stored_arrow

/obj/item/weapon/ranged/bow/ashen
	name = "ashen bow"
	desc = "So sacred, not even ashwalkers use it."
	desc_extended = "A special masterfully crafted ashen bow that somehow invokes the strength of ancient megafauna when drawing arrows."
	icon = 'icons/obj/item/weapons/ranged/bow/ashen.dmi'

	stage_per_decisecond = 5

	draw_sound = 'sound/weapons/bow/draw_ashen.ogg'


	value = 2000

