#define TARGETABLE_LIMBS list(BODY_HEAD, BODY_TORSO, BODY_GROIN, BODY_ARM_LEFT, BODY_ARM_RIGHT , BODY_HAND_LEFT, BODY_HAND_RIGHT, BODY_LEG_LEFT, BODY_LEG_RIGHT, BODY_FOOT_LEFT, BODY_FOOT_RIGHT	)
#define TARGETABLE_LIMBS_KV list(BODY_HEAD = 0, BODY_TORSO = 0, BODY_GROIN = 0, BODY_ARM_LEFT = 0, BODY_ARM_RIGHT = 0, BODY_HAND_LEFT = 0, BODY_HAND_RIGHT = 0, BODY_LEG_LEFT = 0, BODY_LEG_RIGHT = 0, BODY_FOOT_LEFT = 0, BODY_FOOT_RIGHT = 0	)
#define DEFAULT_COLORS list("#498eb1","#4f7081","#326068","#eaeaea","#333333","#fe0000")

#define QWERTY_MACROS list( \
	"W" = "move_up", \
	"D" = "move_right", \
	"S" = "move_down", \
	"A" = "move_left",\
	"1" = "set-intent-help",\
	"2" = "set-intent-disarm", \
	"3" = "set-intent-grab", \
	"4" = "set-intent-harm", \
	"North" = "move_up", \
	"East" = "move_right", \
	"South" = "move_down", \
	"West" = "move_left", \
	"Shift" = "sprint", \
	"Alt" = "walk", \
	"Ctrl" = "grab", \
	"R" = "throw", \
	"Q" = "drop", \
	"C" = "hold", \
	"B" = "sneak", \
	"E" = "examine_mode", \
	"Z" = "quick_self", \
	"X" = "quick_holder", \
	"Space" = "kick", \
	"G" = "cycle-intent-clockwise", \
	"F" = "cycle-intent-counter-clockwise", \
	"T" = "say", \
	"O" = "ooc", \
	"L" = "looc", \
	"V" = "zoom"\
)

#define AZERTY_MACROS list( \
	"Z" = "move_up",\
	"D" = "move_right",\
	"S" = "move_down",\
	"Q" = "move_left",\
	"1" = "set-intent-help",\
	"2" = "set-intent-disarm",\
	"3" = "set-intent-grab",\
	"4" = "set-intent-harm",\
	"North" = "move_up",\
	"East" = "move_right",\
	"South" = "move_down",\
	"West" = "move_left",\
	"Shift" = "sprint",\
	"Alt" = "walk",\
	"Ctrl" = "grab",\
	"R" = "throw",\
	"A" = "drop",\
	"C" = "hold",\
	"B" = "sneak",\
	"E" = "examine_mode",\
	"F" = "quick_self",\
	"X" = "quick_holder", \
	"Space" = "kick",\
	"G" = "cycle-intent-clockwise",\
	"H" = "cycle-intent-counter-clockwise",\
	"T" = "say",\
	"O" = "ooc",\
	"L" = "looc",\
	"V" = "zoom",\
)


#define Z_LEVEL_STATION 1
#define Z_LEVEL_BLUESPACE 2
#define Z_LEVEL_MISSION 3