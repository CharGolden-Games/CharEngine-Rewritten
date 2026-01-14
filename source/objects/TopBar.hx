package objects;

import objects.TopButton;
import objects.TopButton.TopButtonOption;

class TopBar extends FlxSpriteGroup{
    var barSprite:FlxSprite;
    
    public function new(?options:Array<TopButtonOption>) {
        super();
        barSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, 25, 0xff9a3cc0);
        add(barSprite);

        var x:Int = 0;
        for (option in options){
            var finalOptions:TopButtonOption = {label: option.label};
            var button = new TopButton(finalOptions, barSprite.x+x, 0);
            add(button);
            x+=Std.int(button.width);
        }
    }
}