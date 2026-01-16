package settings;

import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.group.FlxGroup.FlxTypedGroup;
import objects.TopBar;
import objects.TopButton.TopButtonOption;

class SettingState extends MusicBeatState
{
    var options:Array<String> = ["Controls", "Visuals and UI", "Engine Settings", "Gameplay" #if ALLOW_DEBUGOPTIONS , "Debug Settings" #end];
    var curSelected:Int = 0;
    var grpOptions:FlxTypedGroup<Alphabet>;
    var bg:FlxSprite;

    var topMenu:Array<TopButtonOption> = [];

    function goToPage()
    {
        switch(options[curSelected].toLowerCase())
        {
            case 'debug settings':
                openSubState(new DebugSettingsState());
            case "visuals and ui":
                openSubState(new PlaceholderSubState());
            case "engine settings":
                openSubState(new PlaceholderSubState());
            case "gameplay":
                openSubState(new PlaceholderSubState());
            case 'controls':
                openSubState(new InputState());
        }
    }
    
    var top:TopBar;

    public override function create() {
        super.create();

        FlxG.sound.playMusic(Paths.music("shop", "shared"));
        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.menuBG("blue"));
        bg.scrollFactor.set();
        bg.screenCenter();
        add(bg);

        grpOptions = new FlxTypedGroup<Alphabet>();
        add(grpOptions);

        for (i in 0...options.length)
        {
            var preOffset:Int = 0;
            var postOffset:Int = 0;

            if (options.length <= 3)
            {
                postOffset = 100;
                preOffset = 50;
            }
            else if (options.length <= 4)
            {
                postOffset = 50;
                preOffset = 100;
            }
            else if (options.length <= 6)
            {
                postOffset = 25;
                preOffset = 50;
            }

            var text:Alphabet = new Alphabet(0, ((100 + postOffset) * i) + preOffset, options[i], true);
            text.ID = i;
            text.screenCenter(X);
            grpOptions.add(text);

            topMenu.push({label: options[i]});
        }

        top = new TopBar(topMenu, 20, 10);
        add(top);

        changeSelection();
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.UI_DOWN_P)
        {
            changeSelection(1);
        }
        if (controls.UI_UP_P)
        {
            changeSelection(-1);
        }
        if (controls.ACCEPT)
        {
            goToPage();
        }
        if (controls.BACK)
        {
            switchState(new MainMenuState());
            FlxG.sound.playMusic(Paths.music("freakyMenu",));
        }
    }

    function changeSelection(change:Int = 0)
    {
        FlxG.sound.play(Paths.sound("scrollMenu"));

        curSelected += change;
        if (curSelected > options.length - 1)
            curSelected = 0;
        if (curSelected < 0)
            curSelected = options.length - 1;

        top.changeIndex(change);

        grpOptions.forEachAlive((member)->{
            if (member.ID == curSelected)
            {
                member.alpha = 1;
            }
            else
            {
                member.alpha = 0.6;
            }
        });
    }

    public override function closeSubState() {
        super.closeSubState();
        ClientPrefs.savePrefs();
    }
}