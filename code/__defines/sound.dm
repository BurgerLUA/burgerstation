#define ENVIRONMENT_NONE -1
#define ENVIRONMENT_GENERIC 0
#define ENVIRONMENT_PADDED_CELL 1
#define ENVIRONMENT_ROOM 2
#define ENVIRONMENT_BATHROOM 3 //Good for maint
#define ENVIRONMENT_LIVINGROOM 4
#define ENVIRONMENT_STONEROOM 5
#define ENVIRONMENT_AUDITORIUM 6
#define ENVIRONMENT_CONCERT_HALL 7
#define ENVIRONMENT_CAVE 8
#define ENVIRONMENT_ARENA 9
#define ENVIRONMENT_HANGAR 10 //Good for hallways
#define ENVIRONMENT_CARPETTED_HALLWAY 12
#define ENVIRONMENT_HALLWAY 12
#define ENVIRONMENT_STONE_CORRIDOR 13
#define ENVIRONMENT_ALLEY 14
#define ENVIRONMENT_FOREST 15
#define ENVIRONMENT_CITY 16
#define ENVIRONMENT_MOUNTAINS 17
#define ENVIRONMENT_QUARRY 18
#define ENVIRONMENT_PLAIN 19
#define ENVIRONMENT_PARKING_LOT 20
#define ENVIRONMENT_SEWER_PIPE 21
#define ENVIRONMENT_UNDERWATER 22
#define ENVIRONMENT_DRUGGED 23
#define ENVIRONMENT_DIZZY 24
#define ENVIRONMENT_PSYCHOTIC 25


#define SOUND_CHANNEL_NONE 0
#define SOUND_CHANNEL_MUSIC 1
#define SOUND_CHANNEL_AMBIENT 2
#define SOUND_CHANNEL_AMBIENT_RANDOM 3
#define SOUND_CHANNEL_UI 4
#define SOUND_CHANNEL_FOOTSTEPS 5
#define SOUND_CHANNEL_FX 6

#define SOUND_SETTING_AMBIENT "ambient" //Birds chirping and ambient sounds.
#define SOUND_SETTING_MUSIC "music" //Music that plays in your head
#define SOUND_SETTING_FX "effects" //Effects like bullets and impacts.
#define SOUND_SETTING_UI "interface"//Interface sounds, like button clicks and inventory noise.
#define SOUND_SETTING_FOOTSTEPS "footsteps" //Footsteps sound, either your own or others.


#define TRACKS_FOREST list(/track/death_to_life,/track/revolver,/track/rise_from_the_dirt,/track/spacemans_flight,/track/village_intro)
#define TRACKS_CAVE list(/track/cave_spook)
#define TRACKS_LAVA list(/track/cursed_lava,/track/lavaland,/track/walking_danger)
#define TRACKS_MOUNTAIN list(/track/crystal_whispers,/track/dawn,/track/rising_bells,/track/russian_heavy,/track/snow_fall,/track/vapor)
#define TRACKS_LOBBY list(/track/slow_fall,/track/boat,/track/two_thirty_six,/track/relaxed_intro)
#define TRACKS_DEAD list(/track/game_over,/track/piano_depression,/track/sorrow_keys)
#define TRACKS_JUNGLE list(/track/water_temple,/track/wistles_from_the_holy_forest)
#define TRACKS_DESERT list(/track/endgame,/track/village_hype)
#define TRACKS_HERALD list(/track/soul_gem)


//unused: /track/meteor_storm, /track/meteor_recovery, /track/intro, /track/endgame, /track/space_wayfarer
//unused boss: /track/nervous_journey, /track/night, /track/progression_mk4, /track/chords, /track/industrial_beat, /track/from_evil