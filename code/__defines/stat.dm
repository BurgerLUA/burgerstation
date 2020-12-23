#define STAT_EXISTS(x) (SSstats.stored_stats[x] ? TRUE : FALSE)
#define STAT_GET(x) SSstats.stored_stats[x]
#define STAT_ADD(x,y) if(!SSstats.stored_stats[x]) {SSstats.stored_stats[x] = y} else {SSstats.stored_stats[x] += y}
#define STAT_SET(x,y) SSstats.stored_stats[x] = y
#define STAT_SUBSET_ADD(x,y,z) if(!SSstats.stored_stats[x]) {SSstats.stored_stats[x] = list}; if(!SSstats.stored_stats[x][y]) {SSstats.stored_stats[x][y] = z} else {SSstats.stored_stats[x][y] += z}