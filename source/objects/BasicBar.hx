package objects;

import flixel.ui.FlxBar;

class FloatRange {
    public var min(default, set):Float = 0;
    public var max(default, set):Float = 2;
    public var onChange:(Float, Bool)->Float = null;
    public function new(min:Float, max:Float)
    {
        this.min = min;
        this.max = max;
    }

    public function newValue(min:Float, max:Float, ?minChange:Bool = false):Float
    {
        var newValue:Float = min;
        this.min = min;
        this.max = max;
        if (!minChange) newValue = max;

        return onChange(newValue, minChange);
    }

    public inline function set(min:Float = 0, max:Float = 0)
    {
        this.min = min;
        this.max = max;
    }

    function set_min(value:Float):Float return newValue(value, max, true);
    function set_max(value:Float):Float return newValue(min, value);
}

class BasicBar extends FlxSpriteGroup
{
    public var baseBar:FlxBar; // expose the healthbar for external stuff.
    public var barBG:FlxSprite;
    public var tracker:Float = 0;
    public var percent(get, null):Float;
    var percentFunc:Void->Float = null;
    public var range:FloatRange = new FloatRange(0, 2);
    var barDirection:FlxBarFillDirection = RIGHT_TO_LEFT;
    public var maxBarRatio(default, set):FlxPoint = new FlxPoint(1, 1); // Basically change this to affect the size of the bar compared to the image
    public var lastColor = {
        empty: 0xFFFF0000,
        fill: 0xFF00FF00
    };

    public function new(x:Float = 0, y:Float = 0, image:String = 'healthbar', direction:FlxBarFillDirection = RIGHT_TO_LEFT, healthFunc:Void->Float = null, min:Float = 0, max:Float = 2)
    {
        super(x, y);
        range.set(min, max);
        range.onChange = (v, minChange)->{
            var min = minChange ? v : min;
            var max = minChange ? max : v;
            baseBar.setRange(min, max);

            return v;
        }
        this.barDirection = direction;
        percentFunc = healthFunc;

        barBG = new FlxSprite().loadGraphic(Paths.image(image));
        barBG.antialiasing = ClientPrefs.data.antialiasing;

        baseBar = new FlxBar(barBG.x + 4, barBG.y + 4, direction, Std.int(barBG.width - (8 * maxBarRatio.x)), Std.int(barBG.height - (8 * maxBarRatio.y)), this, 'tracker', min, max);
        baseBar.createFilledBar(0xFFFF0000, 0xFF00FF00);

        if (ClientPrefs.data.classicHBLayering) add(barBG);
        add(baseBar);
        if (!ClientPrefs.data.classicHBLayering) add(barBG);
    }

    function set_maxBarRatio(ratio:FlxPoint):FlxPoint
    {
        baseBar.destroy();
        baseBar = new FlxBar(barBG.x + 4, barBG.y + 4, barDirection, Std.int(barBG.width - (8 * maxBarRatio.x)), Std.int(barBG.height - (8 * maxBarRatio.y)), this, 'tracker', range.min, range.max);
        baseBar.createFilledBar(lastColor.empty, lastColor.fill);
        return maxBarRatio = ratio;
    }

    function get_percent():Float return tracker;

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (percentFunc != null) tracker = percentFunc();
    }

    public function changeColor(empty:FlxColor, fill:FlxColor)
    {
        baseBar.createFilledBar(empty, fill);
        lastColor = {empty: empty, fill: fill};
        baseBar.updateBar();
    }
}