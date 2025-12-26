function PaGlobal_RecoveryElephant:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:initializeControl()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_RecoveryElephant:initializeControl()
  if Panel_RecoveryElephant == nil then
    return
  end
  local titleArea = UI.getChildControl(Panel_RecoveryElephant, "Static_TitleBar")
  local closeButton = UI.getChildControl(titleArea, "Button_Win_Close")
  if self._isConsole == true then
    closeButton:SetShow(false)
  else
    closeButton:SetShow(true)
    closeButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_RecoveryElephant_Close()")
  end
  self._ui._stc_servantCountText = UI.getChildControl(Panel_RecoveryElephant, "StaticText_ServantListValue")
  self._ui._stc_noServant = UI.getChildControl(Panel_RecoveryElephant, "StaticText_NoServant")
  self._ui._lst_servantList = UI.getChildControl(Panel_RecoveryElephant, "List2_Servant")
  self._ui._lst_servantList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_RecoveryElephant_OnCreateListContent")
  self._ui._lst_servantList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._stc_consoleKeyguidArea = UI.getChildControl(Panel_RecoveryElephant, "Static_BottomBg_ConsoleUI")
  if self._isConsole == true then
    self._ui._stc_consoleKeyguidArea:SetShow(true)
    local keyGuideList = Array.new()
    local keyGuide_A = UI.getChildControl(self._ui._stc_consoleKeyguidArea, "StaticText_A_ConsoleUI")
    local keyGuide_B = UI.getChildControl(self._ui._stc_consoleKeyguidArea, "StaticText_B_ConsoleUI")
    keyGuideList:push_back(keyGuide_A)
    keyGuideList:push_back(keyGuide_B)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_consoleKeyguidArea, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
  else
    self._ui._stc_consoleKeyguidArea:SetShow(false)
  end
end
function PaGlobal_RecoveryElephant:registEventHandler()
  if Panel_RecoveryElephant == nil then
    return
  end
  registerEvent("FromClient_ClearGuildServantDeadCount", "FromClient_RecoveryElephant_Update")
end
function PaGlobal_RecoveryElephant:prepareOpen()
  if Panel_RecoveryElephant == nil then
    return
  end
  self:updateList()
  self:recalcPanelPosition()
  self:open()
end
function PaGlobal_RecoveryElephant:recalcPanelPosition()
  local panel = Panel_RecoveryElephant
  if panel == nil then
    return
  end
  local screenCenterX = getScreenSizeX() / 3
  local screenCenterY = getScreenSizeY() / 3
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  if self._isConsole == true then
    panelSizeY = panelSizeY + self._ui._stc_consoleKeyguidArea:GetSizeY()
  end
  local calcPosX = screenCenterX - panelSizeX / 2
  local calcPosY = screenCenterY - panelSizeY / 2
  if calcPosX < 0 then
    calcPosX = 0
  end
  if calcPosY < 0 then
    calcPosY = 0
  end
  panel:SetPosX(calcPosX)
  panel:SetPosY(calcPosY)
end
function PaGlobal_RecoveryElephant:open()
  if Panel_RecoveryElephant == nil then
    return
  end
  Panel_RecoveryElephant:SetShow(true)
end
function PaGlobal_RecoveryElephant:prepareClose()
  if Panel_RecoveryElephant == nil then
    return
  end
  self:close()
end
function PaGlobal_RecoveryElephant:close()
  if Panel_RecoveryElephant == nil then
    return
  end
  Panel_RecoveryElephant:SetShow(false)
end
function PaGlobal_RecoveryElephant:validate()
  if Panel_RecoveryElephant == nil then
    return
  end
  self._ui._stc_servantCountText:isValidate()
  self._ui._lst_servantList:isValidate()
  self._ui._stc_consoleKeyguidArea:isValidate()
  self._ui._stc_noServant:isValidate()
end
function PaGlobal_RecoveryElephant:updateList()
  if Panel_RecoveryElephant == nil then
    return
  end
  local listManager = self._ui._lst_servantList:getElementManager()
  if listManager == nil then
    return
  end
  self._ui._stc_servantCountText:SetShow(false)
  self._ui._stc_noServant:SetShow(true)
  local myGuildWrapper = ToClient_GetMyGuildInfoWrapper()
  if myGuildWrapper == nil then
    return
  end
  local myGuildElephantCount = guildStable_getServantCount(__eVehicleType_Elephant)
  self._ui._stc_servantCountText:SetShow(true)
  self._ui._stc_servantCountText:SetText(tostring(myGuildElephantCount) .. "/" .. tostring(guildStable_maxSlotCount()))
  listManager:clearKey()
  if myGuildElephantCount ~= 0 then
    self._ui._stc_noServant:SetShow(false)
    for index = 0, myGuildElephantCount - 1 do
      listManager:pushKey(toInt64(0, index))
    end
  end
end
function PaGlobal_RecoveryElephant:createListContent(content, key)
  if Panel_RecoveryElephant == nil or content == nil or key == nil then
    return
  end
  local index = Int64toInt32(key)
  local btn = UI.getChildControl(content, "Button_List")
  local image = UI.getChildControl(content, "Static_Image")
  local name = UI.getChildControl(content, "StaticText_ServantName")
  local locate = UI.getChildControl(content, "StaticText_Locate")
  local state = UI.getChildControl(content, "StaticText_State")
  local servantInfo = guildStable_getServantByIndex(__eVehicleType_Elephant, index)
  if servantInfo == nil then
    return
  end
  local servantRegionName = servantInfo:getRegionName()
  if servantRegionName == nil then
    servantRegionName = ""
  end
  image:ChangeTextureInfoNameAsync(servantInfo:getIconPath1())
  name:SetText(servantInfo:getName())
  locate:SetText(servantRegionName)
  state:SetText("")
  local deadCount = servantInfo:getDeadCount()
  if deadCount > 0 then
    state:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_LIST_TXT_HURT"))
    state:SetFontColor(Defines.Color.C_FFD05D48)
    btn:SetIgnore(false)
    btn:SetMonoTone(false, false)
    btn:addInputEvent("Mouse_LUp", "HandleEventLUp_RecoveryElephant_ServantListButton(" .. tostring(index) .. ")")
  else
    btn:SetIgnore(true)
    btn:SetMonoTone(true, true)
    btn:addInputEvent("Mouse_LUp", "")
  end
end
