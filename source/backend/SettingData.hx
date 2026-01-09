package backend;

import objects.Option;

typedef SettingData = {
    var name:String;
    @:optional var desc:String;
    var variable:String;
    var type:ValueType;
    var defaultValue:Dynamic;
    @:optional var options:Array<String>;
}

class SettingDataParser {
    public static function parse(data:SettingData):Option
    {
        var desc:String = data.desc;
        if (desc == null) desc = "No description?! What the hell!";
        var option:Option = new Option(data.name, desc, data.variable, data.type, data.options);

        return option;
    }
}

enum abstract ValueType(String) from String to String
{
    var bool = "bool";
    var string = "string";
    var value = "float";
    var key = 'keybind';
    var header = 'header';
}