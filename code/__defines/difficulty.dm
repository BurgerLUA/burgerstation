#define DIFFICULTY_EASY "easy"
#define DIFFICULTY_NORMAL "normal"
#define DIFFICULTY_HARD "hard"
#define DIFFICULTY_EXTREME "extreme"
#define DIFFICULTY_SURVIVOR "survivor"

// Difficulty balance.
// Note that during PvP, everything is forced to Normal difficulty.
// You can change this again after character creation once per week.

// Easy:
// Incoming damage multiplied by x0.5.
// AI Target priority multiplied by 1
// Can bring satchels, backpacks, and duffle bags.
// All clothes and non-hardsuit armor can be brought down.
// Maximium enemies allowed to target you at once before modifiers are applied: 1
// Maximum enemies hunting you down at once: 2.
// XP multiplied by x1

// Normal:
// Incoming damage multiplied by x0.75
// Target priority multiplied by 2
// Can bring satchels and backpacks.
// All clothes and non-hardsuit armor can be brought down.
// Maximium enemies allowed to target you at once before modifiers are applied: 2
// Maximum enemies hunting you down at once: 4.
// XP multiplied by x1.25

// Hard:
// Incoming damage multiplied by x1
// AI Target priority multiplied by 4
// Can bring satchels.
// All clothes except bodyarmor and helmets can be brought down.
// Maximium enemies allowed to target you at once before modifiers are applied: 4
// Maximum enemies hunting you down at once: 6.
// XP multiplied by x1.5

// Extreme:
// Incoming damage multiplied by x1
// AI Target priority multiplied by 6
// Cannot bring any equipment.
// Cannot bring any clothing items that are pants, underwear, shirt, gloves, shoes, socks.
// No natural health regeneration.
// Maximium enemies allowed to target you at once before modifiers are applied: 6
// Maximum enemies hunting you down at once: 6.
// XP multiplied by x1.75

// Survivor:
// Incoming damage multiplied by x1
// AI Target priority multiplied by 6
// Player will start completely naked in a random safe location instead of the station, with zero prep.
// No natural health regeneration.
// No natural stamina/mana regeneration past 50%.
// Maximium enemies allowed to target you at once before modifiers are applied: 6
// Maximum enemies hunting you down at once: 6.
// XP multiplied by x2