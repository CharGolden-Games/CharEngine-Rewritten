package charengine.settings;

import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.group.FlxGroup.FlxTypedGroup;

class SettingState extends MusicBeatState
{
    var options:Array<String> = ["controls", "visuals and ui", "engine settings"];
    var curSelected:Int = 0;
    var grpOptions:FlxTypedGroup<Alphabet>;
    var bg:FlxSprite;

    var camBG:FlxCamera;
    var camOptions:FlxCamera;

    public override function create() {
        super.create();


    }
}