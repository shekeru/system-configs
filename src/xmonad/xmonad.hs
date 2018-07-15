import XMonad
import XMonad.Util.EZConfig
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.SimpleFloat

myLayout = gaps [(U, 24), (D, 24), (L, 36), (R,36)] (spacing 10 emptyBSP)

main = xmonad $ defaultConfig {
	terminal = "urxvt",
	layoutHook = myLayout,
	borderWidth = 0,
	normalBorderColor = "#f1f1f1",
	focusedBorderColor = "#2970c4",
	startupHook = do
		spawn "feh --bg-scale /etc/nixos/wallpaper.jpg"
		spawn "urxvt"
	}
