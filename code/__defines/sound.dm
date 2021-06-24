#define ENVIRONMENT_NONE -1

//Use these
#define ENVIRONMENT_GENERIC 0 //Generic building.
#define ENVIRONMENT_PADDED_CELL 1 //I'm in a box
#define ENVIRONMENT_ROOM 2 //Tiny room
#define ENVIRONMENT_BATHROOM 3 //Good for maint
#define ENVIRONMENT_LIVINGROOM 4 //Large room. Kinda muted so I don't really like this.
#define ENVIRONMENT_STONEROOM 5 //Very large room.
#define ENVIRONMENT_CONCERT_HALL 7 //Extremely large room, noticable echo., but feels cleaner.
#define ENVIRONMENT_HANGAR 10 //Good for hallways
#define ENVIRONMENT_CARPETTED_HALLWAY 11 //Maybe a better box.
#define ENVIRONMENT_HALLWAY 12 //Maybe a better box.
#define ENVIRONMENT_STONE_CORRIDOR 13 //Good hallway effect.
#define ENVIRONMENT_ALLEY 14 //Clean hallway effect
#define ENVIRONMENT_QUARRY 18 //Very echoy cave. Good for caves.
#define ENVIRONMENT_PLAIN 19 //Very plain. Meh.
#define ENVIRONMENT_PARKING_LOT 20 //Underground parking lot, medium size.
#define ENVIRONMENT_SEWER_PIPE 21 //Literally in a sewer pipe. Good for lockers, maybe.
#define ENVIRONMENT_DRUGGED 23 //The ss13 drugged hallucination effect
#define ENVIRONMENT_DIZZY 24 //Very large cave or something. Maybe hills or something
#define ENVIRONMENT_PSYCHOTIC 25 //Drugged on steroids

//Don't use these.
#define ENVIRONMENT_AUDITORIUM 6 //Extremely large room, noticable echo.
#define ENVIRONMENT_ARENA 9 //Same as 6, but denser?
#define ENVIRONMENT_CAVE 8 //Same as 6, but dirtier. Don't use.
#define ENVIRONMENT_FOREST 15 //Eh, no words here. No echo to justify this being a forrest.
#define ENVIRONMENT_CITY 16 //I guess it's a city.
#define ENVIRONMENT_MOUNTAINS 17 //Feels no different from 16

#define ENVIRONMENT_UNDERWATER 22 //Not underwater. Just seems like a poor effect.


#define SOUND_CHANNEL_NONE 0
#define SOUND_CHANNEL_MUSIC 1
#define SOUND_CHANNEL_AMBIENT 2
#define SOUND_CHANNEL_AMBIENT_RANDOM 3
#define SOUND_CHANNEL_UI 4
#define SOUND_CHANNEL_FOOTSTEPS 5
#define SOUND_CHANNEL_FX 6
#define SOUND_CHANNEL_FLASHBANG 7

#define SOUND_SETTING_AMBIENT "ambient" //Birds chirping and ambient sounds.
#define SOUND_SETTING_MUSIC "music" //Music that plays in your head
#define SOUND_SETTING_FX "effects" //Effects like bullets and impacts.
#define SOUND_SETTING_UI "interface"//Interface sounds, like button clicks and inventory noise.
#define SOUND_SETTING_FOOTSTEPS "footsteps" //Footsteps sound, either your own or others.