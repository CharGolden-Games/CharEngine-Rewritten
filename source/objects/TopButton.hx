package objects;

typedef TopButtonOption = {
    var label:String;
    @:optional var onClick:Void->Void;
}

class TopButton extends FlxTypedSpriteGroup<FlxSprite>{
    var onClick:Null<Void->Void>;
    var label:FlxText;

    public function new(options:TopButtonOption, x:Float, y:Float){
        super(x, y);
        label = new FlxText(x, y, 0, options.label);
        add(label);

        onClick = options.onClick;
    }

    public override function update(elapsed:Float){
        super.update(elapsed);

        if (FlxG.mouse.justPressed){
            if (onClick != null)
                onClick();
        }
    }
}