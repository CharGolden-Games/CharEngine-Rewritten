package objects;

class Checkbox extends FlxSprite
{
    public var sprTracker:FlxSprite;
    public var value(default, set):Bool;
    public var copyAlpha:Bool = true;
    public var offsetX:Float = 0;
    public var offsetY:Float = 0;
    public function new(x:Float = 0, y:Float = 0, ?checked:Bool = false)
    {
        super(x, y);

        frames = Paths.getSparrowAtlas("checkboxThingie");

        animation.addByPrefix("unchecked", "Check Box unselected0");
        animation.addByPrefix("checked", "Check Box Selected Static0");
        animation.addByPrefix("checking", "Check Box selecting animation0", 24, false);
        animation.addByIndices("unchecking", "Check Box selecting animation0", [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0], "", 24, false);

        antialiasing = ClientPrefs.data.antialiasing;
        animationFinished(checked ? 'checking' : 'unchecking');
        animation.finishCallback = animationFinished;
        value = checked;
    }

	override function update(elapsed:Float) {
		if (sprTracker != null) {
			setPosition(sprTracker.x - 130 + offsetX, sprTracker.y + 30 + offsetY);
			if(copyAlpha) {
				alpha = sprTracker.alpha;
			}
		}
		super.update(elapsed);
	}

	private function set_value(check:Bool):Bool {
		if(check) {
			if(animation.curAnim.name != 'checked' && animation.curAnim.name != 'checking') {
				animation.play('checking', true);
				offset.set(17, 70);
			}
		} else if(animation.curAnim.name != 'unchecked' && animation.curAnim.name != 'unchecking') {
			animation.play("unchecking", true);
			offset.set(17, 70);
		}
		return check;
	}

	private function animationFinished(name:String)
	{
		switch(name)
		{
			case 'checking':
				animation.play('checked', true);
				offset.set(17, 70);

			case 'unchecking':
				animation.play('unchecked', true);
				offset.set();
		}
	}
}