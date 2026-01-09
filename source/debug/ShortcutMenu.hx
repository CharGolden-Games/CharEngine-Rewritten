package debug;

private typedef Option = {
    var name:String;
    var options:Array<String>;
}

class ShortcutMenu extends MusicBeatSubstate
{
    var bg:FlxSprite;

    var menuOptions:Array<Option> = [
        {
            name: "Menus",
            options: [
                "Main Menu",
                "Freeplay",
                "Mods"
            ]
        },
        {
            name: "Options",
            options: [
                "Input Settings",
                "Visuals and UI",
                "Gameplay",
                "Note Settings"
            ]
        }
    ];
    var subOptions:Array<String> = [];
    var grpOptions:FlxTypedGroup<Alphabet>;
    var curSelected:Int = 0;

    var camMenu:FlxCamera;
    var camFollow:FlxObject;
    var instance:Null<MusicBeatState>;

    public function new(?instance:MusicBeatState) // base setup
    {
        super();

        this.instance = instance;
        grpOptions = new FlxTypedGroup<Alphabet>();

        camMenu = new FlxCamera();
        camMenu.bgColor.alpha = 0;
        FlxG.cameras.add(camMenu, false);
        camFollow = new FlxObject();
        camFollow.screenCenter(X);
        add(camFollow);

        this.cameras = [camMenu];
    }

    public override function create() {
        super.create();

        bg = new FlxSprite().loadGraphic(Paths.menuBG());
        bg.alpha = 0.4;
        bg.color = 0xFF484848;
        bg.scrollFactor.set();
        add(bg);

        add(grpOptions);

        if (menuOptions.length == 0) // fallback.
        {
            menuOptions = [{name: "NO MENUS??", options: ["NO MENUS??"]}];
        }
        for (i in 0...menuOptions.length)
        {
            var option:String = menuOptions[i].name;
            var text:Alphabet = new Alphabet(20, 100 * i, option);
            text.screenCenter(X);
            text.ID = i;
            text.snapToPosition();
            grpOptions.add(text);
        }

        changeSelection();
    }

    var inSubMenu:Bool = false;
    public override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.UI_DOWN_P)
        {
            FlxG.sound.play(Paths.sound("scrollMenu"));
            changeSelection(1);
        }
        if (controls.UI_UP_P)
        {
            FlxG.sound.play(Paths.sound("scrollMenu"));
            changeSelection(-1);
        }

        if (controls.ACCEPT)
        {
            if (!inSubMenu)
            {
                inSubMenu = true;
                changeTabs();
            }
            else
            {
                goTo();
            }
        }

        if (controls.BACK)
        {
            if (inSubMenu)
            {
                inSubMenu = false;
                changeTabs();
            }
            else
            {
                close();
            }
        }
    }

    public override function close() {
        super.close();

        instance.closeShortcutMenu();
    }

    function goTo()
    {
        switch (subOptions[curSelected])
        {
            case _: trace("That state is not tied to anything yet!");
        }
    }

    var camTween:FlxTween;
    function changeSelection(change:Int = 0)
    {
        if (!inSubMenu)
        {
            curSelected += change;
            if (curSelected > menuOptions.length-1)
                curSelected = 0;
            if (curSelected < 0)
                curSelected = menuOptions.length-1;
        }
        else
        {
            curSelected += change;
            if (curSelected > subOptions.length-1)
                curSelected = 0;
            if (curSelected < 0)
                curSelected = subOptions.length-1;
        }

        grpOptions.forEachExists(function(text){
            if (text.ID == curSelected)
            {
                text.alpha = 1;
                camFollow.y = text.y + -200; // y with an offset.
            }
            else
            {
                text.alpha = 0.6;
            }
        });

        if (camTween != null) camTween.cancel();
        camTween = FlxTween.tween(camMenu.scroll, {y: camFollow.y}, 0.5, {ease: FlxEase.quartOut});
    }

    public function changeTabs()
    {
        var lastOption:Option = null;
        if (inSubMenu) lastOption = menuOptions[curSelected];
        curSelected = 0;
        grpOptions.forEachExists(function(text){
            text.destroy();
        });
        grpOptions.clear();

        if (inSubMenu)
        {
            subOptions = lastOption.options;
            for (i in 0...lastOption.options.length)
            {
                var option = lastOption.options[i];
                var text:Alphabet = new Alphabet(20, 100 * i, option);
                text.screenCenter(X);
                text.ID = i;
                text.snapToPosition();
                grpOptions.add(text);
            }
        }
        else
        {
            for (i in 0...menuOptions.length)
            {
                var option:String = menuOptions[i].name;
                var text:Alphabet = new Alphabet(20, 100 * i, option);
                text.screenCenter(X);
                text.ID = i;
                text.snapToPosition();
                grpOptions.add(text);
            }
        }
        changeSelection();
    }

    public override function destroy() // cleanup
    {
        super.destroy();

        FlxG.cameras.remove(camMenu);
    }
}