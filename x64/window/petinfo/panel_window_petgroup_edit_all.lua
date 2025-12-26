PaGlobal_PetGroupEdit = {
  _ui = {
    btn_Close = nil,
    rdo_Button = {},
    txt_GroupName = nil,
    edit_Name = nil,
    btn_Confirm = nil,
    btn_Cancel = nil,
    stc_BottomBG = nil,
    txt_ChangeName = nil,
    txt_Confirm = nil,
    txt_Cancel = nil,
    txt_SelectGroup = nil
  },
  _groupCount = 5,
  _indexForConsole = 0,
  _btnGapX = 5,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetGroup_Edit_All_1.lua")
runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetGroup_Edit_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PetGroup_Edit_All_Init")
function FromClient_PetGroup_Edit_All_Init()
  PaGlobal_PetGroupEdit:initialize()
end
