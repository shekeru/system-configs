import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.SimpleFloat
import XMonad.Util.SpawnNamedPipe
import XMonad.Hooks.SetWMName
import System.IO

--myLayout = gaps [(U, 24), (D, 24), (L, 36), (R,36)] (spacing 10 emptyBSP)
myLayout = gaps [(U, 24), (D, 24), (L, 32), (R, 32)] (spacing 8 emptyBSP)

main = xmonad $ docks defaultConfig {
	terminal = "urxvt",
	manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = myLayout,
	modMask = mod4Mask,
	borderWidth = 0,
	normalBorderColor = "#f1f1f1",
	focusedBorderColor = "#2970c4",
	startupHook = do
		spawn "urxvt"
		setWMName "xmonad+xmobar"
	}
