


















#define RADIO_FREQ_AI_PRIVATE 144.7

#define RADIO_FREQ_SECURITY 135.9
#define RADIO_FREQ_ENGINEERING 135.7
#define RADIO_FREQ_MEDICAL 135.5
#define RADIO_FREQ_COMMAND 135.3
#define RADIO_FREQ_SCIENCE 135.1
#define RADIO_FREQ_SERVICE 134.9
#define RADIO_FREQ_SUPPLY 134.7

#define RADIO_FREQ_CENTCOMM 133.7

#define RADIO_FREQ_SYNDICATE 121.3




//In use.

#define RADIO_FREQ_MIN 110.1

#define RADIO_FREQ_ALPHA    145.1
#define RADIO_FREQ_BRAVO    145.3
#define RADIO_FREQ_CHARLIE  145.5
#define RADIO_FREQ_DELTA    145.7
#define RADIO_FREQ_COMMON   145.9

#define RADIO_FREQ_SHIP     146.1

#define RADIO_FREQ_DOOR     180.9

#define RADIO_FREQ_MAX      189.9


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