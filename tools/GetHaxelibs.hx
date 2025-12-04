package;

#if sys
import sys.FileSystem;
import sys.io.File;
using StringTools;

typedef Haxelib = {
    var name:String;
    var version:String;
    @:optional var URL:String;
}

class GetHaxelibs {
    static var haxelibs:Array<Haxelib> = [];

    static function main() {
        var directories:Array<String> = getDirectoryList();

        for (path in directories)
        {
            try
            {
                var ver = getHaxelibVersion(path);
                var url:Null<String> = null;
                if (ver == 'git')
                {
                    url = getGitURL(path);
                }
                haxelibs.push(parseHaxelib(path, getHaxelibVersion(path), url));
            }
            catch(e:Dynamic)
            {
                trace(e);
            }
        }

        buildFile();
    }

    static function buildFile()
    {
        var rawFile:String = '';
        #if windows rawFile += "@echo off\necho INSTALLING LIBRARIES"; #end
        for (lib in haxelibs)
        {
            if (lib.version == "git")
            {
                rawFile += '\nhaxelib git ${lib.name} ${lib.URL}';
            }
            else
            {
                rawFile += '\nhaxelib install ${lib.name} ${lib.version} && haxelib set ${lib.name} ${lib.version}';
            }
        }

        File.saveContent("./haxelibs" #if windows + '.bat' #else + '.sh' #end, rawFile);
    }

    static function getDirectoryList():Array<String>
    {
        return FileSystem.readDirectory("../.haxelib");
    }

    static function getHaxelibVersion(path:String):String
    {
        return File.getContent('../.haxelib/$path/.current');
    }

    static function getGitURL(path:String):String
    {
        var config:GitConfig = new GitConfig(('../.haxelib/$path/git/.git/config'));

        for (k => elements in config.elements)
        {
            if (k.startsWith("remote"))
            {
                for (element in elements)
                {
                    if (element.name == "url")
                        return element.value;
                }
            }
        }

        return null;
    }

    static function parseHaxelib(name:String, version:String, ?URL:Null<String> = null):Haxelib
    {
        return {
            name: name,
            version: version,
            URL: URL
        };
    }
}
#else
class GetHaxelibs {
    public static function main() {
        trace("Access to sys libraries is required for this tool!");
    }
}
#end