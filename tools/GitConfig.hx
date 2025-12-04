package;

using StringTools;

function splitLines(s:String):Array<String> {
    return ~/\r?\n/.split(s);
}

typedef Element = {
    var name:String;
    var value:String;
}

class GitConfig {
    public var elements:Map<String, Array<Element>>;

    public function new(rawFile:String)
    {
        elements = new Map<String, Array<Element>>();
        var file = splitLines(rawFile);
        var lastSection:String = '';
        var lastElements:Array<Element> = [];
        for (line in file)
        {
            var element:Element;
            if (line.startsWith("["))
            {
                if (lastSection != '')
                {
                    elements.set(lastSection, lastElements);
                    lastElements = [];
                }
                lastSection = line.replace("[", "").replace("]", "");
            }
            else
            {
                var splitLine = line.trim().split(" = ");
                element = {name: splitLine[0], value: splitLine[1]};
            }
        }
        trace(elements);
    }
}