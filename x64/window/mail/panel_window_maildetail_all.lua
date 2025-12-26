PaGlobal_Window_MailDetail_All = {
  _mainControl = nil,
  _ui = {
    stc_centerBG = nil,
    stc_mailContentBG = nil,
    txt_title = nil,
    txt_sender = nil,
    frame_mailText = nil,
    frame_mailContent = nil,
    txt_mailContent = nil,
    stc_mailExpirateDate = nil,
    txt_mailExpirateDate = nil,
    frame_vScroll = nil,
    btn_vScrollUp = nil,
    btn_vScrollDown = nil,
    btn_vScrollCtrl = nil,
    frame_hScroll = nil,
    btn_hScrollUp = nil,
    btn_hScrollDown = nil,
    btn_hScrollCtrl = nil,
    stc_MailBottomBG = nil,
    stc_itemSlotBG = nil,
    txt_itemEnClosed = nil,
    txt_itemName = nil,
    txt_itemCount = nil,
    btn_checkAutoDelete = nil,
    stc_itemSlot = {}
  },
  _ui_pc = {
    btn_close = nil,
    btn_receive = nil,
    btn_delete = nil,
    btn_apply = nil
  },
  _ui_console = {
    keyGuides = {},
    stc_consoleBottomBG = nil,
    txt_receiveItem = nil,
    txt_close = nil,
    txt_mailDelete = nil,
    txt_scroll = nil,
    txt_autoDelete = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createMailCount = false,
    createEnchant = true,
    createCash = true
  },
  openMailNo = nil,
  isExistItem = false,
  isMassMail = false,
  panel_SizeY = 0,
  mailTextSizeY = 0,
  autoDeleteBaseSpanY = 0,
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/Mail/Panel_Window_MailDetail_All_1.lua")
runLua("UI_Data/Script/Window/Mail/Panel_Window_MailDetail_All_2.lua")
if true == _ContentsGroup_UsePadSnapping then
  registerEvent("FromClient_luaLoadComplete", "FromClient_Window_MailDetail_AllInit")
end
function FromClient_Window_MailDetail_AllInit()
  PaGlobal_Window_MailDetail_All:initialize()
end
