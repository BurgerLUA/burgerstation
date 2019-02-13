#define KARMA_OVERALL "all" //Killed/Help players
#define KARMA_CLIENT "client" //Client karma

#define KARMA_HUMAN "human"
#define KARMA_LIZARD "lizard"
#define KARMA_CYBORG "cyborg"
#define KARMA_DIONA "diona"

/mob/living/proc/add_karma(var/karma_type,var/amount)

	if(src.client)
		add_karma(amount)

	karma[karma_type] += amount
	return TRUE

/client/proc/add_karma(var/amount)
	karma += amount
	return TRUE