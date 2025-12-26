PaGlobal_GuildDocumentManagement_All = {
  _ui = {
    radio_Unapproved = nil,
    radio_Approval = nil,
    radio_Return = nil,
    stc_SelectBar = nil,
    btn_SelectApproval = nil,
    btn_SelectReturn = nil,
    list2 = nil,
    list2_content = nil
  },
  _ui_pc = {
    btn_Close = nil,
    btn_AllApproval = nil,
    btn_Close2 = nil
  },
  _ui_console = {
    stc_KeyGuideBG = nil,
    txt_KeyGuideX = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil,
    txt_KeyGuideY = nil
  },
  _eTab = {
    eNone = 0,
    eAccept = 1,
    eRefuse = 2
  },
  _selectType = nil,
  _isOpenReq = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildDocumentManagement_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildDocumentManagement_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GuildDocumentManagement_AllInit")
function FromClient_GuildDocumentManagement_AllInit()
  PaGlobal_GuildDocumentManagement_All:initialize()
end
