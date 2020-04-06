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

/stand/proc/generate()
	name = uppertext("[pick(SSname.adjectives)] [pick(SSname.verbs)]")

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

/stand/proc/display_stand(var/mob/caller)
	caller.to_chat("ゴ ゴ ゴ ゴ ゴ ゴ ゴ ゴ")
	caller.to_chat("Stand Name: <b>「[name]」</b>")
	caller.to_chat("Stand User: [caller.name]")
	caller.to_chat("Stand Cry: <b>\"[stand_cry]\"</b>")
	/*
	caller.to_chat("Power: [stat_destructive_power]")
	caller.to_chat("Speed: [stat_speed]")
	caller.to_chat("Range: [stat_range]")
	caller.to_chat("Persistence: [stat_persistence]")
	caller.to_chat("Precision: [stat_precision]")
	caller.to_chat("Potential: [stat_development_potential]")
	*/
	caller.to_chat("ゴ ゴ ゴ ゴ ゴ ゴ ゴ ゴ")
	return TRUE

/mob/living/verb/add_stand()

	if(stand)
		qdel(stand)
		stand = null

	stand = new(src)
	stand.generate()
	stand.display_stand(src)

	return TRUE