package modding;

import backend.SettingData;

typedef ModSetting = {
    var data:Array<TabType>;
}

typedef TabType = {
    var name:String;
    var settings:Array<SettingData>;
}

class ModSettingData {
    // stub
}