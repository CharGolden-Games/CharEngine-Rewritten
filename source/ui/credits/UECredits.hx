package ui.credits;

import objects.Credit;
import settings.BaseSettingsState;

class UECredits extends BaseCreditsState
{
    public function new()
    {
        super(true);
        
        title = "Universe Engine Credits";

        addCredit("Universe Engine Devs");

        addCredit("VideoBotYT", "videobot", 0xFF14FFFF, 'https://linktr.ee/videobot', "First Dev and Engine Owner");
        addCredit("CharGoldenYT", "char", 0xFFFF8800, "https://bsky.app/profile/vschar-official.com", "Second dev - Rewrote the engine from base");

        addCredit("Universe Engine Former Devs");

        addCredit("Daveberry", "dave", 0xFF008BFF, 'https://daveberry.netlify.app/', 'Former DEV, (No Longer) In charge of the LUA, HX files and other',);
        addCredit("BaranMuzu", "baranmuzu", 0xFFBE9877, 'https://linktr.ee/baranmuzu', 'Former DEV, (No Longer) In charge of the LUA files and other');

        addCredit("Special Thanks");

        addCredit("An Ammar", "Ammar", 0xFF00FF00, "https://gamebanana.com/mods/381804", "Hype Mode, Detached Health Bar, Playtester (Pre 1.0)");
        addCredit("Dinus Game", "Dinus Game", 0xFF27FF27, "https://gamebanana.com/members/2053946", "freakyMenu Universe Engine music.");
        addCredit("ShadowMario", "shadowmario", 0xFF444444, 'https://twitter.com/Shadow_Mario_', "Some code borrowed from Psych");
    }

    override function exit() {
        super.exit();

        FlxG.switchState(new CreditSelectorState());
    }

    override function selectThing(credit:Credit) {
        super.selectThing(credit);

        if (grpCredits.curMember.hasLink) FlxG.openURL(grpCredits.curMember.link);
    }
}