import XMonad
import XMonad.Util.EZConfig
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.SimpleFloat
import XMonad.Hooks.Script

myLayout = gaps [(U,50), (D,50), (L,75), (R,75)] (spacing 10 emptyBSP)

main = xmonad $ defaultConfig {
	terminal = "urxvt",
	layoutHook = myLayout,
	borderWidth = 0,
	normalBorderColor = "#f1f1f1",
	focusedBorderColor = "#2970c4",
	startupHook = do
		spawn "feh --bg-scale /etc/nixos/wallpaper.jpg"
		execScriptHook "startup"
		spawn "urxvt"
	}
