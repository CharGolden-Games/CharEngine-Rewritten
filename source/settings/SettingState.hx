package settings;

import flixel.FlxSprite;
import backend.SettingData;
import flixel.group.FlxGroup.FlxTypedGroup;
import objects.tabs.TabBar;
import objects.tabs.TabButton.TabButtonOption;

class SettingState extends MusicBeatState
{
    var options:Array<String> = ["Controls", "Visuals and UI", "Engine Settings", "Gameplay" #if ALLOW_DEBUGOPTIONS , "Debug Settings" #end];
    var curSelected:Int = 0;
    var grpOptions:FlxTypedGroup<FlxText>;
    var bg:FlxSprite;

    var topMenu:Array<TabButtonOption> = [];
    var top:TabBar;

    public override function create() {
        super.create();

        FlxG.mouse.visible = true;

        FlxG.sound.playMusic(Paths.music("shop", "shared"));
        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.menuBG("blue"));
        bg.scrollFactor.set();
        bg.screenCenter();
        add(bg);

        var funnyBG:FlxSprite = new FlxSprite(30, 55).makeGraphic(FlxG.width - 60, FlxG.height - 100, 0x819B3CC0);
        add(funnyBG);

        grpOptions = new FlxTypedGroup<FlxText>();
        add(grpOptions);

        for (i in 0...options.length)
        {
            topMenu.push({label: options[i]});
        }

        top = new TabBar(topMenu, 20, 10);
        add(top);

        changeSelection();
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);

        if (controls.UI_DOWN_P)
        {
            changeSetting(1);
        }
        if (controls.UI_UP_P)
        {
            changeSetting(-1);
        }

        if (controls.UI_RIGHT_P)
        {
            changeSelection(1);
        }
        if (controls.UI_LEFT_P)
        {
            changeSelection(-1);
        }
        if (controls.ACCEPT)
        {
            /* goToPage(); */ // old shi-
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
        top.changeIndex(change);

        loadSettings();
    }

    function loadSettings()
    {
        curSelected = 0;
        grpOptions.forEachExists((_)->{_.destroy();});
        grpOptions.clear();

        var optionShit:Array<SettingData> = [];
        switch (options[top.index].toLowerCase())
        {
            case "controls": optionShit = SettingTabs.controls;
            case "debug settings": optionShit = SettingTabs.debug;
            default: optionShit = SettingTabs._default;
        }
        for (i in 0...optionShit.length)
        {
            var sd = optionShit[i];
            var text:FlxText = new FlxText(30, 100 * (i + 1), FlxG.width, sd.name, 30);
            text.scrollFactor.set();
            var defaultValue:Dynamic;
            if (sd.type != key)
                defaultValue = Reflect.field(ClientPrefs.data, sd.variable);
            else
                defaultValue = ClientPrefs.keyBinds[sd.variable];
            switch (sd.type)
            {
                case header:
                    if (options[top.index].toLowerCase() == "debug settings")
                    {
                        text.text = '${sd.name} >';
                    }
                case bool:
                    text.text = "[";
                    if (defaultValue == true) text.text += " X ";
                    text.text += "] " + sd.name;
                case value | string:
                    text.text = '${sd.name}: $defaultValue';
                case key:
                    text.text = '${sd.name}: ${SettingTabs.keyToString(defaultValue)}';
            }
            text.ID = i;
            grpOptions.add(text);
        }
        changeSetting();
    }

    function changeSetting(change:Int = 0)
    {
        FlxG.sound.play(Paths.sound("scrollMenu"));
        curSelected += change;
        if (curSelected < 0)
            curSelected = grpOptions.length - 1;
        if (curSelected > grpOptions.length - 1)
            curSelected = 0;

        grpOptions.forEachExists((text)->{
            if (text.ID == curSelected)
                text.alpha = 1;
            else
                text.alpha = 0.6;
        });
    }

    public override function switchTo(nextState:FlxState):Bool {
        FlxG.mouse.visible = false;
        return super.switchTo(nextState);
    }
}

class SettingTabs
{
    public static final _default:Array<SettingData> = [
        {
            name: "NO SETTINGS DEFINED??",
            variable: "placeholder",
            type: header,
            defaultValue: null
        }
    ];

    public static final controls:Array<SettingData> = [
        {
            name: "UI LEFT",
            variable: "ui_left",
            type: key,
            defaultValue: ClientPrefs.keyBinds["ui_left"]
        }
    ];

    public static final debug:Array<SettingData> = [
        {
            name: "Chart Editor",
            variable: "placeholder",
            type: header,
            defaultValue: null
        },
        {
            name: "Character Editor",
            variable: "placeholder",
            type: header,
            defaultValue: null
        },
        {
            name: "Modchart Editor",
            variable: "placeholder",
            type: header,
            defaultValue: null
        },
        {
            name: "Stage Editor",
            variable: "placeholder",
            type: header,
            defaultValue: null
        },
        {
            name: "Notetype Editor",
            variable: "placeholder",
            type: header,
            defaultValue: null
        }
    ];

    public static function keyToString(keys:Array<FlxKey>)
    {
        var a:Array<String> = [];
        for (key in keys)
        {
            a.push(key.toString());
        }
        return a;
    }
}