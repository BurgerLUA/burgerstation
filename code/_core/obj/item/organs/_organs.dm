/obj/item/organ/
	name = "ORGAN"
	desc = "An organ."
	var/id = null

	icon = 'icons/mob/living/advanced/species/human.dmi'
	icon_state = null

	var/has_dropped_icon = FALSE
	var/has_dropped_icon_underlay = FALSE
	var/gib_icon_state = null

	var/damage_icon = 'icons/mob/living/advanced/overlays/damage/organic.dmi'

	var/flags_organ = FLAG_ORGAN_NONE

	var/attach_flag //The organ type that it wishes to attach to. Use FLAG_ORGAN_ flags.
	var/obj/item/organ/attached_organ //The organ that it is attached to.
	var/list/obj/item/organ/attached_organs //The organs that are attached to it.

	//var/style

	no_held_draw = TRUE

	var/enable_overlay = TRUE
	var/enable_skin = TRUE
	var/enable_glow = FALSE
	var/enable_detail = FALSE
	var/enable_wounds = FALSE

	reagents = /reagent_container/limb

	var/hud_id

	var/can_be_targeted = FALSE

	var/target_bounds_x_min = 0
	var/target_bounds_x_max = 0

	var/target_bounds_y_min = 0
	var/target_bounds_y_max = 0

	var/list/visual_wounds = list(
		BRUTE = 0,
		BURN = 0

	)

	var/base_miss_chance = 0

	health_base = 100

	health = /health/obj/item/organ

	var/damage_layer = LAYER_MOB_INJURY

	var/bleeding = 0 //How much blood to use per second.

	var/damage_coefficient = 1 //How much should this contribute to the overall health value of an advanced mob?

	var/has_life = FALSE

	var/has_pain = FALSE

	var/can_gib = TRUE

	mouse_opacity = 0 //For now

	enable_blood_stains = TRUE

	appearance_flags = LONG_GLIDE | PIXEL_SCALE | TILE_BOUND | KEEP_TOGETHER
	//SHOULD THE ABOVE USE KEEP_TOGETHER? YES.

	var/can_be_broken = TRUE
	var/broken = FALSE
	var/broken_name //Null basically means generate.

	var/projectile_dodge_chance = 0

	var/armor/armor = /armor/default_organic

/obj/item/organ/proc/check_hit_chance(var/atom/attacker,var/atom/weapon,var/damagetype/damage_type,var/list/params = list(),var/accurate=FALSE,var/find_closest=FALSE,var/inaccuracy_modifier=1)

	if(projectile_dodge_chance > 0 && !accurate && !find_closest && get_dist(src,attacker) > 1)
		var/damagetype/DT = all_damage_types[damage_type]
		if(DT && DT.get_attack_type() == ATTACK_TYPE_RANGED)
			return !prob(projectile_dodge_chance)

	return TRUE

/obj/item/organ/get_top_object()

	var/atom/returning_object
	var/is_held = FALSE

	for(var/k in inventories)
		var/obj/hud/inventory/INV = k
		if(is_held && INV.worn)
			continue
		var/atom/A = INV.get_top_object()
		if(A)
			returning_object = A
			is_held = !INV.worn

	if(!returning_object)
		returning_object = src

	return returning_object

/obj/item/organ/New(var/desired_loc)
	. = ..()
	attached_organs = list()

/obj/item/organ/Destroy()
	color = "#C284FF" //Absurd color. This makes it easier to identify issues.
	attached_organ = null
	attached_organs?.Cut()
	. = ..()

/obj/item/organ/get_base_transform()
	. = ..()
	var/matrix/M = .
	if(!is_advanced(loc) && !is_inventory(loc))
		M.Turn(pick(0,90,180,270))

/obj/item/organ/update_sprite()
	. = ..()
	transform = get_base_transform()

	if(has_dropped_icon && !is_advanced(loc) && enable_skin && additional_blends["skin"])
		var/icon_blend/IB = additional_blends["skin"]
		color = IB.color
	else
		color = null

/obj/item/organ/update_icon()

	. = ..()

	icon_state = initial(icon_state)

	if(has_dropped_icon && !is_advanced(loc))
		icon_state = "[icon_state]_inventory"

/obj/item/organ/update_underlays()

	. = ..()

	if(has_dropped_icon_underlay && !is_advanced(loc))
		var/image/I = new/image(initial(icon),"[icon_state]_underlay")
		add_underlay(I)

/obj/item/organ/proc/send_pain_response(var/pain_amount=50)
	if(!has_pain)
		return FALSE
	var/mob/living/advanced/A = loc
	if(!A.send_pain_response(pain_amount))
		return FALSE
	on_pain()
	for(var/k in attached_organs)
		var/obj/item/organ/O = k
		O.on_pain()
	return TRUE

/obj/item/organ/post_move(var/atom/old_loc)

	. = ..()

	if(is_inventory(old_loc) || is_inventory(loc) || is_advanced(old_loc) || is_advanced(loc))
		update_sprite()


/obj/item/organ/proc/break_bone(var/play_sound=TRUE,var/display_mesage=TRUE)
	if(!health || !can_be_broken || broken)
		return FALSE
	if(!broken_name)
		broken_name = "[src.name]"
	if(play_sound) play_sound('sound/effects/bone_crack.ogg',get_turf(src))
	broken = TRUE
	if(display_mesage && is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		A.visible_message(span("warning","\The [A.name]\s [broken_name] breaks!"),span("danger","Your [broken_name] breaks!"))
	src.health.adjust_loss_smart(pain=health.health_max*0.25,organic=TRUE,robotic=FALSE)
	return TRUE

/obj/item/organ/set_bloodstain(var/desired_level,var/desired_color,var/force=FALSE)
	. = ..()
	if(. && is_advanced(loc))
		var/mob/living/advanced/A = loc
		A.update_overlay_tracked("\ref[src]")

/obj/item/organ/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(health && is_advanced(loc))
		var/mob/living/advanced/A = loc
		if(A.health && !A.has_status_effect(IMMORTAL))
			if(broken)
				health.adjust_loss_smart(pain=damage_amount*0.25,organic=TRUE,robotic=FALSE)
			else if(can_be_broken && SAFENUM(damage_table[BLUNT]) >= health.health_max*0.15 && health.health_max - health.damage[BRUTE] <= SAFENUM(damage_table[BLUNT]))
				break_bone()
			if(A.blood_type)
				var/total_bleed_damage = SAFENUM(damage_table[BLADE])*2.5 + SAFENUM(damage_table[BLUNT])*0.75 + SAFENUM(damage_table[PIERCE])*1.5
				if(!health || !health.organic)
					total_bleed_damage *= 0.5
				if(total_bleed_damage > 0)
					var/bleed_to_add = total_bleed_damage/50
					src.bleeding += bleed_to_add
			if(!A.dead && has_pain && atom_damaged == src && (broken || src.health.health_current <= 0 || critical_hit_multiplier > 1))
				src.send_pain_response(damage_amount)
			if(!A.boss && health.health_current <= damage_amount && (!A.ckey_last || A.health.health_current <= 0))
				var/gib_chance = SAFENUM(damage_table[BLADE])*1.25 + SAFENUM(damage_table[BLUNT]) + SAFENUM(damage_table[PIERCE])*0.75
				if(A.dead)
					gib_chance -= length(attached_organs)*20 //No cheesing torso.
				else
					gib_chance -= length(attached_organs)*50 //No cheesing torso.
				if(gib_chance > 0 && prob(gib_chance))
					if(A.ckey_last) //Hold on, we're a player. Don't be so eager to gib.
						if(A.dead && is_living(attacker)) //Only gib if the player is dead.
							var/mob/living/LA = attacker
							if(LA.client) //And the person doing the gibbing is an active player.
								gib(get_dir(attacker,src))
							//Otherwise, don't gib.
					else
						gib(get_dir(attacker,src))


/obj/item/organ/proc/get_ending_organ(var/limit=10)

	var/list/valid_organs = list()
	for(var/k in src.attached_organs)
		var/obj/item/organ/AO = k
		if(AO.qdeleting)
			continue
		if(!AO.can_be_targeted) //Internal organ.
			continue
		valid_organs += AO
	if(!length(valid_organs))
		return src
	var/obj/item/organ/O = pick(valid_organs)
	if(limit <= 0)
		return O
	limit--
	return O.get_ending_organ(limit)

/obj/item/organ/gib(var/gib_direction=0x0,var/hard=FALSE) //Hard gib destroys the limb.

	if(!can_gib)
		return FALSE

	if(qdeleting) //Likely already gibbed.
		return FALSE

	var/turf/T = get_turf(src)
	if(is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		if(!A.has_status_effect(ZOMBIE))
			A.death()
			A.make_unrevivable()
		if(!A.dead)
			A.visible_message(span("warning","\The [A.name]'s [src.name] explodes!"),span("danger","Your [src.name] explodes!"))
		if(T && A.blood_type)
			var/organ_size = ((target_bounds_x_max - target_bounds_x_min) * (target_bounds_y_max - target_bounds_y_min))/(4*4)
			var/reagent/R = REAGENT(A.blood_type)
			var/list/base_normals = direction_to_pixel_offset(gib_direction)
			base_normals[1] += RAND_PRECISE(-0.25,0.25) //Variation
			base_normals[2] += RAND_PRECISE(-0.25,0.25) //Variation
			for(var/i=1,i<=clamp(organ_size,1,3),i++)
				create_blood(
					/obj/effect/cleanable/blood/gib,
					T,
					R.color,
					base_normals[1]*rand(-TILE_SIZE*0.25,TILE_SIZE*2),
					base_normals[2]*rand(-TILE_SIZE*0.25,TILE_SIZE*2),
					TRUE
				)
			if(gib_icon_state && enable_skin && additional_blends["skin"])
				var/icon_blend/IB = additional_blends["skin"]
				var/obj/effect/cleanable/blood/body_gib/BG = create_blood(
					/obj/effect/cleanable/blood/body_gib,
					T,
					R.color,
					base_normals[1]*rand(-TILE_SIZE*0.25,TILE_SIZE*2),
					base_normals[2]*rand(-TILE_SIZE*0.25,TILE_SIZE*2),
					TRUE
				)
				if(BG)
					BG.icon_state = gib_icon_state
					BG.flesh_color = IB.color
					BG.update_sprite()

	for(var/k in attached_organs)
		var/obj/item/organ/O = k
		O.gib(gib_direction,hard)

	unattach_from_parent(T,hard)

	return TRUE

/obj/item/organ/proc/on_pain() //What happens if this organ is shot while broken. Other things can cause pain as well.
	return FALSE

/obj/item/organ/proc/attach_to(var/obj/item/organ/O)
	attached_organ = O
	O.attached_organs += src
	return TRUE

/obj/item/organ/initialize_blends()

	if(enable_skin)
		add_blend("skin", desired_color = "#FF0000", desired_blend = ICON_MULTIPLY, desired_type = ICON_BLEND_COLOR, desired_should_save = TRUE, desired_layer = worn_layer)

	if(enable_glow)
		add_blend("skin_glow", desired_icon = icon, desired_icon_state = "[icon_state]_glow", desired_color = "#00FF00", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE, desired_layer = worn_layer)

	if(enable_detail)
		add_blend("skin_detail", desired_icon = icon, desired_icon_state = "[icon_state]_color", desired_color = "#0000FF", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY, desired_should_save = TRUE, desired_layer = worn_layer)

	if(enable_wounds)
		for(var/damagetype in visual_wounds)
			add_blend("damage_[damagetype]", desired_icon = damage_icon, desired_color = "#FFFFFF", desired_blend = ICON_OVERLAY, desired_type = ICON_BLEND_OVERLAY,desired_layer = damage_layer)

	. = ..()

/obj/item/organ/PostInitialize()
	. = ..()
	initialize_blends(icon_state)

/*
/obj/item/organ/Finalize()
	. = ..()
	update_sprite()
*/

/obj/item/organ/proc/unattach_from_parent(var/turf/T,var/do_delete=FALSE)

	unattach_children(T,do_delete)

	if(T)
		for(var/k in inventories)
			var/obj/hud/inventory/I = k
			if(I.ultra_persistant)
				continue
			var/list/dropped_objects = I.drop_objects(T)
			for(var/j in dropped_objects)
				var/obj/item/O = j
				animate(O,pixel_x=rand(-8,8),pixel_y=rand(-8,8),time=3)

	if(attached_organ)
		attached_organ.attached_organs -= src
		attached_organ = null

	if(T)
		if(is_advanced(src.loc))
			var/mob/living/advanced/A = src.loc
			A.remove_organ(src,do_delete)
		else if(do_delete)
			qdel(src)
			return TRUE
		else
			src.drop_item(T)
	else if(do_delete)
		qdel(src)
		return TRUE

	update_sprite()

	return TRUE

/obj/item/organ/proc/unattach_children(var/turf/T,var/do_delete=FALSE)
	for(var/k in attached_organs)
		var/obj/item/organ/O = k
		O.unattach_from_parent(T,do_delete)
	return TRUE

/obj/item/organ/proc/on_life()

	if(reagents)
		reagents.metabolize(is_advanced(src.loc) ? src.loc : null)

	if(bleeding >= 1 && is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		if(A.blood_type && A.health && A.blood_volume && prob(25))
			var/bleed_amount = bleeding*TICKS_TO_SECONDS(LIFE_TICK_SLOW)
			var/reagent/R = REAGENT(A.blood_type)
			var/turf/T = get_turf(A)
			if(T) create_blood(/obj/effect/cleanable/blood/drip,T,R.color,A.pixel_x + rand(-TILE_SIZE*0.1,TILE_SIZE*0.1),A.pixel_y + rand(-TILE_SIZE*0.1,TILE_SIZE*0.1))
			A.blood_volume = clamp(A.blood_volume - bleed_amount,0,A.blood_volume_max)
			bleeding = CEILING(max(0,bleeding - (0.02 + bleed_amount*0.075)),0.01)
			QUEUE_HEALTH_UPDATE(A)

	return TRUE

obj/item/organ/proc/on_organ_remove(var/mob/living/advanced/old_owner)
	old_owner.handle_transform()
	return TRUE

obj/item/organ/proc/on_organ_add(var/mob/living/advanced/new_owner)
	new_owner.handle_transform()
	return TRUE

obj/item/organ/proc/get_damage_description(var/mob/examiner,var/verbose=FALSE)

	if(!health)
		return list()

	var/list/damage_desc = list()

	var/mob/living/advanced/A = src.loc

	switch(health.damage[BRUTE])
		if(5 to 15)
			damage_desc += "<i>bruised<i/>"
		if(15 to 25)
			damage_desc += "battered"
		if(25 to 50)
			damage_desc += "<b>crushed</b>"
		if(50 to INFINITY)
			damage_desc += "<u><b>mangled</b></u>"

	switch(health.damage[BURN])
		if(5 to 15)
			damage_desc += "<i>blistered<i/>"
		if(15 to 25)
			damage_desc += "burned"
		if(25 to 50)
			damage_desc += "<b>scorched</b>"
		if(50 to INFINITY)
			damage_desc += "<u><b>charred</b></u>"

	switch(health.damage[PAIN] - (istype(A) ? A.pain_removal : 0))
		if(5 to 15)
			damage_desc += "<i>tender<i/>"
		if(15 to 25)
			damage_desc += "sore"
		if(25 to 50)
			damage_desc += "<b>stinging</b>"
		if(50 to 99)
			damage_desc += "<u><b>hurting</b></u>"
		if(100 to INFINITY)
			damage_desc += "<u><b>numb from the pain</b></u>"

	switch(health.damage[RAD])
		if(15 to 25)
			damage_desc += "glowing"
		if(25 to 50)
			damage_desc += "<b>pulsating</b>"
		if(50 to INFINITY)
			damage_desc += "<u><b>mutating</b></u>"

	switch(bleeding)
		if(0.5 to 2)
			if(health.organic)
				damage_desc += "trickling blood"
			else
				damage_desc += "trickling fluid"
		if(2 to 4)
			if(health.organic)
				damage_desc += "<b>bleeding</b>"
			else
				damage_desc += "<b>leaking fluid</b>"
		if(4 to INFINITY)
			if(health.organic)
				damage_desc += "<u><b>gushing blood</b></u>"
			else
				damage_desc += "<u><b>gushing fluid</b></u>"

	if(broken)
		damage_desc += "<u><b>broken</b></u>"


	return damage_desc


/obj/item/organ/act_emp(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty_tag)
	. = ..()
	for(var/k in inventories)
		var/obj/hud/inventory/I = k
		I.act_emp(owner,source,epicenter,magnitude,desired_loyalty_tag)