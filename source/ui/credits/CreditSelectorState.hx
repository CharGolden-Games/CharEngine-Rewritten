package ui.credits;

import ui.credits.ModCreditsState.CreditFile;
import haxe.Json;
import objects.Credit;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

class CreditSelectorState extends BaseCreditsState
{
    var files:Array<String> = [];
    public function new()
    {
        super();

        title = "Engine Credits";

        addCredit("Universe Engine Team", "ue", 0xFF8888FF, null, "See who helped with the engine!");
        addCredit("Funkin' Crew", "funkin", 0xFFFF8888, null, "The team behind the original kick-ass game!");

        files.push("ue");
        files.push("funkin");

        loadCreditFiles();
    }



    public override function selectThing(credit:Credit) {
        super.selectThing(credit);

        switch (credit.text)
        {
            case "Universe Engine Team":
                openSubState(new UECredits());
            case "Funkin' Crew":
                openSubState(new FunkinCredits());
            default:
                openSubState(new ModCreditsState(files[grpCredits.index]));
        }
    }

    function loadCreditFiles()
    {
        #if sys
        for (file in FileSystem.readDirectory("assets/data/credits"))
        {
            var fileName:String = file.replace(".json", "");
            var rawJson = File.getContent(Paths.json('credits/$fileName'));

            var json:CreditFile = cast Json.parse(rawJson);

            addCredit(json.name, json.icon, FlxColor.fromString(json.color), null, json.desc);
            files.push(fileName);
        }
        #end
    }
}