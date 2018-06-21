import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Spacing
import XMonad.Layout.Gaps
import XMonad.Layout.SimpleFloat
import XMonad.Layout.NoFrillsDecoration

myLayout = gaps [(U,50), (D,50), (L,75), (R,75)] $ spacing 10 $ emptyBSP
myTheme = defaultTheme { activeColor = "#f7a050",
						 inactiveColor = "#ff8267",
						 activeBorderColor = "#f7a050",
						 inactiveBorderColor = "#ff8267",
						 activeTextColor = "#24262b",
						 inactiveTextColor = "#24262b",
						 decoHeight = 24,
						 fontName = "xft:Liberation Mono For Powerline:size=9" }

myLayout = noFrillsDeco shrinkText myTheme $ gaps [(U,50), (D,50), (L,75), (R,75)] $ spacing 10 $ emptyBSP

main = xmonad $ defaultConfig
	{ terminal = "urxvt",
	  layoutHook = myLayout,
	  borderWidth = 1,
	  normalBorderColor = "#f1f1f1",
	  focusedBorderColor = "#2970c4"
	}
