function PaGlobal_CutSceneSkip:initialize()
  self._renderMode = RenderModeWrapper.new(100, {
    Defines.RenderMode.eRenderMode_GroupCamera
  }, false)
  self._renderMode:setClosefunctor(self._renderMode, PaGlobalFunc_CutSceneSkip_Awake)
  self._ui._stc_icon = UI.getChildControl(self._ui._stc_territoryArea, "Static_TerritoryIcon")
  self._ui._txt_mainDesc = UI.getChildControl(self._ui._stc_textArea, "MultilineText_1")
  self:validate()
  self:registerEvent()
  self:resizePanel()
  Panel_Window_CutSceneSkip:SetFadeOverRender()
  local isPadMode = _ContentsGroup_UsePadSnapping
  if isPadMode == false then
    self._ui._btn_skip:SetText(self._ui._btn_skip:GetText() .. "(" .. PAGetString(Defines.StringSheet_GAME, "InputCustomizer_Enter") .. ")")
  end
  self._initialize = true
end
function PaGlobal_CutSceneSkip:prepareOpen()
  if nil == Panel_Window_CutSceneSkip then
    return
  end
  if false == self._initialize then
    return
  end
  if false == ToClient_IsEnterSequence() then
    return
  end
  if ToClient_IsOnlyPartyLeaderSkip() == true then
    local isPartyLeader = RequestParty_isLeader()
    if isPartyLeader == false then
      return
    end
  end
  local skipWrapper = ToClient_sequenceSkipWrapper()
  if nil == skipWrapper then
    local isForceSkip = ToClient_isForceSequenceSkip()
    if isForceSkip == true then
      self._ui._txt_title:SetText("titleString(DEV)")
      self._ui._txt_mainDesc:SetText("mainString(DEV)")
      self._ui._txt_subDesc:SetText("subString(DEV)")
      self._renderMode:set()
      self:open()
    end
    return
  end
  local txt_title = skipWrapper:getTitle()
  local txt_mainDesc = skipWrapper:getMainDescription()
  local txt_subDesc = skipWrapper:getSubDescription()
  local iconPath = skipWrapper:getIconPath()
  self._ui._stc_icon:ChangeTextureInfoNameAsync(iconPath)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_icon, 0, 0, 60, 60)
  self._ui._stc_icon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._stc_icon:setRenderTexture(self._ui._stc_icon:getBaseTexture())
  self._ui._txt_title:SetText(txt_title)
  self._ui._txt_mainDesc:SetText(txt_mainDesc)
  self._ui._txt_subDesc:SetText(txt_subDesc)
  self._renderMode:set()
  self:open()
end
function PaGlobal_CutSceneSkip:open()
  if nil == Panel_Window_CutSceneSkip then
    return
  end
  Panel_Window_CutSceneSkip:SetShow(true)
end
function PaGlobal_CutSceneSkip:prepareClose()
  if nil == Panel_Window_CutSceneSkip then
    return
  end
  self._renderMode:reset()
  self:close()
end
function PaGlobal_CutSceneSkip:close()
  if false == Panel_Window_CutSceneSkip:GetShow() then
    return
  end
  Panel_Window_CutSceneSkip:SetShow(false)
end
function PaGlobal_CutSceneSkip:validate()
  self._ui._stc_territoryArea:isValidate()
  self._ui._stc_icon:isValidate()
  self._ui._txt_title:isValidate()
  self._ui._stc_textArea:isValidate()
  self._ui._txt_subDesc:isValidate()
  self._ui._txt_mainDesc:isValidate()
  self._ui._btn_skip:isValidate()
  self._ui._btn_close:isValidate()
end
function PaGlobal_CutSceneSkip:registerEvent()
  self._ui._btn_skip:addInputEvent("Mouse_LUp", "PaGlobal_CutSceneSkip:doSkip()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_CutSceneSkip:doCancel()")
  registerEvent("FromClient_stopCutSceneCamera", "FromClient_stopCutSceneCamera")
  registerEvent("FromClient_CutsceneKeyGuideShow", "FromClient_CutSceneSkip_CutsceneKeyGuideShow")
end
function PaGlobal_CutSceneSkip:doSkip()
  if ToClient_IsOnlyPartyLeaderSkip() == true then
    ToClient_CutscenePartyLeaderStop()
    return
  end
  if false == ToClient_IsEnterSequence() then
    ToClient_stopCutSceneCamera()
  else
    ToClient_CutsceneStop()
  end
end
function PaGlobal_CutSceneSkip:doCancel()
  if false == ToClient_IsEnterSequence() then
    if true == ToClient_isPlayingGroupCamera() then
      PaGlobal_CutSceneScript:keyPressReset()
    end
  else
    PaGlobal_CutSceneScript:keyPressReset()
  end
  PaGlobal_CutSceneSkip:prepareClose()
end
function PaGlobal_CutSceneSkip:resizePanel()
  Panel_Window_CutSceneSkip:SetSize(getScreenSizeX(), Panel_Window_CutSceneSkip:GetSizeY())
  Panel_Window_CutSceneSkip:ComputePosAllChild()
end
