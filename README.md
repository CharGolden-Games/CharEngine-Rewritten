# Char Engine | The self-proclaimed kickass Friday Night Funkin' engine based on the newgrounds preview (0.2.8) 😎

# Compiling
### Windows:
- [Install the neccassary Haxelibs](tools/haxelibs.bat)
- [Install Visual Studio](github.com/ShadowMario/FNF-PsychEngine/blob/main/setup/windows-msvc.bat)
- `lime test windows` or `lime build windows`
- Done!

### Unix:
- [Install the neccassary haxelibs](tools/haxelibs.sh)
- install gcc (Linux) or install XCode (Mac)
- `lime test` or `lime build` with `linux` or `mac` at the end depending on what you're using.
- Done!

# How To Play:
> [!NOTE]
> Don't keep this stupid joke around too long.

Have you played Friday Night Funkin' before? It's that.

<details>
	<summary><h1>Planned Features:</h1></summary>

- # Chart Editor
	- ## Modchart Editor 
		Make and test a modchart, right from the chart editor!

		[TODO: This should contain instructions and previews of the editor.]
	
	- ## Specialty Notes - Typed Notes
		If you've used Notetypes in other engines, this is just that.
	
	- ## Specialty Notes - Ghost Tap Note
		> [!NOTE]
		> Ghost Tapping MUST be enabled for this note to function

		| Player  | Opponent/Botplay |
		| ------ | -------- |
		| Is immediately destroyed when spawned. | Simulates pressing a note key with no notes present. |

	- ## Specialty Notes - Force Miss Note
		| Player (Ghost Tapping Disabled) | Opponent/Botplay |
		| ------ | -------- |
		| Makes the player take a miss. | Simulates a player missing a note.

	- ## HUD Defines - Extra Icons
		You can define extra health icons to add to the ui, whether it should follow the player/opponent's icon or the exact position the icon should be at.

	- ## HUD Defines - Force HUD Style
		Sets the HUD to specific behaviour defined in `assets/data/hudStyles/<hud_name>.hud` [1]

		Available default styles:

		- `Char Engine/Default`

		- `Funkin'`

		- `Psych Like`

		- `VS Char`


	# Notes:

	[1]: `.hud` is just a json file, you can define custom hud elements behaviour by following <s> <a href="docs/customHudBehaviour.md"> this guide </s> Guide not made yet.</a>
</details>