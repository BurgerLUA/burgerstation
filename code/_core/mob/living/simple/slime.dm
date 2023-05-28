/mob/living/simple/slime/
	name = "slime"
	desc = "Oh no. They're here too."
	desc_extended = "A strange gel-based canibalising lifeform that adapts their colors based on the surrounding environments. Diet typically includes fresh blood."

	icon = 'icons/mob/living/simple/slimes_new.dmi'
	icon_state = "small_neutral"

	var/stored_slimes = 1
	var/stored_slimes_max = 4

	ai = /ai/slime/

	can_attack_while_moving = TRUE

	var/happiness_mod = 0
	var/anger_mod = 0
	var/sadness_mod = 0

	color = "#888888"

	health_base = 50
	stamina_base = 100
	mana_base = 100

	value = 100

	armor = /armor/slime

	size = SIZE_ANIMAL

	damage_type = /damagetype/npc/slime

	movement_delay = DECISECONDS_TO_TICKS(1)

	enable_medical_hud = FALSE
	enable_security_hud = FALSE

	iff_tag = "Slime"
	loyalty_tag = "Slime"

	stun_angle = 0

	blood_type = null

	soul_size = SOUL_SIZE_NONE //Prevents farming.

	level = 2

	alpha = 255 //255 means set automatically based on level

	var/slime_traits = SLIME_TRAIT_NONE

	override_butcher = TRUE
	gib_on_butcher = FALSE

	var/has_bomb = FALSE

/mob/living/simple/slime/on_life_slow()
	. = ..()
	if((slime_traits & SLIME_TRAIT_UNSTABLE) && !dead && !prob(80))
		var/list/valid_turfs = list()
		for(var/turf/simulated/floor/F in orange(src,VIEW_RANGE*0.5))
			if(!F.is_safe() || !F.can_move_to(check_contents=FALSE))
				continue
			valid_turfs += F
		if(length(valid_turfs))
			var/turf/T = pick(valid_turfs)
			src.force_move(T)

/mob/living/simple/slime/proc/update_traits()

	//Canceling out
	if((slime_traits & SLIME_TRAIT_FAST) && (slime_traits & SLIME_TRAIT_SLOW))
		slime_traits &= ~(SLIME_TRAIT_FAST|SLIME_TRAIT_SLOW) //Remove both.

	if(slime_traits & SLIME_TRAIT_GLOW)
		set_light_sprite(stored_slimes + (alpha/255)*2, alpha/255, src.color,LIGHT_OMNI)
	else
		set_light_sprite(null)

	if(slime_traits & SLIME_TRAIT_FIRE)
		src.status_immune[FIRE] = TRUE
	else
		src.status_immune[FIRE] = FALSE

	if(ai && slime_traits & SLIME_TRAIT_AGGRESSIVE)
		ai.aggression = 2
	else
		ai.aggression = initial(ai.aggression)

	handle_transform() //SLIME_TRAIT_STEALTH

	return TRUE

/mob/living/simple/slime/get_damage_received_multiplier(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)
	. = ..()
	if(slime_traits & SLIME_TRAIT_DEFENSIVE)
		. *= 0.5
	if(stored_slimes > 1)
		. *= 1/stored_slimes

/mob/living/simple/slime/get_movement_delay()

	. = ..()

	if(slime_traits & SLIME_TRAIT_SLOW)
		. *= 4

	if(!(slime_traits & SLIME_TRAIT_FAST))
		. *= 2

/mob/living/simple/slime/get_plane()
	if(slime_traits & SLIME_TRAIT_STEALTH)
		return PLANE_MOVABLE_STEALTH
	. = ..()



/mob/living/simple/slime/post_move(var/atom/old_loc)
	. = ..()
	if(. && loc)
		if(ai && ai.objective_attack && (slime_traits & SLIME_TRAIT_THORNS))
			var/turf/T = get_turf(src)
			if(T)
				shoot_projectile(
					src,
					ai.objective_attack,
					null,
					null,
					/obj/projectile/bio/thorn,
					/damagetype/ranged/thorn,
					16,
					16,
					0,
					TILE_SIZE*0.5,
					1,
					"#FFFFFF",
					0,
					1,
					iff_tag,
					loyalty_tag
				)
				play_sound('sound/weapons/ranged/misc/slime_spike.ogg',T)

		if(length(src.contents) < 5)
			var/absorbed = FALSE
			for(var/obj/item/I in loc.contents)
				if(I.size > SIZE_2)
					continue
				absorbed = TRUE
				I.drop_item(src)
				I.pixel_x = initial(I.pixel_x) - 8
			if(absorbed)
				update_sprite()
		if((slime_traits & SLIME_TRAIT_WET) && is_turf(loc))
			var/turf/T = loc
			var/cleaning_power = 100
			for(var/obj/effect/cleanable/C in T.contents)
				if(cleaning_power <= 0)
					break
				qdel(C)
				cleaning_power -= 10
			if(is_simulated(T))
				var/turf/simulated/S = T
				S.add_wet(100)

/mob/living/simple/slime/create_override_contents(var/mob/living/caller) //What gets created when this mob is butchered.
	var/obj/item/slime_core/SC = new(src.loc)
	SC.color = color
	SC.alpha = alpha
	INITIALIZE(SC)
	FINALIZE(SC)
	return TRUE

/mob/living/simple/slime/Finalize()
	if(alpha == 255)
		alpha = min(255,150 + min(1,level/50)*105)
	. = ..()
	update_traits()
	update_sprite()

/mob/living/simple/slime/post_death()

	. = ..()

	var/turf/T = get_turf(src)

	for(var/obj/item/I in contents)
		if(T)
			I.drop_item(T)
		else
			qdel(I)

	if(T)
		if(slime_traits & SLIME_TRAIT_EXPLOSIVE)
			explode(T,2,src,src,src.loyalty_tag)

		if(has_bomb)
			has_bomb = FALSE
			var/obj/item/slime_bomb/SB = new(T)
			INITIALIZE(SB)
			GENERATE(SB)
			FINALIZE(SB)
			SB.owner = src
			SB.loyalty_tag = src.loyalty_tag
			SB.light()

	update_sprite()


/mob/living/simple/slime/attack(var/atom/attacker,var/atom/victim,var/list/params=list(),var/atom/blamed,var/ignore_distance = FALSE, var/precise = FALSE,var/damage_multiplier=1,var/damagetype/damage_type_override) //The src attacks the victim, with the blamed taking responsibility

	if(slime_traits & SLIME_TRAIT_WEAK)
		damage_multiplier *= 0.5

	. = ..()


/mob/living/simple/slime/check_death()

	. = ..()

	if(.) //Would result in death.
		if(stored_slimes <= 1) //Yeah you're dead, kiddo.
			return .

		var/ratio = 1/stored_slimes

		for(var/k in src.health.damage)
			src.health.damage[k] *= ratio

		for(var/i=1,i<=stored_slimes-1,i++) //Big slimes split.
			var/mob/living/simple/slime/S = new(get_turf(src))
			S.color = color
			S.alpha = alpha
			S.level = src.level
			S.slime_traits = src.slime_traits
			S.stored_slimes = 1
			if(src.color != initial(src.color))
				S.name = "hybrid slime"
			else
				S.name = initial(src.name)
			INITIALIZE(S)
			FINALIZE(S)
			if(S.ai)
				S.ai.set_active(TRUE)
				S.ai.find_new_objectives(AI_TICK,TRUE)
			var/turf/T = get_step(src,pick(DIRECTIONS_ALL))
			if(T) S.Move(T)
		var/turf/T = get_step(src,pick(DIRECTIONS_ALL))
		src.Move(T)
		src.stored_slimes = 1
		src.health.update_health()
		src.update_sprite()
		src.add_status_effect(STUN,20,20)
		return FALSE


/mob/living/simple/slime/update_overlays()

	. = ..()

	var/list/my_rgb = ReadRGB(color ? color : "#FFFFFF")
	var/anger = (my_rgb[1]/255) + anger_mod
	var/happiness = (my_rgb[2]/255) + happiness_mod
	var/sadness = (my_rgb[3]/255) + sadness_mod

	if(length(contents))
		sadness = INFINITY //Force a less-animated animation.

	var/mood = "neutral"

	if(anger > happiness && anger > sadness)
		mood = "angry"
	else if(happiness > anger && happiness > sadness)
		mood = "happy"
	else if(sadness > anger && sadness > happiness)
		mood = "sad"

	if(dead)
		if(!override_butcher)
			icon_state = "butchered"
		else
			icon_state = "death"
	else  if(stored_slimes > 1)
		icon_state = "large"
	else
		icon_state = "small_[mood]"

	if(!dead)
		var/face_state = "none"
		if(anger > happiness + sadness)
			face_state = "angry"
		else if(happiness > anger + sadness)
			face_state = "mischevous"
		else if(sadness > anger + happiness)
			face_state = "sad"
		var/image/I = new(initial(icon),"emotion_[face_state]")
		I.appearance_flags = appearance_flags | RESET_COLOR | RESET_ALPHA
		add_overlay(I)

/mob/living/simple/slime/update_underlays()

	. = ..()

	if(!dead)
		for(var/obj/item/O in contents)
			var/image/I = new/image(O.icon,O.icon_state)
			I.appearance = O.appearance
			I.appearance_flags = O.appearance_flags | RESET_ALPHA | RESET_COLOR
			var/matrix/M = matrix()
			M.Scale(0.25,0.25)
			I.transform = M
			add_underlay(I)
		if(has_bomb)
			var/image/I = new/image(initial(icon),"bomb")
			I.appearance_flags = src.appearance_flags | RESET_ALPHA | RESET_COLOR
			add_underlay(I)
	if(stored_slimes <= 1 && slime_traits & SLIME_TRAIT_THORNS)
		var/image/I = new/image(initial(icon),"[src.icon_state]_thorns")
		I.appearance_flags = src.appearance_flags | RESET_ALPHA | RESET_COLOR
		add_underlay(I)

/mob/living/simple/slime/proc/absorb_slime(var/mob/living/simple/slime/desired_slime)

	if(desired_slime == src) //Can't absorb self.
		return FALSE

	var/stored_ratio = desired_slime.stored_slimes / (stored_slimes + desired_slime.stored_slimes)
	var/stored_ratio_inverse = 1 - stored_ratio

	stored_slimes += desired_slime.stored_slimes //Number of stored slimes.

	var/list/my_rgb = ReadRGB(src.color ? src.color : "#FFFFFF")
	var/list/stored_rgb = ReadRGB(desired_slime.color ? desired_slime.color : " #FFFFFF")
	var/new_r = (my_rgb[1] * stored_ratio_inverse) + (stored_rgb[1] * stored_ratio)
	var/new_g = (my_rgb[2] * stored_ratio_inverse) + (stored_rgb[2] * stored_ratio)
	var/new_b = (my_rgb[3] * stored_ratio_inverse) + (stored_rgb[3] * stored_ratio)
	var/new_a = (src.alpha * stored_ratio_inverse) + (desired_slime.alpha * stored_ratio)

	var/new_color = rgb(new_r,new_g,new_b)
	animate(src,alpha=new_a,color=new_color,time=SECONDS_TO_DECISECONDS(2))
	src.alpha = new_a
	src.color = new_color
	src.slime_traits |= desired_slime.slime_traits

	name = "hybrid slime"
	setup_name()

	src.update_sprite()

	if(src.health && desired_slime.health) //Heal brute and burn, damage from tox.
		var/brute_to_restore = desired_slime.health.health_max - desired_slime.health.damage[BRUTE]
		var/burn_to_restore = desired_slime.health.health_max - desired_slime.health.damage[BURN]
		var/tox_to_add = desired_slime.health.damage[TOX]
		if(brute_to_restore || burn_to_restore || tox_to_add)
			src.health.adjust_loss_smart(brute=-brute_to_restore,burn=-burn_to_restore,tox=tox_to_add)

	qdel(desired_slime)

	return TRUE

/mob/living/simple/slime/forest
	name = "forest slime"
	color = "#69A333"
	level = 4

	slime_traits = SLIME_TRAIT_NONE

/mob/living/simple/slime/water
	name = "water slime"
	color = "#52A7C6"
	level = 6

	slime_traits = SLIME_TRAIT_FAST | SLIME_TRAIT_WET

/mob/living/simple/slime/snow
	name = "snow slime"
	color = "#E8ECF4"
	level = 8

	slime_traits = SLIME_TRAIT_COLD

/mob/living/simple/slime/sand
	name = "sand slime"
	color = "#F4CD9F"
	level = 8

	slime_traits = SLIME_TRAIT_FAST

/mob/living/simple/slime/jungle
	name = "jungle slime"
	color = "#6D8756"
	level = 8

	slime_traits = SLIME_TRAIT_TOXIC | SLIME_TRAIT_GLOW | SLIME_TRAIT_THORNS

/mob/living/simple/slime/cave
	name = "cave slime"
	color = "#936952"
	level = 6

	slime_traits = SLIME_TRAIT_STEALTH

/mob/living/simple/slime/ice
	name = "ice slime"
	color = "#93DDE2"
	level = 12

	slime_traits = SLIME_TRAIT_COLD | SLIME_TRAIT_SLOW | SLIME_TRAIT_DEFENSIVE

/mob/living/simple/slime/basalt
	name = "basalt slime"
	color = "#382323"
	level = 18

	slime_traits = SLIME_TRAIT_SLOW | SLIME_TRAIT_DEFENSIVE

/mob/living/simple/slime/magma
	name = "magma slime"
	color = "#E86518"
	level = 20

	slime_traits = SLIME_TRAIT_GLOW | SLIME_TRAIT_FIRE

/mob/living/simple/slime/blood
	name = "blood slime"
	color = "#C2230C"
	level = 18

	slime_traits = SLIME_TRAIT_AGGRESSIVE

/mob/living/simple/slime/oil
	name = "oil slime"
	color = "#332633"
	level = 16

	slime_traits = SLIME_TRAIT_SLOW | SLIME_TRAIT_EXPLOSIVE

/mob/living/simple/slime/bluespace
	name = "bluespace slime"
	color = "#9FB6FF"
	level = 30

	slime_traits = SLIME_TRAIT_UNSTABLE

/mob/living/simple/slime/bluespace/New(var/desired_loc)
	. = ..()
	if(prob(50))
		if(prob(50))
			slime_traits |= SLIME_TRAIT_FAST
		else
			slime_traits |= SLIME_TRAIT_SLOW
