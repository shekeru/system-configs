import XMonad
import XMonad.Util.EZConfig
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.SimpleFloat
import XMonad.Hooks.SetWMName

gapped = gaps [(U, 24), (D, 20), (L, 30), (R, 30)] (spacing 8 emptyBSP)

main = xmonad $ docks defaultConfig {
  terminal = "urxvt", modMask = mod4Mask,
  manageHook = manageDocks <+> manageHook defaultConfig,
  layoutHook = gapped, borderWidth = 0,
  normalBorderColor = "#f1f1f1",
  focusedBorderColor = "#2970c4",
  startupHook = do
    spawn "urxvt"	
    setWMName "xmonad+xmobar"
}
