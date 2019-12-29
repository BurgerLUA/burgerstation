/karma_penalty/
	var/id = null

	var/min_karma //Karma has to be above this amount to trigger.
	var/max_karma //Karma has to be below this amount to trigger.

/karma_penalty/proc/on_trigger(var/mob/attacker,var/mob/victim)
	//Trigger stuff here.

//Assassins
/karma_penalty/assassin_01
	min_karma = 0
	max_karma = 1000000

/karma_penalty/assassin_02
	min_karma = -10000
	max_karma = 0

/karma_penalty/assassin_03
	min_karma = -25000
	max_karma = -5000

/karma_penalty/assassin_04
	min_karma = -50000
	max_karma = -10000

/karma_penalty/assassin_05
	min_karma = -25000
	max_karma = -1000000