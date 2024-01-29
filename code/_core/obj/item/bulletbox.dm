/obj/item/bulletbox
	name = "ammo box"
	desc = "Here, take some ammo!"
	desc_extended = "A non-descript green box that contains a large quantity of a single ammo type."
	icon = 'icons/obj/item/bulletbox.dmi'
	icon_state = "ammo"

	var/bullet_count = 0
	var/bullet_max = 0 //Updated when a new bullet is added.

	var/obj/item/bullet_cartridge/stored_bullet //A path.
	var/obj/item/bullet_cartridge/stored_bullet_original //A path.

	size = SIZE_3
	weight = 30

	value = 100

	pixel_y = 4

	var/small = FALSE
	var/ignore_custom_sprites = FALSE
	var/draw_bullet_on_box = TRUE

	var/next_regen = 0 //For ammo box restocking.

/obj/item/bulletbox/get_examine_list(mob/examiner)
	. = ..()
	if(small == FALSE)
		. += span("notice","Use to open and deploy, ALT+Click to pack up.")

/obj/item/bulletbox/save_item_data(mob/living/advanced/player/P,save_inventory = TRUE,died=FALSE,loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("bullet_count")
	SAVEPATH("stored_bullet")

/obj/item/bulletbox/load_item_data_pre(mob/living/advanced/player/P,list/object_data,loadout=FALSE)
	RUN_PARENT_SAFE
	LOADPATH("stored_bullet")
	set_stored_bullet(stored_bullet)
	LOADVAR("bullet_count")

/obj/item/bulletbox/Generate()
	. = ..()
	if(stored_bullet)
		set_stored_bullet(stored_bullet)

/obj/item/bulletbox/Finalize()
	. = ..()
	update_sprite()

/obj/item/bulletbox/PreDestroy()
	set_stored_bullet(null)
	. = ..()

/obj/item/bulletbox/get_value()
	. = ..()
	if(stored_bullet)
		. += bullet_count * SSbalance.stored_value[stored_bullet]

/obj/item/bulletbox/get_examine_list(mob/caller)
	. = ..()
	if(stored_bullet)
		. += div("notice","It stores [initial(stored_bullet.name)] ([bullet_count]/[bullet_max] capacity).")

/obj/item/bulletbox/click_self(mob/caller,location,control,params)

	if(small || anchored)
		return ..()

	if(drop_item(get_turf(caller)) && set_anchored(TRUE))
		update_sprite()

	return TRUE


/obj/item/bulletbox/clicked_on_by_object(mob/caller,atom/object,location,control,params)

	if(istype(object,/obj/item/bullet_cartridge/))
		INTERACT_CHECK
		INTERACT_DELAY(5)
		var/obj/item/bullet_cartridge/B = object
		if(!stored_bullet)
			if(ignore_custom_sprites)
				if(B.type != initial(stored_bullet))
					caller.to_chat(span("warning","It would be a bad idea to mix bullets up..."))
					return TRUE
			else if(stored_bullet)
				if(B.type != stored_bullet)
					caller.to_chat(span("warning","It would be a bad idea to mix bullets up..."))
					return TRUE
			var/bullets_to_add = min(B.amount,bullet_max)
			set_stored_bullet(B.type)
			bullets_to_add = abs(B.add_item_count(-bullets_to_add))
			bullet_count += bullets_to_add
			caller.to_chat(span("notice","You add [bullets_to_add] bullet\s to \the [src.name]."))
			update_sprite()
			return TRUE
		if(B.type == stored_bullet)
			var/bullets_to_add = min(B.amount,bullet_max - bullet_count)
			if(bullets_to_add <= 0)
				return TRUE
			bullets_to_add = abs(B.add_item_count(-bullets_to_add))
			bullet_count += bullets_to_add
			caller.to_chat(span("notice","You add [bullets_to_add] bullet\s to \the [src.name]."))
			update_sprite()
			return TRUE
		caller.to_chat(span("warning","It would be a bad idea to mix bullets up..."))
		return TRUE

	if(!small && anchored && caller.attack_flags & CONTROL_MOD_DISARM && src.set_anchored(FALSE))
		INTERACT_CHECK
		INTERACT_DELAY(5)
		update_sprite()
		caller.to_chat(span("notice","You pack up \the [src.name]."))
		return TRUE

	if(!stored_bullet)
		return ..()

	if(is_inventory(object))
		INTERACT_CHECK
		INTERACT_DELAY(5)
		var/bullets_to_take = min(bullet_count,initial(stored_bullet.amount_max))
		if(bullets_to_take <= 0)
			return TRUE
		var/obj/hud/inventory/I = object
		var/obj/item/bullet_cartridge/BC = new stored_bullet(get_turf(src))
		INITIALIZE(BC)
		BC.amount = bullets_to_take
		FINALIZE(BC)
		I.add_object(BC)
		bullet_count -= bullets_to_take
		caller.to_chat(span("notice","You take [bullets_to_take] bullets from \the [src.name]."))
		update_sprite()
		return TRUE

	if(is_magazine(object))
		INTERACT_CHECK
		INTERACT_DELAY(5)
		var/obj/item/magazine/M = object
		if(!M.can_load_magazine_path(caller,src.stored_bullet))
			return TRUE
		var/bullets_to_take = min(bullet_count,M.bullet_count_max-M.get_ammo_count())
		if(bullets_to_take <= 0)
			return TRUE
		M.stored_bullets[stored_bullet] += bullets_to_take
		src.bullet_count -= bullets_to_take
		M.update_sprite()
		caller.to_chat(span("notice","You fill up \the [M.name] with [bullets_to_take] bullets from \the [src.name]."))
		update_sprite()
		return TRUE

	. = ..()

/obj/item/bulletbox/proc/set_stored_bullet(desired_path)

	if(!desired_path) //Clear and remove.
		stored_bullet = null
		bullet_count = 0
		bullet_max = 0
		rarity = RARITY_COMMON
		return TRUE

	if(ispath(desired_path))
		stored_bullet = desired_path
		bullet_max = CEILING( 10*(size**3)/initial(stored_bullet.bullet_diameter), 1)
		if(!bullet_max)
			set_stored_bullet(null)
			update_sprite()
			return FALSE
		bullet_count = bullet_max
		rarity = initial(stored_bullet.rarity)
		return TRUE

	return FALSE

/obj/item/bulletbox/update_sprite()
	. = ..()
	name = initial(name)
	if(stored_bullet)
		name = "[name] ([initial(stored_bullet.name)])"

/obj/item/bulletbox/update_icon()
	. = ..()
	icon = initial(icon)
	icon_state = initial(icon_state)
	if(small || anchored)
		icon_state = "[icon_state]_open"

/obj/item/bulletbox/update_overlays()
	. = ..()
	if(stored_bullet) //Draw the logo on the bullet
		if(draw_bullet_on_box)
			var/image/I = new/image(initial(stored_bullet.icon),"[initial(stored_bullet.icon_state)]_1")
			I.color = "#AAAAAA"
			I.alpha = 200
			var/matrix/M = matrix()
			M.Turn(90)
			I.transform = M
			I.pixel_y = -6
			I.pixel_x = 0
			I.plane = FLOAT_PLANE
			I.layer = FLOAT_LAYER
			add_overlay(I)
		if((small || anchored) && bullet_count) //Draw the bullets inside.
			var/ratio = 1 + FLOOR((bullet_count/bullet_max)*2,1)
			if(stored_bullet)
				var/image/I2 = new/image(icon,"[initial(stored_bullet.bulletbox_icon_state) && !ignore_custom_sprites ? initial(stored_bullet.bulletbox_icon_state) : "bullet"]_[ratio]")
				add_overlay(I2)

/obj/item/bulletbox/rifle_556/
	stored_bullet = /obj/item/bullet_cartridge/rifle_223/nato

/obj/item/bulletbox/rifle_556/premium
	stored_bullet = /obj/item/bullet_cartridge/rifle_223/nato/premium

/obj/item/bulletbox/rifle_762
	stored_bullet = /obj/item/bullet_cartridge/rifle_308/nato

/obj/item/bulletbox/rifle_762/premium
	stored_bullet = /obj/item/bullet_cartridge/rifle_308/nato/premium

/obj/item/bulletbox/sniper_127/
	stored_bullet = /obj/item/bullet_cartridge/sniper_127

/obj/item/bulletbox/sniper_127/premium
	stored_bullet = /obj/item/bullet_cartridge/sniper_127/premium

/obj/item/bulletbox/sniper_127/ap
	stored_bullet = /obj/item/bullet_cartridge/sniper_127/ap

/obj/item/bulletbox/shotgun_12/
	stored_bullet = /obj/item/bullet_cartridge/shotgun_12/

/obj/item/bulletbox/shotgun_12/flechette
	stored_bullet = /obj/item/bullet_cartridge/shotgun_12/flechette

/obj/item/bulletbox/shotgun_12/slug
	stored_bullet = /obj/item/bullet_cartridge/shotgun_12/slug

/obj/item/bulletbox/shotgun_12/slug/cleaning
	stored_bullet = /obj/item/bullet_cartridge/shotgun_12/slug/cleaning

/obj/item/bulletbox/rifle_762_revolver
	stored_bullet = /obj/item/bullet_cartridge/revolver_762

/obj/item/bulletbox/shotgun_23/
	stored_bullet = /obj/item/bullet_cartridge/shotgun_23/

/obj/item/bulletbox/shotgun_23/slug
	stored_bullet = /obj/item/bullet_cartridge/shotgun_23/slug





/obj/item/bulletbox/small
	name = "small ammo box"
	desc = "Here, take some ammo!"
	desc_extended = "A small cardboard box specialized for storing a couple handfuls of a single ammo type. Smaller capacity, but doesn't need to be deployed."
	size = SIZE_2
	small = TRUE
	ignore_custom_sprites = TRUE
	draw_bullet_on_box = FALSE
	value = 10

//obj/item/bulletbox/small/get_examine_list(mob/examiner)
//	. = ..()
//	. += span("notice","Use to open and deploy, ALT+Click to pack up.")

/obj/item/bulletbox/small/shotgun_12
	stored_bullet = /obj/item/bullet_cartridge/shotgun_12
	icon = 'icons/obj/item/bulletbox_12.dmi'

/obj/item/bulletbox/small/shotgun_12/slug
	stored_bullet = /obj/item/bullet_cartridge/shotgun_12/slug
	icon = 'icons/obj/item/bulletbox_12_slug.dmi'

/obj/item/bulletbox/small/shotgun_12/flechette
	stored_bullet = /obj/item/bullet_cartridge/shotgun_12/flechette
	icon = 'icons/obj/item/bulletbox_12_flechette.dmi'

/obj/item/bulletbox/small/shotgun_12/techshot
	stored_bullet = /obj/item/bullet_cartridge/shotgun_12/techshot
	icon = 'icons/obj/item/bulletbox_12_techshot.dmi'

/obj/item/bulletbox/small/revolver_357
	stored_bullet = /obj/item/bullet_cartridge/revolver_357
	icon = 'icons/obj/item/bulletbox_357.dmi'
