package ui.credits;

import objects.Credit;
import sys.io.File;
import haxe.Json;

typedef CreditFile = {
    var name:String;
    @:optional var icon:String;
    var color:String;
    var desc:String;
    var credits:Array<CreditStruc>;
}

typedef CreditStruc = {
    var name:String;
    @:optional var icon:String;
    @:optional var desc:String;
    @:optional var color:String;
    @:optional var link:String;
}

class ModCreditsState extends BaseCreditsSubState
{
    public function new(?file:String = 'credits')
    {
        super();
        loadCredits(file);
    }

    function loadCredits(file:String)
    {
        var rawJson:String = File.getContent(Paths.json('credits/$file'));

        var file:CreditFile = cast Json.parse(rawJson);

        title = file.name;
        for (credit in file.credits)
        {
            addCredit(credit.name, credit.icon, FlxColor.fromString(credit.color), credit.link, credit.desc);
        }
    }
}