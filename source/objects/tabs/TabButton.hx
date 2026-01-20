package objects.tabs;

typedef TabButtonOption = {
    var label:String;
    @:optional var onClick:Void->Void;
}

class TabButton extends FlxSpriteGroup
{
    public var onClick:Null<Void->Void>;
    var label:FlxText;
    var bg:FlxSprite;
    public var size = {
        width: 0,
        height: 0
    }

    public function new(options:TabButtonOption, x:Float, y:Float){
        super(x, y);
        label = new FlxText(x + 9, y, 0, options.label, 15);
        
        onClick = options.onClick;
        size.width = Math.ceil(label.width) + 10;
        size.height = Math.ceil(label.height) + 6;

        bg = new FlxSprite(x + 10, y + 4).makeGraphic(size.width, size.height, 0x819B3CC0);
        add(bg);
        add(label);

        add(label);
    }

    public override function update(elapsed:Float){
        super.update(elapsed);

        if (FlxG.mouse.justPressed){
            if (onClick != null)
                onClick();
        }
    }
}