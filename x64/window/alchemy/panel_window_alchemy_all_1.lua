function PaGlobal_Alchemy_All:initialize()
  if nil == Panel_Window_Alchemy_All then
    return
  end
  if true == PaGlobal_Alchemy_All._initialize then
    return
  end
  PaGlobal_Alchemy_All._ui.stc_titleBG = UI.getChildControl(Panel_Window_Alchemy_All, "Static_TitleBg")
  PaGlobal_Alchemy_All._ui.txt_alchemyTitle = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_titleBG, "StaticText_AlchemyTitleIcon")
  PaGlobal_Alchemy_All._ui.txt_cookTitle = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_titleBG, "StaticText_CookTitleIcon")
  PaGlobal_Alchemy_All._ui.btn_question = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_titleBG, "Button_Question")
  PaGlobal_Alchemy_All._ui.btn_close = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_titleBG, "Button_Close")
  PaGlobal_Alchemy_All._ui.stc_leftArea = UI.getChildControl(Panel_Window_Alchemy_All, "Static_LeftArea")
  PaGlobal_Alchemy_All._ui.txt_alchemyDesc = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_leftArea, "StaticText_Desc")
  PaGlobal_Alchemy_All._ui.btn_startAlchemy = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_leftArea, "Button_StartAlchemy")
  PaGlobal_Alchemy_All._ui.btn_massProduction = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_leftArea, "Button_MassProduction")
  PaGlobal_Alchemy_All._ui.btn_rateView = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_leftArea, "Button_RateView")
  PaGlobal_Alchemy_All._ui.stc_materialslots = {}
  for i = 1, PaGlobal_Alchemy_All._maxMaterialCount do
    local materialSlot = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_leftArea, "Static_IconSlot" .. i)
    local slotIcon = {}
    slotIcon = SlotItem.new(slotIcon, "MaterialIcon" .. i, 0, materialSlot, {
      createIcon = true,
      createBorder = true,
      createCount = true,
      createCash = true
    })
    slotIcon:createChild()
    slotIcon.icon:SetIgnore(false)
    slotIcon.icon:SetSize(materialSlot:GetSizeX(), materialSlot:GetSizeY())
    slotIcon.bg = materialSlot
    PaGlobal_Alchemy_All._ui.stc_materialslots[i] = slotIcon
  end
  PaGlobal_Alchemy_All._ui.stc_slotFocus = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_leftArea, "Static_Focus")
  PaGlobal_Alchemy_All._ui.stc_upArrow = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_slotFocus, "Static_Up")
  PaGlobal_Alchemy_All._ui.stc_downArrow = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_slotFocus, "Static_Down")
  PaGlobal_Alchemy_All._ui.stc_cookPotBack = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_leftArea, "Static_Cook_Pot_Back")
  PaGlobal_Alchemy_All._ui.stc_cookPotFront = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_leftArea, "Static_Cook_Pot_Front")
  PaGlobal_Alchemy_All._ui.stc_alchemyPotBack = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_leftArea, "Static_Alchemy_Pot_Back")
  PaGlobal_Alchemy_All._ui.stc_alchemyPotFront = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_leftArea, "Static_Alchemy_Pot_Front")
  SlotItem.new(PaGlobal_Alchemy_All._ui.animPushItemCook, "AnimPushItemCook", 0, PaGlobal_Alchemy_All._ui.stc_cookPotBack, {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createCash = true
  })
  PaGlobal_Alchemy_All._ui.animPushItemCook:createChild()
  SlotItem.new(PaGlobal_Alchemy_All._ui.animPushItemAlchemy, "AnimPushItemAlchemy", 0, PaGlobal_Alchemy_All._ui.stc_alchemyPotBack, {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createCash = true
  })
  PaGlobal_Alchemy_All._ui.animPushItemAlchemy:createChild()
  PaGlobal_Alchemy_All._ui.stc_searchArea = UI.getChildControl(Panel_Window_Alchemy_All, "Static_SearchArea")
  PaGlobal_Alchemy_All._ui.chk_knownRecipe = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_searchArea, "CheckButton_ShowOnlyKnownRecipe")
  PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_searchArea, "CheckButton_KnowRecipe_Old")
  PaGlobal_Alchemy_All._ui.edit_searchBox = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_searchArea, "EditBox_Search")
  PaGlobal_Alchemy_All._ui.stc_LSclick_consoleUI = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_searchArea, "Static_LSC_ConsoleUI")
  PaGlobal_Alchemy_All._ui.stc_RSclick_consoleUI = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_searchArea, "Static_RSC_ConsoleUI")
  PaGlobal_Alchemy_All._ui.stc_LTX_consoleUI = UI.getChildControl(PaGlobal_Alchemy_All._ui.edit_searchBox, "StaticText_KeyGuideLTX")
  PaGlobal_Alchemy_All._ui.list2_knowledgeList = UI.getChildControl(Panel_Window_Alchemy_All, "List2_Knowledge")
  PaGlobal_Alchemy_All._ui.txt_emptyKnowledge = UI.getChildControl(PaGlobal_Alchemy_All._ui.list2_knowledgeList, "StaticText_EmptyKnowldege")
  PaGlobal_Alchemy_All._ui.txt_searchFail = UI.getChildControl(PaGlobal_Alchemy_All._ui.list2_knowledgeList, "StaticText_SearchFail")
  PaGlobal_Alchemy_All._ui.frame_descBG = UI.getChildControl(Panel_Window_Alchemy_All, "Frame_Desc")
  local frameContent = PaGlobal_Alchemy_All._ui.frame_descBG:GetFrameContent()
  PaGlobal_Alchemy_All._ui.txt_knowledgeDesc = UI.getChildControl(frameContent, "StaticText_AlchemyDesc")
  PaGlobal_Alchemy_All._ui.scroll_vertical = UI.getChildControl(PaGlobal_Alchemy_All._ui.frame_descBG, "Frame_1_VerticalScroll")
  PaGlobal_Alchemy_All._ui.stc_keyGuideBG = UI.getChildControl(Panel_Window_Alchemy_All, "Static_KeyGuide_ConsoleUI")
  PaGlobal_Alchemy_All._ui.stc_iconY = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_keyGuideBG, "StaticText_Y_ConsoleUI")
  PaGlobal_Alchemy_All._ui.stc_iconX = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_keyGuideBG, "StaticText_X_ConsoleUI")
  PaGlobal_Alchemy_All._ui.stc_iconA = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_keyGuideBG, "StaticText_A_ConsoleUI")
  PaGlobal_Alchemy_All._ui.stc_iconB = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_keyGuideBG, "StaticText_B_ConsoleUI")
  PaGlobal_Alchemy_All._ui.stc_iconLTY = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_keyGuideBG, "StaticText_RecentMenu")
  PaGlobal_Alchemy_All._ui.stc_iconRS = UI.getChildControl(PaGlobal_Alchemy_All._ui.stc_keyGuideBG, "StaticText_RS_ConsoleUI")
  PaGlobal_Alchemy_All._isConsole = _ContentsGroup_UsePadSnapping or _ContentsGroup_RenewUI
  PaGlobal_Alchemy_All:setBasicSetting()
  PaGlobal_Alchemy_All:setConsoleUI()
  PaGlobal_Alchemy_All:registEventHandler()
  PaGlobal_Alchemy_All:validate()
  PaGlobal_Alchemy_All._initialize = true
end
function PaGlobal_Alchemy_All:setBasicSetting()
  PaGlobal_Alchemy_All._ui.stc_cookPotBack:AddEffect("fUI_AlchemyCook01", true, 0, 0)
  PaGlobal_Alchemy_All._ui.stc_alchemyPotBack:AddEffect("fUI_AlchemyCook01", true, 0, 0)
  PaGlobal_Alchemy_All._ui.animPushItemCook.icon:SetShow(false)
  PaGlobal_Alchemy_All._ui.animPushItemAlchemy.icon:SetShow(false)
  PaGlobal_Alchemy_All._ui.txt_alchemyDesc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_Alchemy_All._ui.txt_alchemyDesc:SetText(PaGlobal_Alchemy_All._ui.txt_alchemyDesc:GetText())
  PaGlobal_Alchemy_All._ui.txt_emptyKnowledge:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECIPE_NORECORD"))
  PaGlobal_Alchemy_All._ui.txt_searchFail:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_NO_SEARCH_RESULT"))
  PaGlobal_Alchemy_All._ui.btn_rateView:SetShow(false)
  if _ContentsGroup_LifeSimulator == true then
    PaGlobal_Alchemy_All._ui.btn_rateView:SetSize(PaGlobal_Alchemy_All._ui.btn_rateView:GetTextSizeX() + 15, PaGlobal_Alchemy_All._ui.btn_rateView:GetSizeY())
  end
end
function PaGlobal_Alchemy_All:setConsoleUI()
  if nil == Panel_Window_Alchemy_All then
    return
  end
  if true == PaGlobal_Alchemy_All._isConsole then
    PaGlobal_Alchemy_All._ui.btn_question:SetShow(false)
    PaGlobal_Alchemy_All._ui.btn_close:SetShow(false)
    PaGlobal_Alchemy_All._ui.btn_startAlchemy:SetShow(false)
    PaGlobal_Alchemy_All._ui.btn_massProduction:SetShow(false)
    PaGlobal_Alchemy_All._ui.stc_LSclick_consoleUI:SetShow(true)
    PaGlobal_Alchemy_All._ui.stc_RSclick_consoleUI:SetShow(true)
    PaGlobal_Alchemy_All._ui.stc_LTX_consoleUI:SetShow(true)
    PaGlobal_Alchemy_All._ui.stc_iconY:SetShow(false)
    PaGlobal_Alchemy_All._ui.stc_iconX:SetShow(false)
    PaGlobal_Alchemy_All._ui.stc_iconRS:SetShow(false)
    PaGlobal_Alchemy_All._ui.stc_keyGuideBG:SetShow(true)
    PaGlobal_Alchemy_All:setAlignKeyGuide()
  else
    PaGlobal_Alchemy_All._ui.btn_question:SetShow(true)
    PaGlobal_Alchemy_All._ui.btn_close:SetShow(true)
    PaGlobal_Alchemy_All._ui.stc_keyGuideBG:SetShow(false)
  end
  if true == _ContentsOption_CH_Help then
    PaGlobal_Alchemy_All._ui.btn_question:SetShow(false)
  end
end
function PaGlobal_Alchemy_All:registEventHandler()
  if nil == Panel_Window_Alchemy_All then
    return
  end
  Panel_Window_Alchemy_All:RegisterShowEventFunc(true, "PaGlobalFunc_Alchemy_All_ShowAni()")
  Panel_Window_Alchemy_All:RegisterShowEventFunc(false, "PaGlobalFunc_Alchemy_All_HideAni()")
  registerEvent("ResponseShowAlchemy", "FromClient_Alchemy_All_ResponseShowAlchemy")
  registerEvent("FromClient_AlchemyFailAck", "FromClient_Alchemy_All_AlchemyFailAck")
  registerEvent("FromClient_UpdateRecenltlyAlchemyList", "FromClient_UpdateRecenltlyAlchemyList")
  PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:addInputEvent("Mouse_LUp", "HandleEventLUp_Alchemy_All_CheckKnownRecipeOnly(false)")
  PaGlobal_Alchemy_All._ui.chk_knownRecipe:addInputEvent("Mouse_LUp", "HandleEventLUp_Alchemy_All_CheckKnownRecipeOnly(true)")
  if false == PaGlobal_Alchemy_All._isConsole then
    PaGlobal_Alchemy_All._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Alchemy_All_Close()")
    PaGlobal_Alchemy_All._ui.btn_startAlchemy:addInputEvent("Mouse_LUp", "PaGlobal_Alchemy_All_StartAlchemy(Defines.s64_const.s64_1)")
    PaGlobal_Alchemy_All._ui.btn_massProduction:addInputEvent("Mouse_LUp", "PaGlobal_Alchemy_All_StartMassProduction()")
    PaGlobal_Alchemy_All._ui.edit_searchBox:addInputEvent("Mouse_LUp", "PaGlobal_Alchemy_All_ClearEditBoxSearchText()")
    PaGlobal_Alchemy_All._ui.edit_searchBox:RegistReturnKeyEvent("HandleEventLUp_Alchemy_All_SearchButton()")
    for i = 1, PaGlobal_Alchemy_All._maxMaterialCount do
      PaGlobal_Alchemy_All._ui.stc_materialslots[i].icon:addInputEvent("Mouse_On", "HandleEventOnOut_Alchemy_All_ShowMaterialTooltip(true," .. i .. ")")
      PaGlobal_Alchemy_All._ui.stc_materialslots[i].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Alchemy_All_ShowMaterialTooltip(false)")
      PaGlobal_Alchemy_All._ui.stc_materialslots[i].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Alchemy_All_PopMaterial(" .. i .. ")")
    end
  else
    Panel_Window_Alchemy_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Alchemy_All_InventoryOpen()")
    Panel_Window_Alchemy_All:registerPadEvent(__eConsoleUIPadEvent_Up_LSClick, "HandleEventLUp_Alchemy_All_CheckKnownRecipeOnlyForPad(false)")
    Panel_Window_Alchemy_All:registerPadEvent(__eConsoleUIPadEvent_Up_RSClick, "HandleEventLUp_Alchemy_All_CheckKnownRecipeOnlyForPad(true)")
    Panel_Window_Alchemy_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_Alchemy_All_StartAlchemyForConsole()")
    Panel_Window_Alchemy_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobal_Alchemy_All_SetSearchFocus()")
    Panel_Window_Alchemy_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "PaGlobal_Alchemy_All_ScrollMaterialDescription(true)")
    Panel_Window_Alchemy_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "PaGlobal_Alchemy_All_ScrollMaterialDescription(false)")
    if true == _ContentsGroup_RenewUI then
      PaGlobal_Alchemy_All._ui.edit_searchBox:setXboxVirtualKeyBoardEndEvent("PaGlobal_Alchemy_All_SearchKnowledge")
    else
      PaGlobal_Alchemy_All._ui.edit_searchBox:RegistReturnKeyEvent("HandleEventLUp_Alchemy_All_SearchButton()")
    end
    for i = 1, PaGlobal_Alchemy_All._maxMaterialCount do
      PaGlobal_Alchemy_All._ui.stc_materialslots[i].bg:addInputEvent("Mouse_On", "HandleEventOnOut_Alchemy_All_MaterialSlotFocus(true," .. i .. ")")
      PaGlobal_Alchemy_All._ui.stc_materialslots[i].bg:addInputEvent("Mouse_Out", "HandleEventOnOut_Alchemy_All_MaterialSlotFocus(false)")
      PaGlobal_Alchemy_All._ui.stc_materialslots[i].bg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "PaGlobal_Alchemy_All_ChangeMaterialCount(" .. i .. ", 1)")
      PaGlobal_Alchemy_All._ui.stc_materialslots[i].bg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "PaGlobal_Alchemy_All_ChangeMaterialCount(" .. i .. ", -1)")
    end
  end
  PaGlobal_Alchemy_All._ui.list2_knowledgeList:changeAnimationSpeed(10)
  PaGlobal_Alchemy_All._ui.list2_knowledgeList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_Alchemy_All_CreateKnowledgeListContent")
  PaGlobal_Alchemy_All._ui.list2_knowledgeList:createChildContent(__ePAUIList2ElementManagerType_List)
  if _ContentsGroup_LifeSimulator == true then
    PaGlobal_Alchemy_All._ui.btn_rateView:addInputEvent("Mouse_LUp", "HandleEventLUp_Alchemy_All_OpenRateViewList(true)")
  end
end
function PaGlobal_Alchemy_All:saveCurrentCheckFormValue()
  if Panel_Window_Alchemy_All == nil then
    return
  end
  local currentValue = PaGlobal_Alchemy_All._CheckFormDataForSave.CheckForm_Nothing
  local isCheckedRecentRecipe = PaGlobal_Alchemy_All._ui.chk_knownRecipe:IsCheck()
  local isCheckedKnownRecipe = PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:IsCheck()
  if isCheckedRecentRecipe == true and isCheckedKnownRecipe == true then
    UI.ASSERT_NAME(false, "[failed PaGlobal_Alchemy_All:saveCurrentCheckFormValue()] \235\145\152 \235\139\164 \236\178\180\237\129\172\235\144\152\236\150\180\236\158\136\236\156\188\235\169\180 \236\149\136\235\144\169\235\139\136\235\139\164!!! \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
    currentValue = PaGlobal_Alchemy_All._CheckFormDataForSave.CheckForm_Nothing
  elseif isCheckedRecentRecipe == true then
    currentValue = PaGlobal_Alchemy_All._CheckFormDataForSave.CheckForm_RecentRecipe
  elseif isCheckedKnownRecipe == true then
    currentValue = PaGlobal_Alchemy_All._CheckFormDataForSave.CheckForm_KnownRecipe
  else
    currentValue = PaGlobal_Alchemy_All._CheckFormDataForSave.CheckForm_Nothing
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eLastUsedCheckBoxFormInAlchemyUI, currentValue, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_Alchemy_All:prepareOpen(isCook, installationType)
  if nil == Panel_Window_Alchemy_All then
    return
  end
  if true == Panel_Window_Alchemy_All:GetShow() then
    if isCook == PaGlobal_Alchemy_All._isCook then
      return
    end
    PaGlobalFunc_Alchemy_All_Close()
  end
  PaGlobal_Alchemy_All._isCook = isCook
  PaGlobal_Alchemy_All._ui.stc_cookPotBack:SetShow(isCook)
  PaGlobal_Alchemy_All._ui.stc_cookPotFront:SetShow(isCook)
  PaGlobal_Alchemy_All._ui.stc_alchemyPotBack:SetShow(not isCook)
  PaGlobal_Alchemy_All._ui.stc_alchemyPotFront:SetShow(not isCook)
  if true == isCook then
    PaGlobal_Alchemy_All._ui.txt_cookTitle:SetShow(true)
    PaGlobal_Alchemy_All._ui.txt_alchemyTitle:SetShow(false)
    PaGlobal_Alchemy_All._ui.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelCook\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(PaGlobal_Alchemy_All._ui.btn_question, "\"PanelCook\"")
    PaGlobal_Alchemy_All._ui.chk_knownRecipe:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHECK_ALCHEMY_LIST_DESC"))
    PaGlobal_Alchemy_All._ui.chk_knownRecipe:SetEnableArea(0, 0, PaGlobal_Alchemy_All._ui.chk_knownRecipe:GetSizeX() + PaGlobal_Alchemy_All._ui.chk_knownRecipe:GetTextSizeX() + 5, PaGlobal_Alchemy_All._ui.chk_knownRecipe:GetSizeY())
    PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_SHOW_LEARNT_COOK"))
    PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:SetEnableArea(0, 0, PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:GetSizeX() + PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:GetTextSizeX() + 5, PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:GetSizeY())
    PaGlobal_Alchemy_All._ui.btn_startAlchemy:SetText(PAGetString(Defines.StringSheet_RESOURCE, "COOK_LETSCOOKING"))
    PaGlobal_Alchemy_All._ui.stc_iconLTY:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_RECENTCOOKTITLE"))
  else
    PaGlobal_Alchemy_All._ui.txt_cookTitle:SetShow(false)
    PaGlobal_Alchemy_All._ui.txt_alchemyTitle:SetShow(true)
    PaGlobal_Alchemy_All._ui.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelAlchemy\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(PaGlobal_Alchemy_All._ui.btn_question, "\"PanelAlchemy\"")
    PaGlobal_Alchemy_All._ui.chk_knownRecipe:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHECK_ALCHEMY_LIST_DESC_1"))
    PaGlobal_Alchemy_All._ui.chk_knownRecipe:SetEnableArea(0, 0, PaGlobal_Alchemy_All._ui.chk_knownRecipe:GetSizeX() + PaGlobal_Alchemy_All._ui.chk_knownRecipe:GetTextSizeX() + 5, PaGlobal_Alchemy_All._ui.chk_knownRecipe:GetSizeY())
    PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_SHOW_LEARNT_ALCHEMY"))
    PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:SetEnableArea(0, 0, PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:GetSizeX() + PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:GetTextSizeX() + 5, PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:GetSizeY())
    PaGlobal_Alchemy_All._ui.btn_startAlchemy:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_REFINING"))
    PaGlobal_Alchemy_All._ui.stc_iconLTY:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_RECENTALCHEMYTITLE"))
  end
  audioPostEvent_SystemUi(12, 11)
  _AudioPostEvent_SystemUiForXBOX(12, 11)
  ToClient_AlchemyClearMaterialSlot()
  PaGlobal_Alchemy_All:updateMaterialSlot()
  if true == isCook then
    ToClient_AlchemyReconstructAlchemyKnowledge(30010)
  else
    ToClient_AlchemyReconstructAlchemyKnowledge(31000)
  end
  local loadedCheckBoxFormValue = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eLastUsedCheckBoxFormInAlchemyUI)
  if loadedCheckBoxFormValue == PaGlobal_Alchemy_All._CheckFormDataForSave.CheckForm_Nothing then
    PaGlobal_Alchemy_All._ui.chk_knownRecipe:SetCheck(false)
    PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:SetCheck(false)
  elseif loadedCheckBoxFormValue == PaGlobal_Alchemy_All._CheckFormDataForSave.CheckForm_RecentRecipe then
    PaGlobal_Alchemy_All._ui.chk_knownRecipe:SetCheck(true)
    PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:SetCheck(false)
  elseif loadedCheckBoxFormValue == PaGlobal_Alchemy_All._CheckFormDataForSave.CheckForm_KnownRecipe then
    PaGlobal_Alchemy_All._ui.chk_knownRecipe:SetCheck(false)
    PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:SetCheck(true)
  else
    PaGlobal_Alchemy_All._ui.chk_knownRecipe:SetCheck(false)
    PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:SetCheck(false)
  end
  PaGlobal_Alchemy_All:updateKnowledgeList()
  Panel_Window_Alchemy_All:ComputePos()
  if false == PaGlobal_Alchemy_All._isConsole then
    Panel_Window_Alchemy_All:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Window_Alchemy_All:GetSizeX() - 5)
    Panel_Window_Alchemy_All:SetPosY(Panel_Window_Inventory_All:GetPosY())
    Inventory_SetFunctor(PaGlobal_Alchemy_All_InventoryFilterFunction, PaGlobal_Alchemy_All_InventoryRClickFunction, PaGlobalFunc_Alchemy_All_Close, nil)
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_SetInventoryDragNoUse(Panel_Window_Alchemy_All)
    else
      FGlobal_SetInventoryDragNoUse(Panel_Window_Alchemy_All)
    end
    InventoryWindow_Show()
  else
    if true == isCook then
      PaGlobal_Alchemy_All._ui.stc_iconY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "COOK_LETSCOOKING"))
    else
      PaGlobal_Alchemy_All._ui.stc_iconY:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_REFINING"))
    end
    PaGlobal_Alchemy_All:setAlignKeyGuide()
  end
  if _ContentsGroup_LifeSimulator == true then
    PaGlobal_Alchemy_All._ui.btn_rateView:SetShow(false)
  end
  PaGlobal_Alchemy_All:open()
end
function PaGlobal_Alchemy_All:open()
  if nil == Panel_Window_Alchemy_All then
    return
  end
  Panel_Window_Alchemy_All:SetShow(true)
end
function PaGlobal_Alchemy_All:prepareClose()
  if nil == Panel_Window_Alchemy_All then
    return
  end
  PaGlobal_Alchemy_All_ClearEditFocus()
  if false == Panel_Window_Alchemy_All:IsShow() then
    return
  end
  PaGlobal_Alchemy_All._filterText = ""
  PaGlobal_Alchemy_All._ui.animPushItemAlchemy.icon:SetShow(false)
  PaGlobal_Alchemy_All._ui.animPushItemCook.icon:SetShow(false)
  if nil ~= PaGlobal_RecentCook then
    PaGlobal_RecentCook:closePanel()
  end
  InventoryWindow_Close()
  if _ContentsGroup_LifeSimulator == true then
    if PaGloabl_Alchemy_RateViewList_Close ~= nil then
      PaGloabl_Alchemy_RateViewList_Close(false)
    end
    PaGlobal_Alchemy_All._isPanelRecentCookOpened = false
  end
  PaGlobal_Alchemy_All:close()
end
function PaGlobal_Alchemy_All:close()
  if nil == Panel_Window_Alchemy_All then
    return
  end
  Panel_Window_Alchemy_All:SetShow(false)
end
function PaGlobal_Alchemy_All:validate()
  if nil == Panel_Window_Alchemy_All then
    return
  end
  PaGlobal_Alchemy_All._ui.stc_titleBG:isValidate()
  PaGlobal_Alchemy_All._ui.txt_alchemyTitle:isValidate()
  PaGlobal_Alchemy_All._ui.txt_cookTitle:isValidate()
  PaGlobal_Alchemy_All._ui.btn_question:isValidate()
  PaGlobal_Alchemy_All._ui.btn_close:isValidate()
end
function PaGlobal_Alchemy_All:clearFocusEdit()
  if nil == GetFocusEdit() or GetFocusEdit():GetKey() ~= PaGlobal_Alchemy_All._ui.edit_searchBox:GetKey() then
    return
  end
  ClearFocusEdit()
end
function PaGlobal_Alchemy_All:cancelAlchemy()
  ToClient_AlchemyCancel()
end
function PaGlobal_Alchemy_All:updateCheckButton(isRecent)
  if PaGlobal_Alchemy_All._ui.chk_knownRecipe:IsCheck() == true and PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:IsCheck() == true then
    PaGlobal_Alchemy_All._ui.chk_knownRecipe:SetCheck(isRecent)
    PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:SetCheck(not isRecent)
  end
  self:saveCurrentCheckFormValue()
end
function PaGlobal_Alchemy_All:updateKnowledgeList()
  if PaGlobal_Alchemy_All._ui.chk_knownRecipe:IsCheck() == true then
    self:updateRecentlyKnowledgeList()
  else
    PaGlobal_Alchemy_All:clearKnowledgeList()
    local isOnlyName = true
    ToClient_AlchemySetKnowledgeFilter(PaGlobal_Alchemy_All._ui.chk_onlyKnownRecipe:IsCheck(), isOnlyName, PaGlobal_Alchemy_All._filterText)
    local countFilteredKnowledge = ToClient_AlchemyGetCountFilteredKnowledge()
    for i = 1, countFilteredKnowledge do
      PaGlobal_Alchemy_All._ui.list2_knowledgeList:getElementManager():pushKey(ToClient_AlchemyGetFilteredKnowledgeIndex(i - 1))
    end
    if 0 == Int64toInt32(PaGlobal_Alchemy_All._ui.list2_knowledgeList:getElementManager():getSize()) then
      local isSearchEnabled = PaGlobal_Alchemy_All._filterText ~= ""
      PaGlobal_Alchemy_All._ui.txt_searchFail:SetShow(isSearchEnabled)
      PaGlobal_Alchemy_All._ui.txt_emptyKnowledge:SetShow(not isSearchEnabled)
    else
      PaGlobal_Alchemy_All._ui.txt_searchFail:SetShow(false)
      PaGlobal_Alchemy_All._ui.txt_emptyKnowledge:SetShow(false)
    end
  end
end
function PaGlobal_Alchemy_All:updateRecentlyKnowledgeList()
  if PaGlobal_Alchemy_All == nil then
    return
  end
  self:clearKnowledgeList()
  ToClient_setRecentlyProcessAlchemyFilter(self._isCook, PaGlobal_Alchemy_All._filterText)
  local countFilteredKnowledge = ToClient_AlchemyGetCountFilteredKnowledge()
  for i = 1, countFilteredKnowledge do
    self._ui.list2_knowledgeList:getElementManager():pushKey(ToClient_AlchemyGetFilteredKnowledgeIndex(i - 1))
  end
  if 0 == Int64toInt32(self._ui.list2_knowledgeList:getElementManager():getSize()) then
    local isSearchEnabled = self._filterText ~= ""
    self._ui.txt_searchFail:SetShow(isSearchEnabled)
    self._ui.txt_emptyKnowledge:SetShow(not isSearchEnabled)
  else
    self._ui.txt_searchFail:SetShow(false)
    self._ui.txt_emptyKnowledge:SetShow(false)
  end
end
function PaGlobal_Alchemy_All:clearKnowledgeList()
  PaGlobal_Alchemy_All._selectedKnowledge = -1
  PaGlobal_Alchemy_All._ui.list2_knowledgeList:getElementManager():clearKey()
  if PaGlobal_Alchemy_All._isCook then
    PaGlobal_Alchemy_All:setKnowledgeDescriptionText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_WANTMORE_SELECT_COOKKNOWLEDGE"))
  else
    PaGlobal_Alchemy_All:setKnowledgeDescriptionText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_WANTMORE_SELECT_ALCHEMYKNOWLEDGE"))
  end
end
function PaGlobal_Alchemy_All:updateMaterialSlot()
  local countSlotPushed = ToClient_AlchemyGetCountSlotWithMaterial()
  for slotIndex = 1, PaGlobal_Alchemy_All._maxMaterialCount do
    local itemStaticWrapper = ToClient_AlchemyGetItemStaticAtMaterialSlot(slotIndex - 1)
    if slotIndex <= countSlotPushed then
      if nil ~= itemStaticWrapper then
        local itemCount = ToClient_AlchemyGetCountItemAtMaterialSlot_s64(slotIndex - 1)
        PaGlobal_Alchemy_All._ui.stc_materialslots[slotIndex]:setItemByStaticStatus(itemStaticWrapper, itemCount)
      else
        PaGlobal_Alchemy_All._ui.stc_materialslots[slotIndex]:clearItem()
      end
    else
      PaGlobal_Alchemy_All._ui.stc_materialslots[slotIndex]:clearItem()
    end
    if true == PaGlobal_Alchemy_All._isConsole and PaGlobal_Alchemy_All._focusedMaterialSlotIndex == slotIndex then
      PaGlobal_Alchemy_All._ui.stc_slotFocus:SetPosX(PaGlobal_Alchemy_All._ui.stc_materialslots[slotIndex].bg:GetPosX())
      PaGlobal_Alchemy_All._ui.stc_slotFocus:SetPosY(PaGlobal_Alchemy_All._ui.stc_materialslots[slotIndex].bg:GetPosY())
      if nil ~= itemStaticWrapper then
        PaGlobal_Alchemy_All._ui.stc_upArrow:SetShow(true)
        PaGlobal_Alchemy_All._ui.stc_downArrow:SetShow(true)
      else
        PaGlobal_Alchemy_All._ui.stc_upArrow:SetShow(false)
        PaGlobal_Alchemy_All._ui.stc_downArrow:SetShow(false)
      end
    end
  end
  if true == PaGlobal_Alchemy_All._isConsole then
    local slotFocusShow = PaGlobal_Alchemy_All._focusedMaterialSlotIndex > 0
    PaGlobal_Alchemy_All._ui.stc_slotFocus:SetShow(slotFocusShow)
    if countSlotPushed > 0 then
      PaGlobal_Alchemy_All._ui.stc_iconY:SetShow(true)
      PaGlobal_Alchemy_All._ui.stc_iconB:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMY_REMOVE_MATERIAL"))
    else
      PaGlobal_Alchemy_All._ui.stc_iconY:SetShow(false)
      PaGlobal_Alchemy_All._ui.stc_iconB:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CLOSE"))
    end
    if nil ~= PaGlobalFunc_InventoryInfo_GetShow then
      if false == PaGlobalFunc_InventoryInfo_GetShow() then
        PaGlobal_Alchemy_All._ui.stc_iconA:SetShow(true)
      else
        PaGlobal_Alchemy_All._ui.stc_iconA:SetShow(false)
      end
    end
    PaGlobal_Alchemy_All:setAlignKeyGuide()
  end
end
function PaGlobal_Alchemy_All:clearMaterialSlot()
  ToClient_AlchemyClearMaterialSlot()
  PaGlobal_Alchemy_All:updateMaterialSlot()
end
function PaGlobal_Alchemy_All:playPushItemAnimation(invenSlotIndex, itemCount)
  local itemWrapper = getInventoryItem(invenSlotIndex)
  local potBack = PaGlobal_Alchemy_All._ui.stc_cookPotBack
  local staticAnimPushItem = PaGlobal_Alchemy_All._ui.animPushItemCook
  local posY = -100
  local endPosY = 80
  local timeRate = 1
  if false == PaGlobal_Alchemy_All._isCook then
    potBack = PaGlobal_Alchemy_All._ui.stc_alchemyPotBack
    staticAnimPushItem = PaGlobal_Alchemy_All._ui.animPushItemAlchemy
    posY = -65
    endPosY = 100
    timeRate = 0.9
  end
  local posX = (potBack:GetSizeX() - staticAnimPushItem.icon:GetSizeX()) * 0.5
  staticAnimPushItem:setItemByStaticStatus(itemWrapper:getStaticStatus(), itemCount)
  audioPostEvent_SystemUi(12, 12)
  _AudioPostEvent_SystemUiForXBOX(12, 12)
  local aniCtrl = staticAnimPushItem.icon
  aniCtrl:SetShow(true)
  aniCtrl:EraseAllEffect()
  aniCtrl:AddEffect("fUI_AlchemySplash01", false, 0, 0)
  local aniInfo = aniCtrl:addMoveAnimation(0 * timeRate, 1.5 * timeRate, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  aniInfo.StartHorizonType = CppEnums.PA_UI_ALIGNHORIZON.PA_UI_HORIZON_LEFT
  aniInfo.EndHorizonType = CppEnums.PA_UI_ALIGNHORIZON.PA_UI_HORIZON_LEFT
  aniInfo:SetStartPosition(posX, posY)
  aniInfo:SetEndPosition(posX, endPosY)
  local aniInfo2 = aniCtrl:addRotateAnimation(0 * timeRate, 1.5 * timeRate, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  aniInfo2:SetStartRotate(0)
  aniInfo2:SetEndRotate(1)
  aniInfo2:SetRotateCount(1)
end
function PaGlobal_Alchemy_All:pushItemFromInventory(itemCount, invenSlotIndex)
  local countSlotPushed = ToClient_AlchemyGetCountSlotWithMaterial()
  _PA_ASSERT(countSlotPushed <= PaGlobal_Alchemy_All._maxMaterialCount, "\236\139\164\236\160\156 \236\130\172\236\154\169 \236\164\145\236\157\184 \236\138\172\235\161\175 \234\176\156\236\136\152\234\176\128 \237\151\136\236\154\169\235\144\156 \234\176\156\236\136\152\235\179\180\235\139\164 \235\167\142\236\138\181\235\139\136\235\139\164.")
  if countSlotPushed == PaGlobal_Alchemy_All._maxMaterialCount and false == ToClient_AlchemyIsInvenSlotPushedInMaterialSlot(invenSlotIndex) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_CANT_ADD_ITEM"))
    return
  end
  PaGlobal_Alchemy_All:playPushItemAnimation(invenSlotIndex, itemCount)
  ToClient_AlchemyPushItemFromInventory(invenSlotIndex, itemCount)
  PaGlobal_Alchemy_All:updateMaterialSlot()
  if _ContentsGroup_LifeSimulator == true then
    if self._isCook == true then
      PaGloabl_Alchemy_RateViewList_CalculateCook()
    else
      PaGloabl_Alchemy_RateViewList_CalculateAlchemy()
    end
  end
end
function PaGlobal_Alchemy_All:showInventoryNumpad(slotIndex, itemCount)
  if true == checkAlchemyAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_NOT_CHANGE"))
    return
  end
  Panel_NumberPad_Show(true, itemCount, slotIndex, PaGlobal_Alchemy_All_NumberPadConfirmClicked)
end
function PaGlobal_Alchemy_All:setKnowledgeDescriptionText(text)
  if false == PaGlobal_Alchemy_All._isConsole then
    PaGlobal_Alchemy_All._ui.txt_knowledgeDesc:SetTextMode(__eTextMode_AutoWrap)
  else
    PaGlobal_Alchemy_All._ui.txt_knowledgeDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
    PaGlobal_Alchemy_All._ui.txt_knowledgeDesc:setLineCountByLimitAutoWrap(6)
  end
  PaGlobal_Alchemy_All._ui.txt_knowledgeDesc:SetText(text)
  local frameContent = PaGlobal_Alchemy_All._ui.frame_descBG:GetFrameContent()
  frameContent:SetSize(frameContent:GetSizeX(), PaGlobal_Alchemy_All._ui.txt_knowledgeDesc:GetSizeY())
  UIScroll.SetButtonSize(PaGlobal_Alchemy_All._ui.scroll_vertical, PaGlobal_Alchemy_All._ui.frame_descBG:GetSizeY(), frameContent:GetSizeY() + 10)
  PaGlobal_Alchemy_All._ui.scroll_vertical:SetControlPos(0)
  PaGlobal_Alchemy_All._ui.frame_descBG:UpdateContentScroll()
  PaGlobal_Alchemy_All._ui.frame_descBG:UpdateContentPos()
end
function PaGlobal_Alchemy_All:setAlignKeyGuide()
  local keyGuides = {
    PaGlobal_Alchemy_All._ui.stc_iconLTY,
    PaGlobal_Alchemy_All._ui.stc_iconY,
    PaGlobal_Alchemy_All._ui.stc_iconX,
    PaGlobal_Alchemy_All._ui.stc_iconRS,
    PaGlobal_Alchemy_All._ui.stc_iconA,
    PaGlobal_Alchemy_All._ui.stc_iconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, PaGlobal_Alchemy_All._ui.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
