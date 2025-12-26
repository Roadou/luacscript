PaGlobal_OtherUser_TriedStack = {
  _ui = {
    _btn_Close = nil,
    _list2 = nil,
    _txt_noData = nil
  },
  _currentStackValue = 0,
  _enchantInfo = nil,
  _initialize = false,
  _isPadMode = _ContentsGroup_UsePadSnapping,
  _currentFailCount = 0,
  _valksScrollCount = 0,
  _originalPosY = 0,
  _selectedIndex = 0
}
registerEvent("FromClient_luaLoadComplete", "FromClient_OtherUser_TriedStack_Init")
registerEvent("FromClient_OpenOthersChoice", "PaGlobalFunc_OtherUser_TriedStack_Open")
function FromClient_OtherUser_TriedStack_Init()
  PaGlobal_OtherUser_TriedStack:initialize()
end
function PaGlobal_OtherUser_TriedStack:initialize()
  if true == PaGlobal_OtherUser_TriedStack._initialize or nil == Panel_OtherUser_AdditionalRate_All then
    return
  end
  local title = UI.getChildControl(Panel_OtherUser_AdditionalRate_All, "Static_TitleArea")
  self._ui._btn_Close = UI.getChildControl(title, "Button_Close")
  self._ui._list2 = UI.getChildControl(Panel_OtherUser_AdditionalRate_All, "List2_2")
  self._ui._txt_noData = UI.getChildControl(Panel_OtherUser_AdditionalRate_All, "StaticText_NoData")
  local txt_notice = UI.getChildControl(Panel_OtherUser_AdditionalRate_All, "StaticText_Notice")
  PaGlobal_OtherUser_TriedStack:registEventHandler()
  Panel_OtherUser_AdditionalRate_All:SetSize(Panel_OtherUser_AdditionalRate_All:GetSizeX(), Panel_OtherUser_AdditionalRate_All:GetSizeY() - txt_notice:GetSizeY() + txt_notice:GetTextSizeY() + 25)
  txt_notice:SetSize(txt_notice:GetSizeX(), txt_notice:GetTextSizeY())
  self._ui._btn_Close:SetShow(self._isPadMode == false)
  PaGlobal_OtherUser_TriedStack._initialize = true
end
function PaGlobal_OtherUser_TriedStack:registEventHandler()
  if nil == Panel_OtherUser_AdditionalRate_All then
    return
  end
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_OtherUser_TriedStack_Close()")
  self._ui._list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_OtherUser_TriedStack_List2")
  self._ui._list2:createChildContent(__ePAUIList2ElementManagerType_List)
  if true == PaGlobal_OtherUser_TriedStack._isPadMode and _ContentsGroup_EnchantRemaster == false then
    Panel_OtherUser_AdditionalRate_All:RegisterUpdateFunc("PaGlobalFunc_OtherUser_AdditionalRate_Check")
  end
end
function PaGlobalFunc_OtherUser_AdditionalRate_Check(deltaTime)
  if isPadUp(__eJoyPadInputType_LeftTrigger) and 0 == PaGlobal_OtherUser_TriedStack._currentFailCount and 0 < PaGlobal_OtherUser_TriedStack._valksScrollCount then
    HandleClicked_ValksStack()
  end
end
function PaGlobal_OtherUser_TriedStack:prepareOpen()
  if nil == Panel_OtherUser_AdditionalRate_All then
    return
  end
  local totalCount = 0
  if _ContentsGroup_EnchantRemaster == true then
    self._currentStackValue = ToClient_GetEnchantStack() + ToClient_GetValksStack() + ToClient_GetBonusStack()
    self._selectedIndex = 0
    totalCount = ToClient_GetOthersChoiceSize()
  else
    PaGloabl_AddStack_All_close()
    self._enchantInfo = getEnchantInformation()
    self._enchantInfo = getEnchantInformation()
    self._currentStackValue = self._enchantInfo:ToClient_getFailCount() + self._enchantInfo:ToClient_getValksCount() + self._enchantInfo:ToClient_getBonusStackCount()
    self._selectedIndex = 0
    totalCount = self._enchantInfo:ToClient_getMostStackSize()
  end
  self._ui._txt_noData:SetShow(totalCount <= 0)
  self._ui._list2:SetShow(totalCount > 0)
  self._ui._list2:getElementManager():clearKey()
  if totalCount > 0 then
    for idx = 0, totalCount - 1 do
      self._ui._list2:getElementManager():pushKey(toInt64(0, idx))
    end
  end
  PaGlobalFunc_OtherUser_TriedStack_OnScreenResize()
  PaGlobal_OtherUser_TriedStack:open()
end
function PaGlobal_OtherUser_TriedStack:open()
  if nil == Panel_OtherUser_AdditionalRate_All then
    return
  end
  if PaGlobal_SpiritEnchant_All._ui_enchant.btn_groupEnchant:GetShow() == true then
    Panel_OtherUser_AdditionalRate_All:SetPosY(PaGlobal_OtherUser_TriedStack._originalPosY + PaGlobal_SpiritEnchant_All._ui_enchant.btn_groupEnchant:GetSizeY())
  else
    Panel_OtherUser_AdditionalRate_All:SetPosY(PaGlobal_OtherUser_TriedStack._originalPosY)
  end
  Panel_OtherUser_AdditionalRate_All:SetShow(true)
end
function PaGlobal_OtherUser_TriedStack:prepareClose()
  if nil == Panel_OtherUser_AdditionalRate_All then
    return
  end
  PaGlobal_OtherUser_TriedStack:close()
end
function PaGlobal_OtherUser_TriedStack:close()
  if nil == Panel_OtherUser_AdditionalRate_All then
    return
  end
  Panel_OtherUser_AdditionalRate_All:SetShow(false)
  if _ContentsGroup_EnchantRemaster == false then
    PaGlobal_SpiritEnchant_All_ButtonEffect_On()
  end
end
function PaGlobalFunc_OtherUser_TriedStack_Open()
  PaGlobal_OtherUser_TriedStack:prepareOpen()
end
function PaGlobalFunc_OtherUser_TriedStack_OnScreenResize()
  if nil == Panel_OtherUser_AdditionalRate_All then
    return
  end
  local targetPanel
  if _ContentsGroup_EnchantRemaster == true then
    if Panel_Window_EnchantStack_All ~= nil and Panel_Window_EnchantStack_All:GetShow() == true then
      targetPanel = Panel_Window_EnchantStack_All
    else
      Panel_OtherUser_AdditionalRate_All:SetHorizonRight()
      Panel_OtherUser_AdditionalRate_All:SetVerticalTop()
      Panel_OtherUser_AdditionalRate_All:SetSpanSize(30, 30)
      PaGlobal_OtherUser_TriedStack._originalPosY = Panel_OtherUser_AdditionalRate_All:GetPosY()
      return
    end
  else
    if nil == Panel_Window_StackExtraction_All then
      return
    end
    targetPanel = Panel_Window_StackExtraction_All
  end
  local posXPadding = 15
  local posX = targetPanel:GetPosX() + targetPanel:GetSizeX() + posXPadding
  local posY = targetPanel:GetPosY()
  local panelEndPosX = posX + Panel_OtherUser_AdditionalRate_All:GetSizeX() + (PaGlobal_OtherUser_TriedStack._ui._list2:GetSizeX() - posXPadding)
  if panelEndPosX > getScreenSizeX() then
    posX = math.max(posXPadding, targetPanel:GetPosX() - Panel_OtherUser_AdditionalRate_All:GetSizeX() - posXPadding)
  end
  Panel_OtherUser_AdditionalRate_All:SetPosX(posX)
  Panel_OtherUser_AdditionalRate_All:SetPosY(posY)
  PaGlobal_OtherUser_TriedStack._originalPosY = Panel_OtherUser_AdditionalRate_All:GetPosY()
end
function PaGlobalFunc_OtherUser_TriedStack_Close()
  PaGlobal_OtherUser_TriedStack:prepareClose()
end
function FromClient_OtherUser_TriedStack_List2(control, key)
  local key32 = Int64toInt32(key)
  local bg = UI.getChildControl(control, "Static_Additional_Data0")
  local txtStack = UI.getChildControl(bg, "StaticText_StackRange")
  local txtPercent = UI.getChildControl(bg, "StaticText_Percent")
  local firstBg = UI.getChildControl(bg, "Static_Bg")
  local mouseLup = UI.getChildControl(bg, "Static_MouseLup")
  if true == PaGlobal_OtherUser_TriedStack._isPadMode then
    mouseLup = UI.getChildControl(bg, "Static_RUp")
  end
  local triedStack = 0
  local count = 0
  local totalCount = 0
  if _ContentsGroup_EnchantRemaster == true then
    triedStack = ToClient_GetOthersChoiceStackByIndex(key32) * 5
  else
    triedStack = PaGlobal_OtherUser_TriedStack._enchantInfo:ToClient_getMostStackByIndex(key32)
    triedStack = triedStack * 5
    count = PaGlobal_OtherUser_TriedStack._enchantInfo:ToClient_getMostStackCountByIndex(key32)
    totalCount = PaGlobal_OtherUser_TriedStack._enchantInfo:ToClient_getMostStackTotalCount()
  end
  if triedStack == 0 then
    txtStack:SetText("+0 ~ +4")
  else
    txtStack:SetText("+" .. triedStack .. " ~ +" .. triedStack + 4)
  end
  if _ContentsGroup_EnchantRemaster == true then
    txtPercent:SetText(math.floor(ToClient_GetOthersChoicePercentByIndex(key32)) .. " %")
  elseif totalCount > 0 then
    txtPercent:SetText(math.floor(count / totalCount * 100) .. " %")
  end
  if 0 == key32 then
    firstBg:SetShow(true)
  else
    firstBg:SetShow(false)
  end
  if _ContentsGroup_EnchantRemaster == true then
    local currentFailCount = ToClient_GetEnchantStack()
    local valksAdviceCount = ToClient_GetInventoryEnchantMaterialSize()
    if currentFailCount == 0 and valksAdviceCount > 0 then
      if PaGlobal_OtherUser_TriedStack._isPadMode == true then
        PaGlobal_OtherUser_TiredStack_ConsoleShow(true)
        firstBg:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "PaGlobalFunc_EnchantStack_All_Open(" .. triedStack .. ")")
        bg:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "PaGlobalFunc_EnchantStack_All_Open(" .. triedStack .. ")")
      else
        firstBg:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantStack_All_Open(" .. triedStack .. ")")
        bg:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantStack_All_Open(" .. triedStack .. ")")
      end
      mouseLup:SetShow(true)
    else
      if PaGlobal_OtherUser_TriedStack._isPadMode == true then
        PaGlobal_OtherUser_TiredStack_ConsoleShow(false)
        firstBg:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "")
        bg:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "")
      else
        firstBg:addInputEvent("Mouse_LUp", "")
        bg:addInputEvent("Mouse_LUp", "")
      end
      mouseLup:SetShow(false)
    end
  else
    local enchantInfo = getEnchantInformation()
    if nil == enchantInfo then
      return
    end
    local currentFailCount = enchantInfo:ToClient_getFailCount()
    local valksScrollCount = PaGlobal_AddStack_All:getValksScrollCount()
    PaGlobal_OtherUser_TriedStack._currentFailCount = currentFailCount
    PaGlobal_OtherUser_TriedStack._valksScrollCount = valksScrollCount
    if 0 == currentFailCount and valksScrollCount > 0 then
      if true == PaGlobal_OtherUser_TriedStack._isPadMode then
        PaGlobal_OtherUser_TiredStack_ConsoleShow(true)
      else
        firstBg:addInputEvent("Mouse_LUp", "HandleClicked_ValksStack(" .. key32 .. ")")
        bg:addInputEvent("Mouse_LUp", "HandleClicked_ValksStack(" .. key32 .. ")")
      end
      if true == PaGlobal_OtherUser_TriedStack._isPadMode then
        if 0 == key32 then
          mouseLup:SetShow(true)
        else
          mouseLup:SetShow(false)
        end
      else
        mouseLup:SetShow(true)
      end
    else
      if true == PaGlobal_OtherUser_TriedStack._isPadMode then
        PaGlobal_OtherUser_TiredStack_ConsoleShow(false)
      else
        firstBg:addInputEvent("Mouse_LUp", "")
        bg:addInputEvent("Mouse_LUp", "")
      end
      mouseLup:SetShow(false)
    end
  end
end
function HandleClicked_ValksStack(index)
  local enchantInfo = getEnchantInformation()
  if nil == enchantInfo then
    return
  end
  if nil == index then
    index = 0
  end
  PaGlobal_OtherUser_TriedStack._selectedIndex = index
  PaGloabl_AddStack_All_Open(1)
  local currentFailCount = enchantInfo:ToClient_getFailCount()
  if 0 == currentFailCount then
    HandleEventLUp_AddStack_All_ClickedItem(4)
  end
end
function FGlobal_OtherUser_AdditionalRate_Index()
  return PaGlobal_OtherUser_TriedStack._selectedIndex
end
