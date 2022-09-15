#define CONFIG(id,fallback) ((SSconfig.config[id] != null) ? SSconfig.config[id] : fallback)
#define CONFIG_DIR "config/config.txt"