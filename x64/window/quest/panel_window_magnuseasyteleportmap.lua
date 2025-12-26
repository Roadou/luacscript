PaGlobal_MagnusEasyTeleportMap = {
  _ui = {
    _btn_City = Array.new(),
    _stc_Bg = nil,
    _btn_Cancel = nil,
    _btn_Close = nil,
    _txt_money = nil,
    _txt_CityName = nil,
    _txt_CityDesc = nil,
    _stc_ticket = nil,
    _stc_ticketTooltip = nil,
    _btn_moveToMagnus = nil,
    _stc_KeyGuide = nil,
    _stc_KeyGuide_A = nil,
    _stc_KeyGuide_B = nil
  },
  _fee = nil,
  _totalCount = 0,
  _selectedIndex = -1,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromCliet_MagnusEasyTeleportMap_Init")
function FromCliet_MagnusEasyTeleportMap_Init()
  PaGlobal_MagnusEasyTeleportMap:initialize()
end
function PaGlobal_MagnusEasyTeleportMap:initialize()
  if Panel_Window_MagnusEasyTeleportMap == nil then
    return
  end
  self._totalCount = ToClient_GetMagnusEasyTeleportInfoCount()
  for idx = 0, self._totalCount do
    local info = ToClient_GetMagnusEasyTeleportInfoByIndex(idx)
    if info ~= nil then
      local regionKeyRaw = info:getRegionKeyRaw()
      local regionWrapper = ToClient_getRegionInfoWrapperByWaypoint(regionKeyRaw)
      if regionWrapper ~= nil then
        local tempBtn = UI.getChildControl(Panel_Window_MagnusEasyTeleportMap, "CheckButton_" .. idx + 1)
        if tempBtn ~= nil then
          local bg = UI.getChildControl(tempBtn, "Static_RegionNormal")
          local innerBg = UI.getChildControl(bg, "Static_RegionBG")
          local tempTable = {
            _btn = tempBtn,
            _base = bg,
            _focus = UI.getChildControl(tempBtn, "Static_RegionMouseOn"),
            _txt = UI.getChildControl(innerBg, "StaticText_Region")
          }
          tempBtn:SetShow(true)
          local bgBase = UI.getChildControl(tempTable._base, "Static_RegionBG")
          local bgFocus = UI.getChildControl(tempTable._focus, "Static_RegionBG")
          UI.getChildControl(bgBase, "StaticText_Region"):SetText(PAGetString(Defines.StringSheet_GAME, info:getName()))
          UI.getChildControl(bgFocus, "StaticText_Region"):SetText(PAGetString(Defines.StringSheet_GAME, info:getName()))
          tempTable._focus:SetShow(false)
          if _ContentsGroup_UsePadSnapping == true then
            tempBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_MagnusEasyTeleportMap_Select(" .. idx .. ")")
            tempBtn:addInputEvent("Mouse_On", "HandleEventOnOut_MagnusEasyTeleportMap_UpdateDesc(true, " .. idx .. ")")
            tempBtn:addInputEvent("Mouse_Out", "HandleEventOnOut_MagnusEasyTeleportMap_UpdateDesc(false, " .. idx .. ")")
            tempTable._base:SetIgnore(true)
            tempTable._focus:SetIgnore(true)
          else
            tempTable._base:addInputEvent("Mouse_LUp", "HandleEventLUp_MagnusEasyTeleportMap_Select(" .. idx .. ")")
            tempTable._base:addInputEvent("Mouse_On", "HandleEventOnOut_MagnusEasyTeleportMap_UpdateDesc(true, " .. idx .. ")")
            tempTable._base:addInputEvent("Mouse_Out", "HandleEventOnOut_MagnusEasyTeleportMap_UpdateDesc(false, " .. idx .. ")")
            tempTable._focus:addInputEvent("Mouse_LUp", "HandleEventLUp_MagnusEasyTeleportMap_Select(" .. idx .. ")")
            tempTable._focus:addInputEvent("Mouse_On", "HandleEventOnOut_MagnusEasyTeleportMap_UpdateDesc(true, " .. idx .. ")")
            tempTable._focus:addInputEvent("Mouse_Out", "HandleEventOnOut_MagnusEasyTeleportMap_UpdateDesc(false, " .. idx .. ")")
          end
          self._ui._btn_City[idx] = tempTable
        end
      end
    end
  end
  local title = UI.getChildControl(Panel_Window_MagnusEasyTeleportMap, "Static_TitleArea")
  self._ui._btn_Close = UI.getChildControl(title, "Button_Close")
  self._ui._stc_KeyGuide = UI.getChildControl(Panel_Window_MagnusEasyTeleportMap, "Static_KeyGuide_ConsoleUI_Import")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_B_ConsoleUI")
  self._ui._txt_money = UI.getChildControl(Panel_Window_MagnusEasyTeleportMap, "Button_Money")
  self._ui._btn_moveToMagnus = UI.getChildControl(Panel_Window_MagnusEasyTeleportMap, "Button_Cancel")
  self._ui._stc_Bg = UI.getChildControl(Panel_Window_MagnusEasyTeleportMap, "Static_DialogBox")
  self._ui._txt_CityName = UI.getChildControl(self._ui._stc_Bg, "StaticText_NPCName")
  self._ui._txt_CityDesc = UI.getChildControl(self._ui._stc_Bg, "StaticText_Dialog")
  self._ui._btn_Cancel = UI.getChildControl(Panel_Window_MagnusEasyTeleportMap, "Button_Cancel")
  self._fee = makeDotMoney(ToClient_RequestMagnusEasyTeleportFee())
  self._ui._stc_ticket = UI.getChildControl(Panel_Window_MagnusEasyTeleportMap, "CheckButton_TeleportActive")
  self._ui._stc_ticketTooltip = UI.getChildControl(Panel_Window_MagnusEasyTeleportMap, "Static_TeleportActive_Tooltip")
  self._ui._stc_KeyGuide:SetShow(_ContentsGroup_UsePadSnapping == true)
  self._ui._btn_Close:SetShow(_ContentsGroup_UsePadSnapping == false)
  PaGlobal_MagnusEasyTeleportMap:registerEvent()
  self._initialize = true
end
function PaGlobal_MagnusEasyTeleportMap:registerEvent()
  registerEvent("onScreenResize", "FromClient_MagnusEasyTeleportMap_Resize")
  registerEvent("FromClient_InventoryUpdate", "FromClient_MagnusEasyTeleportMap_UpdateMoney")
  registerEvent("FromClient_UpdateMagnusTicketState", "FromClient_MagnusEasyTeleportMap_UpdateTicket")
  registerEvent("FromClient_MagnusEasyTeleportSelectDestSuccess", "FromClient_MagnusEasyTeleportSelectDestSuccess")
  registerEvent("FromClinet_ExecuteEnterAbyssOne", "FromClient_MagnusEasyTeleportSelectDestReset")
  registerEvent("FromClient_notOpenIngameCustomizationMessage", "FromClient_notOpenIngameCustomizationMessage")
  self._ui._btn_moveToMagnus:addInputEvent("Mouse_On", "HandleEventOnOut_MagnusEasyTeleportMap_UpdateMagnusBtnDesc(true)")
  self._ui._btn_moveToMagnus:addInputEvent("Mouse_Out", "HandleEventOnOut_MagnusEasyTeleportMap_UpdateMagnusBtnDesc(false)")
  self._ui._stc_ticketTooltip:addInputEvent("Mouse_On", "HandleEventOnOut_MagnusEasyTeleportMap_MagnusTicketBtn(true)")
  self._ui._stc_ticketTooltip:addInputEvent("Mouse_Out", "HandleEventOnOut_MagnusEasyTeleportMap_MagnusTicketBtn(false)")
  self._ui._btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_MagnusEasyTeleportMap_Cancel()")
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "HandleEventLUp_MagnusEasyTeleportMap_Close()")
  Panel_Window_MagnusEasyTeleportMap:RegisterShowEventFunc(true, "PaGlobalFunc_MagnusEasyTeleportMap_ShowAni()")
end
function PaGlobalFunc_MagnusEasyTeleportMap_ShowAni()
  UIAni.showAniScaleElastic(Panel_Window_MagnusEasyTeleportMap)
end
function PaGlobal_MagnusEasyTeleportMap:prepareClose()
  PaGlobal_MagnusEasyTeleportMap:close()
  audioPostEvent_SystemUi(40, 2)
  _AudioPostEvent_SystemUiForXBOX(40, 2)
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
end
function PaGlobal_MagnusEasyTeleportMap:close()
  Panel_Window_MagnusEasyTeleportMap:SetShow(false)
end
function PaGlobal_MagnusEasyTeleportMap:updateMoney()
  if Panel_Window_MagnusEasyTeleportMap == nil or Panel_Window_MagnusEasyTeleportMap:GetShow() == false then
    return
  end
  self._ui._txt_money:SetText(makeDotMoney(getSelfPlayer():get():getMoneyInventory():getMoney_s64()))
end
function PaGlobal_MagnusEasyTeleportMap:prepareOpen()
  if _ContentsGroup_MagnusEasyTeleport == false then
    return
  end
  PaGlobal_MagnusEasyTeleportMap:checkCondition()
  PaGlobal_MagnusEasyTeleportMap:resetAllControl()
  self._ui._txt_CityName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MAGNUS_EASYTELEPORT_ADMINISTRATOR"))
  self._ui._txt_CityDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MAGNUS_EASYTELEPORT_DEFAULT"))
  PaGlobal_MagnusEasyTeleportMap:open()
  PaGlobal_MagnusEasyTeleportMap:updateMoney()
  PaGlobal_MagnusEasyTeleportMap:updateTicket()
  self._ui._stc_Bg:EraseAllEffect()
  self._ui._stc_Bg:AddEffect("UI_A1_Map_Equalizer_01A", true, 0, 0)
  ToClient_AudioPostEvent_UIAudioStateEvent("UIState_Open_AbyssWell")
  audioPostEvent_SystemUi(40, 1)
  _AudioPostEvent_SystemUiForXBOX(40, 1)
end
function PaGlobal_MagnusEasyTeleportMap:checkCondition()
  for idx = 0, self._totalCount do
    local info = ToClient_GetMagnusEasyTeleportInfoByIndex(idx)
    if info ~= nil then
      local regionKeyRaw = info:getRegionKeyRaw()
      local mentalCardKeyRaw = info:getMentalCardKeyRaw()
      local regionWrapper = ToClient_getRegionInfoWrapperByWaypoint(regionKeyRaw)
      if regionWrapper ~= nil then
        local tempBtn = UI.getChildControl(Panel_Window_MagnusEasyTeleportMap, "CheckButton_" .. idx + 1)
        if tempBtn ~= nil then
          tempBtn:SetShow(false)
          local mentalCard = ToClinet_getMentalCardStaticStatus(mentalCardKeyRaw)
          if mentalCard ~= nil and mentalCard:isHasCard() == true then
            tempBtn:SetShow(true)
          end
        end
      end
    end
  end
end
function PaGlobal_MagnusEasyTeleportMap:updateTicket()
  local isPaid = ToClient_IsPaidMagnusEasyTeleportFee()
  PaGlobal_MagnusEasyTeleportMap._ui._stc_ticket:SetCheck(isPaid)
  if isPaid == true then
    PaGlobal_MagnusEasyTeleportMap._ui._stc_ticket:EraseAllEffect()
    PaGlobal_MagnusEasyTeleportMap._ui._stc_ticket:AddEffect("fUI_A1_Map_Ticket_01A", true, 0, 0)
  end
end
function PaGlobal_MagnusEasyTeleportMap:open()
  Panel_Window_MagnusEasyTeleportMap:SetShow(true, true)
end
function PaGlobal_MagnusEasyTeleportMap:resetAllControl()
  for idx = 0, self._totalCount do
    if self._ui._btn_City[idx] ~= nil and self._selectedIndex ~= idx then
      self._ui._btn_City[idx]._base:EraseAllEffect()
      self._ui._btn_City[idx]._base:SetShow(true)
      self._ui._btn_City[idx]._focus:EraseAllEffect()
      self._ui._btn_City[idx]._focus:SetShow(false)
    end
  end
end
function HandleEventLUp_MagnusEasyTeleportMap_Open()
  PaGlobal_MagnusEasyTeleportMap:prepareOpen()
end
function HandleEventLUp_MagnusEasyTeleportMap_Close()
  PaGlobal_MagnusEasyTeleportMap:prepareClose()
end
function HandleEventLUp_MagnusEasyTeleportMap_Select(index)
  if _ContentsGroup_MagnusEasyTeleport == false then
    return
  end
  if PaGlobal_MagnusEasyTeleportMap._ui._btn_City[index] == nil then
    return
  end
  local isRideVehicle = getSelfPlayer():get():doRideMyVehicle()
  if isRideVehicle == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantMoveToWharfDrive"))
    return
  end
  if IsSelfPlayerWaitAction() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_ENTER"))
    return
  end
  local cancel = function()
    PaGlobal_MagnusEasyTeleportMap:resetAllControl()
    PaGlobal_MagnusEasyTeleportMap._selectedIndex = -1
  end
  local isPaid = ToClient_IsPaidMagnusEasyTeleportFee()
  local function selectCity()
    ToClient_RequestMagnusEasyTeleportTarget(index)
  end
  local name = PaGlobal_MagnusEasyTeleportMap._ui._btn_City[index]._txt:GetText()
  local msg = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MAGNUS_EASYTELEPORT_COST_CONFIRM", "destination", name, "cost", PaGlobal_MagnusEasyTeleportMap._fee)
  if isPaid == true then
    msg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MAGNUS_EASYTELEPORT_TICKET_CONFIRM", "destination", name)
  end
  PaGlobal_MagnusEasyTeleportMap._selectedIndex = index
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = msg,
    functionYes = selectCity,
    functionCancel = cancel,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
  audioPostEvent_SystemUi(33, 7)
  _AudioPostEvent_SystemUiForXBOX(33, 7)
end
function HandleEventLUp_MagnusEasyTeleportMap_Cancel()
  if _ContentsGroup_MagnusEasyTeleport == false then
    return
  end
  local isRideVehicle = getSelfPlayer():get():doRideMyVehicle()
  if isRideVehicle == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantMoveToWharfDrive"))
    return
  end
  if IsSelfPlayerWaitAction() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_ENTER"))
    return
  end
  PaGlobal_MagnusEasyTeleportMap:resetAllControl()
  PaGlobal_MagnusEasyTeleportMap._ui._btn_Cancel:EraseAllEffect()
  PaGlobal_MagnusEasyTeleportMap._ui._btn_Cancel:AddEffect("fUI_A1_Map_Botton_01A", true, 0, 0)
  audioPostEvent_SystemUi(33, 4)
  _AudioPostEvent_SystemUiForXBOX(33, 4)
  ToClient_RequestMagnusEasyTeleportCancel()
end
function HandleEventOnOut_MagnusEasyTeleportMap_UpdateDesc(isOn, index)
  local self = PaGlobal_MagnusEasyTeleportMap
  if self._ui._btn_City[index] == nil then
    return
  end
  if index == PaGlobal_MagnusEasyTeleportMap._selectedIndex then
    return
  end
  PaGlobal_MagnusEasyTeleportMap:resetAllControl()
  local isPaid = ToClient_IsPaidMagnusEasyTeleportFee()
  if isOn == true then
    local name = self._ui._btn_City[index]._txt:GetText()
    if isPaid == true then
      self._ui._txt_CityDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MAGNUS_EASYTELEPORT_TICKET", "destination", name))
    else
      self._ui._txt_CityDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MAGNUS_EASYTELEPORT_COST", "destination", name))
    end
    if index ~= self._selectedIndex and self._selectedIndex ~= -1 then
      self._ui._btn_City[self._selectedIndex]._base:SetShow(true)
      self._ui._btn_City[self._selectedIndex]._focus:SetShow(false)
      self._ui._btn_City[self._selectedIndex]._focus:EraseAllEffect()
    end
    self._ui._btn_City[index]._base:SetShow(false)
    self._ui._btn_City[index]._focus:SetShow(true)
    self._ui._btn_City[index]._focus:EraseAllEffect()
    self._ui._btn_City[index]._focus:AddEffect("fUI_A1_Map_Focusing_01A", true, 0, 0)
    audioPostEvent_SystemUi(33, 6)
    _AudioPostEvent_SystemUiForXBOX(33, 6)
  else
    self._ui._btn_City[index]._base:SetShow(true)
    self._ui._btn_City[index]._focus:SetShow(false)
    self._ui._txt_CityDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MAGNUS_EASYTELEPORT_DEFAULT"))
    if index ~= self._selectedIndex and self._selectedIndex ~= -1 then
      self._ui._btn_City[self._selectedIndex]._base:SetShow(false)
      self._ui._btn_City[self._selectedIndex]._focus:SetShow(true)
      self._ui._btn_City[self._selectedIndex]._focus:EraseAllEffect()
      self._ui._btn_City[self._selectedIndex]._focus:AddEffect("fUI_A1_Map_Focusing_01A", true, 0, 0)
    end
  end
end
function HandleEventOnOut_MagnusEasyTeleportMap_UpdateMagnusBtnDesc(isOn)
  local self = PaGlobal_MagnusEasyTeleportMap
  if isOn == true then
    self._ui._txt_CityDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MAGNUS_EASYTELEPORT_TOMAGNUS"))
    self._ui._btn_Cancel:EraseAllEffect()
    self._ui._btn_Cancel:AddEffect("fUI_A1_Map_Botton_01A", true, 0, 0)
  else
    self._ui._txt_CityDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MAGNUS_EASYTELEPORT_DEFAULT"))
    self._ui._btn_Cancel:EraseAllEffect()
  end
end
function HandleEventOnOut_MagnusEasyTeleportMap_MagnusTicketBtn(isOn)
  if isOn == true then
    local msg = PAGetString(Defines.StringSheet_GAME, "LUA_MAGNUS_EASYTELEPORT_NOTICKET_TOOLTIP")
    if ToClient_IsPaidMagnusEasyTeleportFee() == true then
      msg = PAGetString(Defines.StringSheet_GAME, "LUA_MAGNUS_EASYTELEPORT_TICKETNOCOUNT_TOOLTIP")
    end
    TooltipSimple_Show(PaGlobal_MagnusEasyTeleportMap._ui._stc_ticket, msg, "")
  else
    TooltipSimple_Hide()
  end
end
function FromClient_MagnusEasyTeleportMap_Resize()
  Panel_Window_MagnusEasyTeleportMap:ComputePos()
end
function FromClient_MagnusEasyTeleportMap_UpdateMoney()
  PaGlobal_MagnusEasyTeleportMap:updateMoney()
end
function FromClient_MagnusEasyTeleportMap_UpdateTicket()
  if Panel_Window_MagnusEasyTeleportMap == nil then
    return
  end
  PaGlobal_MagnusEasyTeleportMap:updateTicket()
  local isPaid = ToClient_IsPaidMagnusEasyTeleportFee()
  if isPaid == true then
    audioPostEvent_SystemUi(33, 5)
    _AudioPostEvent_SystemUiForXBOX(33, 5)
  end
end
function FromClient_MagnusEasyTeleportSelectDestSuccess()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "MAGNUS_EASYTELEPORT_GUIDE"))
  interaction_Forceed()
  HandleEventLUp_MagnusEasyTeleportMap_Close()
end
function FromClient_MagnusEasyTeleportSelectDestReset()
  if Panel_Window_MagnusEasyTeleportMap == nil then
    return
  end
  PaGlobal_MagnusEasyTeleportMap._selectedIndex = -1
end
function FromClient_notOpenIngameCustomizationMessage()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_NOTUSEALERT"))
end
