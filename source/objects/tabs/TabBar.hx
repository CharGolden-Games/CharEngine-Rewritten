package objects.tabs;

import objects.tabs.TabButton;
import objects.tabs.TabButton.TabButtonOption;

class TabBar extends FlxTypedSpriteGroup<TabButton>{
    //var barSprite:FlxSprite; // moving the bg to the buttons themselves lmao.
    public var index(default, null):Int = 0;
    var globalOffset:FlxPoint = new FlxPoint();
    var center:Bool = false;
    var trueLength(get, null):Int;

    function get_trueLength():Int
    {
        var l = 0;
        forEachExists((M)->{l++;});

        return l;
    }
    
    public function new(?options:Array<TabButtonOption>, x:Float = 0, y:Float = 0) {
        super();
        globalOffset.set(x, y);
        /* barSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, 25, 0xff9a3cc0);
        add(barSprite);

        var x:Int = 0; // old code
        for (option in options){
            var button = new TopButton({label: option.label}, barSprite.x+x, 0);
            add(button);
            x+=Std.int(button.width);
        } */

        for (i in 0...options.length)
        {
            var option = options[i];
            var button = new TabButton({label: option.label}, 0, globalOffset.y);
            button.onClick = ()->{
                onClick(button, option.onClick);
            }
            button.ID = i;
            add(button);
        }

        updateOffsets();
    }
    
    private function onClick(o:TabButton, ?oc:Void->Void):Void
    {
        index = o.ID;
        if (oc != null) oc();
    }

    public function changeIndex(change:Int = 0)
    {
        index += change;
        if (index > trueLength - 1)
           index = 0;
       if (index < 0)
           index = trueLength - 1;

        forEachExists((button)->{
            if (button.ID == index)
                button.alpha = 1;
            else
                button.alpha = 0.6;
        });
    }

    public function setIndex(i:Int = 0)
    {
        index = i;
        changeIndex();
    }

    function updateOffsets()
    {
        var lastOffset:Float = globalOffset.x;
        var w:Float = 0;

        forEachExists((button)->{
            trace(lastOffset);
            button.x = lastOffset;
            lastOffset+=button.size.width + 5;
            w += button.size.width + 5;
        });
    }
}