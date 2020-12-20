//A = 5
//B = 4
//C = 3
//D = 2
//E = 1

#define VOWELS list("a","e","i","o","u","y")
#define CONSONANTS list("b","c","d","f","g","h","j","k","l","m","n","p","q","r","s","t","v","w","x","z")

/stand/
	var/name = "Stand Name"
	var/mob/living/stand_user

	var/stat_destructive_power = 1
	var/stat_speed = 1
	var/stat_range = 1
	var/stat_persistence = 1
	var/stat_precision = 1
	var/stat_development_potential = 1

	var/stand_cry = "ORA"

	var/mob/living/advanced/stand/linked_stand

/stand/proc/on_move(var/success,var/new_loc,var/new_dir)

	if(success && (!linked_stand.ai || !linked_stand.ai.objective_attack))
		linked_stand.glide_size = stand_user.glide_size
		var/should_phase = linked_stand.alpha > 0 && get_dist(linked_stand.loc,new_loc) > 1
		if(should_phase) new/obj/effect/temp/phase/out(linked_stand.loc)
		linked_stand.force_move(new_loc)
		if(should_phase) new/obj/effect/temp/phase(new_loc)
		linked_stand.set_dir(new_dir)

	return TRUE

/stand/New(var/desired_owner)

	if(desired_owner)
		stand_user = desired_owner

	return ..()

/stand/Destroy()

	QDEL_NULL(linked_stand)

	if(stand_user)
		stand_user = null

	return ..()

/stand/proc/generate()
	name = uppertext("[pick(SStext.adjectives)] [pick(SStext.verbs)]")

	var/points_left = 3*6
	var/passes_left = points_left*3
	while(points_left > 0 && passes_left > 0)

		if(stat_destructive_power < 5)
			var/add_destuct = prob(50)
			stat_destructive_power += add_destuct
			points_left -= add_destuct

		if(stat_speed < 5)
			var/add_speed = prob(50)
			stat_speed += add_speed
			points_left -= add_speed

		if(stat_range < 5)
			var/add_range = prob(50)
			stat_range += add_range
			points_left -= add_range

		if(stat_persistence < 5)
			var/add_persistence = prob(50)
			stat_persistence += add_persistence
			points_left -= add_persistence

		if(stat_precision < 5)
			var/add_precision = prob(50)
			stat_precision += add_precision
			points_left -= add_precision

		if(stat_development_potential < 5)
			var/add_potential= prob(50)
			stat_development_potential += add_potential
			points_left -= add_potential

		passes_left -= 1

	//HORA
	//4123

	var/list/shout_list = list(
		"123! 123 123 123!",
		"1232323232323!",
		"123-123-123-123-123!",
		"4123412341234123!",
		"4123. 4123. 4123 4123 4123!",
		"123 123 4123333333333333!",
		"4123232323!",
		"41232323 123 41232323 123!"
	)

	stand_cry = pick(shout_list)
	stand_cry = replacetext(stand_cry,"4",pick(CONSONANTS))
	stand_cry = replacetext(stand_cry,"2",pick(CONSONANTS))
	stand_cry = replacetext(stand_cry,"1",pick(VOWELS - "y"))
	stand_cry = replacetext(stand_cry,"3",pick(VOWELS))
	stand_cry = uppertext(stand_cry)

	linked_stand = new /mob/living/advanced/stand(stand_user.loc)
	linked_stand.name = name
	linked_stand.sex = stand_user.gender
	linked_stand.gender = stand_user.gender
	linked_stand.owner = stand_user
	linked_stand.set_iff_tag(stand_user.iff_tag)
	linked_stand.set_loyalty_tag(stand_user.loyalty_tag)
	INITIALIZE(linked_stand)
	FINALIZE(linked_stand)
	linked_stand.equip_loadout(pick(subtypesof(/loadout/stand/)))

	if(stand_user.ai)
		stand_user.set_intent(INTENT_HARM)

/stand/proc/display_stand(var/mob/caller)
	caller.to_chat("Stand Name: <b>[name]</b>")
	caller.to_chat("Stand User: [stand_user.name]")
	caller.to_chat("Stand Cry: <b>\"[stand_cry]\"</b>")
	return TRUE

/mob/living/proc/remove_stand()
	QDEL_NULL(stand)
	return TRUE

/mob/living/proc/add_stand()

	if(dead || qdeleting)
		return FALSE

	if(stand)
		to_chat(span("warning","You already have a stand!"))
		return FALSE

	stand = new(src)
	stand.generate()
	stand.display_stand(src)

	var/obj/hud/button/stand/S = new
	S.update_owner(src)

	return TRUE