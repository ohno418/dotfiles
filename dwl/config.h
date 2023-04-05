#include <X11/XF86keysym.h>

/* appearance */
static const int sloppyfocus               = 0;  /* focus follows mouse */
static const int bypass_surface_visibility = 0;  /* 1 means idle inhibitors will disable idle tracking even if it's surface isn't visible  */
static const unsigned int borderpx         = 1;  /* border pixel of windows */
static const float bordercolor[]           = {0.5, 0.5, 0.5, 1.0};
static const float focuscolor[]            = {0.2, 1.0, 0.7, 1.0};
/* To conform the xdg-protocol, set the alpha to zero to restore the old behavior */
static const float fullscreen_bg[]         = {0.1, 0.1, 0.1, 1.0};

/* autostart */
static const char *const autostart[] = {
	"wbg", "/home/ohno/dev/dotfiles/dwl/wallpaper.jpg", NULL,
	"yambar", NULL,
	"fcitx5", NULL,
	// This is for GTK+ applications to improve start-up time.
	// https://github.com/swaywm/sway/wiki#gtk-applications-take-20-seconds-to-start
	"dbus-update-activation-environment", "--systemd", "WAYLAND_DISPLAY", NULL,
	NULL /* terminate */
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* app_id     title       tags mask     isfloating   monitor */
	// { "firefox",  NULL,       1 << 8,       0,           -1 },
	NULL,
};

/* layout(s) */
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* monitors */
static const MonitorRule monrules[] = {
	/* name       mfact nmaster scale layout       rotate/reflect                x    y */
	/* example of a HiDPI laptop monitor:
	{ "eDP-1",    0.5,  1,      2,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
	*/
	/* defaults */
	{ NULL,       0.55, 1,      1,    &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL,   -1,  -1 },
};

/* keyboard */
static const struct xkb_rule_names xkb_rules = {
	/* can specify fields: rules, model, layout, variant, options */
	.options = "ctrl:nocaps",
};

static const int repeat_rate = 50;
static const int repeat_delay = 300;

/* Trackpad */
static const int tap_to_click = 1;
static const int tap_and_drag = 1;
static const int drag_lock = 1;
static const int natural_scrolling = 1;
static const int disable_while_typing = 1;
static const int left_handed = 0;
static const int middle_button_emulation = 0;
/* You can choose between:
LIBINPUT_CONFIG_SCROLL_NO_SCROLL
LIBINPUT_CONFIG_SCROLL_2FG
LIBINPUT_CONFIG_SCROLL_EDGE
LIBINPUT_CONFIG_SCROLL_ON_BUTTON_DOWN
*/
static const enum libinput_config_scroll_method scroll_method = LIBINPUT_CONFIG_SCROLL_2FG;

/* You can choose between:
LIBINPUT_CONFIG_CLICK_METHOD_NONE       
LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS       
LIBINPUT_CONFIG_CLICK_METHOD_CLICKFINGER 
*/
static const enum libinput_config_click_method click_method = LIBINPUT_CONFIG_CLICK_METHOD_BUTTON_AREAS;

/* You can choose between:
LIBINPUT_CONFIG_SEND_EVENTS_ENABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED
LIBINPUT_CONFIG_SEND_EVENTS_DISABLED_ON_EXTERNAL_MOUSE
*/
static const uint32_t send_events_mode = LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;

/* You can choose between:
LIBINPUT_CONFIG_ACCEL_PROFILE_FLAT
LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE
*/
static const enum libinput_config_accel_profile accel_profile = LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE;
static const double accel_speed = 0.3;
/* Hide the cursor when timeout. */
static const int cursor_timeout = 5;
/* You can choose between:
LIBINPUT_CONFIG_TAP_MAP_LRM -- 1/2/3 finger tap maps to left/right/middle
LIBINPUT_CONFIG_TAP_MAP_LMR -- 1/2/3 finger tap maps to left/middle/right
*/
static const enum libinput_config_tap_button_map button_map = LIBINPUT_CONFIG_TAP_MAP_LRM;

/* If you want to use the windows key for MODKEY, use WLR_MODIFIER_LOGO */
#define MODKEY WLR_MODIFIER_ALT

#define TAGKEYS(KEY,SKEY,TAG) \
	{ MODKEY,                    KEY,            view,            {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL,  KEY,            toggleview,      {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_SHIFT, SKEY,           tag,             {.ui = 1 << TAG} }, \
	{ MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT,SKEY,toggletag, {.ui = 1 << TAG} }

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
// terminal
static const char *termcmd[] = { "foot", NULL };
// browser
static const char *ffcmd[] = { "firefox", NULL };
static const char *ffprivatecmd[] = { "firefox", "--private-window", NULL };
// audio
static const char *volupcmd[] = { "pamixer", "--increase", "5", NULL };
static const char *voldowncmd[] = { "pamixer", "--decrease", "5", NULL };
static const char *mutecmd[] = { "pamixer", "--toggle-mute", NULL };
static const char *mutemiccmd[] = { "pamixer", "--default-source", "--toggle-mute", NULL };
// backlight
static const char *blupcmd[] = { "brightnessctl", "set", "5%+", NULL };
static const char *bldowncmd[] = { "brightnessctl", "set", "5%-", NULL };
static const char *lockcmd[] = { "waylock", NULL };

static const Key keys[] = {
	/* Note that Shift changes certain key codes: c -> C, 2 -> at, etc. */
	/* modifier                  key                 function        argument */
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Return,     spawn,          {.v = termcmd} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_B,          spawn,          {.v = ffcmd} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_P,          spawn,          {.v = ffprivatecmd} },
	{ MODKEY,                    XKB_KEY_j,          focusstack,       {.i = +1} },
	{ MODKEY,                    XKB_KEY_k,          focusstack,       {.i = -1} },
	{ MODKEY,                    XKB_KEY_i,          incnmaster,       {.i = +1} },
	{ MODKEY,                    XKB_KEY_d,          incnmaster,       {.i = -1} },
	{ MODKEY,                    XKB_KEY_h,          setmfact,         {.f = -0.05} },
	{ MODKEY,                    XKB_KEY_l,          setmfact,         {.f = +0.05} },
	{ MODKEY,                    XKB_KEY_Return,     zoom,             {0} },
	{ MODKEY,                    XKB_KEY_Tab,        view,             {0} },
	{ MODKEY,                    XKB_KEY_o,          view,             {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Q,          killclient,       {0} },
	{ MODKEY,                    XKB_KEY_t,          setlayout,        {.v = &layouts[0]} },
	{ MODKEY,                    XKB_KEY_f,          setlayout,        {.v = &layouts[1]} },
	{ MODKEY,                    XKB_KEY_m,          setlayout,        {.v = &layouts[2]} },
	{ MODKEY,                    XKB_KEY_space,      setlayout,        {0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_space,      togglefloating,   {0} },
	{ MODKEY,                    XKB_KEY_e,          togglefullscreen, {0} },
	{ MODKEY,                    XKB_KEY_0,          view,             {.ui = ~0} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_parenright, tag,              {.ui = ~0} },
	{ MODKEY,                    XKB_KEY_comma,      focusmon,         {.i = WLR_DIRECTION_LEFT} },
	{ MODKEY,                    XKB_KEY_period,     focusmon,         {.i = WLR_DIRECTION_RIGHT} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_less,       tagmon,           {.i = WLR_DIRECTION_LEFT} },
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_greater,    tagmon,           {.i = WLR_DIRECTION_RIGHT} },
	// audio
	{ 0, XF86XK_AudioRaiseVolume, spawn, {.v = volupcmd } },
	{ 0, XF86XK_AudioLowerVolume, spawn, {.v = voldowncmd } },
	{ 0, XF86XK_AudioMute,        spawn, {.v = mutecmd } },
	{ 0, XF86XK_AudioMicMute,     spawn, {.v = mutemiccmd } },
	{ 0, XKB_KEY_F12,             spawn, {.v = volupcmd } },
	{ 0, XKB_KEY_F11,             spawn, {.v = voldowncmd } },
	{ 0, XKB_KEY_F10,             spawn, {.v = mutecmd } },
	{ 0, XKB_KEY_F9,              spawn, {.v = mutemiccmd } },
	// backlight
	{ 0, XF86XK_MonBrightnessUp,   spawn, {.v = blupcmd } },
	{ 0, XF86XK_MonBrightnessDown, spawn, {.v = bldowncmd } },
	{ 0, XKB_KEY_F8,               spawn, {.v = blupcmd } },
	{ 0, XKB_KEY_F7,               spawn, {.v = bldowncmd } },
	// screenshot
	{ 0, XKB_KEY_Print, spawn, SHCMD("grim -g \"$(slurp -d)\" -t png ~/Downloads/$(date '+%Y%m%d-%H%M%S').png") },
	// lock
	{ MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_X, spawn, {.v = lockcmd} },

	TAGKEYS(          XKB_KEY_1, XKB_KEY_exclam,                       0),
	TAGKEYS(          XKB_KEY_2, XKB_KEY_at,                           1),
	TAGKEYS(          XKB_KEY_3, XKB_KEY_numbersign,                   2),
	TAGKEYS(          XKB_KEY_4, XKB_KEY_dollar,                       3),
	TAGKEYS(          XKB_KEY_5, XKB_KEY_percent,                      4),
	TAGKEYS(          XKB_KEY_6, XKB_KEY_asciicircum,                  5),
	TAGKEYS(          XKB_KEY_7, XKB_KEY_ampersand,                    6),
	TAGKEYS(          XKB_KEY_8, XKB_KEY_asterisk,                     7),
	TAGKEYS(          XKB_KEY_9, XKB_KEY_parenleft,                    8),

	{ MODKEY|WLR_MODIFIER_SHIFT|WLR_MODIFIER_LOGO, XKB_KEY_Q, quit, {0} },

	// TODO: ??
	/* Ctrl-Alt-Backspace and Ctrl-Alt-Fx used to be handled by X server */
	{ WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT, XKB_KEY_Terminate_Server, quit, {0} },
#define CHVT(n) { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_XF86Switch_VT_##n, chvt, {.ui = (n)} }
	CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6),
	CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
};

static const Button buttons[] = {
	{ MODKEY, BTN_LEFT,   moveresize,     {.ui = CurMove} },
	{ MODKEY, BTN_MIDDLE, togglefloating, {0} },
	{ MODKEY, BTN_RIGHT,  moveresize,     {.ui = CurResize} },
};
