package objects;

typedef TopButtonOption = {
    var label:String;
}

class TopButton extends FlxSprite{
    var onClick:Void->Void;
    var label:FlxText;

    public function new(name:TopButtonOption, x:Float, y:Float){
        super(x, y);
        label = new FlxText(x, y, 0, TopButtonOption.label);
    }

    public override function update(elapsed:Float){
        if (FlxG.mouse.justPressed){
            if (onClick != null)
                onClick();
        }
    }
}