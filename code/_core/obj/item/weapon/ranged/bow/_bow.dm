/obj/item/weapon/ranged/bow

	icon_state = "inventory"

	requires_bullets = TRUE

	shoot_sounds = list(
		'sound/weapons/ranged/bow/fire.ogg'
	)
	empty_sounds = list()

	shoot_alert = ALERT_LEVEL_NONE

	automatic = FALSE

	var/stage_per_decisecond = 30 //At 100 dex.
	var/stage_max = 100 //At 100 strength.
	var/stage_current = 0

	var/mob/living/advanced/current_shooter

	override_icon_state = TRUE

	ranged_damage_type = /damagetype/ranged/bow/

	heat_max = 0.03

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 0.9
	movement_spread_base = 0.05

	var/draw_sound = 'sound/weapons/ranged/bow/draw_steel.ogg'

	var/spam_prevention = 0

	size = SIZE_3
	weight = 10

	use_iff_tag = FALSE
	use_loyalty_tag = TRUE

	dan_mode = TRUE

	var/icon_state_count = 3

/obj/item/weapon/ranged/bow/Finalize()
	. = ..()
	update_sprite()


/obj/item/weapon/ranged/bow/on_equip(var/atom/old_location,var/silent=FALSE)
	. = ..()
	stage_max = initial(stage_max)
	stage_per_decisecond = initial(stage_per_decisecond)
	var/obj/hud/inventory/I = loc
	if(is_living(I.owner))
		var/mob/living/L = I.owner
		var/strength_mod = 0.5 + L.get_attribute_power(ATTRIBUTE_STRENGTH,0,1,2)*0.5
		var/dex_mod = 0.25 + L.get_attribute_power(ATTRIBUTE_DEXTERITY,0,1,2)*0.75
		stage_per_decisecond *= dex_mod
		stage_per_decisecond = CEILING(stage_per_decisecond,1)
		stage_max *= strength_mod
		stage_max = CEILING(stage_max,1)

/obj/item/weapon/ranged/bow/get_static_spread()
	return 0

/obj/item/weapon/ranged/bow/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bow/on_mouse_up(var/mob/caller as mob, var/atom/object,location,control,params) //Release. This fires the bow.
	if(stage_current > 0 )
		shoot(caller,object,location,params,max(stage_current/100,0.25))
		stage_current = 0
		next_shoot_time = world.time + 2
		update_sprite()
	return TRUE

/obj/item/weapon/ranged/bow/click_on_object(var/mob/caller,var/atom/object,location,control,params)
	if(object.plane >= PLANE_HUD)
		return ..()
	if(object.loc && object.loc.plane >= PLANE_HUD)
		return ..()
	if(!is_advanced(caller))
		return ..()
	current_shooter = caller
	START_THINKING(src)
	return TRUE

/obj/item/weapon/ranged/bow/update_icon()
	. = ..()
	icon_state = initial(icon_state)
	var/icon_num = stage_current ? 1 + ((stage_current/initial(stage_max)) * icon_state_count) : 0
	if(icon_num > 0)
		icon_state = "[icon_state]_[CEILING(icon_num,1)]"

/obj/item/weapon/ranged/bow/think()

	var/held_down = src.next_shoot_time <= world.time && current_shooter && !current_shooter.qdeleting && (current_shooter.ai || (current_shooter.attack_flags & CONTROL_MOD_LEFT) || (current_shooter.attack_flags & CONTROL_MOD_RIGHT)) && !(current_shooter.attack_flags & CONTROL_MOD_DISARM)

	if(held_down)
		if(stage_current == 0 && world.time >= spam_prevention)
			play_sound(draw_sound,get_turf(src))
			spam_prevention = world.time + 5
		if(stage_current < stage_max)
			stage_current = min(stage_max,stage_current + stage_per_decisecond)
			update_icon() //update_sprite isn't called here as it is intensive.
		. = TRUE
	else
		if(stage_current > 0)
			stage_current = 0
			update_icon()
		. = FALSE

	. = ..() || . //weirdest statement I ever wrote.


/obj/item/weapon/ranged/bow/get_base_spread()
	return 0.1

/obj/item/weapon/ranged/bow/handle_ammo(var/mob/caller)

	if(!is_advanced(caller))
		return FALSE

	var/mob/living/advanced/A = caller
	var/obj/item/right_item = A.inventories_by_id[BODY_HAND_RIGHT_HELD]?.get_top_object()
	var/obj/item/left_item = A.inventories_by_id[BODY_HAND_LEFT_HELD]?.get_top_object()

	var/obj/item/I
	if(right_item == src)
		I = left_item
	else if(left_item == src)
		I = right_item

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

	stage_per_decisecond = 4
	stage_max = 100

	value = 200

	icon_state_count = 4

	tier = 1

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bow/wood/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bow/steel
	name = "steel bow"
	desc = "For ranged ungas who like steel."
	desc_extended = "An upgraded bow that is harder to pull back, but is more accurate and fires more of a punch."
	icon = 'icons/obj/item/weapons/ranged/bow/steel.dmi'

	stage_per_decisecond = 3
	stage_max = 125

	value = 300

	icon_state_count = 4

	tier = 2

	rarity = RARITY_UNCOMMON

/obj/item/weapon/ranged/bow/hardlight
	name = "hardlight bow"
	desc = "How can light be hard? :flushed:"
	desc_extended = "A space-age bow that somehow uses the power of light to conjure arrows if none are provided. Fires really fast, regardless."
	icon = 'icons/obj/item/weapons/ranged/bow/hardlight.dmi'

	var/obj/item/bullet_cartridge/arrow/stored_arrow = /obj/item/bullet_cartridge/arrow/hardlight

	draw_sound = 'sound/weapons/ranged/bow/draw_hardlight.ogg'

	value = 3000

	ranged_damage_type = /damagetype/ranged/bow/hardlight

	stage_per_decisecond = 10
	stage_max = 50

	icon_state_count = 4

	tier = 3

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bow/hardlight/Initialize()
	. = ..()
	stored_arrow = new stored_arrow(src)
	stored_arrow.initialize_type = INITIALIZE_NONE
	INITIALIZE(stored_arrow)
	GENERATE(stored_arrow)
	FINALIZE(stored_arrow)

/obj/item/weapon/ranged/bow/hardlight/handle_ammo(var/mob/caller)
	. = ..()
	if(!.) return stored_arrow

/obj/item/weapon/ranged/bow/hardlight/syndicate
	name = "syndicate laser bow"
	icon = 'icons/obj/item/weapons/ranged/bow/laser_bow.dmi'
	icon_state_count = 3
	stored_arrow = /obj/item/bullet_cartridge/arrow/hardlight/syndicate
	ranged_damage_type = /damagetype/ranged/bow/hardlight/syndicate
	stage_per_decisecond = 8
	stage_max = 75

/obj/item/weapon/ranged/bow/ashen
	name = "ashen bow"
	desc = "So sacred, not even ashwalkers use it."
	desc_extended = "A special masterfully crafted ashen bow that somehow invokes the strength of ancient megafauna when drawing arrows."
	icon = 'icons/obj/item/weapons/ranged/bow/ashen.dmi'

	draw_sound = 'sound/weapons/ranged/bow/draw_ashen.ogg'

	ranged_damage_type = /damagetype/ranged/bow/ashen

	value = 2000

	stage_per_decisecond = 5
	stage_max = 125

	tier = 4

	icon_state_count = 4

	rarity = RARITY_UNCOMMON

/obj/item/weapon/ranged/bow/get_damage_per_hit(armor_to_use)
	var/damagetype/D = all_damage_types[ranged_damage_type]
	return D.get_damage_per_hit(armor_to_use) * (stage_max/100)

/obj/item/weapon/ranged/bow/get_hits_per_second()
	return (stage_per_decisecond/stage_max)*10



