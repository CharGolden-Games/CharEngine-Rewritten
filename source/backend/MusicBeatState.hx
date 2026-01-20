package backend;

import ui.debug.ShortcutMenu;
import flixel.FlxState;
import backend.Conductor.BPMChangeEvent;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;

class MusicBeatState extends FlxUIState
{
	private var curStep:Int = 0;
	private var curBeat:Int = 0;
	private var controls(get, never):Controls;

	var disableTabMenu:Bool = #if DEBUGMENUS false #else true #end;

	inline function get_controls():Controls
		return Controls.instance;

	override function create()
	{
		super.create();
	}

	var hadPersistence:Bool = false;
	override function update(elapsed:Float)
	{
		// everyStep();
		var oldStep:Int = curStep;

		updateCurStep();
		updateBeat();

		if (oldStep != curStep && curStep >= 0)
			stepHit();

		if (FlxG.keys.justPressed.TAB)
		{
			if (!disableTabMenu)
			{
				hadPersistence = persistentUpdate;
				if (persistentUpdate) persistentUpdate = false;
				openSubState(new ShortcutMenu(this));
			}
		}

		super.update(elapsed);
	}
	
	public function closeShortcutMenu()
	{
		persistentUpdate = hadPersistence;
	}

	private function updateBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
	}

	private function updateCurStep():Void
	{
		var lastChange:BPMChangeEvent = {
			stepTime: 0,
			songTime: 0,
			bpm: 0
		}
		for (i in 0...Conductor.bpmChangeMap.length)
		{
			if (Conductor.songPosition >= Conductor.bpmChangeMap[i].songTime)
				lastChange = Conductor.bpmChangeMap[i];
		}

		curStep = lastChange.stepTime + Math.floor((Conductor.songPosition - lastChange.songTime) / Conductor.stepCrochet);
	}

	public function stepHit():Void
	{
		if (curStep % 4 == 0)
			beatHit();
	}

	public function beatHit():Void
	{
		// do literally nothing dumbass
	}

	public function switchState(s:FlxState)
	{
		FlxG.switchState(s);
	}
}
