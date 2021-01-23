//Not in use.
#define RADIO_FREQ_AI_PRIVATE 1447

#define RADIO_FREQ_SECURITY 1359
#define RADIO_FREQ_ENGINEERING 1357
#define RADIO_FREQ_MEDICAL 1355
#define RADIO_FREQ_COMMAND 1353
#define RADIO_FREQ_SCIENCE 1351
#define RADIO_FREQ_SERVICE 1349
#define RADIO_FREQ_SUPPLY 1347

#define RADIO_FREQ_CENTCOMM 1337

#define RADIO_FREQ_SYNDICATE 1213




//In use.
#define RADIO_FREQ_MIN 110.1

#define RADIO_FREQ_ALPHA    1451
#define RADIO_FREQ_BRAVO    1453
#define RADIO_FREQ_CHARLIE  1455
#define RADIO_FREQ_DELTA    1457
#define RADIO_FREQ_COMMON   1459

#define RADIO_FREQ_SHIP     1461

#define RADIO_FREQ_DOOR     1809

#define RADIO_FREQ_MAX      1899


/proc/frequency_to_name(var/frequency)

	switch(frequency)
		if(RADIO_FREQ_ALPHA)
			return "Alpha"
		if(RADIO_FREQ_BRAVO)
			return "Bravo"
		if(RADIO_FREQ_CHARLIE)
			return "Charlie"
		if(RADIO_FREQ_DELTA)
			return "Delta"
		if(RADIO_FREQ_COMMON)
			return "Common"
		if(RADIO_FREQ_SHIP)
			return "ShipComm"
	return "Unknown"