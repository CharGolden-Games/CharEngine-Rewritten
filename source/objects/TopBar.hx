package objects;

import objects.TopButton;
import objects.TopButton.TopButtonOption;

class TopBar extends FlxSpriteGroup{
    var options:Array<TopButton> = [];
    var barSprite:FlxSprite;
    
    public function new(?options:Array<TopButtonOption>) {
        this.options = options;
        super();
        barSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, 25, 0xff9a3cc0);
        add(barSprite);

        var x:Int = 0;
        for (button in options){
            button = new TopButton(options.label, barSprite.x+x, 0);
            add(button);
            x+=Std.int(button.width);
        }
    }
}