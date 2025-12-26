local isBossRange = false
local btn_bossCamera, chk_SetHide, _UseOtherPlayerUpdate
local _isShortcutEventCheck = false
local _bossKey = {
  kuAng = 23001,
  kaAng = 23060,
  NuAng = 23032,
  DumChit = 23073,
  Muraka = 23158,
  Quint = 23157,
  Opin = 23810,
  Gamos = 23120,
  Gamos_quest = 23552,
  MorningLand_Boss = 21357
}
local _bossCharacterWrapper
local function clear_BossCamButton()
  isBossRange = false
  btn_bossCamera:SetShow(false)
  btn_bossCamera:SetCheck(false)
  chk_SetHide:SetShow(false)
  chk_SetHide:SetCheck(false)
  sttic_sequenceAni:SetShow(false)
  stc_SequenceAni2:SetShow(false)
  ToClient_onBossCamera(false)
end
function click_button()
  if false == isBossRange then
    clear_BossCamButton()
    return
  end
  if true == btn_bossCamera:IsCheck() then
  else
    chk = ToClient_onBossCamera(false)
  end
  sttic_sequenceAni:SetShow(btn_bossCamera:IsCheck())
  if nil == _bossCharacterWrapper then
    return
  end
  local characterKey = _bossCharacterWrapper:getCharacterKeyRaw()
  local activeViewDistance, viewDistance, minDistance, maxDistance, viewBoundaryDistacne, viewInterPlationTime, mouse_wheel_sensitivity
  if _bossKey.kaAng == characterKey then
    activeViewDistance = 450
    viewDistance = 300
    minDistance = 100
    maxDistance = 700
    viewBoundaryDistacne = 100
    viewInterPlationTime = 3
    mouse_wheel_sensitivity = 0.08
  elseif _bossKey.Gamos == characterKey or _bossKey.Gamos_quest == characterKey then
    activeViewDistance = 1500
    viewDistance = 1000
    minDistance = 100
    maxDistance = 1500
    viewBoundaryDistacne = 500
    viewInterPlationTime = 5
    mouse_wheel_sensitivity = 0.08
  elseif _bossKey.MorningLand_Boss == characterKey then
    activeViewDistance = 1500
    viewDistance = 1000
    minDistance = 100
    maxDistance = 1500
    viewBoundaryDistacne = 500
    viewInterPlationTime = 5
    mouse_wheel_sensitivity = 0.08
  else
    activeViewDistance = 700
    viewDistance = 450
    minDistance = 100
    maxDistance = 1000
    viewBoundaryDistacne = 100
    viewInterPlationTime = 3
    mouse_wheel_sensitivity = 0.08
  end
  local chk = ToClient_onBossCamera(btn_bossCamera:IsCheck(), activeViewDistance, viewDistance, minDistance, maxDistance, viewBoundaryDistacne, viewInterPlationTime, mouse_wheel_sensitivity)
  if false == chk then
    _PA_LOG("\234\180\145\236\154\180", "Camera \236\180\136\234\184\176\237\153\148\234\176\128 \235\144\152\236\167\128 \236\149\138\236\149\152\235\139\164...?")
    btn_bossCamera:SetCheck(false)
  end
end
function click_characterHideSet()
  if ToClient_isPlayingSequence() == true then
    return
  end
  _isShortcutEventCheck = false
  if _isShortcutEventCheck == false then
    setUseOtherPlayerUpdate(chk_SetHide:IsCheck() == false)
  end
  stc_SequenceAni2:SetShow(chk_SetHide:IsCheck() == true)
  setGameOption()
  if _UseOtherPlayerUpdate then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TOOLTIP_PLAYERHIDEOFF"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_OPTION_TOOLTIP_PLAYERHIDEON"))
  end
end
function FromClient_Event_characterHideSet(isEnable, isOption)
  if btn_bossCamera:GetShow() == false then
    return
  end
  _isShortcutEventCheck = true
  stc_SequenceAni2:SetShow(isEnable == false)
  chk_SetHide:SetCheck(isEnable == false)
end
function bossCamera_ShowTooltip(isShow, index)
  if isShow == nil then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if index == 1 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_BOSSCAMERA_TOOLTIPNAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_BOSSCAMERA_TOOLTIPDESC")
    control = btn_bossCamera
  elseif index == 2 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_COMMONGAMESCREENUI_OTHERUSERHIDE_SET_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_COMMONGAMESCREENUI_OTHERUSERHIDE_SET_DESC")
    control = chk_SetHide
  end
  TooltipSimple_Show(control, name, desc)
end
function FromClient_EventCameraCharacter_RangeIn(characterWrapper)
  local isReplayMode = ToClient_IsPlayingReplay()
  if true == isReplayMode then
    return
  end
  if nil == characterWrapper then
    _PA_LOG("\234\180\145\236\154\180", "[\235\179\180\236\138\164\236\185\180\235\169\148\235\157\188] \235\179\180\236\138\164 characterWrapper\234\176\128 nil\236\157\180\235\169\180 \236\149\136\235\144\152\235\138\148\235\141\176\236\154\169..")
    return
  end
  _bossCharacterWrapper = characterWrapper
  btn_bossCamera:SetShow(true)
  if ToClient_isPlayingSequence() == false then
    setGameOption()
    chk_SetHide:SetShow(true)
    chk_SetHide:SetCheck(not _UseOtherPlayerUpdate)
  else
    chk_SetHide:SetShow(false)
  end
  isBossRange = true
end
function FromClient_EventCameraCharacter_RangeChange()
  local isReplayMode = ToClient_IsPlayingReplay()
  if true == isReplayMode then
    return
  end
  btn_bossCamera:SetShow(true)
  if ToClient_isPlayingSequence() == false then
    setGameOption()
    chk_SetHide:SetShow(true)
    chk_SetHide:SetCheck(not _UseOtherPlayerUpdate)
  else
    chk_SetHide:SetShow(false)
  end
  PaGlobal_BossCamera_Repos()
  isBossRange = true
end
function FromClient_EventCameraCharacter_RangeOut()
  isBossRange = false
  clear_BossCamButton()
end
function FromClient_EventCameraCharacter_Dead()
  isBossRange = false
  clear_BossCamButton()
end
function PaGlobal_BossCamera_Repos()
  local radarSizeX = FGlobal_Panel_Radar_GetSizeX()
  if nil ~= btn_bossCamera then
    local keyboardGuideX = 0
    if nil ~= Panel_Widget_KeyboardGuide and Panel_Widget_KeyboardGuide:GetShow() then
      keyboardGuideX = Panel_Widget_KeyboardGuide:GetSizeX() + 15
    end
    btn_bossCamera:SetPosX(getScreenSizeX() - radarSizeX - keyboardGuideX - btn_bossCamera:GetSizeX() - 20)
    btn_bossCamera:SetPosY(Panel_Radar:GetSizeY() - btn_bossCamera:GetSizeY() + 10)
    sttic_sequenceAni:SetPosX(btn_bossCamera:GetPosX() - 5)
    sttic_sequenceAni:SetPosY(btn_bossCamera:GetPosY() - 5)
    if nil ~= PaGlobal_BetterEquipment_GetNextPosY and nil ~= Panel_Widget_BetterEquipment and true == Panel_Widget_BetterEquipment:GetShow() then
      local nextPosY = PaGlobal_BetterEquipment_GetNextPosY()
      if nextPosY > btn_bossCamera:GetPosY() then
        btn_bossCamera:SetPosY(nextPosY + 10)
        sttic_sequenceAni:SetPosY(btn_bossCamera:GetPosY() - 5)
      end
    end
    chk_SetHide:SetPosY(btn_bossCamera:GetPosY() + btn_bossCamera:GetSizeY())
    chk_SetHide:SetPosX(btn_bossCamera:GetPosX() + 8)
    stc_SequenceAni2:SetPosX(chk_SetHide:GetPosX() - 13)
    stc_SequenceAni2:SetPosY(chk_SetHide:GetPosY() - 13)
  end
end
local function initialize()
  btn_bossCamera = UI.getChildControl(Panel_CommonGameScreenUI, "CheckButton_BossCamera")
  btn_bossCamera:SetShow(false)
  btn_bossCamera:addInputEvent("Mouse_LUp", "click_button()")
  btn_bossCamera:addInputEvent("Mouse_On", "bossCamera_ShowTooltip(true, 1)")
  btn_bossCamera:addInputEvent("Mouse_Out", "bossCamera_ShowTooltip()")
  sttic_sequenceAni = UI.getChildControl(Panel_CommonGameScreenUI, "Static_SequenceAni")
  sttic_sequenceAni:SetShow(false)
  chk_SetHide = UI.getChildControl(Panel_CommonGameScreenUI, "CheckButton_VisualOtherCharacter")
  stc_SequenceAni2 = UI.getChildControl(Panel_CommonGameScreenUI, "Static_SequenceAni2")
  stc_SequenceAni2:SetShow(false)
  chk_SetHide:addInputEvent("Mouse_LUp", "click_characterHideSet()")
  chk_SetHide:addInputEvent("Mouse_On", "bossCamera_ShowTooltip(true, 2)")
  chk_SetHide:addInputEvent("Mouse_Out", "bossCamera_ShowTooltip()")
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  setGameOption()
  _isShortcutEventCheck = false
  chk_SetHide:SetCheck(not _UseOtherPlayerUpdate)
  PaGlobal_BossCamera_Repos()
  clear_BossCamButton()
end
function setGameOption()
  _UseOtherPlayerUpdate = ToClient_getGameOptionControllerWrapper():getUseOtherPlayerUpdate()
  if btn_bossCamera:GetShow() == true then
    stc_SequenceAni2:SetShow(not _UseOtherPlayerUpdate)
  end
end
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_CommonGameScreenUI")
function FromClient_luaLoadComplete_CommonGameScreenUI()
  initialize()
  Panel_CommonGameScreenUI:SetShow(true)
  btn_bossCamera:SetShow(false)
  chk_SetHide:SetShow(false)
  if false == isGameServiceTypeConsole() then
    registerEvent("FromClient_EventCameraCharacter_RangeIn", "FromClient_EventCameraCharacter_RangeIn")
    registerEvent("FromClient_EventCameraCharacter_RangeChange", "FromClient_EventCameraCharacter_RangeChange")
    registerEvent("FromClient_EventCameraCharacter_RangeOut", "FromClient_EventCameraCharacter_RangeOut")
    registerEvent("FromClient_EventCameraCharacter_Dead", "FromClient_EventCameraCharacter_Dead")
    registerEvent("FromClient_OtherPlayeUpdate", "FromClient_Event_characterHideSet")
  end
end
