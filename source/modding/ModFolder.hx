package modding;

class ModFolder {
    // Fun fact, null = only settable in class, never = can not be set at all!
    public var path(default, null):String; // the path to the mod folder
    public var modName(get, never):String;

    public var scripts:Array<Dynamic> = []; // All available scripts to load.

    function get_modName():String
    {
        return 'noMod';
    }

    public function loadMod(path:String)
    {
        this.path = path;
    }
}