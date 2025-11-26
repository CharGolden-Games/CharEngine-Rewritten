package settings;

import flixel.text.FlxText;

class InputState extends MusicBeatSubstate
{
    public override function create() {
        super.create();

        var text:FlxText = new FlxText(0, 0, FlxG.width, "NOTHIN' HERE YET!");
        text.setFormat(Paths.font("VCR OSD Mono"), 40, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
        text.borderSize = 3;
        add(text);
        text.screenCenter(Y);
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.BACK) close();
    }
}