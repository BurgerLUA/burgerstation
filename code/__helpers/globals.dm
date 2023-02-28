#define INCREASE_STAT(mob,stat,amount)										\
	var/savedata/client/globals/G = ckey_to_globaldata[mob?.client?.ckey]; 	\
	if(G) G.loaded_data["stats"][stat] += amount;


#define GET_STAT(mob,stat) ckey_to_globaldata[mob?.client?.ckey]?.loaded_data["stats"][stat]
