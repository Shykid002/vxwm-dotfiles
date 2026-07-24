static const char norm_fg[] = "#c2c0c0";
static const char norm_bg[] = "#0b0404";
static const char norm_border[] = "#665454";

static const char sel_fg[] = "#c2c0c0";
static const char sel_bg[] = "#575757";
static const char sel_border[] = "#c2c0c0";

static const char urg_fg[] = "#c2c0c0";
static const char urg_bg[] = "#474747";
static const char urg_border[] = "#474747";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
