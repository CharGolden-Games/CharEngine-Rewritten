package ui.credits;

import objects.Credit;

class FunkinCredits extends BaseCreditsSubState
{
    public function new()
    {
        super();
        
        title = "Funkin' Crew";

        addCredit("Funkin' Crew");

        addCredit('ninjamuffin99', 'ninjamuffin99', 0xFFCF2D2D, "https://x.com/ninja_muffin99", "Programmer of Friday Night Funkin'");
        addCredit("PhantomArcade", "phantomarcade", 0xFFFADC45, "https://x.com/PhantomArcade3K", "Animator of Friday Night Funkin'");
        addCredit("evilsk8r", "evilsk8r", 0xFF5ABD4B, "https://x.com/evilsk8r", "Artist of Friday Night Funkin'");
        addCredit("kawaisprite", 'kawaisprite', 0xFF378FC7, "https://x.com/kawaisprite", "Composer of Friday Night Funkin'");
    }
}