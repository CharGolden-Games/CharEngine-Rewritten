package settings;

import objects.Option;
import backend.SettingData;

/**
 * This contains EVERY option excluding input options.
 */
class DebugSettingsState extends BaseSettingsState
{
    public function new()
    {
        title = "Debug Settings";
        vars = [
            {name: "Downscroll", desc: "If enabled, puts the notes on the bottom of the screen.", variable: "downscroll", type: bool, defaultValue: false},
            {name: "Naughtyness", desc: "Whether to censor bad language. (Might not do anything currently)", variable: "naughtyness", type: bool, defaultValue: true},
            {name: "Flashing Lights", desc: "If you're sensitive to this kinda thing, you should have this off.", variable: "flashing", type: bool, defaultValue: true},
            {name: "Allow Camera Bop", desc: "Whether to allow the camera to bop to the beat or not.", variable: "allowCamZoom", type: bool, defaultValue: true},
            {name: "Check For Updates", desc: "Whether the engine should check for new versions on launch.", variable: "update", type: bool, defaultValue: true},
            {name: "Ghost Tapping", desc: "Press the notes whenever you want if enabled!", variable: "ghostTapping", type: bool, defaultValue: true},
            {name: "Sing When Ghost Tapping", desc: "[GHOST TAPPING MUST BE ON] Whether the player character should play the sing animation when a direction is hit and there are no notes present.", variable: "playAnimOnGhostTap", type: bool, defaultValue: true},
            {name: "Play Inst In Freeplay", desc: "Whether the inst to a song should play when selected.", variable: "playInstInFreeplay", type: bool, defaultValue: true},
            {name: "Antialiasing", desc: "Smoothes out the visuals lmao.", variable: "antialiasing", type: bool, defaultValue: true},
            {name: "Prefer Hardcoded Characters", desc: "Whether you prefer to use characters included in the source over modded ones. (CAN BREAK MODS.)", variable: "preferHardcodedChars", type: bool, defaultValue: true}
        ];

        watermark = "THIS PAGE MAY CONTAIN EXPERIMENTAL SETTINGS ANY SETTING WITH AN ASTERISK VOIDS YOUR SCORE!";

        super();
    }
}