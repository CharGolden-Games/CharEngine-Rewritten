package backend;

import flixel.util.FlxSave;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

class SaveVariables
{
	public var downscroll:Bool = false;
	public var naughtyness:Bool = true;
	public var flashing:Bool = true;
	public var allowCamZoom:Bool = true;
	public var update:Bool = true;
	public var ghostTapping:Bool = true;
	public var playAnimOnGhostTap:Bool = true;
	public var previewInst:Bool = true;
	public var antialiasing:Bool = true;
	public var preferHardcodedChars:Bool = false;
	public var bsKillCombo:Bool = false; // Whether bads/shits kill combo.
	public var classicHBLayering:Bool = false; // Whether the Healthbar's background should be behind (Base Funkin') or in front of (Psych/Codename) the actual bar.
	public var uiStyle:String = "Universe Engine";
	public var disableCreditBounce:Bool = false;

	public var placeholder:Bool = false; // DO NOT REMOVE.

	public function new() resetInvalidOptions();

	function resetInvalidOptions() // use this function to reset any options that may have changed since a previous commit/version
	{
		if (FlxG.save.data.playInstInFreeplay != null)
		{
			previewInst = FlxG.save.data.playInstInFreeplay;
			FlxG.save.data.playInstInFreeplay = null;
		}
	}
}

class ClientPrefs
{
 public static var keyBinds:Map<String, Array<FlxKey>> = [
		//Key Bind, Name for ControlsSubState
		'note_up'		=> [W, UP],
		'note_left'		=> [A, LEFT],
		'note_down'		=> [S, DOWN],
		'note_right'	=> [D, RIGHT],
		
		'ui_up'			=> [W, UP],
		'ui_left'		=> [A, LEFT],
		'ui_down'		=> [S, DOWN],
		'ui_right'		=> [D, RIGHT],
		
		'accept'		=> [SPACE, ENTER],
		'back'			=> [BACKSPACE, ESCAPE],
		'pause'			=> [ENTER, ESCAPE],
		'reset'			=> [R],
		
		'volume_mute'	=> [ZERO],
		'volume_up'		=> [NUMPADPLUS, PLUS],
		'volume_down'	=> [NUMPADMINUS, MINUS],
		
		'debug_1'		=> [SEVEN],
		'debug_2'		=> [EIGHT]
	];
	public static var gamepadBinds:Map<String, Array<FlxGamepadInputID>> = [
		'note_up'		=> [DPAD_UP, Y],
		'note_left'		=> [DPAD_LEFT, X],
		'note_down'		=> [DPAD_DOWN, A],
		'note_right'	=> [DPAD_RIGHT, B],
		
		'ui_up'			=> [DPAD_UP, LEFT_STICK_DIGITAL_UP],
		'ui_left'		=> [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
		'ui_down'		=> [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN],
		'ui_right'		=> [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],
		
		'accept'		=> [A, START],
		'back'			=> [B],
		'pause'			=> [START],
		'reset'			=> [BACK]
	];

	public static var defaultBinds:Map<String, Array<FlxKey>>;
	public static var defaultGamepadBinds:Map<String, Array<FlxGamepadInputID>>;

	public static var data:SaveVariables = null;
	public static var defaultData:SaveVariables = null;

	public static function savePrefs()
	{
		for (field in Reflect.fields(data))
		{
			Reflect.setField(FlxG.save.data, field, Reflect.field(data, field));
		}
		FlxG.save.data.volume = FlxG.sound.volume;
		FlxG.save.flush();

		var save:FlxSave = new FlxSave();
		save.bind("controls_v2", CoolUtil.saveFolder);

		save.data.keyboard = keyBinds;
		save.data.gamepad = gamepadBinds;
		save.flush();
		FlxG.log.add("Preferences Saved!");
		trace("Preferences Saved!");
	}

	public static function loadPrefs()
	{
		if (data == null) data = new SaveVariables();
		if (defaultData == null) defaultData = new SaveVariables();

		for (field in Reflect.fields(FlxG.save.data))
		{
			if (Reflect.hasField(data, field))
			{
				Reflect.setField(data, field, Reflect.field(FlxG.save.data, field));
			}
		}
		FlxG.sound.volume = FlxG.save.data.volume;

		reloadBinds();
	}

	public static function resetKeys(controller:Null<Bool> = null) //Null = both, False = Keyboard, True = Controller
	{
		if(controller != true)
			for (key in keyBinds.keys())
				if(defaultBinds.exists(key))
					keyBinds.set(key, defaultBinds.get(key).copy());

		if(controller != false)
			for (button in gamepadBinds.keys())
				if(defaultGamepadBinds.exists(button))
					gamepadBinds.set(button, defaultGamepadBinds.get(button).copy());
	}

	public static function clearInvalidKeys(key:String)
	{
		var keyBind:Array<FlxKey> = keyBinds.get(key);
		var gamepadBind:Array<FlxGamepadInputID> = gamepadBinds.get(key);
		while(keyBind != null && keyBind.contains(NONE)) keyBind.remove(NONE);
		while(gamepadBind != null && gamepadBind.contains(NONE)) gamepadBind.remove(NONE);
	}

	public static function loadDefaultkeys()
	{
		defaultBinds = keyBinds.copy();
		defaultGamepadBinds = gamepadBinds.copy();
	}

	public static function reloadBinds()
	{
		var save:FlxSave = new FlxSave();
		save.bind("controls_v2", CoolUtil.saveFolder);

		if(save != null)
		{
			if(save.data.keyboard != null)
			{
				var loadedControls:Map<String, Array<FlxKey>> = save.data.keyboard;
				for (control => keys in loadedControls)
					if(keyBinds.exists(control)) keyBinds.set(control, keys);
			}
			if(save.data.gamepad != null)
			{
				var loadedControls:Map<String, Array<FlxGamepadInputID>> = save.data.gamepad;
				for (control => keys in loadedControls)
					if(gamepadBinds.exists(control)) gamepadBinds.set(control, keys);
			}
			reloadVolumeKeys();
		}
	}

	public static function reloadVolumeKeys()
	{
		TitleState.muteKeys = keyBinds.get('volume_mute').copy();
		TitleState.volumeDownKeys = keyBinds.get('volume_down').copy();
		TitleState.volumeUpKeys = keyBinds.get('volume_up').copy();
		toggleVolumeKeys(true);
	}
	public static function toggleVolumeKeys(?turnOn:Bool = true)
	{
		FlxG.sound.muteKeys = turnOn ? TitleState.muteKeys : [];
		FlxG.sound.volumeDownKeys = turnOn ? TitleState.volumeDownKeys : [];
		FlxG.sound.volumeUpKeys = turnOn ? TitleState.volumeUpKeys : [];
	}
}