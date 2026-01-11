package ui.credits;

import objects.Credit;
import settings.BaseSettingsState;

class UECredits extends BaseCreditsState
{
    public function new()
    {
        super(true);
        addCredit("Universe Engine Devs");

        addCredit("VideoBotYT", "videobot", 0xFF14FFFF, 'https://linktr.ee/videobot', "First Dev and Engine Owner");
        addCredit("CharGoldenYT", "char", 0xFFFF8800, "https://bsky.app/profile/vschar-official.com", "Second dev - Rewrote the engine from base");

        addCredit("Universe Engine Former Devs");

        addCredit("Daveberry", "dave", 0xFF008BFF, 'https://daveberry.netlify.app/', 'Former DEV, (No Longer) In charge of the LUA, HX files and other',);
        addCredit("BaranMuzu", "baranmuzu", 0xFFBE9877, 'https://linktr.ee/baranmuzu', 'Former DEV, (No Longer) In charge of the LUA files and other');
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