PaGlobal_AsiaChampionshop_Agreement = {
  _ui = {
    _btn_agree = nil,
    _btn_cancel = nil,
    _frame = nil,
    _frame_desc = nil,
    _keyguide = nil,
    _keyguide_A = nil,
    _keyguide_B = nil
  },
  _worldIdx = nil,
  _channelIdx = nil,
  _initialize = false
}
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_AsiaChampionshop_Agreement_Init")
function FromClient_AsiaChampionshop_Agreement_Init()
  PaGlobal_AsiaChampionshop_Agreement:initialize()
end
function PaGlobal_AsiaChampionshop_Agreement:initialize()
  if true == PaGlobal_AsiaChampionshop_Agreement._initialize or nil == Panel_AsiaChampionship_Agreement_All then
    return
  end
  local stc_bg = UI.getChildControl(Panel_AsiaChampionship_Agreement_All, "Static_EventBanner")
  self._ui._frame = UI.getChildControl(Panel_AsiaChampionship_Agreement_All, "Frame_Desc")
  self._ui._frame_desc = UI.getChildControl(self._ui._frame, "Frame_1_Content")
  self._txt_desc = UI.getChildControl(self._ui._frame_desc, "StaticText_Desc")
  self._ui._btn_agree = UI.getChildControl(Panel_AsiaChampionship_Agreement_All, "Button_Agree")
  self._ui._btn_cancel = UI.getChildControl(Panel_AsiaChampionship_Agreement_All, "Button_Cancel")
  self._ui._keyguide = UI.getChildControl(Panel_AsiaChampionship_Agreement_All, "Static_KeyGuide_Console")
  self._ui._keyguide_A = UI.getChildControl(self._ui._keyguide, "StaticText_A_ConsoleUI")
  self._ui._keyguide_B = UI.getChildControl(self._ui._keyguide, "StaticText_B_ConsoleUI")
  local txtSizeY = self._txt_desc:GetTextSizeY()
  self._ui._frame_desc:SetSize(self._ui._frame_desc:GetSizeX(), txtSizeY + 10)
  self._ui._frame_desc:ComputePos()
  self._ui._frame:UpdateContentScroll()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._keyguide:SetShow(_ContentsGroup_UsePadSnapping == true)
  if _ContentsGroup_UsePadSnapping == true then
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      self._ui._keyguide_A,
      self._ui._keyguide_B
    }, self._ui._keyguide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  self._ui._btn_agree:addInputEvent("Mouse_LUp", "PaGlobal_AsiaChampionshop_Agreement:join()")
  self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_AsiaChampionshop_Agreement_Close()")
  registerEvent("FromClient_MultiSiegeNationAck", "FromClient_MultiSiegeNationAck")
  PaGlobal_AsiaChampionshop_Agreement._initialize = true
end
function PaGlobal_AsiaChampionshop_Agreement:prepareOpen()
  if nil == Panel_AsiaChampionship_Agreement_All then
    return
  end
  PaGlobal_AsiaChampionshop_Agreement._ui._btn_agree:SetMonoTone(true, true)
  PaGlobal_AsiaChampionshop_Agreement._ui._btn_agree:SetIgnore(true)
  PaGlobal_AsiaChampionshop_Agreement:open()
end
function PaGlobal_AsiaChampionshop_Agreement:open()
  if nil == Panel_AsiaChampionship_Agreement_All then
    return
  end
  Panel_AsiaChampionship_Agreement_All:SetShow(true)
end
function PaGlobal_AsiaChampionshop_Agreement:prepareClose()
  if nil == Panel_AsiaChampionship_Agreement_All then
    return
  end
  self._worldIdx = nil
  self._channelIdx = nil
  PaGlobal_AsiaChampionshop_Agreement:close()
end
function PaGlobal_AsiaChampionshop_Agreement:close()
  if nil == Panel_AsiaChampionship_Agreement_All then
    return
  end
  Panel_AsiaChampionship_Agreement_All:SetShow(false)
end
function PaGlobal_AsiaChampionshop_Agreement_Open(worldIdx, channelIdx)
  if nil == Panel_AsiaChampionship_Agreement_All then
    return
  end
  if ToClient_isMultiNationSiegeUser() == false then
    return
  end
  PaGlobal_AsiaChampionshop_Agreement._worldIdx = worldIdx
  PaGlobal_AsiaChampionshop_Agreement._channelIdx = channelIdx
  ToClient_PrepareJoinMultiNationField(__eMultiNationServerTypeSiege)
  PaGlobal_AsiaChampionshop_Agreement:prepareOpen()
end
function PaGlobal_AsiaChampionshop_Agreement:join()
  if ToClient_isMultiNationSiegeUser() == false then
    return
  end
  if self._worldIdx == nil or self._channelIdx == nil then
    return
  end
  local channelServerData = getGameChannelServerDataByIndex(self._worldIdx, self._channelIdx)
  if channelServerData:isMultiNationSiegeServer() == false then
    return
  end
  selectServerGroup(self._worldIdx, self._channelIdx)
  PaGlobal_AsiaChampionshop_Agreement:close()
end
function PaGlobal_AsiaChampionshop_Agreement_Close()
  if nil == Panel_AsiaChampionship_Agreement_All then
    return
  end
  PaGlobal_AsiaChampionshop_Agreement:close()
end
function FromClient_MultiSiegeNationAck()
  if nil == Panel_AsiaChampionship_Agreement_All then
    return
  end
  PaGlobal_AsiaChampionshop_Agreement._ui._btn_agree:SetMonoTone(false, false)
  PaGlobal_AsiaChampionshop_Agreement._ui._btn_agree:SetIgnore(false)
end
