function PaGlobal_ServantFantasySkin:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:initializeControl()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ServantFantasySkin:initializeControl()
  if Panel_Dialog_ServantFantasySkin == nil then
    return
  end
  local stc_titleBg = UI.getChildControl(Panel_Dialog_ServantFantasySkin, "Static_TitleArea")
  self._ui.btn_close = UI.getChildControl(stc_titleBg, "Button_Close")
  local stc_mainBg = UI.getChildControl(Panel_Dialog_ServantFantasySkin, "Static_MainBG")
  local stc_leftBg = UI.getChildControl(stc_mainBg, "Static_Default")
  local stc_rightBg = UI.getChildControl(stc_mainBg, "Static_Change")
  self._ui.stc_textureSlotLeft = UI.getChildControl(stc_leftBg, "Static_Slot")
  self._ui.stc_textureBgLeft = UI.getChildControl(stc_leftBg, "Static_SelectBG")
  self._ui.stc_textBgLeft = UI.getChildControl(stc_leftBg, "Static_SelectTextBG")
  self._ui.stc_selectLeft = UI.getChildControl(stc_leftBg, "Static_Select")
  local stc_leftText = UI.getChildControl(stc_leftBg, "StaticText_Default")
  local stc_leftMouseIcon = UI.getChildControl(stc_leftBg, "Static_Click")
  self._ui.stc_textureSlotRight = UI.getChildControl(stc_rightBg, "Static_Slot")
  self._ui.stc_textureBgRight = UI.getChildControl(stc_rightBg, "Static_SelectBG")
  self._ui.stc_textBgRight = UI.getChildControl(stc_rightBg, "Static_SelectTextBG")
  self._ui.stc_selectRight = UI.getChildControl(stc_rightBg, "Static_Select")
  local stc_rightText = UI.getChildControl(stc_rightBg, "StaticText_Change")
  local stc_rightMouseIcon = UI.getChildControl(stc_rightBg, "Static_Click")
  self._ui.btn_confirm = UI.getChildControl(Panel_Dialog_ServantFantasySkin, "Button_Confirm")
  local stc_keyGuideBg = UI.getChildControl(Panel_Dialog_ServantFantasySkin, "Static_KeyGuideArea")
  local keyGuide_Y = UI.getChildControl(stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  local keyGuide_B = UI.getChildControl(stc_keyGuideBg, "StaticText_B_ConsoleUI")
  self._ui.btn_close:SetShow(not self._isConsole)
  self._ui.btn_confirm:SetShow(not self._isConsole)
  stc_keyGuideBg:SetShow(self._isConsole)
  keyGuide_Y:SetShow(self._isConsole)
  keyGuide_B:SetShow(self._isConsole)
  if self._isConsole == true then
    local keyGuideList = Array.new()
    keyGuideList:push_back(keyGuide_Y)
    keyGuideList:push_back(keyGuide_B)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
    stc_keyGuideBg:SetSpanSize(0, 0)
    stc_keyGuideBg:SetPosY(0)
    stc_keyGuideBg:ComputePos()
  end
  stc_leftText:SetSize(stc_leftText:GetTextSizeX(), stc_leftText:GetSizeY())
  local leftButtonSizeX = self._ui.stc_textureSlotLeft:GetSizeX()
  local leftButtonPosX = self._ui.stc_textureSlotLeft:GetPosX()
  stc_leftMouseIcon:SetShow(not self._isConsole)
  if self._isConsole == true then
    local leftBeginPosX = (leftButtonPosX + leftButtonSizeX - stc_leftText:GetSizeX()) / 2
    stc_leftText:SetPosX(leftBeginPosX)
    stc_leftText:SetPosY(self._ui.stc_textureSlotLeft:GetPosY() + self._ui.stc_textureSlotLeft:GetSizeY() + 15)
  else
    local leftBeginPosX = (leftButtonPosX + leftButtonSizeX - (stc_leftText:GetSizeX() + stc_leftMouseIcon:GetSizeX())) / 2 - 5
    stc_leftMouseIcon:SetPosX(leftBeginPosX - 5)
    stc_leftMouseIcon:SetPosY(self._ui.stc_textureSlotLeft:GetPosY() + self._ui.stc_textureSlotLeft:GetSizeY() + 10)
    stc_leftText:SetPosX(leftBeginPosX + stc_leftMouseIcon:GetSizeX())
    stc_leftText:SetPosY(stc_leftMouseIcon:GetPosY() + (stc_leftMouseIcon:GetSizeY() - stc_leftText:GetSizeY()) / 2)
  end
  stc_rightText:SetSize(stc_rightText:GetTextSizeX(), stc_rightText:GetSizeY())
  local rightButtonSizeX = self._ui.stc_textureSlotRight:GetSizeX()
  local rightButtonPosX = self._ui.stc_textureSlotRight:GetPosX()
  stc_rightMouseIcon:SetShow(not self._isConsole)
  if self._isConsole == true then
    local rightBeginPosX = (rightButtonPosX + rightButtonSizeX - stc_rightText:GetSizeX()) / 2
    stc_rightText:SetPosX(rightBeginPosX)
    stc_rightText:SetPosY(self._ui.stc_textureSlotRight:GetPosY() + self._ui.stc_textureSlotRight:GetSizeY() + 15)
  else
    local rightBeginPosX = (rightButtonPosX + rightButtonSizeX - (stc_rightText:GetSizeX() + stc_rightMouseIcon:GetSizeX())) / 2 - 5
    stc_rightMouseIcon:SetPosX(rightBeginPosX)
    stc_rightMouseIcon:SetPosY(self._ui.stc_textureSlotRight:GetPosY() + self._ui.stc_textureSlotRight:GetSizeY() + 10)
    stc_rightText:SetPosX(rightBeginPosX + stc_rightMouseIcon:GetSizeX())
    stc_rightText:SetPosY(stc_rightMouseIcon:GetPosY() + (stc_rightMouseIcon:GetSizeY() - stc_rightText:GetSizeY()) / 2)
  end
end
function PaGlobal_ServantFantasySkin:registEventHandler()
  if Panel_Dialog_ServantFantasySkin == nil then
    return
  end
  if self._isConsole == true then
    Panel_Dialog_ServantFantasySkin:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ServantFantasySkin_DoChange()")
    Panel_Dialog_ServantFantasySkin:ignorePadSnapMoveToOtherPanel()
  else
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFantasySkin_Close()")
    self._ui.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantFantasySkin_DoChange()")
  end
  self._ui.stc_textureSlotLeft:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantFantasySkin_SetModelForm_Original()")
  self._ui.stc_textureSlotRight:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantFantasySkin_SetModelForm_New()")
  registerEvent("FromClient_FantasyServantChangeForm", "FromClient_ServantFantasySkin_SuccessChangeForm")
end
function PaGlobal_ServantFantasySkin:prepareOpen()
  if Panel_Dialog_ServantFantasySkin == nil then
    return
  end
  if self._currentServantNo == nil then
    return
  end
  self._currentServantCharacterKeyRaw = nil
  self._changeTargetFormIndexRaw = nil
  self._beforeSceneIndex = -1
  self:changeClickControl(0)
  self:updateTextureSlot()
  self:recalcPanelPosition()
  self:open()
end
function PaGlobal_ServantFantasySkin:recalcPanelPosition()
  local panel = Panel_Dialog_ServantFantasySkin
  if panel == nil then
    return
  end
  local calcPosX = getScreenSizeX() - panel:GetSizeX() - 100
  local calcPosY = getScreenSizeY() / 2 - panel:GetSizeY() / 2
  if calcPosX < 0 then
    calcPosX = 0
  end
  if calcPosY < 0 then
    calcPosY = 0
  end
  panel:SetPosX(calcPosX)
  panel:SetPosY(calcPosY)
end
function PaGlobal_ServantFantasySkin:open()
  if Panel_Dialog_ServantFantasySkin == nil then
    return
  end
  Panel_Dialog_ServantFantasySkin:SetShow(true)
end
function PaGlobal_ServantFantasySkin:prepareClose()
  if Panel_Dialog_ServantFantasySkin == nil then
    return
  end
  if 0 < self._currentSelectedButtonIndex then
    HandleEventLUp_ServantFantasySkin_SetModelForm_Original()
  end
  self:close()
end
function PaGlobal_ServantFantasySkin:close()
  if Panel_Dialog_ServantFantasySkin == nil then
    return
  end
  Panel_Dialog_ServantFantasySkin:SetShow(false)
end
function PaGlobal_ServantFantasySkin:validate()
  if Panel_Dialog_ServantFantasySkin == nil then
    return
  end
  self._ui.btn_close:isValidate()
  self._ui.stc_textureSlotLeft:isValidate()
  self._ui.stc_textureBgLeft:isValidate()
  self._ui.stc_textBgLeft:isValidate()
  self._ui.stc_selectLeft:isValidate()
  self._ui.stc_textureSlotRight:isValidate()
  self._ui.stc_textureBgRight:isValidate()
  self._ui.stc_textBgRight:isValidate()
  self._ui.stc_selectRight:isValidate()
  self._ui.btn_confirm:isValidate()
end
function PaGlobal_ServantFantasySkin:changeClickControl(buttonIndex)
  if Panel_Dialog_ServantFantasySkin == nil then
    return
  end
  if buttonIndex ~= 0 and buttonIndex ~= 1 then
    UI.ASSERT_NAME(false, "\235\178\132\237\138\188\236\157\152 \236\157\184\235\141\177\236\138\164\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  if self._currentSelectedButtonIndex == buttonIndex then
    return
  end
  if buttonIndex == 0 then
    self._ui.stc_textureBgLeft:SetShow(true)
    self._ui.stc_textBgLeft:SetShow(true)
    self._ui.stc_selectLeft:SetShow(true)
    self._ui.stc_textureBgRight:SetShow(false)
    self._ui.stc_textBgRight:SetShow(false)
    self._ui.stc_selectRight:SetShow(false)
  else
    self._ui.stc_textureBgLeft:SetShow(false)
    self._ui.stc_textBgLeft:SetShow(false)
    self._ui.stc_selectLeft:SetShow(false)
    self._ui.stc_textureBgRight:SetShow(true)
    self._ui.stc_textBgRight:SetShow(true)
    self._ui.stc_selectRight:SetShow(true)
  end
  self._currentSelectedButtonIndex = buttonIndex
end
function PaGlobal_ServantFantasySkin:updateTextureSlot()
  if Panel_Dialog_ServantFantasySkin == nil then
    return
  end
  if self._currentServantNo == nil then
    return
  end
  if PaGlobalFunc_ServantFunction_All_Get_NpcType() ~= 0 then
    UI.ASSERT_NAME(false, "\235\167\136\234\181\191\234\176\132\236\157\180 \236\149\132\235\139\140\235\141\176 \237\153\152\236\131\129\235\167\136\236\157\152 \236\153\184\237\152\149 \235\179\128\234\178\189\236\157\132 \237\149\160 \236\136\152\235\138\148 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local servantInfo = stable_getServant(self._currentServantNo)
  if servantInfo == nil then
    UI.ASSERT_NAME(false, "\236\132\160\237\131\157\237\149\156 \237\153\152\236\131\129\235\167\136 \236\160\149\235\179\180\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self._ui.stc_textureSlotLeft:ChangeTextureInfoNameAsync(servantInfo:getIconPath1())
  local formManager = getServantFormManager()
  if formManager == nil then
    return
  end
  local isRollBackFormIndex = false
  local currentServantFormIndexRaw = servantInfo:getFormIndexRaw()
  local currentServantDefaultFormIndexRaw = servantInfo:getDefaultFormIndexRaw()
  if currentServantFormIndexRaw == 0 then
    isRollBackFormIndex = false
  elseif currentServantFormIndexRaw == currentServantDefaultFormIndexRaw then
    isRollBackFormIndex = false
  else
    isRollBackFormIndex = true
  end
  local changableFormSSW
  if isRollBackFormIndex == true then
    changableFormSSW = formManager:getFormByFormIndexRaw(currentServantDefaultFormIndexRaw)
    if changableFormSSW == nil then
      return
    end
    self._changeTargetFormIndexRaw = 0
  else
    local currentServantCharacterKey = servantInfo:getCharacterKey()
    local changableFormCount = formManager:getFormCountByCharacterKey(currentServantCharacterKey)
    if changableFormCount == 0 or changableFormCount == nil then
      UI.ASSERT_NAME(false, "\237\152\132\236\158\172 \236\132\160\237\131\157\237\149\156 \237\153\152\236\131\129\235\167\136\236\157\152 \235\179\128\234\178\189 \234\176\128\235\138\165\237\149\156 \236\153\184\237\152\149 \236\160\149\235\179\180\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    changableFormSSW = formManager:getFormByCharacterKey(currentServantCharacterKey, 0)
    if changableFormSSW == nil then
      return
    end
    self._changeTargetFormIndexRaw = changableFormSSW:getIndexRaw()
  end
  self._currentServantCharacterKeyRaw = servantInfo:getCharacterKeyRaw()
  self._ui.stc_textureSlotRight:ChangeTextureInfoNameAsync(changableFormSSW:getIcon1())
  return
end
function PaGlobal_ServantFantasySkin:setServantModelForm_new(doForce)
  if Panel_Dialog_ServantFantasySkin == nil then
    return
  end
  if self._currentServantNo == nil then
    UI.ASSERT_NAME(false, "\237\152\132\236\158\172 \236\132\160\237\131\157\235\144\156 \237\131\145\236\138\185\235\172\188\236\157\152 ServantNo\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  if PaGlobalFunc_ServantFunction_All_Get_NpcType() ~= 0 then
    UI.ASSERT_NAME(false, "\235\167\136\234\181\191\234\176\132\236\157\180 \236\149\132\235\139\140\235\141\176 \237\153\152\236\131\129\235\167\136\236\157\152 \236\153\184\237\152\149 \235\179\128\234\178\189\236\157\132 \237\149\160 \236\136\152\235\138\148 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local servantInfo = stable_getServant(self._currentServantNo)
  if servantInfo == nil then
    UI.ASSERT_NAME(false, "\236\132\160\237\131\157\237\149\156 \237\153\152\236\131\129\235\167\136 \236\160\149\235\179\180\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local isRollBackFormIndex = false
  local currentServantFormIndexRaw = servantInfo:getFormIndexRaw()
  local currentServantDefaultFormIndexRaw = servantInfo:getDefaultFormIndexRaw()
  if currentServantFormIndexRaw == 0 then
    isRollBackFormIndex = false
  elseif currentServantFormIndexRaw == currentServantDefaultFormIndexRaw then
    isRollBackFormIndex = false
  else
    isRollBackFormIndex = true
  end
  local formManager = getServantFormManager()
  if formManager == nil then
    UI.ASSERT_NAME(false, "formManager\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local currentServantCharacterKey = servantInfo:getCharacterKey()
  local changableFormCount = formManager:getFormCountByCharacterKey(currentServantCharacterKey)
  if changableFormCount == 0 or changableFormCount == nil then
    UI.ASSERT_NAME(false, "\235\179\128\234\178\189 \234\176\128\235\138\165\237\149\156 \236\153\184\237\152\149\236\160\149\235\179\180\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local newFormSSW
  if isRollBackFormIndex == true then
    newFormSSW = formManager:getFormByFormIndexRaw(currentServantDefaultFormIndexRaw)
  else
    newFormSSW = formManager:getFormByCharacterKey(currentServantCharacterKey, 0)
  end
  if newFormSSW == nil then
    UI.ASSERT_NAME(false, "\236\152\164\235\166\172\236\167\128\235\132\144 formStaticStatusWrapper\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self:setServantModelForm(newFormSSW:getIndexRaw(), doForce)
end
function PaGlobal_ServantFantasySkin:setServantModelForm_original(doForce)
  if Panel_Dialog_ServantFantasySkin == nil then
    return
  end
  if self._currentServantNo == nil then
    UI.ASSERT_NAME(false, "\237\152\132\236\158\172 \236\132\160\237\131\157\235\144\156 \237\131\145\236\138\185\235\172\188\236\157\152 ServantNo\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  if PaGlobalFunc_ServantFunction_All_Get_NpcType() ~= 0 then
    UI.ASSERT_NAME(false, "\235\167\136\234\181\191\234\176\132\236\157\180 \236\149\132\235\139\140\235\141\176 \237\153\152\236\131\129\235\167\136\236\157\152 \236\153\184\237\152\149 \235\179\128\234\178\189\236\157\132 \237\149\160 \236\136\152\235\138\148 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local servantInfo = stable_getServant(self._currentServantNo)
  if servantInfo == nil then
    UI.ASSERT_NAME(false, "\236\132\160\237\131\157\237\149\156 \237\153\152\236\131\129\235\167\136 \236\160\149\235\179\180\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local formManager = getServantFormManager()
  if formManager == nil then
    UI.ASSERT_NAME(false, "formManager\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local currentServantFormIndexRaw = servantInfo:getFormIndexRaw()
  local originalFormSSW
  if currentServantFormIndexRaw == 0 then
    originalFormSSW = formManager:getFormByFormIndexRaw(servantInfo:getDefaultFormIndexRaw())
  else
    originalFormSSW = formManager:getFormByFormIndexRaw(currentServantFormIndexRaw)
  end
  if originalFormSSW == nil then
    UI.ASSERT_NAME(false, "\236\152\164\235\166\172\236\167\128\235\132\144 formStaticStatusWrapper\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self:setServantModelForm(originalFormSSW:getIndexRaw(), doForce)
end
function PaGlobal_ServantFantasySkin:setServantModelForm(newFormIndexRaw, doForce)
  if Panel_Dialog_ServantFantasySkin == nil or newFormIndexRaw == nil then
    return
  end
  if self._currentServantNo == nil then
    UI.ASSERT_NAME(false, "\237\152\132\236\158\172 \236\132\160\237\131\157\235\144\156 \237\131\145\236\138\185\235\172\188\236\157\152 ServantNo\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  if PaGlobalFunc_ServantFunction_All_Get_NpcType() ~= 0 then
    UI.ASSERT_NAME(false, "\235\167\136\234\181\191\234\176\132\236\157\180 \236\149\132\235\139\140\235\141\176 \237\153\152\236\131\129\235\167\136\236\157\152 \236\153\184\237\152\149 \235\179\128\234\178\189\236\157\132 \237\149\160 \236\136\152\235\138\148 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local servantInfo = stable_getServant(self._currentServantNo)
  if servantInfo == nil then
    UI.ASSERT_NAME(false, "\236\132\160\237\131\157\237\149\156 \237\153\152\236\131\129\235\167\136 \236\160\149\235\179\180\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local formManager = getServantFormManager()
  if formManager == nil then
    UI.ASSERT_NAME(false, "formManager\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local formSSW
  if newFormIndexRaw == 0 then
    formSSW = formManager:getFormByFormIndexRaw(servantInfo:getDefaultFormIndexRaw())
  else
    formSSW = formManager:getFormByFormIndexRaw(newFormIndexRaw)
  end
  if formSSW == nil then
    UI.ASSERT_NAME(false, "FormIndex\236\151\144 \237\149\180\235\139\185\237\149\152\235\138\148 formStaticStatusWrapper\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local selectedSceneIndex
  if Panel_Dialog_ServantList_All ~= nil then
    selectedSceneIndex = PaGlobalFunc_ServantList_All_GetSceneIndex()
  end
  if selectedSceneIndex == nil then
    UI.ASSERT_NAME(false, "\237\152\132\236\158\172 \236\132\160\237\131\157\235\144\156 SceneIndex\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local newActionIndex = formSSW:getActionIndex()
  if (doForce == nil or doForce == false) and PaGlobal_ServantLookChange_All._beforeSceneIndex == newActionIndex then
    return
  end
  PaGlobalFunc_ServantFunction_All_Servant_ScenePopObject(selectedSceneIndex)
  if PaGlobal_ServantLookChange_All._beforeSceneIndex ~= -1 then
    showSceneCharacter(selectedSceneIndex, false)
  end
  showSceneCharacter(selectedSceneIndex, true, newActionIndex)
  PaGlobal_ServantLookChange_All._beforeSceneIndex = newActionIndex
end
