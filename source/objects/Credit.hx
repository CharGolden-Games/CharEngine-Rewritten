package objects;

class Credit extends FlxTypedSpriteGroup<FlxSprite>
{
    var alphabet:Alphabet;
    public var icon:FlxSprite;

    @:isVar public var text(default, set):String;
    public var desc:Null<String>;
    public var link:Null<String>;
    public var intendedColor:Null<FlxColor>;

    public var selectable(get, never):Bool;
    public var hasLink(get, never):Bool;
    public var hasDesc(get, never):Bool;

    function get_hasLink():Bool return link != null;

    function get_hasDesc():Bool return desc != null;

    // Whether you can select this credit, if it has at least a link or at least a desc, it will be selectable.
    function get_selectable():Bool return (get_hasDesc() || get_hasLink());

    function set_text(text:String):String
    {
        this.text = text;
        alphabet.text = text;

        return text;
    }

    public function new(X:Float = 0, Y:Float = 0, name:String, ?icon:String, ?color:FlxColor, ?link:String, ?desc:String)
    {
        super(X, Y);
        
        this.desc = desc;
        this.link = link;
        intendedColor = color;

        alphabet = new Alphabet(0, 0, "");
        this.text = name;
        add(alphabet);

        if (icon != null)
        {
            alphabet.x += 200;
            alphabet.snapToPosition();

            this.icon = new FlxSprite().loadGraphic(Paths.image('credits/$icon'));
            add(this.icon);
        }
    }
}

class CreditGroup extends FlxTypedGroup<Credit>
{
    public var index(default, null):Int = 0;
    public var curMember(get, never):Credit;
    public var follow:FlxPoint;

    function get_curMember():Credit return members[index];

    public function new()
    {
        super();
        follow = new FlxPoint(FlxG.width / 2);
    }
    
    public function newCredit(name:String, ?icon:String, ?color:FlxColor, ?link:String, ?desc:String)
    {
        var credit:Credit = new Credit(20, 200 * length, name, icon, color, link, desc);
        credit.alpha = 0.6;
        credit.ID = length;
        credit.screenCenter(X);
        add(credit);
    }

    public function newCreditFromType(credit:CreditType)
    {
        var credit:Credit = new Credit(20, 200 * length, credit.name, credit.icon, credit.color, credit.link, credit.desc);
        credit.alpha = 0.6;
        credit.ID = length;
        credit.screenCenter(X);
        add(credit);
    }

    var camTween:FlxTween;
    public function changeIndex(change:Int = 0)
    {
        index += change;
        if (index > length-1)
            index = 0;
        if (index < 0)
            index = length-1;

        follow.y = curMember.y;

        forEachExists(function (member) {
            if (member.ID == index)
                member.alpha = 1;
            else
                member.alpha = 0.6;
        });

        if (!curMember.selectable)
        {
            if (change == 0) change = 1; // Failsafe.
            changeIndex(change);
        }
    }
}

typedef CreditType = {
    var name:String;
    @:optional var icon:String;
    @:optional var desc:String;
    @:optional var color:FlxColor;
    @:optional var link:String;
}