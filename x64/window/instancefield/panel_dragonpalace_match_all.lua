PaGlobal_DragonPalace_Match_All = {
  _ui = {
    btn_join = nil,
    btn_close = nil,
    btn_rule = nil,
    stc_rule = nil,
    stc_subBG = nil,
    frame_desc = nil,
    frame_content = nil,
    frame_vscroll = nil
  },
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_DragonPalace_Match_Init")
function FromClient_DragonPalace_Match_Init()
  PaGlobal_DragonPalace_Match_All:initialize()
end
function PaGlobal_DragonPalace_Match_All:initialize()
  if true == PaGlobal_DragonPalace_Match_All._initialize or nil == Panel_DragonPalace_Match_All then
    return
  end
  self._ui.btn_join = UI.getChildControl(Panel_DragonPalace_Match_All, "Button_Join")
  self._ui.btn_close = UI.getChildControl(Panel_DragonPalace_Match_All, "Button_Close")
  self._ui.btn_rule = UI.getChildControl(Panel_DragonPalace_Match_All, "Button_Rule")
  self._ui.stc_rule = UI.getChildControl(Panel_DragonPalace_Match_All, "Static_MatchRule")
  self._ui.stc_title = UI.getChildControl(self._ui.stc_rule, "Static_TitleArea")
  self._ui.btn_ruleClose = UI.getChildControl(self._ui.stc_title, "Button_Win_Close")
  self._ui.stc_subBG = UI.getChildControl(self._ui.stc_rule, "Static_SubBg")
  self._ui.frame_desc = UI.getChildControl(self._ui.stc_subBG, "Frame_ScenarioDesc")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_desc, "Frame_1_Content")
  self._ui.stc_txt = UI.getChildControl(self._ui.frame_content, "StaticText_1")
  self._ui.frame_vscroll = UI.getChildControl(self._ui.frame_desc, "Frame_1_VerticalScroll")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_DragonPalace_Match_All:validate()
  PaGlobal_DragonPalace_Match_All:registEventHandler(self._isConsole)
  PaGlobal_DragonPalace_Match_All:swichPlatform(self._isConsole)
  PaGlobal_DragonPalace_Match_All._initialize = true
end
function PaGlobal_DragonPalace_Match_All:registEventHandler(isConsole)
  registerEvent("onScreenResize", "PaGlobalFunc_DragonPalace_Match_All_OnScreenResize")
  self._ui.btn_join:addInputEvent("Mouse_LUp", "PaGlobalFunc_DragonPalace_Join()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_DragonPalace_Match_All_Close()")
  self._ui.btn_rule:addInputEvent("Mouse_LUp", "PaGlobalFunc_DragonPalace_Rule_Open()")
  self._ui.btn_ruleClose:addInputEvent("Mouse_LUp", "PaGlobalFunc_DragonPalace_Match_All_Close()")
end
function PaGlobal_DragonPalace_Match_All:swichPlatform(isConsole)
  self._ui.btn_close:SetShow(not isConsole)
end
function PaGlobal_DragonPalace_Match_All:prepareOpen()
  PaGlobal_HorseRacing_Enter:switchMatchingUI(false)
  self._ui.frame_content:SetSize(self._ui.frame_content:GetSizeX(), self._ui.stc_txt:GetTextSizeY() + 20)
  local frameVScroll = self._ui.frame_desc:GetVScroll()
  if frameVScroll ~= nil then
    frameVScroll:SetControlPos(0)
    self._ui.frame_desc:UpdateContentPos()
  end
  PaGlobal_DragonPalace_Match_All:open()
  ToClient_requestInstanceFieldRoomList(true, __eInstanceContentsType_MiniGame)
  PaGlobalFunc_DragonPalace_Match_All_OnScreenResize()
end
function PaGlobal_DragonPalace_Match_All:open()
  if nil == Panel_DragonPalace_Match_All then
    return
  end
  Panel_DragonPalace_Match_All:SetShow(true)
end
function PaGlobal_DragonPalace_Match_All:prepareClose()
  if nil == Panel_DragonPalace_Match_All then
    return
  end
  PaGlobal_DragonPalace_Match_All:close()
end
function PaGlobal_DragonPalace_Match_All:close()
  if nil == Panel_DragonPalace_Match_All then
    return
  end
  Panel_DragonPalace_Match_All:SetShow(false)
end
function PaGlobal_DragonPalace_Match_All:validate()
  if nil == Panel_DragonPalace_Match_All then
    return
  end
  self._ui.btn_join:isValidate()
  self._ui.btn_close:isValidate()
end
function PaGlobalFunc_DragonPalace_Match_All_Open()
  if true == Panel_DragonPalace_Match_All:GetShow() then
    return
  end
  PaGlobal_DragonPalace_Match_All:prepareOpen()
end
function PaGlobalFunc_DragonPalace_Match_All_OnScreenResize()
  if nil == Panel_DragonPalace_Match_All then
    return
  end
  Panel_DragonPalace_Match_All:ComputePos()
end
function PaGlobalFunc_DragonPalace_Match_All_Close()
  if false == Panel_DragonPalace_Match_All:GetShow() then
    return
  end
  if PaGlobal_DragonPalace_Match_All._ui.stc_rule:GetShow() == true then
    PaGlobal_DragonPalace_Match_All._ui.stc_rule:SetShow(false)
    return
  end
  PaGlobal_DragonPalace_Match_All:prepareClose()
end
function PaGlobalFunc_DragonPalace_Join()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == selfPlayer:isInstancePlayer() then
    return
  end
  if true == selfPlayer:get():hasParty() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BATTLEROYAL_ROOM_PARTY_NOT_IN"))
    return
  end
  local playerWrapper = getSelfPlayer()
  if nil == playerWrapper then
    return
  end
  local player = playerWrapper:get()
  local hp = player:getHp()
  local maxHp = player:getMaxHp()
  if player:doRideMyVehicle() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_NOT_RIDEHORSE"))
    return
  elseif ToClient_IsMyselfInArena() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCompetitionAlreadyIn"))
    return
  end
  if false == IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_ENTER"))
    return
  end
  if hp == maxHp then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_WAIT_PROCESS"))
    local mapKey = ToClient_GetInstanceFieldMapKeyInfoByTypeAndIndex(__eInstanceContentsType_MiniGame, __eMiniGame_Normal, 0)
    ToClient_requestJoinMatching(__eMatchMode_Normal, __eInstanceContentsType_MiniGame, __eMiniGame_Normal, mapKey, 0)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_MAXHP_CHECK"))
  end
end
function PaGlobalFunc_DragonPalace_Rule_Open()
  if nil == Panel_DragonPalace_Match_All then
    return
  end
  PaGlobal_DragonPalace_Match_All._ui.stc_rule:SetShow(true)
end
