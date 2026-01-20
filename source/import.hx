#if !macro
import backend.ClientPrefs;
import backend.MusicBeatState;
import backend.MusicBeatSubstate;
import backend.Paths;
import backend.CoolUtil;
import backend.Highscore;
import backend.Conductor;
import backend.Controls;
import backend.Song;
import backend.Section;
#if ALLOW_DISCORD
import backend.Discord.DiscordClient;
#end

import objects.Alphabet;
import objects.MenuItem;
import objects.MenuCharacter;
import objects.HealthIcon;
import objects.Character;
import objects.Boyfriend;
import objects.Note;
import objects.Deadfriend;

import ui.TitleState;
import ui.PlayState;
import ui.MainMenuState;

import shaderslmfao.*;

// Flixel
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxObject;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

// Using imports
using StringTools;
#end