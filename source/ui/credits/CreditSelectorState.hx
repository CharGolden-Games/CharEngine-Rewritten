package ui.credits;

import objects.Credit;

class CreditSelectorState extends BaseCreditsState
{
    public function new()
    {
        super();

        addCredit("Universe Engine Team", "ue", 0xFF8888FF, null, "See who helped with the engine!");
        addCredit("Funkin' Crew", "funkin", 0xFFFF8888, null, "The team behind the original kick-ass game!");
    }

    public override function selectThing(credit:Credit) {
        super.selectThing(credit);

        switch (credit.text)
        {
            case "Universe Engine Team":
                FlxG.switchState(new UECredits());
            case "Funkin' Crew":
                FlxG.switchState(new FunkinCredits());
        }
    }
}