PaGlobal_EndingCredit = {
  _ui = {
    stc_ImageArea,
    stc_G,
    stc_S,
    stc_CreditArea,
    txt_Title,
    stc_RectArea,
    txt_Name_0,
    txt_Name_1,
    txt_Name_2,
    txt_Name = {},
    txt_Log,
    chk_Fast,
    stc_LastCreditArea,
    mul_Desc,
    stc_Ci
  },
  nameList = {},
  _imageAllCount = 135,
  _imageGCount = 101,
  _imageSCount = 34,
  _nameControlMaxCount = 35,
  _currentIndex = 0,
  _speed = 200,
  _speedValue = 1,
  _hideTime = 0,
  _endTime = 3,
  _imageTime = 10,
  _imageShowTime = 10,
  _pause = false,
  _lastCredeit = false,
  _ciPosY = 0
}
if isGameTypeKorea() == true then
  runLua("UI_Data/Script/Window/Movie/Panel_EndingCredit_All_01.lua")
elseif isGameTypeJapan() == true then
  runLua("UI_Data/Script/Window/Movie/Panel_EndingCredit_All_01_JP.lua")
elseif isGameTypeRussia() == true then
  runLua("UI_Data/Script/Window/Movie/Panel_EndingCredit_All_01_RU.lua")
elseif isGameTypeNA() == true then
  if 0 == getServiceNationType() then
    runLua("UI_Data/Script/Window/Movie/Panel_EndingCredit_All_01_NA.lua")
  elseif 1 == getServiceNationType() then
    runLua("UI_Data/Script/Window/Movie/Panel_EndingCredit_All_01_EU.lua")
  end
elseif isGameTypeTR() == true then
  runLua("UI_Data/Script/Window/Movie/Panel_EndingCredit_All_01_TR.lua")
elseif isGameTypeASIA() == true then
  runLua("UI_Data/Script/Window/Movie/Panel_EndingCredit_All_01_ASIA.lua")
elseif isGameTypeSA() == true then
  runLua("UI_Data/Script/Window/Movie/Panel_EndingCredit_All_01_SA.lua")
elseif isGameTypeTaiwan() == true then
  runLua("UI_Data/Script/Window/Movie/Panel_EndingCredit_All_01_TW.lua")
else
  runLua("UI_Data/Script/Window/Movie/Panel_EndingCredit_All_01.lua")
end
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_EndingCredit_All")
function FromClient_PaGlobal_EndingCredit_All()
  PaGlobal_EndingCredit:initialize()
end
