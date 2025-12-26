function PaGlobal_UseCharacterWp_All:initialize()
  if true == self._initialize or nil == Panel_Window_UseCharacterWp_All then
    return
  end
  self._ui._stc_title = UI.getChildControl(Panel_Window_UseCharacterWp_All, "StaticText_Title")
  self._ui._stc_title_icon = UI.getChildControl(self._ui._stc_title, "StaticText_TitleIcon")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_title, "Button_Win_Close")
  self._ui._list2_button = UI.getChildControl(Panel_Window_UseCharacterWp_All, "List2_CharacterSelect")
  self._ui._list2_content = UI.getChildControl(self._ui._list2_button, "List2_2_Content")
  self._ui._list2_scroll = UI.getChildControl(self._ui._list2_button, "List2_2_VerticalScroll")
  self._ui._stc_KeyGuideBg = UI.getChildControl(Panel_Window_UseCharacterWp_All, "Static_KeyGuide_Console")
  self._ui._btn_confirm_consoleUI = UI.getChildControl(self._ui._stc_KeyGuideBg, "StaticText_Select_Console")
  self._ui._btn_cancel_consoleUI = UI.getChildControl(self._ui._stc_KeyGuideBg, "StaticText_Close_Console")
  self._ui._btn_otherItem_consoleUI = UI.getChildControl(self._ui._stc_KeyGuideBg, "StaticText_OtherItem_Console")
  self._ui._stc_blockBg = UI.getChildControl(Panel_Window_UseCharacterWp_All, "Static_BlockBg")
  self._panelOriginSizeY = Panel_Window_UseCharacterWp_All:GetSizeY()
  self._listOriginPosX = self._ui._list2_button:GetPosX()
  self._listOriginPosY = self._ui._list2_button:GetPosY()
  self._listOriginSizeY = self._ui._list2_button:GetSizeY()
  self._ui._list2_button:changeAnimationSpeed(10)
  self._ui._list2_button:setMinScrollBtnSize(float2(10, 50))
  self._isUsePadSnapping = _ContentsGroup_UsePadSnapping
  self._initialize = true
  self:registEventHandler()
  self:setConsoleUI()
  self:validate()
end
function PaGlobal_UseCharacterWp_All:setConsoleUI()
  if Panel_Window_UseCharacterWp_All == nil then
    return
  end
  if self._isUsePadSnapping == true then
    self._ui._btn_close:SetShow(false)
    self._ui._stc_KeyGuideBg:SetShow(true)
    self._ui._btn_confirm_consoleUI:SetShow(true)
    self._ui._btn_cancel_consoleUI:SetShow(true)
    if self._currentOpenType == self._openType._secretRandomShop then
      self._ui._btn_otherItem_consoleUI:SetShow(true)
      Panel_Window_UseCharacterWp_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_RandomShop_All_OtherItemShow(\"Y\")")
    else
      self._ui._btn_otherItem_consoleUI:SetShow(false)
      Panel_Window_UseCharacterWp_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    end
    self._ui._stc_KeyGuideBg:SetPosY(Panel_Window_UseCharacterWp_All:GetSizeY())
    self._ui._stc_KeyGuideBg:SetSize(Panel_Window_UseCharacterWp_All:GetSizeX(), self._ui._stc_KeyGuideBg:GetSizeY())
    local keyGuideSizeX = self._ui._btn_confirm_consoleUI:GetSizeX() + self._ui._btn_confirm_consoleUI:GetTextSizeX() + self._ui._btn_cancel_consoleUI:GetSizeX() + self._ui._btn_cancel_consoleUI:GetTextSizeX()
    local keyGuides = {
      self._ui._btn_confirm_consoleUI,
      self._ui._btn_otherItem_consoleUI,
      self._ui._btn_cancel_consoleUI
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_KeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    self._ui._stc_KeyGuideBg:SetShow(false)
    self._ui._btn_confirm_consoleUI:SetShow(false)
    self._ui._btn_otherItem_consoleUI:SetShow(false)
    self._ui._btn_cancel_consoleUI:SetShow(false)
  end
end
function PaGlobal_UseCharacterWp_All:registEventHandler()
  if Panel_Window_UseCharacterWp_All == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_UseCharacterWp_All_Close()")
  self._ui._list2_button:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_UseCharacterWp_All_MakeCharacterWpList")
  self._ui._list2_button:createChildContent(__ePAUIList2ElementManagerType_List)
  Panel_Window_UseCharacterWp_All:RegisterShowEventFunc(true, "PaGlobalFunc_UseCharacterWp_All_ShowAni()")
  Panel_Window_UseCharacterWp_All:RegisterShowEventFunc(false, "PaGlobalFunc_UseCharacterWp_All_HideAni()")
  registerEvent("FromClient_WpChangedWithParam", "FromClient_UseCharacterWp_All_SelfPlayerWpChanged")
  registerEvent("FromClient_WpChangedOtherCharacter", "FromClient_UseCharacterWp_All_OtherCharacterWpChanged")
end
function PaGlobal_UseCharacterWp_All:prepareOpen(type, param0)
  if Panel_Window_UseCharacterWp_All == nil then
    return
  end
  local selfPlayerActorWrapper = getSelfPlayer()
  if selfPlayerActorWrapper == nil then
    return
  end
  self._currentOpenType = type
  self._param0 = param0
  self._selectedIndex = -1
  self._selfCharacterNo_64 = selfPlayerActorWrapper:getCharacterNo_64()
  self:settingByOpenType()
  self._ui._list2_button:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_UseCharacterWp_All_MakeCharacterWpList")
  self._ui._list2_button:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_button:SetShow(true)
  self._ui._list2_button:getElementManager():clearKey()
  local characterDatacount = getCharacterDataCount(__ePlayerCreateNormal)
  for idx = 0, characterDatacount - 1 do
    self._ui._list2_button:getElementManager():pushKey(idx)
  end
  self:checkCurrentCharacterButton()
  self:setConsoleUI()
  self:open()
end
function PaGlobal_UseCharacterWp_All:open()
  if Panel_Window_UseCharacterWp_All == nil then
    return
  end
  Panel_Window_UseCharacterWp_All:SetShow(true)
end
function PaGlobal_UseCharacterWp_All:prepareClose()
  if Panel_Window_UseCharacterWp_All == nil then
    return
  end
  self._selectedIndex = -1
  self:close()
end
function PaGlobal_UseCharacterWp_All:close()
  Panel_Window_UseCharacterWp_All:SetShow(false)
end
function PaGlobal_UseCharacterWp_All:settingByOpenType()
  if Panel_Window_UseCharacterWp_All == nil then
    return
  end
  if self._currentOpenType == self._openType._investNode then
    self._ui._btn_close:SetShow(true)
    self._ui._stc_title_icon:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NODELEVEL_CHARACTERSELECT"))
    if Panel_Window_UseCharacterWp_All:GetShow() == false then
      if self._isUsePadSnapping == true then
        local snappedControl = ToClient_getSnappedControl()
        if snappedControl ~= nil then
          Panel_Window_UseCharacterWp_All:SetPosX(getMousePosX())
          Panel_Window_UseCharacterWp_All:SetPosY(getMousePosY())
        else
          Panel_Window_UseCharacterWp_All:SetPosX(getOriginScreenSizeX() / 2 - Panel_Window_UseCharacterWp_All:GetSizeX() / 2)
          Panel_Window_UseCharacterWp_All:SetPosY(getOriginScreenSizeY() / 2 - Panel_Window_UseCharacterWp_All:GetSizeY() / 2)
        end
        if Panel_Window_UseCharacterWp_All:GetPosY() + Panel_Window_UseCharacterWp_All:GetSizeY() + self._ui._stc_KeyGuideBg:GetSizeY() > getScreenSizeY() then
          Panel_Window_UseCharacterWp_All:SetPosY(getScreenSizeY() - Panel_Window_UseCharacterWp_All:GetSizeY() - self._ui._stc_KeyGuideBg:GetSizeY() - 30)
        end
      else
        Panel_Window_UseCharacterWp_All:SetPosX(getMousePosX())
        Panel_Window_UseCharacterWp_All:SetPosY(getMousePosY())
        if Panel_Window_UseCharacterWp_All:GetPosY() + Panel_Window_UseCharacterWp_All:GetSizeY() > getScreenSizeY() or Panel_Window_UseCharacterWp_All:GetPosY() < 0 then
          Panel_Window_UseCharacterWp_All:SetPosY(getScreenSizeY() - Panel_Window_UseCharacterWp_All:GetSizeY() - 30)
        end
      end
      if Panel_Window_UseCharacterWp_All:GetPosX() + Panel_Window_UseCharacterWp_All:GetSizeX() > getScreenSizeX() or 0 > Panel_Window_UseCharacterWp_All:GetPosX() then
        Panel_Window_UseCharacterWp_All:SetPosX(getScreenSizeX() - Panel_Window_UseCharacterWp_All:GetSizeX())
      end
    end
    Panel_Window_UseCharacterWp_All:SetSize(Panel_Window_UseCharacterWp_All:GetSizeX(), self._panelOriginSizeY)
    self._ui._list2_button:SetSize(self._ui._list2_button:GetSizeX(), self._listOriginSizeY)
  elseif self._currentOpenType == self._openType._workerRandomSelect then
    self._ui._btn_close:SetShow(false)
    self._ui._stc_title_icon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_ENERGYPOINT_CONSUMES"))
    if Panel_Window_WorkerRandomSelect_All ~= nil then
      Panel_Window_UseCharacterWp_All:SetSize(Panel_Window_UseCharacterWp_All:GetSizeX(), Panel_Window_WorkerRandomSelect_All:GetSizeY())
      self._ui._list2_button:SetSize(self._ui._list2_button:GetSizeX(), Panel_Window_WorkerRandomSelect_All:GetSizeY() - 50)
      self._startPosX = (getScreenSizeX() - (Panel_Window_UseCharacterWp_All:GetSizeX() + Panel_Window_WorkerRandomSelect_All:GetSizeX())) / 2
      Panel_Window_UseCharacterWp_All:SetPosX(self._startPosX - 5)
      Panel_Window_WorkerRandomSelect_All:SetPosX(Panel_Window_UseCharacterWp_All:GetPosX() + Panel_Window_UseCharacterWp_All:GetSizeX() + 10)
      Panel_Window_UseCharacterWp_All:SetPosY(Panel_Window_WorkerRandomSelect_All:GetPosY())
      self._ui._stc_blockBg:SetSize(self._ui._list2_button:GetSizeX(), self._ui._list2_button:GetSizeY())
    end
  elseif self._currentOpenType == self._openType._secretRandomShop then
    self._ui._btn_close:SetShow(false)
    self._ui._stc_title_icon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_ENERGYPOINT_CONSUMES"))
    if Panel_Window_RandomShop_All ~= nil then
      Panel_Window_UseCharacterWp_All:SetSize(Panel_Window_UseCharacterWp_All:GetSizeX(), Panel_Window_RandomShop_All:GetSizeY())
      self._ui._list2_button:SetSize(self._ui._list2_button:GetSizeX(), Panel_Window_RandomShop_All:GetSizeY() - 50)
      self._startPosX = (getScreenSizeX() - (Panel_Window_UseCharacterWp_All:GetSizeX() + Panel_Window_RandomShop_All:GetSizeX())) / 2
      Panel_Window_UseCharacterWp_All:SetPosX(self._startPosX - 5)
      Panel_Window_RandomShop_All:SetPosX(Panel_Window_UseCharacterWp_All:GetPosX() + Panel_Window_UseCharacterWp_All:GetSizeX() + 10)
      Panel_Window_UseCharacterWp_All:SetPosY(Panel_Window_RandomShop_All:GetPosY())
    end
  end
end
function PaGlobal_UseCharacterWp_All:checkCurrentCharacterButton()
  if Panel_Window_UseCharacterWp_All == nil then
    return
  end
  if self._currentOpenType ~= self._openType._workerRandomSelect and self._currentOpenType ~= self._openType._secretRandomShop then
    return
  end
  for index = 0, getCharacterDataCount(__ePlayerCreateNormal) - 1 do
    local contents = self._ui._list2_button:GetContentByKey(index)
    local characterData = ToClient_getSortNormalCharacterDataByIndex(index)
    if contents ~= nil and characterData ~= nil then
      local btn_character = UI.getChildControl(contents, "RadioButton_CharacterName")
      if index == 0 then
        self._selectedIndex = index
        btn_character:SetCheck(true)
      else
        btn_character:SetCheck(false)
      end
    end
  end
end
function PaGlobal_UseCharacterWp_All:selectCharacterList(characterIdx)
  if self._currentOpenType == self._openType._investNode then
    self._selectedIndex = characterIdx
    local wpCalc = math.floor(ToClient_getWpInSortNormalCharacterDataList(characterIdx) / 10)
    if wpCalc < 1 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMentalNotEnoughWp"))
      return
    end
    local s64_maxNumber = tonumber64(wpCalc)
    Panel_NumberPad_Show(true, s64_maxNumber, 0, PaGlobalFunc_UseCharacterWp_All_InvestNode)
  elseif self._currentOpenType == self._openType._workerRandomSelect then
    if PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart == true then
      return
    end
    self._selectedIndex = characterIdx
    PaGlobalFunc_WorkerRandomSelect_All_SelectCharacterWp()
  elseif self._currentOpenType == self._openType._secretRandomShop then
    self._selectedIndex = characterIdx
    PaGlobalFunc_RandomShop_All_CheckWp()
  end
end
function PaGlobal_UseCharacterWp_All:validate()
  self._ui._stc_title:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._list2_button:isValidate()
  self._ui._list2_content:isValidate()
  self._ui._stc_KeyGuideBg:isValidate()
  self._ui._btn_confirm_consoleUI:isValidate()
  self._ui._btn_cancel_consoleUI:isValidate()
  self._ui._stc_blockBg:isValidate()
end
