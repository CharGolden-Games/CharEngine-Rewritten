package;

import openfl.Assets;

class Deadfriend extends Boyfriend
{
    public function new(x:Float, y:Float, ?char:String = 'bf')
	{
        if (Assets.exists("assets/characters/" + char + "-dead.json"))
        {
            char += '-dead';
        }

		super(x, y, char);
	}
}