function PaGlobal_WorkerAuction_All:initialize()
  if true == PaGlobal_WorkerAuction_All._initialize then
    return
  end
  PaGlobal_WorkerAuction_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_WorkerAuction_All._ui._stc_TitleBg = UI.getChildControl(Panel_Window_WorkerAuction_All, "Static_TitleBG")
  PaGlobal_WorkerAuction_All._ui._stc_MainBg = UI.getChildControl(Panel_Window_WorkerAuction_All, "Static_MainBg")
  PaGlobal_WorkerAuction_All._ui._btn_QuestionPC = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_TitleBg, "Button_Question")
  PaGlobal_WorkerAuction_All._ui._btn_ClosePC = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_TitleBg, "Button_Win_Close")
  PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg = UI.getChildControl(Panel_Window_WorkerAuction_All, "Static_RadioButtonGroupBg")
  PaGlobal_WorkerAuction_All._ui._rdo_MarketList = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg, "RadioButton_List")
  PaGlobal_WorkerAuction_All._ui._rdo_Register = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg, "RadioButton_Regist")
  PaGlobal_WorkerAuction_All._ui._rdo_MyRegister = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg, "RadioButton_MyList")
  PaGlobal_WorkerAuction_All._ui._btn_LB_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg, "Button_LB_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._btn_RB_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg, "Button_RB_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._stc_SelectBar = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg, "Static_SelectBar")
  PaGlobal_WorkerAuction_All._ui._stc_AuctionArea = UI.getChildControl(Panel_Window_WorkerAuction_All, "Static_AuctionArea")
  PaGlobal_WorkerAuction_All._ui._stc_PageBg = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_AuctionArea, "Static_PageBg")
  PaGlobal_WorkerAuction_All._ui._txt_PageValue = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_PageBg, "StaticText_PageValue")
  PaGlobal_WorkerAuction_All._ui._btn_LeftPage = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_PageBg, "Button_Left_PCUI")
  PaGlobal_WorkerAuction_All._ui._btn_RightPage = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_PageBg, "Button_Right_PCUI")
  PaGlobal_WorkerAuction_All._ui._btn_Left_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_PageBg, "Button_Left_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._btn_Right_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_PageBg, "Button_Right_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide = UI.getChildControl(Panel_Window_WorkerAuction_All, "Static_BottomBG_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._stc_A_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide, "StaticText_A_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._stc_B_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide, "StaticText_B_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._stc_X_KeyGuide = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide, "StaticText_X_ConsoleUI")
  PaGlobal_WorkerAuction_All._ui._stc_MoneyArea = UI.getChildControl(Panel_Window_WorkerAuction_All, "Static_MyMoneyArea")
  PaGlobal_WorkerAuction_All._ui._txt_MoneyValue = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_MoneyArea, "StaticText_MoneyValue")
  PaGlobal_WorkerAuction_All._ui._list2_region = UI.getChildControl(Panel_Window_WorkerAuction_All, "List2_Region")
  PaGlobal_WorkerAuction_All._ui._list2_region:changeAnimationSpeed(10)
  PaGlobal_WorkerAuction_All._ui._list2_region:setMinScrollBtnSize(float2(10, 50))
  PaGlobal_WorkerAuction_All._ui._list2_region:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_WorkerAuction_All_UpdateRegionList")
  PaGlobal_WorkerAuction_All._ui._list2_region:createChildContent(__ePAUIList2ElementManagerType_Tree)
  PaGlobal_WorkerAuction_All._ui._combo_Sort = UI.getChildControl(Panel_Window_WorkerAuction_All, "Combobox_Sort")
  PaGlobal_WorkerAuction_All._ui._combo_SortList = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._combo_Sort, "Combobox_List")
  PaGlobal_WorkerAuction_All._ui._btn_reset = UI.getChildControl(Panel_Window_WorkerAuction_All, "Button_Reset")
  if false == PaGlobal_WorkerAuction_All._isConsole then
    PaGlobal_WorkerAuction_All._ui._stc_ListSlotTemplete = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_AuctionArea, "Static_ListSlotTemplate_PCUI")
  else
    PaGlobal_WorkerAuction_All._ui._stc_ListSlotTemplete = UI.getChildControl(PaGlobal_WorkerAuction_All._ui._stc_AuctionArea, "Static_ListSlotTemplate_ConsoleUI")
    PaGlobal_WorkerAuction_All._keyGuides = {
      PaGlobal_WorkerAuction_All._ui._stc_X_KeyGuide,
      PaGlobal_WorkerAuction_All._ui._stc_A_KeyGuide,
      PaGlobal_WorkerAuction_All._ui._stc_B_KeyGuide
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(PaGlobal_WorkerAuction_All._keyGuides, PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  local slotStartPosY = PaGlobal_WorkerAuction_All._ui._stc_PageBg:GetSizeY() + PaGlobal_WorkerAuction_All._ui._stc_PageBg:GetPosY() + 5
  PaGlobal_WorkerAuction_All._config._startY = slotStartPosY
  PaGlobal_WorkerAuction_All._radioTabList[PaGlobal_WorkerAuction_All._ENUMTABINDEX_MARKETLIST] = PaGlobal_WorkerAuction_All._ui._rdo_MarketList
  PaGlobal_WorkerAuction_All._radioTabList[PaGlobal_WorkerAuction_All._ENUMTABINDEX_REGISTER] = PaGlobal_WorkerAuction_All._ui._rdo_Register
  PaGlobal_WorkerAuction_All._radioTabList[PaGlobal_WorkerAuction_All._ENUMTABINDEX_MYREGISTER] = PaGlobal_WorkerAuction_All._ui._rdo_MyRegister
  PaGlobal_WorkerAuction_All._selectedTab = PaGlobal_WorkerAuction_All._ENUMTABINDEX_MARKETLIST
  PaGlobal_WorkerAuction_All._radioTabList[PaGlobal_WorkerAuction_All._selectedTab]:SetCheck(true)
  PaGlobal_WorkerAuction_All._radioTabList[PaGlobal_WorkerAuction_All._selectedTab]:SetFontColor(PaGlobal_WorkerAuction_All._TABCOLOR_SELECTED)
  local selectBarSapnX = PaGlobal_WorkerAuction_All._radioTabList[PaGlobal_WorkerAuction_All._selectedTab]:GetSpanSize().x
  local selectBarSapnY = PaGlobal_WorkerAuction_All._ui._stc_SelectBar:GetSpanSize().y
  PaGlobal_WorkerAuction_All._ui._stc_SelectBar:SetSpanSize(selectBarSapnX, selectBarSapnY)
  PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide:SetShow(PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_Left_KeyGuide:SetShow(PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_Right_KeyGuide:SetShow(PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_LB_KeyGuide:SetShow(PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_RB_KeyGuide:SetShow(PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_LeftPage:SetShow(not PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_RightPage:SetShow(not PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_QuestionPC:SetShow(not PaGlobal_WorkerAuction_All._isConsole)
  PaGlobal_WorkerAuction_All._ui._btn_ClosePC:SetShow(not PaGlobal_WorkerAuction_All._isConsole)
  if true == _ContentsOption_CH_Help then
    PaGlobal_WorkerAuction_All._ui._btn_QuestionPC:SetShow(false)
  end
  if _ContentsGroup_WorkerImprovement == true then
    local hierableRegionCount = ToClient_getWorkerHierableRegionListMaxCount()
    for index = 0, hierableRegionCount - 1 do
      local regionKey = ToClient_getWorkerHierableRegionKey(index)
      local regionInfo = getRegionInfoByRegionKey(regionKey)
      if regionInfo ~= nil then
        local regionKeyRaw = regionKey:get()
        local territoryKeyRaw = regionInfo:getTerritoryKeyRaw()
        local territoryOptionSize = #PaGlobal_WorkerRandomSelect_All._territoryContentsOption
        if territoryKeyRaw < 0 or territoryKeyRaw > territoryOptionSize then
          _PA_ASSERT_NAME(false, "\236\131\136\235\161\156\236\154\180 Territory\234\176\128 \236\182\148\234\176\128\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. PaGlobal_WorkerRandomSelect_All._territoryContentsOption\236\151\144 \236\182\148\234\176\128 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\152\164\236\131\129\235\175\188")
        end
        if PaGlobal_WorkerRandomSelect_All._territoryContentsOption[territoryKeyRaw] == true then
          local workerRegionData = {}
          workerRegionData.regionKeyRaw = regionKeyRaw
          workerRegionData.territoryKeyRaw = territoryKeyRaw
          table.insert(self._workerRegionList, workerRegionData)
        end
      end
    end
  end
  PaGlobal_WorkerAuction_All._targetControlList = Array.new()
  PaGlobal_WorkerAuction_All:validate()
  PaGlobal_WorkerAuction_All:registEventHandler()
  PaGlobal_WorkerAuction_All:createControl()
  PaGlobal_WorkerAuction_All:createComboSort()
  Panel_Window_WorkerAuction_All:SetChildIndex(PaGlobal_WorkerAuction_All._ui._combo_Sort, 999)
end
function PaGlobal_WorkerAuction_All:validate()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  PaGlobal_WorkerAuction_All._ui._stc_TitleBg:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_MainBg:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_AuctionArea:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_QuestionPC:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_ClosePC:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_RadioGroupBg:isValidate()
  PaGlobal_WorkerAuction_All._ui._rdo_MarketList:isValidate()
  PaGlobal_WorkerAuction_All._ui._rdo_Register:isValidate()
  PaGlobal_WorkerAuction_All._ui._rdo_MyRegister:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_LB_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_RB_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_SelectBar:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_PageBg:isValidate()
  PaGlobal_WorkerAuction_All._ui._txt_PageValue:isValidate()
  PaGlobal_WorkerAuction_All._ui._combo_Sort:isValidate()
  PaGlobal_WorkerAuction_All._ui._combo_SortList:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_LeftPage:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_RightPage:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_Left_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_Right_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_Bottom_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_A_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_B_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._stc_X_KeyGuide:isValidate()
  PaGlobal_WorkerAuction_All._ui._list2_region:isValidate()
  PaGlobal_WorkerAuction_All._ui._btn_reset:isValidate()
  PaGlobal_WorkerAuction_All._initialize = true
end
function PaGlobal_WorkerAuction_All:registEventHandler()
  if nil == Panel_Window_WorkerAuction_All or false == PaGlobal_WorkerAuction_All._initialize then
    return
  end
  registerEvent("FromClient_ResponseWorkerAuction", "FromClient_WorkerAuction_All_ResponseWorkerAuction()")
  registerEvent("FromClient_ResponseMyWorkerAuction", "FromClient_WorkerAuction_All_ResponseMyWorkerAuction()")
  registerEvent("EventWarehouseUpdate", "FromClient_WorkerAuction_All_UpdateMoney()")
  registerEvent("FromClient_RegistAuction", "FromClient_WorkerAuction_All_RegisterDone()")
  registerEvent("FromClient_BuyWorkerAuction", "FromClient_WorkerAuction_All_BuyWorkerDone()")
  registerEvent("FromClient_PopWorkerPriceAuction", "FromClient_WorkerAuction_All_ReceiveMoneyDone()")
  registerEvent("FromClient_CancelRegistAuction", "FromClient_WorkerAuction_All_CancelRegistDone()")
  registerEvent("FromClient_ResponseAllWorkerList", "FromClient_ResponseAllWorkerList()")
  registerEvent("onScreenResize", "FromClient_WorkerAuction_All_OnScreenResize()")
  if false == PaGlobal_WorkerAuction_All._isConsole then
    PaGlobal_WorkerAuction_All._ui._btn_ClosePC:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_Close()")
    PaGlobal_WorkerAuction_All._ui._rdo_MarketList:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_TabButtonClick(0)")
    PaGlobal_WorkerAuction_All._ui._rdo_Register:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_TabButtonClick(1)")
    PaGlobal_WorkerAuction_All._ui._rdo_MyRegister:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_TabButtonClick(2)")
    PaGlobal_WorkerAuction_All._ui._btn_QuestionPC:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Worker\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(PaGlobal_WorkerAuction_All._ui._btn_QuestionPC, "\"Worker\"")
    PaGlobal_WorkerAuction_All._ui._btn_LeftPage:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_ChangePage( -1 )")
    PaGlobal_WorkerAuction_All._ui._btn_RightPage:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_ChangePage( 1 )")
    PaGlobal_WorkerAuction_All._ui._stc_AuctionArea:addInputEvent("Mouse_UpScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( -1 )")
    PaGlobal_WorkerAuction_All._ui._stc_AuctionArea:addInputEvent("Mouse_DownScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( 1 )")
    PaGlobal_WorkerAuction_All._ui._stc_PageBg:addInputEvent("Mouse_UpScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( -1 )")
    PaGlobal_WorkerAuction_All._ui._stc_PageBg:addInputEvent("Mouse_DownScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( 1 )")
    PaGlobal_WorkerAuction_All._ui._stc_MainBg:addInputEvent("Mouse_UpScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( -1 )")
    PaGlobal_WorkerAuction_All._ui._stc_MainBg:addInputEvent("Mouse_DownScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( 1 )")
  else
    Panel_Window_WorkerAuction_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobalFunc_WorkerAuction_All_ChangeTabByPad( -1 )")
    Panel_Window_WorkerAuction_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobalFunc_WorkerAuction_All_ChangeTabByPad( 1 )")
    Panel_Window_WorkerAuction_All:registerPadEvent(__eConsoleUIPadEvent_LT, "HandleEventLUp_WorkerAuction_All_ChangePage( -1 )")
    Panel_Window_WorkerAuction_All:registerPadEvent(__eConsoleUIPadEvent_RT, "HandleEventLUp_WorkerAuction_All_ChangePage( 1 )")
    Panel_Window_WorkerAuction_All:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "PaGlobal_WorkerAuction_All:DpadRightEvent()")
  end
  PaGlobal_WorkerAuction_All._ui._combo_Sort:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_ComboSort()")
  PaGlobal_WorkerAuction_All._ui._combo_Sort:GetListControl():SetIgnore(false)
  PaGlobal_WorkerAuction_All._ui._combo_Sort:GetListControl():AddSelectEvent("HandleEventLUp_WorkerAuction_All_SetComboSort()")
  PaGlobal_WorkerAuction_All._ui._btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_ResetRegionSelect()")
end
function PaGlobal_WorkerAuction_All:onScreenResize()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  Panel_Window_WorkerAuction_All:ComputePos()
  local screenY = getScreenSizeY()
  local panelSizeY = Panel_Window_WorkerAuction_All:GetSizeY()
  local DialogSizeY = Panel_Npc_Dialog_All:GetSizeY()
  local availableSize = screenY - DialogSizeY
  local adjustSpanY = availableSize / 2 - panelSizeY / 2
  if panelSizeY > availableSize then
    Panel_Window_WorkerAuction_All:SetPosY(0)
  else
    Panel_Window_WorkerAuction_All:SetPosY(adjustSpanY)
  end
  if true == self._isConsole then
    Panel_Window_WorkerAuction_All:SetPosY(self._originPanelYConsole - self._adjustPanelYConsole)
  end
end
function PaGlobal_WorkerAuction_All:createControl()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  for index = 0, PaGlobal_WorkerAuction_All._config._maxSlotCount - 1 do
    local info = {}
    info.slot = UI.cloneControl(PaGlobal_WorkerAuction_All._ui._stc_ListSlotTemplete, PaGlobal_WorkerAuction_All._ui._stc_AuctionArea, "WokerSlotList_" .. index)
    info.slotImage = UI.getChildControl(info.slot, "Static_Image")
    info.txt_SlotName = UI.getChildControl(info.slot, "StaticText_Name")
    info.txt_WorkSpeedTitle = UI.getChildControl(info.slot, "StaticText_WorkSpeedTitle")
    info.txt_WorkSpeedValue = UI.getChildControl(info.slot, "StaticText_WorkSpeedValue")
    info.txt_MoveSpeedTitle = UI.getChildControl(info.slot, "StaticText_MoveSpeedTitle")
    info.txt_MoveSpeedValue = UI.getChildControl(info.slot, "StaticText_MoveSpeedValue")
    info.txt_LuckValue = UI.getChildControl(info.slot, "StaticText_LuckValue")
    info.txt_ActionValue = UI.getChildControl(info.slot, "StaticText_ActionPointValue")
    info.txt_UpgradeChangeValue = UI.getChildControl(info.slot, "StaticText_UpgradeChanceCountValue")
    info.txt_MoneyValue = UI.getChildControl(info.slot, "StaticText_MoneyValue")
    info.btn_Buy = UI.getChildControl(info.slot, "Button_Base")
    info.txt_State = UI.getChildControl(info.slot, "StaticText_State")
    info.txt_State:SetTextMode(__eTextMode_AutoWrap)
    info.txt_levelValue = UI.getChildControl(info.slot, "StaticText_WorkerLevelValue")
    info.txt_WorkSpeedTitle:SetText(info.txt_WorkSpeedTitle:GetText())
    info.txt_MoveSpeedTitle:SetText(info.txt_MoveSpeedTitle:GetText())
    info.icon = {}
    for skillIdx = 1, PaGlobal_WorkerAuction_All._config._maxSkillCount do
      info.iconBg = UI.getChildControl(info.slot, "Static_SkillIconBg_" .. skillIdx)
      info.icon[skillIdx] = UI.getChildControl(info.iconBg, "Static_SkillIcon_" .. skillIdx)
      if PaGlobal_WorkerAuction_All._isConsole == false then
        info.icon[skillIdx]:addInputEvent("Mouse_UpScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( -1 )")
        info.icon[skillIdx]:addInputEvent("Mouse_DownScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( 1 )")
      end
    end
    info.slot:SetPosX(PaGlobal_WorkerAuction_All._config._startX)
    info.slot:SetPosY(PaGlobal_WorkerAuction_All._config._startY + (info.slot:GetSizeY() + PaGlobal_WorkerAuction_All._config._gapY) * index)
    info.slot:SetShow(false)
    local lastSkillNo = PaGlobal_WorkerAuction_All._config._maxSkillCount + 1
    info.lv40SkillIconBg = UI.getChildControl(info.slot, "Static_SkillIconBg_" .. lastSkillNo)
    info.lv40SkillIcon = UI.getChildControl(info.lv40SkillIconBg, "Static_SkillIcon_" .. lastSkillNo)
    if PaGlobal_WorkerAuction_All._isConsole == false then
      local slotBg = UI.getChildControl(info.slot, "Static_ListSlotBG")
      slotBg:addInputEvent("Mouse_UpScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( -1 )")
      slotBg:addInputEvent("Mouse_DownScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( 1 )")
      info.btn_Buy:addInputEvent("Mouse_UpScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( -1 )")
      info.btn_Buy:addInputEvent("Mouse_DownScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( 1 )")
      info.txt_State:addInputEvent("Mouse_UpScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( -1 )")
      info.txt_State:addInputEvent("Mouse_DownScroll", "HandleEventLUp_WorkerAuction_All_ChangePage( 1 )")
      info.txt_State:SetIgnore(false)
    end
    PaGlobal_WorkerAuction_All._slotList[index] = info
    PaGlobal_WorkerAuction_All._targetControlList:push_back(info.slot)
  end
end
function PaGlobal_WorkerAuction_All:checkRandomWorkerOpen()
  if nil ~= Panel_Window_WorkerRandomSelect_All and true == Panel_Window_WorkerRandomSelect_All:GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_COMPLETE_WORKERCONTRACT"))
    return false
  end
  return true
end
function PaGlobal_WorkerAuction_All:prepareOpen()
  PaGlobal_WorkerAuction_All._ui._list2_region:createChildContent(__ePAUIList2ElementManagerType_Tree)
  if nil == Panel_Window_WorkerAuction_All or true == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  local curWaypointKey = getCurrentWaypointKey()
  if nil ~= curWaypointKey then
    PaGlobal_WorkerAuction_All._plantKey = ToClient_convertWaypointKeyToPlantKey(getCurrentWaypointKey())
    PaGlobal_WorkerAuction_All._workerAuctionInfo = RequestGetAuctionInfo()
  end
  PaGlobal_WorkerAuction_All._ui._txt_MoneyValue:SetText(makeDotMoney(getSelfPlayer():get():getMoneyInventory():getMoney_s64()))
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  if _ContentsGroup_WorkerImprovement == true then
    PaGlobal_WorkerAuction_All:setRegionData()
  end
  PaGlobal_WorkerAuction_All:update(PaGlobal_WorkerAuction_All._selectedTab)
  PaGlobal_WorkerAuction_All:open()
  PaGlobal_WorkerAuction_All:onScreenResize()
  PaGlobal_WorkerAuction_All._isResponseWorkerList = true
end
function PaGlobal_WorkerAuction_All:open()
  if nil == Panel_Window_WorkerAuction_All or true == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  Panel_Window_WorkerAuction_All:SetShow(true)
end
function PaGlobal_WorkerAuction_All:update(tabIndex)
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  PaGlobal_WorkerAuction_All:resetSlot()
  PaGlobal_WorkerSkillTooltip_All_Hide()
  if PaGlobal_WorkerAuction_All._ENUMTABINDEX_MARKETLIST == tabIndex then
    PaGlobal_WorkerAuction_All:updateWorkerMarketList()
  elseif PaGlobal_WorkerAuction_All._ENUMTABINDEX_REGISTER == tabIndex then
    PaGlobal_WorkerAuction_All:updateMyWorkerList(false)
  else
    PaGlobal_WorkerAuction_All:updateMyWorkerList(true)
  end
  PaGlobal_WorkerAuction_All:updateMoney()
end
function PaGlobal_WorkerAuction_All:prepareClose()
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  TooltipSimple_Hide()
  PaGlobal_WorkerSkillTooltip_All_Hide()
  PaGlobal_WorkerAuction_All:resetSlot()
  PaGlobal_WorkerAuction_All:resetData()
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  if _ContentsGroup_WorkerImprovement == true then
    self:closeRegionToggle()
    self._selectedRegionKeyRaw = 0
    self._selectSortType = __eSort_Latest
    self._ui._combo_Sort:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKER_SORTFILTER_DATE"))
  end
  PaGlobal_WorkerAuction_All:close()
end
function PaGlobal_WorkerAuction_All:close()
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  Panel_Window_WorkerAuction_All:SetShow(false)
end
function PaGlobal_WorkerAuction_All:resetData()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  PaGlobal_WorkerAuction_All._plantKey = -1
  PaGlobal_WorkerAuction_All._workerAuctionInfo = -1
  PaGlobal_WorkerAuction_All._selectedWorker = -1
  PaGlobal_WorkerAuction_All._currentPage = 1
  PaGlobal_WorkerAuction_All._maxPage = 1
  PaGlobal_WorkerAuction_All._selectedTab = PaGlobal_WorkerAuction_All._ENUMTABINDEX_MARKETLIST
  for ii = 0, #PaGlobal_WorkerAuction_All._radioTabList do
    if ii == PaGlobal_WorkerAuction_All._selectedTab then
      PaGlobal_WorkerAuction_All._radioTabList[ii]:SetCheck(true)
      PaGlobal_WorkerAuction_All._radioTabList[ii]:SetFontColor(PaGlobal_WorkerAuction_All._TABCOLOR_SELECTED)
      local selectBarSapnX = PaGlobal_WorkerAuction_All._radioTabList[ii]:GetSpanSize().x
      local selectBarSapnY = PaGlobal_WorkerAuction_All._ui._stc_SelectBar:GetSpanSize().y
      PaGlobal_WorkerAuction_All._ui._stc_SelectBar:SetSpanSize(selectBarSapnX, selectBarSapnY)
    else
      PaGlobal_WorkerAuction_All._radioTabList[ii]:SetCheck(false)
      PaGlobal_WorkerAuction_All._radioTabList[ii]:SetFontColor(PaGlobal_WorkerAuction_All._TABCOLOR_BASE)
    end
  end
end
function PaGlobal_WorkerAuction_All:updateWorkerMarketList()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  local auctionInfo = PaGlobal_WorkerAuction_All._workerAuctionInfo
  local listCount = 0
  local startIndex = 0
  local endIndex = PaGlobal_WorkerAuction_All._config._maxSlotCount - 1
  if _ContentsGroup_WorkerImprovement == true then
    listCount = auctionInfo:getAuctionFilteredWorkerNoListCount(self._selectedRegionKeyRaw, self._selectSortType)
    startIndex = (PaGlobal_WorkerAuction_All._currentPage - 1) * PaGlobal_WorkerAuction_All._config._maxSlotCount
    if listCount <= startIndex then
      PaGlobal_WorkerAuction_All._currentPage = 1
      startIndex = 0
    end
    endIndex = startIndex + endIndex
  else
    listCount = auctionInfo:getWorkerAuctionCount()
  end
  local uiIndex = 0
  local contents = PaGlobal_WorkerAuction_All._slotList
  PaGlobal_WorkerAuction_All:pageNumberUpdate(listCount)
  if listCount <= 0 then
    for index = 0, PaGlobal_WorkerAuction_All._config._maxSlotCount - 1 do
      contents[index].slot:SetShow(false)
    end
    if _ContentsGroup_WorkerImprovement == true then
      local regionInfoWrapper = getRegionInfoWrapper(self._selectedRegionKeyRaw)
      if regionInfoWrapper ~= nil then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_NO_REGISTER_MARKET"))
      end
    end
    return
  end
  for index = startIndex, endIndex do
    if listCount <= index then
      break
    end
    if uiIndex >= PaGlobal_WorkerAuction_All._config._maxSlotCount then
      break
    end
    do
      local info = contents[uiIndex]
      local workerInfo = PaGlobal_WorkerAuction_All:getWorkerInfo(index, true)
      if nil == workerInfo then
        info.slot:SetShow(false)
        break
      end
      info.slotImage:ChangeTextureInfoNameAsync(workerInfo.icon)
      info.txt_SlotName:SetText(workerInfo.name .. "<PAColor0xFF5A5A5A> (" .. workerInfo.town .. ")<PAOldColor>")
      UI.setLimitTextAndAddTooltip(info.txt_SlotName, info.txt_SlotName:GetText(), "")
      info.txt_UpgradeChangeValue:SetTextHorizonRight()
      if CppEnums.CharacterGradeType.CharacterGradeType_Boss <= workerInfo.grade or CppEnums.CharacterGradeType.CharacterGradeType_Normal == workerInfo.grade then
        info.txt_UpgradeChangeValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_CANNOTUPGRADE"))
        if info.txt_UpgradeChangeValue:GetSizeX() + 10 < info.txt_UpgradeChangeValue:GetTextSizeX() then
          info.txt_UpgradeChangeValue:SetTextHorizonCenter()
        end
        info.txt_UpgradeChangeValue:SetFontColor(PaGlobal_WorkerAuction_All._COLOR_DISABLED)
        UI.setLimitTextAndAddTooltip(info.txt_UpgradeChangeValue, info.txt_UpgradeChangeValue:GetText(), "")
      else
        info.txt_UpgradeChangeValue:SetText(workerInfo.upgradeCount)
        info.txt_UpgradeChangeValue:SetFontColor(PaGlobal_WorkerAuction_All._COLOR_ACTIVE)
      end
      info.txt_WorkSpeedValue:SetText(string.format("%.2f", tostring(workerInfo.workSpeed / 1000000)))
      info.txt_LuckValue:SetText(string.format("%.2f", workerInfo.luck / 10000))
      info.txt_MoveSpeedValue:SetText(string.format("%.2f", workerInfo.moveSpeed / 100))
      info.txt_ActionValue:SetText(workerInfo.maxActionPoint)
      info.txt_MoneyValue:SetText(makeDotMoney(workerInfo.maxPrice))
      info.txt_State:SetShow(false)
      info.btn_Buy:SetShow(true)
      info.btn_Buy:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERTRADEHIRE_BUYBUTTON"))
      info.txt_levelValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_CRAFTLEVEL") .. workerInfo.level)
      workerInfo.workerWrapperLua:foreachSkillList(function(skillIdx, skillStaticStatusWrapper)
        local iconIdx = skillIdx + 1
        if nil == info.icon[iconIdx] then
          info.icon[iconIdx]:addInputEvent("Mouse_On", "")
          info.icon[iconIdx]:addInputEvent("Mouse_Out", "")
          return true
        end
        info.icon[iconIdx]:ChangeTextureInfoNameAsync(skillStaticStatusWrapper:getIconPath())
        local x1, y1, x2, y2 = setTextureUV_Func(info.icon[iconIdx], 0, 0, 44, 44)
        info.icon[iconIdx]:getBaseTexture():setUV(x1, y1, x2, y2)
        info.icon[iconIdx]:setRenderTexture(info.icon[iconIdx]:getBaseTexture())
        if false == PaGlobal_WorkerAuction_All._isConsole then
          info.icon[iconIdx]:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerAuction_All_ChangePage( true," .. uiIndex .. "," .. iconIdx .. "," .. index .. ",true)")
          info.icon[iconIdx]:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerAuction_All_ChangePage()")
        end
        return false
      end)
      if workerInfo.level >= __eWorkerPossibleLevelChangeStorage then
        info.lv40SkillIcon:ChangeTextureInfoNameAsync("new_ui_common_forlua/skill/workerskill/2019.dds")
        if PaGlobal_WorkerAuction_All._isConsole == false then
          info.lv40SkillIcon:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerAuction_All_Lv40SkillDesc( " .. uiIndex .. ", true )")
          info.lv40SkillIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerAuction_All_Lv40SkillDesc( " .. uiIndex .. ", false )")
        end
      else
        info.lv40SkillIcon:ChangeTextureInfoNameAsync("")
        info.lv40SkillIcon:addInputEvent("Mouse_On", "")
        info.lv40SkillIcon:addInputEvent("Mouse_Out", "")
      end
      if true == PaGlobal_WorkerAuction_All._isConsole and nil ~= Panel_Widget_WorkerSkillTooltip_All then
        PaGlobalFunc_WorkerSkillTooltip_All_SetUIBase(PaGlobal_WorkerAuction_All._ui._stc_MainBg)
        info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_WorkerSkillTooltip_All_ShowTooltip(" .. index .. "," .. "true" .. ")")
        info.slot:addInputEvent("Mouse_On", "PaGlobalFunc_WorkerAuction_All_CloseSkillTooltip_Console()")
      end
      if true == workerInfo.isMine then
        info.txt_State:SetShow(true)
        info.btn_Buy:SetShow(false)
        info.txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_REGISTINGNOW"))
      elseif false == PaGlobal_WorkerAuction_All._isConsole then
        info.btn_Buy:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_BuyWorker(" .. index .. ")")
      else
        info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerAuction_All_BuyWorker(" .. index .. ")")
      end
      info.slot:SetShow(true)
      uiIndex = uiIndex + 1
    end
  end
end
function PaGlobal_WorkerAuction_All:updateMyWorkerList(isRegisteredMyWorkerList)
  if nil == Panel_Window_WorkerAuction_All or false == Panel_Window_WorkerAuction_All:GetShow() then
    return
  end
  local auctionInfo = PaGlobal_WorkerAuction_All._workerAuctionInfo
  local listCount
  local uiIndex = 0
  if true == isRegisteredMyWorkerList then
    if _ContentsGroup_WorkerImprovement == true then
      listCount = auctionInfo:getAuctionFilteredWorkerNoListCount(self._selectedRegionKeyRaw, self._selectSortType)
    else
      listCount = auctionInfo:getWorkerAuctionCount()
    end
  elseif _ContentsGroup_WorkerImprovement == true then
    listCount = ToClient_GetFilteredWorkerNoListCount(self._selectedRegionKeyRaw, self._selectSortType)
  else
    local plantKey = PaGlobal_WorkerAuction_All._plantKey
    if nil == plantKey then
      return
    end
    listCount = ToClient_getPlantWaitWorkerListCount(plantKey, 0)
  end
  PaGlobal_WorkerAuction_All:pageNumberUpdate(listCount)
  if listCount <= 0 then
    if false == isRegisteredMyWorkerList then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WOKRERMANAGER_NO_WORKER"))
      return
    elseif _ContentsGroup_WorkerImprovement == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_NO_WORKER_MINE"))
    end
  end
  local startWorkerDataIndex = (PaGlobal_WorkerAuction_All._currentPage - 1) * PaGlobal_WorkerAuction_All._config._maxSlotCount
  if listCount <= startWorkerDataIndex then
    PaGlobal_WorkerAuction_All._currentPage = 1
    startWorkerDataIndex = 0
  end
  local uiIndex = 0
  local contents = PaGlobal_WorkerAuction_All._slotList
  for index = startWorkerDataIndex, startWorkerDataIndex + PaGlobal_WorkerAuction_All._config._maxSlotCount - 1 do
    if listCount <= index then
      break
    end
    do
      local info = contents[uiIndex]
      local workerInfo = PaGlobal_WorkerAuction_All:getWorkerInfo(index, isRegisteredMyWorkerList)
      if nil == workerInfo then
        info.slot:SetShow(false)
        break
      end
      info.txt_UpgradeChangeValue:SetTextHorizonRight()
      if CppEnums.CharacterGradeType.CharacterGradeType_Boss <= workerInfo.grade or CppEnums.CharacterGradeType.CharacterGradeType_Normal == workerInfo.grade then
        info.txt_UpgradeChangeValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_CANNOTUPGRADE"))
        if info.txt_UpgradeChangeValue:GetSizeX() + 10 < info.txt_UpgradeChangeValue:GetTextSizeX() then
          info.txt_UpgradeChangeValue:SetTextHorizonCenter()
        end
        info.txt_UpgradeChangeValue:SetFontColor(PaGlobal_WorkerAuction_All._COLOR_DISABLED)
        UI.setLimitTextAndAddTooltip(info.txt_UpgradeChangeValue, info.txt_UpgradeChangeValue:GetText(), "")
      else
        info.txt_UpgradeChangeValue:SetText(workerInfo.upgradeCount)
        info.txt_UpgradeChangeValue:SetFontColor(PaGlobal_WorkerAuction_All._COLOR_ACTIVE)
      end
      info.slotImage:ChangeTextureInfoNameAsync(workerInfo.icon)
      info.txt_SlotName:SetText(workerInfo.name .. "<PAColor0xFF5A5A5A> (" .. workerInfo.town .. ")<PAOldColor>")
      UI.setLimitTextAndAddTooltip(info.txt_SlotName, info.txt_SlotName:GetText(), "")
      info.txt_WorkSpeedValue:SetText(string.format("%.2f", tostring(workerInfo.workSpeed / 1000000)))
      info.txt_LuckValue:SetText(string.format("%.2f", workerInfo.luck / 10000))
      info.txt_MoveSpeedValue:SetText(string.format("%.2f", workerInfo.moveSpeed / 100))
      info.txt_ActionValue:SetText(workerInfo.actionPoint)
      info.txt_MoneyValue:SetText(makeDotMoney(workerInfo.maxPrice))
      info.txt_levelValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_TEXT_CRAFTLEVEL") .. workerInfo.level)
      workerInfo.workerWrapperLua:foreachSkillList(function(skillIdx, skillStaticStatusWrapper)
        local iconIdx = skillIdx + 1
        if nil == info.icon[iconIdx] then
          info.icon[iconIdx]:addInputEvent("Mouse_On", "")
          info.icon[iconIdx]:addInputEvent("Mouse_Out", "")
          return true
        end
        info.icon[iconIdx]:ChangeTextureInfoNameAsync(skillStaticStatusWrapper:getIconPath())
        local x1, y1, x2, y2 = setTextureUV_Func(info.icon[iconIdx], 0, 0, 44, 44)
        info.icon[iconIdx]:getBaseTexture():setUV(x1, y1, x2, y2)
        info.icon[iconIdx]:setRenderTexture(info.icon[iconIdx]:getBaseTexture())
        if false == PaGlobal_WorkerAuction_All._isConsole then
          info.icon[iconIdx]:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerAuction_All_ChangePage( true," .. uiIndex .. "," .. iconIdx .. "," .. index .. "," .. tostring(isRegisteredMyWorkerList) .. ")")
          info.icon[iconIdx]:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerAuction_All_ChangePage()")
        end
        return false
      end)
      if workerInfo.level >= __eWorkerPossibleLevelChangeStorage then
        info.lv40SkillIcon:ChangeTextureInfoNameAsync("new_ui_common_forlua/skill/workerskill/2019.dds")
        if PaGlobal_WorkerAuction_All._isConsole == false then
          info.lv40SkillIcon:addInputEvent("Mouse_On", "HandleEventOnOut_WorkerAuction_All_Lv40SkillDesc( " .. uiIndex .. ", true )")
          info.lv40SkillIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_WorkerAuction_All_Lv40SkillDesc( " .. uiIndex .. ", false )")
        end
      else
        info.lv40SkillIcon:ChangeTextureInfoNameAsync("")
        info.lv40SkillIcon:addInputEvent("Mouse_On", "")
        info.lv40SkillIcon:addInputEvent("Mouse_Out", "")
      end
      if true == isRegisteredMyWorkerList then
        info.txt_State:SetShow(false)
        info.btn_Buy:SetShow(true)
        _PA_LOG("\236\157\180\235\139\164\237\152\156", Int64toInt32(workerInfo.workerPrice))
        if nil ~= workerInfo.workerPrice and 0 < Int64toInt32(workerInfo.workerPrice) then
          info.txt_MoneyValue:SetText(makeDotMoney(workerInfo.workerPrice))
        end
        if true == PaGlobal_WorkerAuction_All._isConsole and nil ~= Panel_Widget_WorkerSkillTooltip_All then
          PaGlobalFunc_WorkerSkillTooltip_All_SetUIBase(PaGlobal_WorkerAuction_All._ui._stc_MainBg)
          info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_WorkerSkillTooltip_All_ShowTooltip(" .. index .. "," .. "true" .. ")")
          info.slot:addInputEvent("Mouse_On", "PaGlobalFunc_WorkerAuction_All_CloseSkillTooltip_Console()")
        end
        local isEndAuction = auctionInfo:getWorkerAuctionEnd(workerInfo.workerNo)
        if true == isEndAuction then
          info.btn_Buy:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERAUCTION_WORKERGETPRICE"))
          if false == PaGlobal_WorkerAuction_All._isConsole then
            info.btn_Buy:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_ReceiveMoney(" .. index .. ")")
          else
            info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerAuction_All_ReceiveMoney(" .. index .. ")")
          end
        else
          info.btn_Buy:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ITEMMARKETSET_REGISTCANCLE_BTN"))
          if false == PaGlobal_WorkerAuction_All._isConsole then
            info.btn_Buy:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_CancelRegistWorker(" .. index .. ")")
          else
            info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerAuction_All_CancelRegistWorker(" .. index .. ")")
          end
        end
      else
        if true == PaGlobal_WorkerAuction_All._isConsole and nil ~= Panel_Widget_WorkerSkillTooltip_All then
          PaGlobalFunc_WorkerSkillTooltip_All_SetUIBase(PaGlobal_WorkerAuction_All._ui._stc_MainBg)
          info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_WorkerSkillTooltip_All_ShowTooltip(" .. index .. ",false)")
          info.slot:addInputEvent("Mouse_On", "PaGlobalFunc_WorkerAuction_All_CloseSkillTooltip_Console()")
        end
        info.txt_State:SetShow(true)
        info.btn_Buy:SetShow(false)
        if true == workerInfo.isAuctionRegister then
          info.txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_REGISTINGNOW"))
        elseif true == workerInfo.isWorking then
          info.txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_WORKINGNOW"))
        elseif workerInfo.actionPoint ~= workerInfo.maxActionPoint then
          info.txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_WORKERTRADE_RENEW_WORKER_LACK"))
        elseif workerInfo.grade < 2 then
          info.txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_WORKERTRADE_RENEW_GRADE_LACK"))
        elseif workerInfo.workerWrapperLua:getIsSellable() == false then
          info.txt_State:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_CANNOT_REGIST"))
        else
          info.txt_State:SetShow(false)
          info.btn_Buy:SetShow(true)
          info.btn_Buy:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORKERAUCTION_WORKERRESIST_BTN"))
          if false == PaGlobal_WorkerAuction_All._isConsole then
            info.btn_Buy:addInputEvent("Mouse_LUp", "HandleEventLUp_WorkerAuction_All_RegistWorker(" .. index .. ")")
          else
            info.slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_WorkerAuction_All_RegistWorker(" .. index .. ")")
          end
        end
      end
      info.btn_Buy:SetTextMode(__eTextMode_AutoWrap)
      info.btn_Buy:SetText(info.btn_Buy:GetText())
      if info.btn_Buy:GetTextSizeX() < info.btn_Buy:GetSizeX() or info.btn_Buy:GetTextSizeY() < info.btn_Buy:GetSizeY() then
        UI.setLimitTextAndAddTooltip(info.btn_Buy)
      end
      info.slot:SetShow(true)
      uiIndex = uiIndex + 1
    end
  end
end
function PaGlobal_WorkerAuction_All:getWorkEfficiency(workerWrapperLua)
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  if nil == workerWrapperLua then
    return
  end
  local _tempWorkEfficiency = 0
  if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(2) then
    _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(2)
  end
  if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(5) then
    _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(5)
  end
  if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(6) then
    _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(6)
  end
  if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(8) then
    _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(8)
  end
  return _tempWorkEfficiency
end
function PaGlobal_WorkerAuction_All:getWorkerInfo(index, isAuction)
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  local workerWrapperLua, workerNoRaw, workerPrice
  if true == isAuction then
    local auctionInfo = PaGlobal_WorkerAuction_All._workerAuctionInfo
    if _ContentsGroup_WorkerImprovement == true then
      workerNoRaw = auctionInfo:getAuctionFilteredWorkerNoByIndex(self._selectedRegionKeyRaw, self._selectSortType, index)
    else
      workerNoRaw = auctionInfo:getWorkerAuction(index)
    end
    workerWrapperLua = getWorkerWrapperByAuction(workerNoRaw, true)
    workerPrice = auctionInfo:getWorkerAuctionPrice(workerNoRaw)
  elseif _ContentsGroup_WorkerImprovement == true then
    workerNoRaw = PaGlobalFunc_WorkerAuction_All_getFilterWorkerNoByIndex(index)
    workerWrapperLua = getWorkerWrapper(workerNoRaw, false)
  else
    local plantKey = PaGlobal_WorkerAuction_All._plantKey
    if nil ~= plantKey then
      workerNoRaw = ToClient_getPlantWaitWorkerNoRawByIndex(plantKey, index)
      workerWrapperLua = getWorkerWrapper(workerNoRaw, false)
    end
  end
  if nil == workerWrapperLua then
    return nil
  end
  local function getGradeToColorString()
    local auctionAll = PaGlobal_WorkerAuction_All
    local grade = workerWrapperLua:getGradeXXX()
    if CppEnums.CharacterGradeType.CharacterGradeType_Normal == grade then
      return "<PAColor0xFFB9C2DC>"
    elseif CppEnums.CharacterGradeType.CharacterGradeType_Elite == grade then
      return "<PAColor0xFF83A543>"
    elseif CppEnums.CharacterGradeType.CharacterGradeType_Hero == grade then
      return "<PAColor0xFF438DCC>"
    elseif CppEnums.CharacterGradeType.CharacterGradeType_Legend == grade then
      return "<PAColor0xFFF5BA3A>"
    elseif CppEnums.CharacterGradeType.CharacterGradeType_Boss == grade then
      return "<PAColor0xFFD05D48>"
    elseif CppEnums.CharacterGradeType.CharacterGradeType_Assistant == grade then
      return "<PAColor0xFFB9C2DC>"
    end
    return "<PAColor0xFFB9C2DC>"
  end
  local getWorkEfficiency = function(workerWrapperLua)
    local _tempWorkEfficiency = 0
    if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(2) then
      _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(2)
    end
    if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(5) then
      _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(5)
    end
    if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(6) then
      _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(6)
    end
    if _tempWorkEfficiency < workerWrapperLua:getWorkEfficiency(8) then
      _tempWorkEfficiency = workerWrapperLua:getWorkEfficiency(8)
    end
    return _tempWorkEfficiency
  end
  local workerInfo = {
    workerWrapperLua = nil,
    workerNo = nil,
    icon = nil,
    defaultSkillStatus = nil,
    name = nil,
    town = nil,
    level = nil,
    luck = nil,
    moveSpeed = nil,
    maxPrice = nil,
    auctionPrice = nil,
    actionPoint = nil,
    maxActionPoint = nil,
    workSpeed = nil,
    isAuctionRegister = false,
    isWorking = false,
    grade = nil,
    upgradeCount = nil,
    isMine = false
  }
  workerInfo.workerWrapperLua = workerWrapperLua
  workerInfo.workerNo = workerNoRaw
  workerInfo.icon = workerWrapperLua:getWorkerIcon()
  workerInfo.defaultSkillStatus = workerWrapperLua:getWorkerDefaultSkillStaticStatus()
  workerInfo.town = ToClient_GetNodeNameByWaypointKey(workerWrapperLua:getHomeWaypoint())
  workerInfo.name = getGradeToColorString() .. workerWrapperLua:getName() .. "<PAOldColor>"
  workerInfo.level = workerWrapperLua:getLevel()
  workerInfo.luck = workerWrapperLua:getLuck()
  workerInfo.moveSpeed = workerWrapperLua:getMoveSpeed()
  workerInfo.isMine = workerWrapperLua:isMine()
  workerInfo.maxPrice = workerWrapperLua:getWorkerMaxPrice()
  workerInfo.actionPoint = workerWrapperLua:getActionPoint()
  workerInfo.maxActionPoint = workerWrapperLua:getMaxActionPoint()
  workerInfo.workSpeed = getWorkEfficiency(workerWrapperLua)
  workerInfo.isAuctionRegister = workerWrapperLua:getIsAuctionInsert()
  workerInfo.isWorking = workerWrapperLua:isWorking()
  workerInfo.grade = workerWrapperLua:getGrade()
  workerInfo.upgradeCount = workerWrapperLua:getUpgradePoint()
  workerInfo.workerPrice = workerPrice
  return workerInfo
end
function PaGlobal_WorkerAuction_All:updateMoney()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  PaGlobal_WorkerAuction_All._ui._txt_MoneyValue:SetText(makeDotMoney(getSelfPlayer():get():getMoneyInventory():getMoney_s64()))
end
function PaGlobal_WorkerAuction_All:resetSlot()
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  local info = PaGlobal_WorkerAuction_All._slotList
  for ii = 0, PaGlobal_WorkerAuction_All._config._maxSlotCount - 1 do
    info[ii].slot:SetShow(false)
    if false == PaGlobal_WorkerAuction_All._isConsole then
      info[ii].btn_Buy:addInputEvent("Mouse_LUp", "")
      info[ii].slot:addInputEvent("Mouse_On", "")
      info[ii].slot:addInputEvent("Mouse_Out", "")
    else
      info[ii].slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      info[ii].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    end
    for jj = 1, PaGlobal_WorkerAuction_All._config._maxSkillCount do
      info[ii].icon[jj]:ChangeTextureInfoNameAsync("")
      info[ii].icon[jj]:SetSpanSize(1, 2)
      info[ii].icon[jj]:addInputEvent("Mouse_On", "")
      info[ii].icon[jj]:addInputEvent("Mouse_Out", "")
    end
  end
end
function PaGlobal_WorkerAuction_All:pageNumberUpdate(listCount)
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  PaGlobal_WorkerAuction_All._maxPage = math.floor(listCount / PaGlobal_WorkerAuction_All._config._maxSlotCount)
  if 0 ~= listCount % PaGlobal_WorkerAuction_All._config._maxSlotCount then
    PaGlobal_WorkerAuction_All._maxPage = PaGlobal_WorkerAuction_All._maxPage + 1
  end
  if PaGlobal_WorkerAuction_All._ENUMTABINDEX_MARKETLIST == PaGlobal_WorkerAuction_All._selectedTab then
    PaGlobal_WorkerAuction_All._ui._txt_PageValue:SetText(tostring(PaGlobal_WorkerAuction_All._currentPage))
  elseif 0 == PaGlobal_WorkerAuction_All._maxPage then
    if self._currentPage > self._maxPage + 1 then
      self._currentPage = self._maxPage + 1
    end
    PaGlobal_WorkerAuction_All._ui._txt_PageValue:SetText(tostring(PaGlobal_WorkerAuction_All._currentPage) .. " / " .. tostring(PaGlobal_WorkerAuction_All._maxPage + 1))
  else
    if self._currentPage > self._maxPage then
      self._currentPage = self._maxPage
    end
    PaGlobal_WorkerAuction_All._ui._txt_PageValue:SetText(tostring(PaGlobal_WorkerAuction_All._currentPage) .. " / " .. tostring(PaGlobal_WorkerAuction_All._maxPage))
  end
end
function PaGlobal_WorkerAuction_All:AudioPostEvent(idx, value)
  if nil == Panel_Window_WorkerAuction_All then
    return
  end
  if true == PaGlobal_WorkerAuction_All._isConsole then
    _AudioPostEvent_SystemUiForXBOX(idx, value)
  else
    audioPostEvent_SystemUi(idx, value)
  end
end
function PaGlobal_WorkerAuction_All:setRegionData()
  if Panel_Window_WorkerAuction_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  local currentRegionInfoWrapper = getRegionInfoWrapper(selfPlayer:getRegionKeyRaw())
  if currentRegionInfoWrapper == nil then
    return
  end
  local currentTerritoryKeyRaw = currentRegionInfoWrapper:getTerritoryKeyRaw()
  local currentRegionKeyRaw = currentRegionInfoWrapper:getRegionKey()
  local currentTerritoryRegionTotalCount = 0
  local regionPositionValue = 0
  local territoryList = {}
  self._ui._list2_region:getElementManager():clearKey()
  for idx = 1, #self._workerRegionList do
    local workerRegionData = self._workerRegionList[idx]
    local treeElement = self._ui._list2_region:getElementManager():getByKey(toInt64(0, workerRegionData.territoryKeyRaw), false)
    if treeElement == nil then
      treeElement = self._ui._list2_region:getElementManager():getMainElement():createChild(toInt64(0, workerRegionData.territoryKeyRaw))
      table.insert(territoryList, workerRegionData.territoryKeyRaw)
    end
    treeElement:createChild(toInt64(0, workerRegionData.regionKeyRaw + self._separatorNumber))
    if workerRegionData.territoryKeyRaw == currentTerritoryKeyRaw then
      currentTerritoryRegionTotalCount = currentTerritoryRegionTotalCount + 1
      if workerRegionData.regionKeyRaw == currentRegionKeyRaw then
        regionPositionValue = currentTerritoryRegionTotalCount
      end
    end
  end
  for idx = 1, #territoryList do
    self._ui._list2_region:getElementManager():toggle(territoryList[idx])
  end
  local totalCount = #territoryList + currentTerritoryRegionTotalCount
  local controlPos = currentTerritoryKeyRaw + regionPositionValue
  self._verticalControlPos = controlPos / totalCount
  self._list2CurrentIndex = currentTerritoryKeyRaw
end
function PaGlobal_WorkerAuction_All:closeRegionToggle()
  for idx = 0, #PaGlobal_WorkerRandomSelect_All._territoryContentsOption do
    if PaGlobal_WorkerRandomSelect_All._territoryContentsOption[idx] == true then
      local treeElement = self._ui._list2_region:getElementManager():getByKey(toInt64(0, idx), false)
      if treeElement ~= nil then
        treeElement:setIsOpen(false)
      end
    end
  end
  for idx = 0, #PaGlobal_WorkerRandomSelect_All._territoryContentsOption do
    if PaGlobal_WorkerRandomSelect_All._territoryContentsOption[idx] == true then
      local uiContent = self._ui._list2_region:GetContentByKey(toInt64(0, idx))
      if uiContent ~= nil then
        UI.getChildControl(uiContent, "RadioButton_Territory"):SetCheck(false)
      end
    end
  end
end
function PaGlobal_WorkerAuction_All:createComboSort()
  if Panel_Window_WorkerAuction_All == nil then
    return
  end
  if _ContentsGroup_WorkerImprovement == false then
    self._ui._combo_Sort:SetShow(false)
    return
  end
  self._ui._combo_Sort:setListTextHorizonCenter()
  self._ui._combo_Sort:DeleteAllItem()
  self._ui._combo_Sort:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKER_SORTFILTER_DATE"))
  self._ui._combo_Sort:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_WORKER_SORTFILTER_DATE"))
  self._ui._combo_Sort:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_WORKER_SORTFILTER_GRADE"))
  self._ui._combo_Sort:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_WORKER_SORTFILTER_LEVEL"))
end
function PaGlobal_WorkerAuction_All:updateWorkerCount()
  self._ui._list2_region:getElementManager():clearKey()
  self:setRegionData()
  local verticalScroll = UI.getChildControl(self._ui._list2_region, "List2_1_VerticalScroll")
  self._ui._list2_region:moveIndex(self._list2CurrentIndex)
  verticalScroll:SetControlPos(self._verticalControlPos)
end
function PaGlobal_WorkerAuction_All:DpadRightEvent()
  local currentControl = ToClient_getSnappedControl()
  if currentControl == nil then
    return
  end
  local targetTemp, resultTarget
  for ii = 1, #self._targetControlList do
    targetTemp = self._targetControlList[ii]
    if targetTemp:GetShow() == true and targetTemp:IsIgnore() == false and targetTemp ~= currentControl and currentControl:GetParentPosX() < targetTemp:GetParentPosX() then
      if resultTarget == nil then
        resultTarget = targetTemp
      else
        local prevDiffX = math.abs(currentControl:GetParentPosX() - resultTarget:GetParentPosX())
        local prevDiffY = math.abs(currentControl:GetParentPosY() - resultTarget:GetParentPosY())
        local curDiffX = math.abs(currentControl:GetParentPosX() - targetTemp:GetParentPosX())
        local curDiffY = math.abs(currentControl:GetParentPosY() - targetTemp:GetParentPosY())
        if prevDiffX >= curDiffX and prevDiffY > curDiffY then
          resultTarget = targetTemp
        end
      end
    end
  end
  if resultTarget ~= nil then
    ToClient_padSnapChangeToTarget(resultTarget)
  end
end
