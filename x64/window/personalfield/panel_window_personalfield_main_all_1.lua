function PaGlobal_PersonalField_Main_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._txt_titleArea = UI.getChildControl(Panel_Window_PersonalField_Main, "StaticText_TitleArea")
  self._ui._txt_titelIcon = UI.getChildControl(self._ui._txt_titleArea, "StaticText_TitleIcon")
  self._ui._stc_green = UI.getChildControl(self._ui._txt_titelIcon, "Static_Green")
  self._ui._stc_yellow = UI.getChildControl(self._ui._txt_titelIcon, "Static_Yellow")
  self._ui._stc_red = UI.getChildControl(self._ui._txt_titelIcon, "Static_Red")
  self._ui._btn_close = UI.getChildControl(self._ui._txt_titleArea, "Button_Win_Close")
  self._ui._stc_mainBG = UI.getChildControl(Panel_Window_PersonalField_Main, "Static_MainBG")
  self._ui._fieldList = UI.getChildControl(Panel_Window_PersonalField_Main, "List2_MonsterList")
  self._ui._stc_alertMainBG = UI.getChildControl(Panel_Window_PersonalField_Main, "Static_AlertMainBG")
  self._ui._txt_alertBG = UI.getChildControl(self._ui._stc_alertMainBG, "StaticText_Alert_BG")
  self._ui._txt_alertDesc = UI.getChildControl(self._ui._txt_alertBG, "MultilineText_Desc")
  self._ui._btn_serverSelect = UI.getChildControl(self._ui._txt_alertBG, "Button_ServerSelect")
  self._ui._stc_desc = UI.getChildControl(Panel_Window_PersonalField_Main, "Static_Desc")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_desc, "StaticText_Desc")
  local descString
  if _ContentsGroup_PersonalFieldCharge == true then
    descString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALFIELD_DESC")
  else
    descString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALFIELD_OLD_DESC")
  end
  self._ui._txt_desc:SetText(descString)
  self._ui._txt_timeTitle = UI.getChildControl(Panel_Window_PersonalField_Main, "StaticText_Time_Title")
  self._ui._txt_time = UI.getChildControl(Panel_Window_PersonalField_Main, "StaticText_Time_Value")
  self._ui._txt_serverBusy = UI.getChildControl(Panel_Window_PersonalField_Main, "StaticText_ServerBusy")
  self._ui._btn_uiOnOff = UI.getChildControl(Panel_Window_PersonalField_Main, "CheckButton_UI_OnOff")
  self._ui._rdo_shallow = UI.getChildControl(Panel_Window_PersonalField_Main, "RadioButton_Common")
  self._ui._rdo_deep = UI.getChildControl(Panel_Window_PersonalField_Main, "RadioButton_EdaniaAndAxto")
  self._ui._stc_selectLine = UI.getChildControl(Panel_Window_PersonalField_Main, "Static_SelctLine")
  self._ui._stc_keyLB = UI.getChildControl(Panel_Window_PersonalField_Main, "Static_SelectLB_C")
  self._ui._stc_keyRB = UI.getChildControl(Panel_Window_PersonalField_Main, "Static_SelectRB_C")
  self._ui._stc_keyGuide = UI.getChildControl(Panel_Window_PersonalField_Main, "Static_ConsoleKey")
  self._ui._txt_keyGuideA = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_A_ConsoleUI")
  self._ui._txt_keyGuideB = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_B_ConsoleUI")
  self._ui._txt_keyGuideX = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_X_ConsoleUI")
  self._ui._btn_serverSelectAlwaysOn = UI.getChildControl(Panel_Window_PersonalField_Main, "Button_ServerSelect")
  self._basePanelSizeY = Panel_Window_PersonalField_Main:GetSizeY()
  self._baseMainBGSizeY = self._ui._stc_mainBG:GetSizeY()
  self._baseDescBGSizeY = self._ui._stc_desc:GetSizeY()
  self._baseAlertDescSizeY = self._ui._txt_alertDesc:GetSizeY()
  self._baseAlertDescSpanY = self._ui._txt_alertDesc:GetSpanSize().y
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_PersonalField_Main_All:validate()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  self._ui._txt_titleArea:isValidate()
  self._ui._txt_titelIcon:isValidate()
  self._ui._stc_green:isValidate()
  self._ui._stc_yellow:isValidate()
  self._ui._stc_red:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._stc_mainBG:isValidate()
  self._ui._fieldList:isValidate()
  self._ui._stc_alertMainBG:isValidate()
  self._ui._txt_alertBG:isValidate()
  self._ui._txt_alertDesc:isValidate()
  self._ui._btn_serverSelect:isValidate()
  self._ui._stc_desc:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._txt_timeTitle:isValidate()
  self._ui._txt_time:isValidate()
  self._ui._txt_serverBusy:isValidate()
  self._ui._btn_uiOnOff:isValidate()
  self._ui._rdo_shallow:isValidate()
  self._ui._rdo_deep:isValidate()
  self._ui._stc_selectLine:isValidate()
  self._ui._stc_keyLB:isValidate()
  self._ui._stc_keyRB:isValidate()
  self._ui._stc_keyGuide:isValidate()
  self._ui._txt_keyGuideA:isValidate()
  self._ui._txt_keyGuideB:isValidate()
  self._ui._txt_keyGuideX:isValidate()
  self._ui._btn_serverSelectAlwaysOn:isValidate()
end
function PaGlobal_PersonalField_Main_All:registEventHandler()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  registerEvent("onScreenResize", "FromClient_PersonalField_Main_All_ResizePanel")
  registerEvent("FromClient_UpdatePersonalFieldRemainTime", "FromClient_PersonalField_Main_All_UpdateRemainTime")
  registerEvent("FromClient_UpdatePersonalFieldServerState", "FromClient_PersonalField_Main_All_UpdateServerState")
  self._ui._fieldList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_PersonalField_Main_All_ListControlCreate")
  self._ui._fieldList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_uiOnOff:addInputEvent("Mouse_LUp", "HandleEventLUp_PersonalField_Main_All_ToggleWidget()")
  self._ui._txt_titelIcon:addInputEvent("Mouse_On", "HandleEventOnOut_PersonalField_Main_All_SetShowStateTooltip(true)")
  self._ui._txt_titelIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_PersonalField_Main_All_SetShowStateTooltip(false)")
  self._ui._btn_serverSelect:addInputEvent("Mouse_LUp", "HandlePadEventLUp_PersonalField_Main_All_OpenChannelSelect()")
  self._ui._btn_serverSelectAlwaysOn:addInputEvent("Mouse_LUp", "HandlePadEventLUp_PersonalField_Main_All_OpenChannelSelect()")
  self._ui._rdo_shallow:addInputEvent("Mouse_LUp", "HandlePadEventLUp_PersonalField_Main_All_SelectType(nil)")
  self._ui._rdo_deep:addInputEvent("Mouse_LUp", "HandlePadEventLUp_PersonalField_Main_All_SelectType(nil)")
  if true == self._isConsole then
    self._ui._btn_close:SetShow(false)
    self._ui._stc_keyGuide:SetShow(true)
    Panel_Window_PersonalField_Main:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandlePadEventLUp_PersonalField_Main_All_Confirm()")
    Panel_Window_PersonalField_Main:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_PersonalField_Main_All_Close()")
    Panel_Window_PersonalField_Main:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_PersonalField_Main_All_ToggleWidget()")
    self:setAlignKeyGuide()
    self._ui._stc_keyLB:SetShow(true)
    self._ui._stc_keyRB:SetShow(true)
    Panel_Window_PersonalField_Main:registerPadEvent(__eConsoleUIPadEvent_LB, "HandlePadEventLUp_PersonalField_Main_All_SelectType(true)")
    Panel_Window_PersonalField_Main:registerPadEvent(__eConsoleUIPadEvent_RB, "HandlePadEventLUp_PersonalField_Main_All_SelectType(false)")
  else
    self._ui._btn_close:SetShow(true)
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_PersonalField_Main_All_Close()")
  end
end
function PaGlobal_PersonalField_Main_All:setAlignKeyGuide()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  if false == self._isConsole then
    return
  end
  local keyGuides = {
    self._ui._txt_keyGuideX,
    self._ui._txt_keyGuideA,
    self._ui._txt_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_PersonalField_Main_All:prepareOpen()
  if nil == Panel_Window_PersonalField_Main and true == Panel_Window_PersonalField_Main:GetShow() then
    return
  end
  if false == _ContentsGroup_PersonalField then
    return
  end
  if nil ~= Panel_Widget_PersonalField_Enter and true == Panel_Widget_PersonalField_Enter:GetShow() then
    return
  end
  FromClient_PersonalField_Main_All_ResizePanel()
  local isNotShow = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eIsShowPersonalFieldWidget)
  self._ui._btn_uiOnOff:SetCheck(not isNotShow)
  self:update()
  self:open()
end
function PaGlobal_PersonalField_Main_All:open()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  Panel_Window_PersonalField_Main:SetShow(true)
end
function PaGlobal_PersonalField_Main_All:prepareClose()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  self._naviPosList = {}
  self._serverState = __ePersonalFieldServerState_NoEntry
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_PersonalField_Main_All:close()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  Panel_Window_PersonalField_Main:SetShow(false)
end
function PaGlobal_PersonalField_Main_All:update()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  if false == _ContentsGroup_PersonalField then
    return
  end
  self:updateServerState()
  self:updateFieldList()
  self:updateRemainTime()
  self:setAlignKeyGuide()
end
function PaGlobal_PersonalField_Main_All:updateFieldList()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  self._naviPosList = {}
  self._enterIndex = nil
  self._selectKey = nil
  if true == self._isConsole then
    if true == self._isNonEnterServer then
      self._ui._txt_keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_SELECT"))
    else
      self._ui._txt_keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHECKEDQUESTLIST_BTN_NAVI"))
    end
  end
  local toIndex = self._ui._fieldList:getCurrenttoIndex()
  local fieldCount = ToClient_GetPersonalFieldSize()
  local needEnterItemKey = self._ui._rdo_deep:IsCheck() == true
  self._isDeepInfoExist = false
  self._ui._fieldList:getElementManager():clearKey()
  for index = 0, fieldCount - 1 do
    local instanceSpawnWrapper = ToClient_getInstanceSpawnInfoWrapperByIndex(index)
    if instanceSpawnWrapper ~= nil then
      local enterItemSSW = getItemEnchantStaticStatus(instanceSpawnWrapper:getEnterItemKey())
      if enterItemSSW == nil then
        if needEnterItemKey == false then
          self._ui._fieldList:getElementManager():pushKey(toInt64(0, index))
        end
      else
        self._isDeepInfoExist = true
        if needEnterItemKey == true then
          self._ui._fieldList:getElementManager():pushKey(toInt64(0, index))
        end
      end
    end
  end
  if self._isDeepInfoExist == true then
    self._ui._rdo_shallow:SetSpanSize(-100, self._ui._rdo_shallow:GetSpanSize().y)
    self._ui._rdo_deep:SetSpanSize(100, self._ui._rdo_deep:GetSpanSize().y)
    self._ui._rdo_shallow:SetShow(true)
    self._ui._rdo_deep:SetShow(true)
  else
    self._ui._rdo_shallow:SetSpanSize(0, self._ui._rdo_shallow:GetSpanSize().y)
    self._ui._rdo_shallow:SetShow(true)
    self._ui._rdo_deep:SetShow(false)
  end
  if true == Panel_Window_PersonalField_Main:GetShow() then
    if toIndex >= fieldCount then
      toIndex = fieldCount - 1
    end
    self._ui._fieldList:moveIndex(toIndex)
  end
  self._ui._fieldList:requestUpdateVisible()
  if needEnterItemKey == false then
    self._ui._stc_selectLine:SetPosX(self._ui._rdo_shallow:GetPosX() + (self._ui._rdo_shallow:GetSizeX() - self._ui._stc_selectLine:GetSizeX()) * 0.5)
  else
    self._ui._stc_selectLine:SetPosX(self._ui._rdo_deep:GetPosX() + (self._ui._rdo_deep:GetSizeX() - self._ui._stc_selectLine:GetSizeX()) * 0.5)
  end
end
function PaGlobal_PersonalField_Main_All:updateRemainTime()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  if nil == PaGlobal_Widget_PersonalField_All_SetRemainTimeText then
    return
  end
  local seconds = ToClient_GetPersonalFieldLeftTime()
  if nil == seconds or seconds < 0 then
    seconds = 0
  end
  local clockTime = ""
  local clockHours = math.max(math.floor(seconds / 3600), 0)
  local clockMinutes = math.max(math.floor(seconds % 3600 / 60), 0)
  local clockSeconds = math.max(math.floor(seconds % 3600 % 60), 0)
  if clockHours > 0 then
    clockTime = PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", tostring(clockHours)) .. " "
  end
  clockTime = clockTime .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", tostring(clockMinutes))
  local text = ""
  local needEnterItemKey = self._ui._rdo_deep:IsCheck() == true
  if needEnterItemKey == true then
    if clockHours * 60 + clockMinutes < 65 then
      text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PANEL_PERSONALFIELD_TIMELEFT", "remainTime", clockTime)
      self._ui._txt_time:addInputEvent("Mouse_On", "HandleEventOnOut_PersonalField_Main_All_SetShowRemainTimeTooltip(true)")
      self._ui._txt_time:addInputEvent("Mouse_Out", "HandleEventOnOut_PersonalField_Main_All_SetShowRemainTimeTooltip(false)")
    else
      text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_LIGHTPEARLBUFF_TIME", "getPearlPackageTime", clockTime)
      self._ui._txt_time:addInputEvent("Mouse_On", "")
      self._ui._txt_time:addInputEvent("Mouse_Out", "")
    end
  else
    text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_LIGHTPEARLBUFF_TIME", "getPearlPackageTime", clockTime)
    self._ui._txt_time:addInputEvent("Mouse_On", "")
    self._ui._txt_time:addInputEvent("Mouse_Out", "")
  end
  self._ui._txt_time:SetText(text)
  self._ui._txt_time:SetEnableArea(0, 0, self._ui._txt_time:GetSizeX() + self._ui._txt_time:GetTextSizeX(), self._ui._txt_time:GetSizeY())
end
function PaGlobal_PersonalField_Main_All:updateServerState()
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  self._ui._stc_green:SetShow(false)
  self._ui._stc_yellow:SetShow(false)
  self._ui._stc_red:SetShow(false)
  self._serverState = __ePersonalFieldServerState_NoEntry
  self._isNonEnterServer = true
  local enterControl
  if nil ~= self._selectKey and false == ToClient_IsEnterMirrorField() then
    local control = self._ui._fieldList:GetContentByKey(self._selectKey)
    if nil ~= control then
      local stc_slotBG = UI.getChildControl(control, "Static_Bg")
      if nil ~= stc_slotBG then
        local btn_enter = UI.getChildControl(stc_slotBG, "Button_Enter_Import")
        if nil ~= btn_enter then
          btn_enter:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PERSONALFIELD_SERVERSTATUS_LOCKED"))
          btn_enter:SetIgnore(true)
          enterControl = btn_enter
        end
      end
    end
  end
  local curChannelData = getCurrentChannelServerData()
  if nil == curChannelData then
    return
  end
  if true == curChannelData._isInstanceChannel then
    self._ui._txt_keyGuideA:SetShow(false)
    return
  end
  if true == curChannelData._isSiegeChannel or true == curChannelData:isPVPServer() then
    local channelName = getChannelName(curChannelData._worldNo, curChannelData._serverNo)
    if nil == channelName then
      channelName = ""
    end
    local alertText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_ALERT_DESC_MAIN", "server", tostring(channelName))
    self._ui._txt_alertDesc:SetText(alertText)
    local alertDescGapY = self._ui._txt_alertDesc:GetTextSizeY() - self._baseAlertDescSizeY
    if alertDescGapY < 0 then
      alertDescGapY = 0
    end
    local alertDescSpanSizeY = self._baseAlertDescSpanY - alertDescGapY / 2
    self._ui._txt_alertDesc:SetSpanSize(self._ui._txt_alertDesc:GetSpanSize().x, alertDescSpanSizeY)
    self._ui._stc_alertMainBG:SetShow(true)
    self._ui._txt_keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVERSELECT_SELECT"))
    return
  end
  self._isNonEnterServer = false
  self._ui._stc_alertMainBG:SetShow(false)
  self._serverState = ToClient_GetPersonalFieldServerState(curChannelData._serverNo)
  if __ePersonalFieldServerState_Free == self._serverState then
    self._ui._stc_green:SetShow(true)
  elseif __ePersonalFieldServerState_Busy == self._serverState then
    self._ui._stc_yellow:SetShow(true)
  else
    self._ui._stc_red:SetShow(true)
  end
  if nil ~= enterControl and __ePersonalFieldServerState_NoEntry ~= self._serverState then
    enterControl:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALFIELD_ENTER"))
    enterControl:SetIgnore(false)
  end
end
function PaGlobal_PersonalField_Main_All:listControlCreate(content, key)
  if nil == Panel_Window_PersonalField_Main then
    return
  end
  local index = Int64toInt32(key)
  local stc_slotBG = UI.getChildControl(content, "Static_Bg")
  local txt_areaName = UI.getChildControl(stc_slotBG, "StaticText_Name")
  local txt_desc = UI.getChildControl(stc_slotBG, "StaticText_Desc")
  local btn_navi = UI.getChildControl(stc_slotBG, "Button_Navi")
  local btn_enter = UI.getChildControl(stc_slotBG, "Button_Enter_Import")
  local btn_exit = UI.getChildControl(stc_slotBG, "Button_Exit_Import")
  btn_navi:SetShow(false)
  btn_enter:SetShow(false)
  btn_exit:SetShow(false)
  btn_navi:addInputEvent("Mouse_LUp", "")
  btn_enter:addInputEvent("Mouse_LUp", "")
  btn_exit:addInputEvent("Mouse_LUp", "")
  stc_slotBG:EraseAllEffect()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local instanceSpawnWrapper = ToClient_getInstanceSpawnInfoWrapperByIndex(index)
  if nil == instanceSpawnWrapper then
    return
  end
  local curChannelData = getCurrentChannelServerData()
  if nil == curChannelData then
    return
  end
  local serverState = ToClient_GetPersonalFieldServerState(curChannelData._serverNo)
  local isShowEffect = false
  local needEnterItemKey = self._ui._rdo_deep:IsCheck() == true
  local baseTexture = stc_slotBG:getBaseTexture()
  if needEnterItemKey == false then
    stc_slotBG:ChangeTextureInfoTextureIDAsync("Combine_Btn_Mid_Noraml")
  else
    local enterType = instanceSpawnWrapper:getEnterType()
    if enterType == __ePersonalMirrorFieldEnterType_Edania then
      stc_slotBG:ChangeTextureInfoTextureIDAsync("Combine_Etc_HuntPlace_Btn_List_Edania")
    else
      stc_slotBG:ChangeTextureInfoTextureIDAsync("Combine_Etc_HuntPlace_Btn_List_Atoraxion")
    end
  end
  stc_slotBG:SetGridType(1)
  stc_slotBG:SetGridPosX(0, 5, 555, 560)
  stc_slotBG:SetGridPosY(0, 5, 60, 65)
  stc_slotBG:SetGridUVX(0, 5, 35, 40)
  stc_slotBG:SetGridUVY(0, 5, 35, 40)
  local x1, y1, x2, y2 = setTextureUV_Func(stc_slotBG, baseTexture:getUV(0).x, baseTexture:getUV(0).y, baseTexture:getUV(3).x, baseTexture:getUV(3).y)
  baseTexture:setUV(x1, y1, x2, y2)
  stc_slotBG:setRenderTexture(baseTexture)
  if true == curChannelData._isSiegeChannel or true == curChannelData:isPVPServer() or true == curChannelData._isInstanceChannel then
    content:SetIgnore(true)
    stc_slotBG:SetIgnore(true)
  else
    content:SetIgnore(false)
    stc_slotBG:SetIgnore(false)
    local isEnterMirrorField = ToClient_IsEnterMirrorField()
    local isEnterPersonalField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalField)
    if true == isEnterMirrorField and false == isEnterPersonalField then
      btn_navi:addInputEvent("Mouse_LUp", "HandleEventLUp_PersonalField_Main_All_Navi(" .. tostring(index) .. ")")
      btn_navi:SetShow(true)
    else
      local selfPlayerPosition = selfPlayer:getPosition()
      local radius = instanceSpawnWrapper:getRadius()
      local distance = instanceSpawnWrapper:getDistance(selfPlayerPosition)
      if true == isEnterPersonalField and radius > distance then
        btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_PersonalField_Main_All_Leave()")
        btn_exit:SetShow(true)
        self._enterIndex = index
        self._selectKey = key
        isShowEffect = true
      elseif distance < radius * 0.8 then
        btn_enter:addInputEvent("Mouse_LUp", "HandleEventLUp_PersonalField_Main_All_OpenEnterUI()")
        btn_enter:SetShow(true)
        self._enterIndex = index
        self._selectKey = key
        if __ePersonalFieldServerState_NoEntry == serverState then
          btn_enter:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PERSONALFIELD_SERVERSTATUS_LOCKED"))
          btn_enter:SetIgnore(true)
        end
        isShowEffect = true
      else
        btn_navi:addInputEvent("Mouse_LUp", "HandleEventLUp_PersonalField_Main_All_Navi(" .. tostring(index) .. ")")
        btn_navi:SetShow(true)
      end
    end
  end
  if _ContentsGroup_LootingItemRecord == true then
    local btn_openReport = UI.getChildControl(stc_slotBG, "Button_OpenReport")
    if btn_openReport ~= nil then
      btn_openReport:SetShow(true)
      btn_openReport:addInputEvent("Mouse_LUp", "PaGloabl_Window_LootingItemReport_Main_All_Open(" .. index .. ")")
      if btn_enter:GetShow() == true then
        btn_openReport:SetSpanSize(btn_enter:GetSizeX() + btn_enter:GetSpanSize().x + 5, btn_openReport:GetSpanSize().y)
      elseif btn_navi:GetShow() == true then
        btn_openReport:SetSpanSize(btn_navi:GetSizeX() + btn_navi:GetSpanSize().x + 5, btn_openReport:GetSpanSize().y)
      end
    end
  end
  if true == self._isConsole then
    stc_slotBG:addInputEvent("Mouse_On", "HandlePadEventOn_PersonalField_Main_All_SelectIndex(" .. tostring(index) .. ")")
  end
  if true == isShowEffect then
    stc_slotBG:AddEffect("fUI_InGame_Light_02A", true, 0, 0)
  end
  local centerPos = instanceSpawnWrapper:getCenterPos()
  local fieldNo = instanceSpawnWrapper:getFieldNo()
  local tempTable = {_centerPos = centerPos, _fieldNo = fieldNo}
  self._naviPosList[index] = tempTable
  local areaName = instanceSpawnWrapper:getAreaName()
  if nil ~= areaName then
    txt_areaName:SetText(areaName)
  end
  local desc = instanceSpawnWrapper:getDesc()
  if desc ~= nil then
    local enterItemSSW = getItemEnchantStaticStatus(instanceSpawnWrapper:getEnterItemKey())
    if enterItemSSW == nil then
      UI.setLimitTextAndAddTooltip(txt_desc, desc, "")
      txt_desc:SetText(desc)
    else
      UI.setLimitTextAndAddTooltip(txt_desc, desc .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PANEL_PERSONALFIELD_RECOMMAND_ATT", "itemname", enterItemSSW:getName()), "")
      txt_desc:SetText(desc .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PANEL_PERSONALFIELD_RECOMMAND_ATT", "itemname", enterItemSSW:getName()))
    end
  end
  local isGm = ToClient_SelfPlayerIsGM()
  if isGm == true then
    local index = instanceSpawnWrapper:getIndex()
    txt_areaName:SetText(txt_areaName:GetText() .. " ( " .. tostring(index) .. " )")
  end
end
