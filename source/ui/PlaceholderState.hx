package ui;

class PlaceholderState extends MusicBeatState
{
    public static var lastState:FlxState;

    public override function create() {
        super.create();

        var text:FlxText = new FlxText(0, 0, FlxG.width, "THIS IS A PLACEHOLDER STATE.,");
        text.setFormat(Paths.font("vcr.ttf"), 50, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
        text.borderSize = 3;
        text.screenCenter(Y);
        add(text);
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.BACK)
        {
            if (lastState == null)
            {
                FlxG.switchState(new MainMenuState());
            }
            else
            {
                var lState = lastState;
                lastState = null;
                FlxG.switchState(Type.createEmptyInstance(Type.getClass(lState)));
            }
        }
    }
}