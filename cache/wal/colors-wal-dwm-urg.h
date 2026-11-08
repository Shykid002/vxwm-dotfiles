static const char norm_fg[] = "#c6c4c2";
static const char norm_bg[] = "#1e160d";
static const char norm_border[] = "#70675c";

static const char sel_fg[] = "#c6c4c2";
static const char sel_bg[] = "#30516C";
static const char sel_border[] = "#c6c4c2";

static const char urg_fg[] = "#c6c4c2";
static const char urg_bg[] = "#304555";
static const char urg_border[] = "#304555";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
