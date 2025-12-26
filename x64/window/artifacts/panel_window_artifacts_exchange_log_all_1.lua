function PaGlobal_ArtifactsExchangeLog:initialize()
  if self._initialize == true then
    return
  end
  self:controlAll_Init()
  self:controlConsole_Init()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ArtifactsExchangeLog:controlAll_Init()
  if Panel_Window_Artifacts_Exchange_LOG_All == nil then
    return
  end
  self._ui.stc_TopBg = UI.getChildControl(Panel_Window_Artifacts_Exchange_LOG_All, "Static_TopBg")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_TopBg, "StaticText_Title")
  self._ui.button_Close = UI.getChildControl(self._ui.stc_TopBg, "Button_Close_PCUI")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_Artifacts_Exchange_LOG_All, "Static_MainBg")
  self._ui.stc_blockBg = UI.getChildControl(Panel_Window_Artifacts_Exchange_LOG_All, "Static_BlockBg")
  self._ui.stc_bg = UI.getChildControl(self._ui.stc_mainBg, "Static_Bg")
  self._ui.list2_lightStone = UI.getChildControl(self._ui.stc_mainBg, "List2_LightStone")
  self._ui.list2_Content = UI.getChildControl(self._ui.list2_lightStone, "List2_LightStone_Content")
  self._ui.stc_slotBg = UI.getChildControl(self._ui.list2_Content, "Static_SlotBg")
  self._ui.stc_itemSlot = UI.getChildControl(self._ui.stc_slotBg, "Static_ItemIcon")
  self._ui.btn_exchange = UI.getChildControl(self._ui.stc_mainBg, "Button_Exchange")
  self._ui.btn_cancel = UI.getChildControl(self._ui.stc_mainBg, "Button_Cancel")
  self._ui.stc_blockBg:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui.stc_blockBg:ComputePos()
  local slot = {}
  for index = 0, self._maxSlotCount - 1 do
    SlotItem.new(slot, "Artifact_Slot_", 0, self._ui.stc_slotBg, PaGlobal_ArtifactsExchangeLog._slotConfig)
    slot:createChild()
  end
  self._itemSlot = slot
end
function PaGlobal_ArtifactsExchangeLog:controlConsole_Init()
  if Panel_Window_Artifacts_Exchange_LOG_All == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  self._ui.stc_bottomBg = UI.getChildControl(Panel_Window_Artifacts_Exchange_LOG_All, "Static_BottomBg")
  self._ui.btn_KeyGuideConfirm = UI.getChildControl(self._ui.stc_bottomBg, "StaticText_A")
  self._ui.btn_KeyGuideCancel = UI.getChildControl(self._ui.stc_bottomBg, "StaticText_B")
  self._ui.button_Close:SetShow(false)
  self._ui.btn_exchange:SetShow(false)
  self._ui.btn_cancel:SetShow(false)
  self._ui.stc_blockBg:SetShow(false)
  self._ui.stc_bottomBg:SetShow(true)
  self._ui.stc_mainBg:SetSize(self._ui.stc_mainBg:GetSizeX(), self._ui.stc_mainBg:GetSizeY() - self._ui.btn_exchange:GetSizeY() - 20)
  Panel_Window_Artifacts_Exchange_LOG_All:SetSize(Panel_Window_Artifacts_Exchange_LOG_All:GetSizeX(), self._ui.stc_mainBg:GetPosY() + self._ui.stc_mainBg:GetSizeY())
  self._ui.stc_bottomBg:ComputePos()
end
function PaGlobal_ArtifactsExchangeLog:registEventHandler()
  if Panel_Window_Artifacts_Exchange_LOG_All == nil then
    return
  end
  registerEvent("FromClient_responseTradePrice", "FromClient_responseTradePrice_Artifact")
  self._ui.button_Close:addInputEvent("Mouse_LUp", "PaGlobal_ArtifactsExchangeLog_Close()")
  self._ui.btn_exchange:addInputEvent("Mouse_LUp", "HandleEventLUp_ArtifactsExchangeLog_DoExchange()")
  self._ui.btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_ArtifactsExchangeLog_Close()")
  self._ui.list2_lightStone:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_ArtifactsExchangeLog_ControlCreate")
  self._ui.list2_lightStone:createChildContent(__ePAUIList2ElementManagerType_List)
  if self._isConsole == true then
    Panel_Window_Artifacts_Exchange_LOG_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ArtifactsExchangeLog_DoExchange()")
    Panel_Window_Artifacts_Exchange_LOG_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_ArtifactsExchangeLog_Close()")
  end
end
function PaGlobal_ArtifactsExchangeLog:prepareOpen()
  if Panel_Window_Artifacts_Exchange_LOG_All == nil then
    return
  end
  Panel_Window_Artifacts_Exchange_LOG_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  Panel_Window_Artifacts_Exchange_LOG_All:ComputePos()
  self:setData()
  self:open()
end
function PaGlobal_ArtifactsExchangeLog:open()
  if Panel_Window_Artifacts_Exchange_LOG_All == nil then
    return
  end
  ToClient_padSnapIgnoreGroupMove()
  Panel_Window_Artifacts_Exchange_LOG_All:SetShow(true)
end
function PaGlobal_ArtifactsExchangeLog:prepareClose()
  if Panel_Window_Artifacts_Exchange_LOG_All == nil then
    return
  end
  self:close()
end
function PaGlobal_ArtifactsExchangeLog:close()
  if Panel_Window_Artifacts_Exchange_LOG_All == nil then
    return
  end
  Panel_Window_Artifacts_Exchange_LOG_All:SetShow(false)
end
function PaGlobal_ArtifactsExchangeLog:validate()
  if Panel_Window_Artifacts_Exchange_LOG_All == nil then
    return
  end
  self._ui.stc_TopBg:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.button_Close:isValidate()
  self._ui.stc_mainBg:isValidate()
  self._ui.stc_bg:isValidate()
  self._ui.list2_lightStone:isValidate()
  self._ui.btn_exchange:isValidate()
  self._ui.btn_cancel:isValidate()
  if self._isConsole == true then
    self._ui.stc_bottomBg:isValidate()
    self._ui.btn_KeyGuideConfirm:isValidate()
    self._ui.btn_KeyGuideCancel:isValidate()
  end
end
function PaGlobal_ArtifactsExchangeLog:setData()
  if Panel_Window_Artifacts_Exchange_LOG_All == nil then
    return
  end
  if nil == PaGlobal_ArtifactsExchange._exchangeSlots then
    return
  end
  self._ui.list2_lightStone:getElementManager():clearKey()
  local lightStoneCount = math.floor(#PaGlobal_ArtifactsExchange._exchangeAddedSlotNo / 3)
  for idx = 0, #PaGlobal_ArtifactsExchange._exchangeSlots do
    if idx == lightStoneCount * 3 then
      break
    end
    local slot = PaGlobal_ArtifactsExchange._exchangeSlots[idx]
    if slot.slotNo ~= 0 then
      self._ui.list2_lightStone:getElementManager():pushKey(toInt64(0, slot.slotNo))
    end
  end
end
