package ui;

class PlaceholderSubState extends MusicBeatSubstate
{
    public override function create() {
        super.create();

        this.camera = FlxG.cameras.list[FlxG.cameras.list.length - 1];

        var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
        bg.alpha = 0.6;
        add(bg);

        var text:FlxText = new FlxText(0, 0, FlxG.width, "THIS IS A PLACEHOLDER STATE.,");
        text.setFormat(Paths.font("vcr.ttf"), 50, 0xFFFFFFFF, CENTER, OUTLINE, 0xFF000000);
        text.borderSize = 3;
        text.screenCenter(Y);
        add(text);
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.BACK) close();
    }
}