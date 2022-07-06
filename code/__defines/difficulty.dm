#define DIFFICULTY_EASY "Easy"
#define DIFFICULTY_NORMAL "Normal"
#define DIFFICULTY_HARD "Hard"
#define DIFFICULTY_EXTREME "Extreme"
#define DIFFICULTY_NIGHTMARE "Nightmare"

#define DIFFICULTY_ALL list(DIFFICULTY_EASY,DIFFICULTY_NORMAL,DIFFICULTY_HARD,DIFFICULTY_EXTREME,DIFFICULTY_NIGHTMARE)

// Difficulty balance.
// Note that during PvP, everything is forced to Normal difficulty.
// You can change this again after character creation once per week.

// Easy:
// Incoming damage multiplied by x0.25.
// AI Target priority multiplied by 1
// Maximium enemies allowed to target you at once before modifiers are applied: 1
// Maximum enemies hunting you down at once: 3.
// XP multiplied by x1

// Normal:
// Incoming damage multiplied by x0.5
// Target priority multiplied by 2
// Maximium enemies allowed to target you at once before modifiers are applied: 2
// Maximum enemies hunting you down at once: 4.
// XP multiplied by x1.25

// Hard:
// Incoming damage multiplied by x0.75
// AI Target priority multiplied by 4
// Maximium enemies allowed to target you at once before modifiers are applied: 4
// Maximum enemies hunting you down at once: 5.
// XP multiplied by x1.5

// Extreme:
// Incoming damage multiplied by x1
// AI Target priority multiplied by 6.
// No natural health regeneration.
// Maximium enemies allowed to target you at once before modifiers are applied: 6
// Maximum enemies hunting you down at once: 8.
// XP multiplied by x1.75

// Nightmare:
// Incoming damage multiplied by x1
// AI Target priority multiplied by 6.
// No natural health regeneration.
// No natural stamina/mana regeneration past 50%.
// Maximium enemies allowed to target you at once before modifiers are applied: 6
// Maximum enemies hunting you down at once: 10.
// XP multiplied by x2