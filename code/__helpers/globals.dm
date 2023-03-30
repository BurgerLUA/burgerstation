#define INCREASE_ACHIEVEMENT(mob,achievement,amount)								\
	var/savedata/client/globals/G = ckey_to_globaldata[mob?.client?.ckey];			\
	if(G)																			\
		if(!G.loaded_data["achievements"][achievement])								\
			G.loaded_data["achievements"][achievement] = 1;							\
		else																		\
			G.loaded_data["achievements"][achievement] += amount;


#define GET_ACHIEVEMENT(mob,achievement) ckey_to_globaldata[mob?.client?.ckey]?.loaded_data["achievements"][achievement]
