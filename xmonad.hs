--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
import System.Exit
import XMonad.Config.Gnome
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Actions.SpawnOn
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Run(spawnPipe)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.Cross
import XMonad.Layout.Circle
import XMonad.Layout.Accordion
import XMonad.Layout.NoBorders
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.SwapWorkspaces


import System.IO


import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "gnome-terminal"

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The mask for the numlock key. Numlock status is "masked" from the
-- current modifier status, so the keybindings will work with numlock on or
-- off. You may need to change this on some systems.
--
-- You can find the numlock modifier by running "xmodmap" and looking for a
-- modifier with Num_Lock bound to it:
--
-- > $ xmodmap | grep Num
-- > mod2        Num_Lock (0x4d)
--
-- Set numlockMask = 0 if you don't have a numlock key, or want to treat
-- numlock status separately.
--
--myNumlockMask   = mod2Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["web", "2","3","4","5","6","7","8","9","0", "-", "=", "ctl"] -- ctl is ~

-- Border colors for unfocused and focused windows, respectively.
--

selected   = "'#fad184'"
background = "'#efebe7'"
foreground = "'#000000'"
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff8822"

-- height matches Ubuntu top Gnome panel
barHeight = "24"
 
--  font intended to match Ubuntu default application font
appFontXft = "'xft\
                \:Sans\
                \:pixelsize=14\
                \:weight=regular\
                \:width=semicondensed\
                \:dpi=96\
                \:hinting=true\
                \:hintstyle=hintslight\
                \:antialias=true\
                \:rgba=rgb\
                \:lcdfilter=lcdlight\
             \'"
 
-- currently dzen2 compiled locally to get xft support
-- (-e prevents loss of title if naive user clicks on dzen2)
myDzenTitleBar =
    "dzen2\
        \ -ta l\
        \ -x 400 -w 900 -y 0\
        \ -e 'entertitle=uncollapse'\
        \ -h  " ++ barHeight  ++ "\
        \ -bg " ++ background ++ "\
        \ -fg " ++ foreground ++ "\
        \ -fn " ++ appFontXft
 
-- dmenu patched and compiled locally to add xft support
myDmenuTitleBar =
    "exec `dmenu_run \
        \ -i\
        \ -bh " ++ barHeight  ++ "\
        \ -nb " ++ background ++ "\
        \ -nf " ++ foreground ++ "\
        \ -sb " ++ selected   ++ "\
        \ -fn " ++ appFontXft ++ "\
    \`" 
--"


------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm              , xK_Return), spawn $ XMonad.terminal conf)
    , ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    --, ((modm              , xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ((modm              , xK_p     ), spawn "dmenu_run")

    -- launch gnome-do
    --, ((modm              , xK_p     ), spawn "gnome-do")

    -- Monitor management
    , ((modm              , xK_i     ), spawn "xrandr --output eDP-1 --auto --output DP-3 --auto --right-of eDP-1")
    , ((modm .|. shiftMask, xK_i     ), spawn "xrandr --output eDP-1 --auto --output DP-3 --auto --same-as eDP-1")
    , ((modm .|. controlMask, xK_i     ), spawn "xrandr --output eDP-1 --auto --output DP-3 --off")

    -- VPN management
    , ((modm              , xK_u     ), spawn "nmcli connection up firewall-01-UDP4-9999-zach-home-01 passwd-file ~/.vpn/firewall-01-UDP4-9999-zach-home-01/pwfile")
    , ((modm .|. shiftMask, xK_u     ), spawn "nmcli connection down firewall-01-UDP4-9999-zach-home-01")

    -- close focused window 
    , ((modm .|. shiftMask, xK_c     ), kill)
    
    -- Musicazoo (R.I.P. 2012 -- 2015)
    -- , ((shiftMask, xF86XK_AudioRaiseVolume    ), spawn "mz vol up > /dev/null")
    -- , ((shiftMask, xF86XK_AudioLowerVolume    ), spawn "mz vol down > /dev/null")
    -- , ((shiftMask, xF86XK_AudioMute    ), spawn "mz skip > /dev/null")

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    --, ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Lock screen
    --, ((modm .|. shiftMask, xK_l     ), spawn "light-locker-command -l")

    -- Suspend
    , ((modm .|. shiftMask, xK_s     ), spawn "systemctl suspend")

    -- Hibernate
    , ((modm .|. shiftMask, xK_h     ), spawn "systemctl hibernate")

    --, ((modm,               xK_z     ), spawn "export DISPLAY=:0; /home/zbanks/autoclick ")


    -- toggle the status bar gap (used with avoidStruts from Hooks.ManageDocks)
    -- , ((modm , xK_b ), sendMessage ToggleStruts)

    -- , ((modm .|. shiftMask, xK_o    ), spawn myDmenuTitleBar)

    -- Quit xmonad
    --, ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    -- Weird shortcuts
    , ((modm .|. shiftMask, xK_q     ), spawn "gnome-terminal -x sh -c 'vim ~/.xmonad/xmonad.hs'")
    , ((modm .|. shiftMask, xK_g     ), spawn "sleep 0.3; gnome-screenshot --area")

    -- Restart xmonad
    , ((modm              , xK_q     ), restart "xmonad" True)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    -- mod-ctl-[1..9], Swap current workspace with N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9]++[xK_0, xK_minus, xK_equal, xK_grave])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask), (swapWithCurrent, controlMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask), (swapWithCurrent, controlMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask .|. shiftMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask .|. shiftMask, button2), (\w -> focus w >> windows W.swapMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask .|. shiftMask, button3), (\w -> focus w >> mouseResizeWindow w))

    -- control-click, same as above
    , ((modMask .|. controlMask, button1), (\w -> focus w >> mouseResizeWindow w))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts ( smartBorders tiled ||| Mirror tiled ||| noBorders Full ||| radiance)
  where
     radiance = Mirror $ Tall 1 0 (782/1080)
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
-- | Move the window to a given workspace
doSink = ask >>= \w -> doF (W.sink w)
--doSwapMaster = ask >>= \w -> doF (W.swapMaster w)

myManageHook = composeAll
    [ manageHook gnomeConfig
    , title =? "Snes9x: Linux"      --> doShift "-"
    , className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Do"             --> doIgnore
    -- , className =? "radiance"       --> doSink
    , className =? "radiance"       --> doF W.swapMaster
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    , isFullscreen                  --> doFullFloat ] <+> manageDocks

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True


------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--
-----------------------------
--myLogHookWithPP :: PP -> X ()
--myLogHookWithPP pp = do
--    ewmhDesktopsLogHook
--    dynamicLogWithPP pp


-------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    -- spawnOnce "google-chrome"

      spawn "xmodmap -e 'remove Lock = Caps_Lock'"
      spawn "xmodmap -e 'keysym Caps_Lock = Escape'"
      spawn "setxkbmap -option caps:escape"
      --spawn "light-locker"
      --spawn "xmobar"
      --spawnOn "ctl" "gnome-terminal --class=CtlTerm -e 'alsamixer -c1'"
      --spawnOn "ctl" "gnome-terminal --class=CtlTerm -e 'watch -n10 acpi -V'"
      --spawnOn "ctl" "gnome-terminal --class=CtlTerm -e nmtui"
      gnomeRegister
      startupHook desktopConfig 

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
        xmonad $ gnomeConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        --numlockMask        = myNumlockMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        startupHook        = myStartupHook
    }

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will 
-- use the defaults defined in xmonad/XMonad/Config.hs
-- 
-- No need to modify this.
--
--defaults = gnomeConfig {
---- simple stuff
--terminal           = myTerminal,
--focusFollowsMouse  = myFocusFollowsMouse,
--borderWidth        = myBorderWidth,
--modMask            = myModMask,
--numlockMask        = myNumlockMask,
--workspaces         = myWorkspaces,
--normalBorderColor  = myNormalBorderColor,
--focusedBorderColor = myFocusedBorderColor,
--
---- key bindings
--keys               = myKeys,
--mouseBindings      = myMouseBindings,
--
---- hooks, layouts
--layoutHook         = myLayout,
--manageHook         = myManageHook,
--logHook            = myLogHook,
--startupHook        = myStartupHook
--}
