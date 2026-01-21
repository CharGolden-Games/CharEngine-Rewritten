package settings;

class VisualUISettingsState extends BaseSettingsState
{
    public function new()
    {
        title = "Visuals and UI Settings";
        vars = [
            {name: "Downscroll", desc: "If enabled, puts the notes on the bottom of the screen.", variable: "downscroll", type: bool, defaultValue: false},
            {name: "Flashing Lights", desc: "If you're sensitive to this kinda thing, you should have this off.", variable: "flashing", type: bool, defaultValue: true},
            {name: "Allow Camera Bop", desc: "Whether to allow the camera to bop to the beat or not.", variable: "allowCamZoom", type: bool, defaultValue: true},
            {name: "Sing When Ghost Tapping", desc: "[GHOST TAPPING MUST BE ON] Whether the player character should play the sing animation when a direction is hit and there are no notes present.", variable: "playAnimOnGhostTap", type: bool, defaultValue: true},
            {name: "Play Inst In Freeplay", desc: "Whether the inst to a song should play when selected.", variable: "previewInst", type: bool, defaultValue: true},
            {name: "Antialiasing", desc: "Smoothes out the visuals lmao.", variable: "antialiasing", type: bool, defaultValue: true},
            {name: "UI Style", desc: "What the HUD should look like", variable: "uiStyle", type: string, defaultValue: "Char Engine", options: ["Char Engine", "Original"]},
            {name: "Disable Credits Bounce", desc: "Disables the bounce when selecting a credit in credits", type: bool, variable: "disableCreditBounce", defaultValue: false}
        ];
        super();
    }
}