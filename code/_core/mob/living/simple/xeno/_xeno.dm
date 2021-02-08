/mob/living/simple/xeno
	name = "xeno"
	desc = "Xenos mad."
	desc_extended = "Oh shit they're here too?!"
	icon = 'icons/mob/living/simple/alien_drone.dmi'
	icon_state = "living"

	ai = /ai/xeno
	damage_type = /damagetype/npc/xeno
	class = /class/xeno

	pixel_x = -16

	butcher_contents = list(
		/obj/item/container/food/dynamic/meat/raw_xeno/,
		/obj/item/container/food/dynamic/meat/raw_xeno/,
		/obj/item/container/food/dynamic/meat/raw_xeno/
	)

	loyalty_tag = "Alien"
	iff_tag = "Alien"

	movement_delay = 1

	size = SIZE_HUMAN

	var/next_talk = 0
	var/leaping = FALSE

	var/can_leap = FALSE
	var/can_spit = FALSE

	var/death_sounds = TRUE

/mob/living/simple/xeno/get_emote_sound(var/emote_id)

	switch(emote_id)
		if("pain")
			return null

	return null


/mob/living/simple/xeno/on_life_slow()

	. = ..()

	if(. && ai && ai.active && ai.alert_level != ALERT_LEVEL_COMBAT && next_talk <= world.time && prob(25))

		var/sound_to_play

		switch(ai.alert_level)
			if(ALERT_LEVEL_NONE)
				var/list/valid_sounds = list(
					'sound/voice/xeno/talk1.ogg',
					'sound/voice/xeno/talk2.ogg',
					'sound/voice/xeno/talk3.ogg',
					'sound/voice/xeno/talk4.ogg',
					'sound/voice/xeno/talk5.ogg'
				)
				sound_to_play = pick(valid_sounds)
			if(ALERT_LEVEL_NOISE)
				var/list/valid_sounds = list(
					'sound/voice/xeno/lowHiss1.ogg',
					'sound/voice/xeno/lowHiss2.ogg',
					'sound/voice/xeno/lowHiss3.ogg',
					'sound/voice/xeno/lowHiss4.ogg'
				)
				sound_to_play = pick(valid_sounds)
			if(ALERT_LEVEL_CAUTION)
				var/list/valid_sounds = list(
					'sound/voice/xeno/growl1.ogg',
					'sound/voice/xeno/growl2.ogg',
					'sound/voice/xeno/growl3.ogg',
					'sound/voice/xeno/growl4.ogg',
					'sound/voice/xeno/growl5.ogg',
					'sound/voice/xeno/growl6.ogg',
					'sound/voice/xeno/growl7.ogg',
					'sound/voice/xeno/growl8.ogg',
					'sound/voice/xeno/growl9.ogg',
					'sound/voice/xeno/growl10.ogg'
				)
				sound_to_play = pick(valid_sounds)

		if(sound_to_play)
			play_sound(sound_to_play,get_turf(src),range_max=VIEW_RANGE)

		next_talk = world.time + SECONDS_TO_DECISECONDS(rand(5,12))

	return .


/mob/living/simple/xeno/attack(var/atom/attacker,var/atom/victim,var/list/params=list(),var/atom/blamed,var/ignore_distance = FALSE, var/precise = FALSE,var/damage_multiplier=1) //The src attacks the victim, with the blamed taking responsibility

	. = ..()

	if(. && next_talk <= world.time && prob(50))
		var/list/valid_sounds = list(
			'sound/voice/xeno/screech1.ogg',
			'sound/voice/xeno/screech2.ogg',
			'sound/voice/xeno/screech3.ogg',
			'sound/voice/xeno/screech4.ogg'
		)
		play_sound(pick(valid_sounds),get_turf(src),range_max=VIEW_RANGE)
		next_talk = world.time + SECONDS_TO_DECISECONDS(rand(5,12))
	return .

/mob/living/simple/xeno/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(!stealthy && !dead && damage_amount > 20 && prob(25))
		var/list/valid_sounds = list(
			'sound/voice/xeno/hurt1.ogg',
			'sound/voice/xeno/hurt2.ogg'
		)
		play_sound(pick(valid_sounds),get_turf(src),range_max=VIEW_RANGE)

	return .


/mob/living/simple/xeno/post_death()

	. = ..()

	if(death_sounds && prob(50))
		var/list/valid_sounds = list(
			'sound/voice/xeno/death1.ogg',
			'sound/voice/xeno/death2.ogg'
		)
		play_sound(pick(valid_sounds),get_turf(src),range_max=VIEW_RANGE)

	update_sprite()

	return .


/mob/living/simple/xeno/Cross(atom/movable/O)

	if(is_living(O))
		var/mob/living/L = O
		if(L.loyalty_tag == loyalty_tag) return TRUE

	return ..()



/mob/living/simple/xeno/throw_self(var/atom/thrower,var/atom/desired_target,var/target_x,var/target_y,var/vel_x,var/vel_y,var/lifetime = -1, var/steps_allowed = 0,var/desired_iff)

	if(!can_leap)
		return ..()

	leaping = TRUE
	update_sprite()

	. = ..()

	if(!.)
		leaping = FALSE
		update_sprite()
		return .

	var/obj/projectile/P = .
	P.rotate_projectile = FALSE
	P.set_dir(get_dir(thrower,desired_target))

	return P

/mob/living/simple/xeno/on_thrown(var/atom/owner,var/atom/hit_atom,var/atom/hit_wall) //What happens after the person is thrown and it hits an object.

	. = ..()

	if(!can_leap)
		return .

	if(is_living(hit_atom))
		var/mob/living/L = hit_atom
		L.add_status_effect(STUN,10,10)

	if(hit_wall)
		src.add_status_effect(STUN,30,30)

	leaping = FALSE
	update_sprite()

	return .

/mob/living/simple/xeno/post_move(var/old_loc)
	. = ..()
	if(.)
		update_icon()
	return .

/mob/living/simple/xeno/update_icon()

	if(dead)
		if(health && health.get_loss(BRUTE) < health.get_loss(BURN))
			icon_state = "husk"
		else
			icon_state = "dead"
	else if(horizontal)
		icon_state = "stun"
	else if(leaping)
		icon_state = "leap"
	else if(movement_flags & MOVEMENT_RUNNING)
		icon_state = "sprint"
	else
		icon_state = initial(icon_state)

	return ..()