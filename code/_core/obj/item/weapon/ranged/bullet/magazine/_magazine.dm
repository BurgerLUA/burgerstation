/obj/item/weapon/ranged/bullet/magazine/
	open = TRUE

	var/obj/item/magazine/stored_magazine //You can use one or the other.

	var/requires_cock_each_shot = FALSE

	stored_bullets = null

	var/empty_warning_percent = 0.2 //0-1, as a percentage

/obj/item/weapon/ranged/bullet/magazine/PreDestroy()
	QDEL_NULL(stored_magazine)
	. = ..()

/obj/item/weapon/ranged/bullet/magazine/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEATOM("stored_magazine")

/obj/item/weapon/ranged/bullet/magazine/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADATOM("stored_magazine")
	if(stored_magazine)
		src.open = FALSE

/obj/item/weapon/ranged/bullet/magazine/proc/get_magazine()
	return stored_magazine

/obj/item/weapon/ranged/bullet/magazine/proc/get_cock_sound(var/direction="both")
	switch(direction)
		if("both")
			return pick(
				'sound/weapons/ranged/generic/gun_slide1.ogg',
				'sound/weapons/ranged/generic/gun_slide2.ogg',
				'sound/weapons/ranged/generic/gun_slide3.ogg',
				'sound/weapons/ranged/generic/gun_slide4.ogg',
				'sound/weapons/ranged/generic/gun_slide5.ogg')
		if("forward")
			return 'sound/weapons/ranged/generic/slide_drop.ogg'
		if("back")
			return 'sound/weapons/ranged/generic/slide_lock.ogg'

/obj/item/weapon/ranged/bullet/magazine/Generate()

	if(stored_magazine)
		var/obj/item/magazine/M = new stored_magazine(src)
		stored_magazine = null
		INITIALIZE(M)
		GENERATE(M)
		FINALIZE(M)
		M.click_on_object(null,src)
		src.click_self()

	return ..()

/obj/item/weapon/ranged/bullet/magazine/click_self(var/mob/caller,location,control,params)

	. = ..()

	if(.)
		return .

	if(next_shoot_time > world.time)
		return FALSE

	var/turf/T = get_turf(src)

	var/cock_type // = "flacid"

	if(eject_chambered_bullet(caller,caller ? caller.loc : T,TRUE))
		cock_type = "back"

	if(load_new_bullet_from_magazine(caller))
		cock_type = cock_type == "back" ? "both" : "forward"

	if(cock_type)
		if(T)
			play_sound(get_cock_sound(cock_type),T,range_max=VIEW_RANGE*0.5,pitch=sound_pitch)
		update_sprite()

	next_shoot_time = max(next_shoot_time,world.time + 5)

	return TRUE

/obj/item/weapon/ranged/bullet/magazine/proc/eject_magazine(var/mob/caller as mob)

	if(!stored_magazine) CRASH("[caller.get_debug_name()] tried to eject a magazine from [src.get_debug_name()], but there was no stored_magazine!")

	var/turf/T = get_turf(caller)

	if(!T)
		qdel(src)
	else
		stored_magazine.drop_item(T)
		play_sound(stored_magazine.get_magazine_eject_sound(),T,range_max=VIEW_RANGE*0.5,pitch=sound_pitch)
		if(stored_magazine)
			stored_magazine.update_sprite()
			stored_magazine = null

	open = TRUE
	update_sprite()

	return TRUE

/obj/item/weapon/ranged/bullet/magazine/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params) //The src was clicked on by the object

	if(stored_magazine && !wielded && is_inventory(object) && is_inventory(src.loc) && !caller.attack_flags)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(1)
		var/obj/item/magazine/M = stored_magazine
		var/obj/hud/inventory/I = object
		eject_magazine(caller)
		if(!M || M.qdeleting)
			stored_magazine = null //Something went terribly wrong.
			return TRUE
		I.add_object(M)
		return TRUE

	return ..()

/obj/item/weapon/ranged/bullet/magazine/proc/load_new_bullet_from_magazine(var/mob/caller)

	var/obj/item/magazine/M = get_magazine()

	if(!M) return FALSE

	var/bullet_length = length(M.stored_bullets) //The number of different types of bullets.

	if(bullet_length && !chambered_bullet)
		var/obj/item/bullet_cartridge/B
		if(length(M.stored_bullets) == 1)
			B = M.stored_bullets[1]
		else
			B = pickweight(M.stored_bullets)
		if(can_load_chamber(null,B))
			M.stored_bullets[B] -= 1
			if(M.stored_bullets[B] <= 0)
				M.stored_bullets -= B
			B = new B(src)
			INITIALIZE(B)
			B.amount = 1
			FINALIZE(B)
			chambered_bullet = B
			return TRUE

	return FALSE

/obj/item/weapon/ranged/bullet/magazine/handle_ammo(var/mob/caller)

	. = ..()

	if(.)
		if(chambered_bullet)
			eject_chambered_bullet(caller,get_turf(src),TRUE)
		if(!requires_cock_each_shot)
			load_new_bullet_from_magazine(caller)



/obj/item/weapon/ranged/bullet/magazine/proc/can_fit_magazine(var/obj/item/magazine/M)

	if(!istype(M))
		return FALSE

	if(!M.weapon_whitelist[src.type])
		return FALSE

	return TRUE

/obj/item/weapon/ranged/bullet/magazine/play_shoot_sounds(var/mob/caller,var/list/shoot_sounds_to_use = list(),var/shoot_alert_to_use = ALERT_LEVEL_NONE)

	. = ..()

	if(. && empty_warning_percent > 0 && length(empty_sounds))
		var/sound_strength = 1

		if(stored_magazine)
			var/capacity = stored_magazine.get_ammo_count()/stored_magazine.bullet_count_max
			sound_strength = 1 - clamp(capacity/empty_warning_percent,0,1)

		if(sound_strength > 0)
			play_sound('sound/effects/gun_empty_sound.ogg',get_turf(src), pitch = sound_pitch + sound_strength*0.5, volume = 100 * sound_strength,range_max=VIEW_RANGE)