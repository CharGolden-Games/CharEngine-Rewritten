package;

import sys.io.File;

using StringTools;

class MakeNewRelease
{
    static var buildOptions:Array<String> = [];
    static var args:Array<String> = Sys.args();
    static var enableTracing:Bool = false;
    static var version:String = "";
    static var platform:String = #if windows "windows"; #else
     #if mac "mac"; #else
      "linux";
       #end
        #end

    public static function main()
    {
        applyArgs();

        var baseCommand:String = "lime build " + platform;

        if (buildOptions.contains("-test"))
        {
            buildOptions.pop();
            baseCommand = "lime test " + platform;
        }

        Sys.command(baseCommand, buildOptions);
        var path = "./export/" + (buildOptions.contains("-debug") ? "debug" : "release") + '/$platform/bin/' #if mac + "UniverseEngine.app" #end;
        #if unix
        Sys.command("zip", ["export/archives/" + 'Universe-Engine-$platform.zip', path]);
        #else
        Sys.command("tar.exe", ['-a', '-c', '-f', "export/archives/Universe-Engine-Windows.zip", path]);
        #end
    }

    static function applyArgs()
    {
        version = File.getContent("gitVersion.txt");
        for (arg in args)
        {
            var aArg:Array<String> = [];
            if (arg.contains("="))
                aArg = arg.split("=")
            else
                aArg.push(arg);

            if (arg == "-mode=test" || arg == "-test")
            {
                buildOptions.push("-test");
            }
            switch (aArg[0].replace("-", ""))
            {
                case "version":
                    version = aArg[1];

                case "mode":
                    switch (aArg[1])
                    {
                        case "debug":
                            enableTracing = true;
                            buildOptions.push("-debug");

                        case "release":
                             buildOptions.push("-DOfficialRelease");

                        case "releaseCandidate" | "rc":
                            buildOptions.push("-debug");
                            buildOptions.push("-DReleaseCandidate_" + version);

                        case _: trace("test/other mode.");
                    }
                
                case "platform":
                    platform = aArg[1];
            }
        }
    }
}