package ui.credits;

import objects.Credit;
import objects.Credit.CreditGroup;
import objects.Credit.CreditType;

class BaseCreditsState extends MusicBeatState
{
    var bg:FlxSprite;
    var alphabet:Alphabet;

    var options:Array<CreditType> = [];
    var grpCredits:CreditGroup;
    var camBG:FlxCamera;
    var camCredits:FlxCamera;
    var curSelected(get, never):Int;
    var title:String;

    var descBox:FlxSprite;
    var descText:FlxText;
    var inSubMenu:Bool = false;

    function get_curSelected():Int return grpCredits.index;

    public function new(subMenu:Bool = false)
    {
        super();
        inSubMenu = subMenu;
    }

    public override function create() {
        super.create();

        if (title == null) title = "credits";

        #if ALLOW_DISCORD
        DiscordClient.changePresence(title, null);
        #end

        camBG = new FlxCamera();
        camCredits = new FlxCamera();
        var camDesc = new FlxCamera();
        camCredits.bgColor.alpha = 0;
        camDesc.bgColor.alpha = 0;
        FlxG.cameras.add(camBG);
        FlxG.cameras.add(camCredits, false);
        FlxG.cameras.add(camDesc, false);
        camCredits.zoom = 0.75;

        bg = new FlxSprite().loadGraphic(Paths.menuBG());
        bg.color = 0xFFFD719B;
        bg.antialiasing = ClientPrefs.data.antialiasing;
        add(bg);

        grpCredits = new CreditGroup();
        grpCredits.cameras = [camCredits];
        add(grpCredits);

        descBox = new FlxSprite().makeGraphic(FlxG.width, 10, 0xFF000000);
        descBox.cameras = [camDesc];
        descBox.alpha = 0.8;
        add(descBox);

        alphabet = new Alphabet(0, 0, title);
        alphabet.setScale(0.5, 0.5);
        alphabet.snapToPosition();
        alphabet.cameras = [camDesc];
        add(alphabet);

        descText = new FlxText(0, 50, FlxG.width, "No Desc!", 20);
        descText.cameras = [camDesc];
        descText.alpha = 0.8;
        add(descText);

        for (i in 0...options.length)
        {
            var option = options[i];
            grpCredits.newCreditFromType(option);
        }

        changeSelection();
        snapToPosition();
    }

    function snapToPosition()
    {
        if (camTween != null) camTween.cancel();

        camCredits.scroll.y = grpCredits.follow.y - 200;
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
        bg.color = FlxColor.interpolate(bg.color, grpCredits.curMember.intendedColor, CoolUtil.camLerpShit(0.045));

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
            selectThing(grpCredits.curMember);
        }
        if (controls.BACK)
        {
            exit();
        }
    }

    public function exit()
    {
        if (!inSubMenu) FlxG.switchState(new MainMenuState());
    }

    public function addCredit(name:String, ?icon:String, ?color:FlxColor, ?link:String, ?desc:String):CreditType
    {
        var credit:CreditType = {name: name, icon: icon, color: color, link: link, desc: desc};
        options.push(credit);
        return credit;
    }

    public function selectThing(credit:Credit)
    {
        // define what happens when thing is selected here!
    }

    function updateDesc()
    {
        if (grpCredits.curMember.hasDesc)
        {
            descText.text = 'The people that made this possible!\n' + grpCredits.curMember.desc;
            descBox.setGraphicSize(FlxG.width, Std.int(descText.height + 50));
            descBox.updateHitbox();
            descBox.visible = true;
            descText.visible = true;
        }
        else
        {
            descBox.visible = false;
            descText.visible = false;
        }
    }

    var camTween:FlxTween;
    function changeSelection(change:Int = 0)
    {
        grpCredits.changeIndex(change);

        updateDesc();

        if (camTween != null) camTween.cancel();
        if (!ClientPrefs.data.disableCreditBounce)
            camTween = FlxTween.tween(camCredits.scroll, {y: grpCredits.follow.y - 200}, 1, {ease: FlxEase.bounceOut});
        else
            camTween = FlxTween.tween(camCredits.scroll, {y: grpCredits.follow.y - 200}, 0.5, {ease: FlxEase.quartOut});
    }
}