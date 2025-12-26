local UI_color = Defines.Color
function PaGlobal_Menu_Remake:initialize()
  if true == PaGlobal_Menu_Remake._initialize then
    return
  end
  self:commonInitControl()
  self:consoleInitControl()
  self:switchPlatform()
  PaGlobal_Menu_Remake._isLeft = 0 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMenuOpenWay)
  PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(true)
  PaGlobal_Menu_Remake:hideTooltip()
  PaGlobal_Menu_Remake:resetMenu(true)
  PaGlobal_Menu_Remake:setMenuOpenWayBtn()
  PaGlobal_Menu_Remake:setCustomize_menu(false)
  PaGlobal_Menu_Remake:resizeMenu()
  if false == isGameServiceTypeConsole() and false == _ContentsGroup_ExpirienceWiki_KorVersion then
    PaGlobal_Menu_Remake.DEFAULT_HEADER_MENU_INDEX[1] = 1
  end
  PaGlobal_Menu_Remake:registEventHandler()
  PaGlobal_Menu_Remake:validate()
  PaGlobal_Menu_Remake._initialize = true
end
function PaGlobal_Menu_Remake:commonInitControl()
  PaGlobal_Menu_Remake._ui.stc_topGroup = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_Top_Group")
  PaGlobal_Menu_Remake._ui.stc_menuGroup = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_Menu_Group")
  PaGlobal_Menu_Remake._ui.stc_searchGroup = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_Search_Group")
  PaGlobal_Menu_Remake._ui.stc_searchResultGroup = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_Search_Result_Group")
  PaGlobal_Menu_Remake._ui.radiobtn_searchResult = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_searchResultGroup, "RadioButton_Result_Btn")
  PaGlobal_Menu_Remake._ui.stc_subMenuGroup = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_SubMenu_Group")
  PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_MenuSelect_Desc_Group")
  PaGlobal_Menu_Remake._ui.stc_submenu_BG = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_Submenu_BG")
  PaGlobal_Menu_Remake._ui.stc_submenu_highlight = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_SubMenu_Highlight")
  PaGlobal_Menu_Remake._ui.stc_header_button_group = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_topGroup, "Static_Header_Button_Group")
  PaGlobal_Menu_Remake._ui.stc_header_button = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_header_button_group, "RadioButton_Header_Button")
  PaGlobal_Menu_Remake._ui.stc_header_button_title_group = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_header_button_group, "Static_Header_Button_Title_Group")
  PaGlobal_Menu_Remake._ui.stctxt_header_button_title = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_header_button_title_group, "StaticText_Header_Button_Title")
  PaGlobal_Menu_Remake._ui.stc_header_title_shape1 = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_header_button_title_group, "Static_Header_Title_Shape1")
  PaGlobal_Menu_Remake._ui.stc_header_title_shape2 = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_header_button_title_group, "Static_Header_Title_Shape2")
  PaGlobal_Menu_Remake._beforeTitleShape1SpanX = PaGlobal_Menu_Remake._ui.stc_header_title_shape1:GetSpanSize().x
  PaGlobal_Menu_Remake._beforeTitleShape2SpanX = PaGlobal_Menu_Remake._ui.stc_header_title_shape2:GetSpanSize().x
  PaGlobal_Menu_Remake._ui.stc_header_interface_group = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_topGroup, "Static_Header_Interface_Group")
  PaGlobal_Menu_Remake._ui.edit_searchTxt = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_searchGroup, "Edit_Search_Txt")
  PaGlobal_Menu_Remake._ui.stctxt_title_icon = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_header_interface_group, "StaticText_TitleIcon")
  PaGlobal_Menu_Remake._ui.stctxt_title_icon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_RENEW_MENU_TITLE"))
  PaGlobal_Menu_Remake._ui.stctxt_title_icon:SetEnableArea(0, 0, PaGlobal_Menu_Remake._ui.stctxt_title_icon:GetSizeX() + PaGlobal_Menu_Remake._ui.stctxt_title_icon:GetTextSizeX() + 15, PaGlobal_Menu_Remake._ui.stctxt_title_icon:GetSizeY())
  PaGlobal_Menu_Remake._ui.stctxt_customize_desc = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_header_interface_group, "StaticText_CustomizeMode_Desc")
  PaGlobal_Menu_Remake._ui.stctxt_customize_desc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_Menu_Remake._ui.stctxt_customize_desc:SetText(PaGlobal_Menu_Remake._ui.stctxt_customize_desc:GetText())
  PaGlobal_Menu_Remake._ui.btn_cancel = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_header_interface_group, "Button_Cancel")
  PaGlobal_Menu_Remake._ui.btn_commit = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_header_interface_group, "Button_Commit")
  PaGlobal_Menu_Remake._ui.btn_changeUi = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_header_interface_group, "Button_Change_UI")
  PaGlobal_Menu_Remake._ui.btn_openway = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_header_interface_group, "Button_OpenWay")
  PaGlobal_Menu_Remake._ui.btn_customizeUi = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_header_interface_group, "Button_Customize_Menu")
  PaGlobal_Menu_Remake._ui.stc_menuSelect_desc = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group, "StaticText_MenuSelect_Desc")
  PaGlobal_Menu_Remake._ui.stc_menuSelect_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_EDITSLOTTEXT"))
  PaGlobal_Menu_Remake._ui.stctxt_header_button_title:SetText("")
  PaGlobal_Menu_Remake._ui.stc_header_title_shape1:SetShow(false)
  PaGlobal_Menu_Remake._ui.stc_header_title_shape2:SetShow(false)
  PaGlobal_Menu_Remake._ui.stc_menu_highlight = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_Menu_Highlight")
  PaGlobal_Menu_Remake._ui.radiobtn_menu = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_menuGroup, "RadioButton_Menu_Btn")
  PaGlobal_Menu_Remake._ui.radiobtn_sub_menu = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_subMenuGroup, "RadioButton_SubMenu")
  PaGlobal_Menu_Remake._ui.stc_recentMenuSet = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_RecentMenuGroup")
  PaGlobal_Menu_Remake._ui.btn_recentMenuFixed = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_recentMenuSet, "Button_Fixed")
  PaGlobal_Menu_Remake._ui.btn_recentMenuDelete = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_recentMenuSet, "Button_Delete")
  PaGlobal_Menu_Remake._ui.stc_arrowKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_menuGroup, "StaticText_ArrowKeyGuide")
  PaGlobal_Menu_Remake._ui.stc_arrowKeyGuide:ComputePos()
  PaGlobal_Menu_Remake._ui.stc_enterKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_menuGroup, "StaticText_EnterKeyGuide")
  local enterGuideSpanSizeX = PaGlobal_Menu_Remake._ui.stc_arrowKeyGuide:GetPosX() + PaGlobal_Menu_Remake._ui.stc_arrowKeyGuide:GetSizeX() + PaGlobal_Menu_Remake._ui.stc_arrowKeyGuide:GetTextSizeX() + 10
  PaGlobal_Menu_Remake._ui.stc_enterKeyGuide:SetSpanSize(enterGuideSpanSizeX, PaGlobal_Menu_Remake._ui.stc_enterKeyGuide:GetSpanSize().y)
  PaGlobal_Menu_Remake._ui.stc_enterKeyGuide:ComputePos()
  PaGlobal_Menu_Remake._ui.stc_subMenuKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_subMenuGroup, "StaticText_SettingKeyGuide")
  local keyguideSpanSizeX = PaGlobal_Menu_Remake._ui.stc_subMenuKeyGuide:GetSizeX() + PaGlobal_Menu_Remake._ui.stc_subMenuKeyGuide:GetTextSizeX()
  PaGlobal_Menu_Remake._ui.stc_subMenuKeyGuide:SetSpanSize(keyguideSpanSizeX, PaGlobal_Menu_Remake._ui.stc_subMenuKeyGuide:GetSpanSize().y)
  PaGlobal_Menu_Remake._ui.stc_subMenuKeyGuide:ComputePos()
  PaGlobal_Menu_Remake._ui.stc_newIconTemplete = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_NEW")
  PaGlobal_Menu_Remake._ui.stc_hotIconTemplete = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_HOT")
  PaGlobal_Menu_Remake._ui.stc_eventIconTemplete = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_EVENT")
  PaGlobal_Menu_Remake._ui.stc_updateIconTemplete = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_UPDATE")
  Panel_Widget_Menu_Remake:setDynamicScalePanelIndex(__eDynamicScalePanel_Menu)
  PaGlobal_Menu_Remake._ui.btn_scaleResize_left = UI.getChildControl(Panel_Widget_Menu_Remake, "Button_ScaleResize_LeftTop")
  PaGlobal_Menu_Remake._ui.btn_scaleResize_right = UI.getChildControl(Panel_Widget_Menu_Remake, "Button_ScaleResize_RightTop")
  PaGlobal_Menu_Remake._ui.btn_nextHeaderMenu = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_Arrow_Right")
  PaGlobal_Menu_Remake._ui.btn_prevHeaderMenu = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_Arrow_Left")
  PaGlobal_Menu_Remake._ui.stc_nextHeaderMenuKeyGuide = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_Console_Page_Right")
  PaGlobal_Menu_Remake._ui.stc_prevHeaderMenuKeyGuide = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_Console_Page_Left")
  PaGlobal_Menu_Remake._ui.btn_nextHeaderMenu:SetShow(true == _ContentsGroup_ESCMenuAddNewLine)
  PaGlobal_Menu_Remake._ui.btn_prevHeaderMenu:SetShow(true == _ContentsGroup_ESCMenuAddNewLine)
  PaGlobal_Menu_Remake._ui.stc_nextHeaderMenuKeyGuide:SetShow(true == _ContentsGroup_ESCMenuAddNewLine)
  PaGlobal_Menu_Remake._ui.stc_prevHeaderMenuKeyGuide:SetShow(true == _ContentsGroup_ESCMenuAddNewLine)
  PaGlobal_Menu_Remake._ui.stc_eventBanner = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_Event_Banner")
end
function PaGlobal_Menu_Remake:consoleInitControl()
  PaGlobal_Menu_Remake._ui_console.stc_arrowKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_menuGroup, "StaticText_MoveKeyGuide_ConsoleUI")
  PaGlobal_Menu_Remake._ui_console.stc_enterKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_menuGroup, "StaticText_EnterKeyGuide_ConsoleUI")
  PaGlobal_Menu_Remake._ui_console.stc_subMenuKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_subMenuGroup, "StaticText_SettingKeyGuide_ConsoleUI")
  PaGlobal_Menu_Remake._ui_console.stc_keyGuideLeftBg = UI.getChildControl(Panel_Widget_Menu_Remake, "StaticText_KeyGuideBg_ConsoleUILeft")
  PaGlobal_Menu_Remake._ui_console.stc_searchLeftKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui_console.stc_keyGuideLeftBg, "StaticText_SearchKeyGuide_ConsoleUI")
  PaGlobal_Menu_Remake._ui_console.stc_changeLeftKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui_console.stc_keyGuideLeftBg, "StaticText_ChangeKeyGuide_ConsoleUI")
  PaGlobal_Menu_Remake._ui_console.stc_customLeftKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui_console.stc_keyGuideLeftBg, "StaticText_CustomKeyGuide_ConsoleUI")
  PaGlobal_Menu_Remake._ui_console.stc_openwayLeftKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui_console.stc_keyGuideLeftBg, "StaticText_OpenWayGuide_ConsoleUI")
  PaGlobal_Menu_Remake._ui_console.stc_saveLeftKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui_console.stc_keyGuideLeftBg, "StaticText_Save_ConsoleUI")
  PaGlobal_Menu_Remake._ui_console.stc_keyGuideRightBg = UI.getChildControl(Panel_Widget_Menu_Remake, "StaticText_KeyGuideBg_ConsoleUIRight")
  PaGlobal_Menu_Remake._ui_console.stc_searchRightKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui_console.stc_keyGuideRightBg, "StaticText_SearchKeyGuide_ConsoleUI")
  PaGlobal_Menu_Remake._ui_console.stc_changeRightKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui_console.stc_keyGuideRightBg, "StaticText_ChangeKeyGuide_ConsoleUI")
  PaGlobal_Menu_Remake._ui_console.stc_customRightKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui_console.stc_keyGuideRightBg, "StaticText_CustomKeyGuide_ConsoleUI")
  PaGlobal_Menu_Remake._ui_console.stc_openwayRightKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui_console.stc_keyGuideRightBg, "StaticText_OpenWayGuide_ConsoleUI")
  PaGlobal_Menu_Remake._ui_console.stc_saveRightKeyGuide = UI.getChildControl(PaGlobal_Menu_Remake._ui_console.stc_keyGuideRightBg, "StaticText_Save_ConsoleUI")
  PaGlobal_Menu_Remake._ui_console.stc_seasonPassBanner = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_SeasonPass_Banner")
  PaGlobal_Menu_Remake._ui_console.stc_growthPassBanner = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_GrowthPass_Banner")
  PaGlobal_Menu_Remake._ui_console.stc_growthPassBanner_PS = UI.getChildControl(Panel_Widget_Menu_Remake, "Static_GrowthPass_Banner_PS")
  if true == ToClient_isConsole() then
    PaGlobal_Menu_Remake._ui_console.stc_changeLeftKeyGuide:SetShow(false)
    PaGlobal_Menu_Remake._ui_console.stc_changeRightKeyGuide:SetShow(false)
  end
  PaGlobal_Menu_Remake._ui_console.stc_arrowKeyGuide:ComputePos()
  local enterGuideSpanSizeX = PaGlobal_Menu_Remake._ui_console.stc_arrowKeyGuide:GetPosX() + PaGlobal_Menu_Remake._ui_console.stc_arrowKeyGuide:GetSizeX() + PaGlobal_Menu_Remake._ui_console.stc_arrowKeyGuide:GetTextSizeX() + 10
  PaGlobal_Menu_Remake._ui_console.stc_enterKeyGuide:SetSpanSize(enterGuideSpanSizeX, PaGlobal_Menu_Remake._ui_console.stc_enterKeyGuide:GetSpanSize().y)
  PaGlobal_Menu_Remake._ui_console.stc_enterKeyGuide:ComputePos()
  local keyguideSpanSizeX = PaGlobal_Menu_Remake._ui_console.stc_subMenuKeyGuide:GetSizeX() + PaGlobal_Menu_Remake._ui_console.stc_subMenuKeyGuide:GetTextSizeX()
  PaGlobal_Menu_Remake._ui_console.stc_subMenuKeyGuide:SetSpanSize(keyguideSpanSizeX, PaGlobal_Menu_Remake._ui_console.stc_subMenuKeyGuide:GetSpanSize().y)
  PaGlobal_Menu_Remake._ui_console.stc_subMenuKeyGuide:ComputePos()
  PaGlobal_Menu_Remake._ui_console.stc_keyGuideLeftBg:ComputePos()
  PaGlobal_Menu_Remake._ui_console.stc_keyGuideRightBg:ComputePos()
  self._defaultKeyGuideBGSizeX = PaGlobal_Menu_Remake._ui_console.stc_keyGuideLeftBg:GetSizeX()
  self:AlignkeyGuide()
end
function PaGlobal_Menu_Remake:switchPlatform()
  if true == _ContentsOption_CH_GameType or _ContentsGroup_UsePadSnapping or isGameTypeGT() == true then
    PaGlobal_Menu_Remake._ui.btn_changeUi:SetShow(false)
    PaGlobal_Menu_Remake._ui.btn_customizeUi:SetSpanSize(50, PaGlobal_Menu_Remake._ui.btn_openway:GetSpanSize().y)
    PaGlobal_Menu_Remake._ui.btn_openway:SetSpanSize(PaGlobal_Menu_Remake._ui.btn_changeUi:GetSpanSize().x, PaGlobal_Menu_Remake._ui.btn_openway:GetSpanSize().y)
  end
  PaGlobal_Menu_Remake._ui.btn_nextHeaderMenu:SetShow(false == _ContentsGroup_UsePadSnapping)
  PaGlobal_Menu_Remake._ui.btn_prevHeaderMenu:SetShow(false == _ContentsGroup_UsePadSnapping)
  PaGlobal_Menu_Remake._ui.stc_prevHeaderMenuKeyGuide:SetShow(true == _ContentsGroup_UsePadSnapping)
  PaGlobal_Menu_Remake._ui.stc_nextHeaderMenuKeyGuide:SetShow(true == _ContentsGroup_UsePadSnapping)
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobal_Menu_Remake._ui.btn_cancel:SetShow(false)
    PaGlobal_Menu_Remake._ui.btn_commit:SetShow(false)
    PaGlobal_Menu_Remake._ui.btn_openway:SetShow(false)
    PaGlobal_Menu_Remake._ui.btn_changeUi:SetShow(false)
    PaGlobal_Menu_Remake._ui.btn_customizeUi:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_arrowKeyGuide:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_enterKeyGuide:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_subMenuKeyGuide:SetShow(false)
    PaGlobal_Menu_Remake._ui.btn_scaleResize_left:SetShow(false)
    PaGlobal_Menu_Remake._ui.btn_scaleResize_right:SetShow(false)
    PaGlobal_Menu_Remake._ui_console.stc_arrowKeyGuide:SetShow(true)
    PaGlobal_Menu_Remake._ui_console.stc_enterKeyGuide:SetShow(true)
    PaGlobal_Menu_Remake._ui_console.stc_subMenuKeyGuide:SetShow(true)
    PaGlobal_Menu_Remake._ui_console.stc_keyGuideLeftBg:SetShow(true)
    PaGlobal_Menu_Remake._ui_console.stc_keyGuideRightBg:SetShow(true)
  else
    PaGlobal_Menu_Remake._ui_console.stc_arrowKeyGuide:SetShow(false)
    PaGlobal_Menu_Remake._ui_console.stc_enterKeyGuide:SetShow(false)
    PaGlobal_Menu_Remake._ui_console.stc_subMenuKeyGuide:SetShow(false)
    PaGlobal_Menu_Remake._ui_console.stc_keyGuideLeftBg:SetShow(false)
    PaGlobal_Menu_Remake._ui_console.stc_keyGuideRightBg:SetShow(false)
  end
end
function PaGlobal_Menu_Remake:setMenuCondition()
  PaGlobal_Menu_Remake._conditionGroup = {}
  PaGlobal_Menu_Remake._conditionGroup = {
    _isLocalwarOpen = true,
    _isMercenaryOpen = true,
    _isContentsArsha = true,
    _isFreeFight = true,
    _isTeamDuelOpen = true,
    _isBossAlert = true,
    _isFairyOpen = 0 < ToClient_getFairyUnsealedList() + ToClient_getFairySealedList(),
    _isCampOpen = ToClient_isCampingReigsted(),
    _isMaidOpen = true == (0 < getTotalMaidList() and 7 <= getSelfPlayer():get():getLevel() and false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence)),
    _isPetOpen = 0 ~= ToClient_getPetUnsealedList() + ToClient_getPetSealedList(),
    _isQuestOpen = false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence),
    _isDailyStampOpen = 0 < ToClient_GetAttendanceInfoCount(),
    _isSailerOpen = 0 < ToClient_getEmployeeCount(),
    _isSiegeWarCall = PaGlobalFunc_menu_All_SiegeWarCallCheck(),
    _isBusterCall = PaGlobalFunc_menu_All_BusterCallCheck(),
    _isSummonPartyCall = PaGlobalFunc_menu_All_SummonPartyCallCheck(),
    _isReturnTown = PaGlobalFunc_menu_All_ReturnTownCheck(),
    _isSiegeWarReturnCall = PaGlobalFunc_menu_All_SiegeWarReturnCallCheck(),
    _isGMQuizCall = PaGlobalFunc_menu_All_GMQuizCallCheck()
  }
  if true == _ContentsGroup_ForceShowWidgetIcon then
    PaGlobal_Menu_Remake._conditionGroup._isPetOpen = true
    PaGlobal_Menu_Remake._conditionGroup._isFairyOpen = true
    PaGlobal_Menu_Remake._conditionGroup._isMaidOpen = true
  end
end
function PaGlobal_Menu_Remake:pressedArrowKey(keycode)
  if nil == keycode then
    return
  end
  local nowMenuIndex = PaGlobal_Menu_Remake._nowMenuIndex
  local nowMenuMode = PaGlobal_Menu_Remake._nowMenuMode
  local nowSelectedMenuIndex = PaGlobal_Menu_Remake._nowSelectedMenuIndex
  local MAX_LINE_SHOWHEADER = PaGlobal_Menu_Remake._MAX_LINE_SHOWHEADER
  if keycode == CppEnums.VirtualKeyCode.KeyCode_DOWN then
    if nowMenuMode == "header" then
      if math.ceil(nowMenuIndex / MAX_LINE_SHOWHEADER) >= math.ceil(#PaGlobal_Menu_Remake._headerHotKeyGroup / MAX_LINE_SHOWHEADER) then
        if true == PaGlobal_Menu_Remake._ui.stc_searchResultGroup:GetShow() then
          PaGlobal_Menu_Remake:searchMenu_toggle(1, true)
        else
          PaGlobal_Menu_Remake:menu_toggle(1, true)
        end
      else
        nowMenuIndex = nowMenuIndex + MAX_LINE_SHOWHEADER
        PaGlobal_Menu_Remake:headMenu_toggle(nowMenuIndex)
      end
    elseif nowMenuMode == "menu" then
      if nowMenuIndex >= #PaGlobal_Menu_Remake._menuHotKeyGroup then
        if false == self._isCustomizeMode then
          nowMenuIndex = 1
          PaGlobal_Menu_Remake:menu_toggle(nowMenuIndex, false)
          PaGlobal_Menu_Remake:headMenu_toggle(nowMenuIndex)
        else
          nowMenuIndex = 1
          PaGlobal_Menu_Remake:menu_toggle(nowMenuIndex, true)
        end
      else
        nowMenuIndex = nowMenuIndex + 1
        PaGlobal_Menu_Remake:menu_toggle(nowMenuIndex, true)
      end
    elseif nowMenuMode == "submenu" then
      local menuHotKey = PaGlobal_Menu_Remake._menuHotKey[nowSelectedMenuIndex]
      if nowMenuIndex >= menuHotKey.submenuCnt then
        nowMenuIndex = 1
      else
        nowMenuIndex = nowMenuIndex + 1
      end
      PaGlobal_Menu_Remake:submenu_toggle(nowMenuIndex, true)
    elseif nowMenuMode == "search" then
      if nowMenuIndex >= #PaGlobal_Menu_Remake._searchResult then
        nowMenuIndex = 1
        PaGlobal_Menu_Remake:searchMenu_toggle(nowMenuIndex, false)
        PaGlobal_Menu_Remake:headMenu_toggle(nowMenuIndex)
      else
        nowMenuIndex = nowMenuIndex + 1
        PaGlobal_Menu_Remake:searchMenu_toggle(nowMenuIndex, true)
      end
    end
  elseif keycode == CppEnums.VirtualKeyCode.KeyCode_UP then
    if nowMenuMode == "header" then
      if math.ceil(nowMenuIndex / MAX_LINE_SHOWHEADER) == 1 then
        if true == PaGlobal_Menu_Remake._ui.stc_searchResultGroup:GetShow() then
          nowMenuIndex = #PaGlobal_Menu_Remake._searchResult
          PaGlobal_Menu_Remake:searchMenu_toggle(nowMenuIndex, true)
        else
          nowMenuIndex = #PaGlobal_Menu_Remake._menuHotKeyGroup
          PaGlobal_Menu_Remake:menu_toggle(nowMenuIndex, true)
        end
      else
        nowMenuIndex = nowMenuIndex - MAX_LINE_SHOWHEADER
        PaGlobal_Menu_Remake:headMenu_toggle(nowMenuIndex)
      end
    elseif nowMenuMode == "menu" then
      if 1 == nowMenuIndex then
        if false == self._isCustomizeMode then
          nowMenuIndex = 1 + MAX_LINE_SHOWHEADER * (math.ceil(#PaGlobal_Menu_Remake._headerHotKeyGroup / MAX_LINE_SHOWHEADER) - 1)
          PaGlobal_Menu_Remake:menu_toggle(nowMenuIndex, false)
          PaGlobal_Menu_Remake:headMenu_toggle(nowMenuIndex)
        else
          nowMenuIndex = #PaGlobal_Menu_Remake._menuHotKeyGroup
          PaGlobal_Menu_Remake:menu_toggle(nowMenuIndex, true)
        end
      else
        nowMenuIndex = nowMenuIndex - 1
        PaGlobal_Menu_Remake:menu_toggle(nowMenuIndex, true)
      end
    elseif nowMenuMode == "submenu" then
      local menuHotKey = PaGlobal_Menu_Remake._menuHotKey[nowSelectedMenuIndex]
      if nowMenuIndex == 1 then
        nowMenuIndex = menuHotKey.submenuCnt
      else
        nowMenuIndex = nowMenuIndex - 1
      end
      PaGlobal_Menu_Remake:submenu_toggle(nowMenuIndex, true)
    elseif nowMenuMode == "search" then
      if 1 == nowMenuIndex then
        nowMenuIndex = 1 + MAX_LINE_SHOWHEADER * (math.ceil(#PaGlobal_Menu_Remake._headerHotKeyGroup / MAX_LINE_SHOWHEADER) - 1)
        PaGlobal_Menu_Remake:searchMenu_toggle(nowMenuIndex, false)
        PaGlobal_Menu_Remake:headMenu_toggle(nowMenuIndex)
      else
        nowMenuIndex = nowMenuIndex - 1
        PaGlobal_Menu_Remake:searchMenu_toggle(nowMenuIndex, true)
      end
    end
  elseif keycode == CppEnums.VirtualKeyCode.KeyCode_RIGHT then
    if nowMenuMode == "header" then
      if nowMenuIndex % MAX_LINE_SHOWHEADER == 0 then
        nowMenuIndex = nowMenuIndex + 1 - MAX_LINE_SHOWHEADER
      else
        nowMenuIndex = nowMenuIndex + 1
      end
      PaGlobal_Menu_Remake:headMenu_toggle(nowMenuIndex)
    elseif nowMenuMode == "menu" then
      PaGlobal_Menu_Remake:menu_select(nowMenuIndex)
    end
  elseif keycode == CppEnums.VirtualKeyCode.KeyCode_LEFT then
    if nowMenuMode == "header" then
      if nowMenuIndex % MAX_LINE_SHOWHEADER == 1 then
        nowMenuIndex = nowMenuIndex + MAX_LINE_SHOWHEADER - 1
      else
        nowMenuIndex = nowMenuIndex - 1
      end
      PaGlobal_Menu_Remake:headMenu_toggle(nowMenuIndex)
    elseif nowMenuMode == "submenu" then
      PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(false)
      PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:SetShow(true)
      PaGlobal_Menu_Remake:setHighLight("menu")
      PaGlobal_Menu_Remake:recentmenu_setHide()
      PaGlobal_Menu_Remake:menu_toggle(nowSelectedMenuIndex, true)
      local textureDDS = PaGlobal_Menu_Remake._menuGrid.ddsUrl
      local textureUVOn = PaGlobal_Menu_Remake._menuGrid.on
      if PaGlobal_Menu_Remake._menuHotKey[nowSelectedMenuIndex].isNew or PaGlobal_Menu_Remake._menuHotKey[nowSelectedMenuIndex].isHot then
        textureUVOn = PaGlobal_Menu_Remake._newMenuGrid.on
      end
      controlGroup = PaGlobal_Menu_Remake._menuHotKeyGroup[PaGlobal_Menu_Remake._nowSelectedMenuIndex]
      controlGroup.radiobtn:ChangeTextureInfoNameAsync(textureDDS)
      controlGroup.radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUVOn.x1, textureUVOn.y1, textureUVOn.x2, textureUVOn.y2)
      PaGlobal_Menu_Remake._nowSelectedMenuIndex = 0
    end
  end
end
function PaGlobal_Menu_Remake:searchingMenu()
  local searchText = PaGlobal_Menu_Remake._ui.edit_searchTxt:GetEditText()
  ClearFocusEdit()
  if nil == searchText or "" == searchText then
    PaGlobal_Menu_Remake:setBeforeSearch()
    return
  end
  searchText = string.gsub(searchText, "%(", "%%(")
  searchText = string.gsub(searchText, "%)", "%%)")
  PaGlobal_Menu_Remake._searchResult = {}
  for ii = 2, #PaGlobal_Menu_Remake._menuHotKey do
    local menuHotKey = PaGlobal_Menu_Remake._menuHotKey[ii]
    if nil ~= menuHotKey and nil ~= menuHotKey.subMenu then
      for submenuIndex = 1, #menuHotKey.subMenu do
        if (nil == menuHotKey.subMenu[submenuIndex].isContentOpen or true == menuHotKey.subMenu[submenuIndex].isContentOpen) and (nil == menuHotKey.subMenu[submenuIndex].isConditionOpen or true == menuHotKey.subMenu[submenuIndex].isConditionOpen) and nil ~= menuHotKey.subMenu[submenuIndex].func then
          local startIdx, endIdx = string.find(string.lower(menuHotKey.subMenu[submenuIndex].title), string.lower(searchText))
          if nil ~= startIdx and nil ~= endIdx then
            PaGlobal_Menu_Remake._searchResult[#PaGlobal_Menu_Remake._searchResult + 1] = menuHotKey.subMenu[submenuIndex]
          end
        end
      end
    end
  end
  PaGlobal_Menu_Remake:setSearchResult()
end
function PaGlobal_Menu_Remake:setSearchResult()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  if nil == PaGlobal_Menu_Remake._searchResult or 0 == #PaGlobal_Menu_Remake._searchResult then
    PaGlobal_Menu_Remake:setBeforeSearch()
    return
  end
  if false == PaGlobal_Menu_Remake._ui.stc_searchResultGroup:GetShow() then
    PaGlobal_Menu_Remake._beforeSearchMenuMode = PaGlobal_Menu_Remake._nowMenuMode
    PaGlobal_Menu_Remake._beforeSearchSelectedMenuIndex = PaGlobal_Menu_Remake._nowMenuIndex
    PaGlobal_Menu_Remake._beforeSelectedMenuIndex = PaGlobal_Menu_Remake._nowSelectedMenuIndex
    PaGlobal_Menu_Remake._ui.stc_searchResultGroup:SetShow(true)
    PaGlobal_Menu_Remake._ui.stc_menuGroup:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_submenu_BG:SetShow(false)
  end
  for index, controlGroup in pairs(PaGlobal_Menu_Remake._searchResultGroup) do
    if nil ~= controlGroup and nil ~= controlGroup.radiobtn then
      controlGroup.radiobtn:SetShow(false)
      controlGroup.radiobtn:addInputEvent("Mouse_LUp", "")
      controlGroup.radiobtn:addInputEvent("Mouse_On", "")
    end
  end
  for ii = 1, PaGlobal_Menu_Remake._MAX_SUBMENUHOTKEY_COUNT do
    PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake.numberKeySetting[ii]] = {}
    PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake.numberPadKeySetting[ii]] = {}
  end
  local tempPosY = 1
  for ii = 1, #PaGlobal_Menu_Remake._searchResult do
    if nil == PaGlobal_Menu_Remake._searchResultGroup[ii] then
      local radiobtn_result = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.stc_searchResultGroup, "RadioButton_Result_Btn", PaGlobal_Menu_Remake._ui.stc_searchResultGroup, "RadioButton_Result_Btn_" .. ii)
      local stc_menuIcon = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.radiobtn_searchResult, "Static_Menu_Icon", radiobtn_result, "Static_Menu_Icon")
      local stctxt_hotkey = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.radiobtn_searchResult, "StaticText_Hotkey", radiobtn_result, "StaticText_Hotkey")
      local stctxt_title = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.radiobtn_searchResult, "StaticText_Title", radiobtn_result, "StaticText_Title")
      local stc_NewIcon = UI.createAndCopyBasePropertyControl(Panel_Widget_Menu_Remake, "Static_NEW", radiobtn_result, "Static_NEW")
      local stc_HotIcon = UI.createAndCopyBasePropertyControl(Panel_Widget_Menu_Remake, "Static_HOT", radiobtn_result, "Static_HOT")
      local stc_EventIcon = UI.createAndCopyBasePropertyControl(Panel_Widget_Menu_Remake, "Static_EVENT", radiobtn_result, "Static_EVENT")
      local stc_UpdateIcon = UI.createAndCopyBasePropertyControl(Panel_Widget_Menu_Remake, "Static_UPDATE", radiobtn_result, "Static_UPDATE")
      if _ContentsGroup_UsePadSnapping then
        stctxt_hotkey:SetShow(false)
        ToClient_padSnapRefreshTarget(radiobtn_result)
      else
        stctxt_hotkey:SetText(ii)
      end
      stc_NewIcon:SetVerticalMiddle()
      stc_NewIcon:SetHorizonRight()
      stc_NewIcon:SetSpanSize(10, 0)
      stc_HotIcon:SetVerticalMiddle()
      stc_HotIcon:SetHorizonRight()
      stc_HotIcon:SetSpanSize(10, 0)
      stc_EventIcon:SetVerticalMiddle()
      stc_EventIcon:SetHorizonRight()
      stc_EventIcon:SetSpanSize(10, 0)
      stc_UpdateIcon:SetVerticalMiddle()
      stc_UpdateIcon:SetHorizonRight()
      stc_UpdateIcon:SetSpanSize(10, 0)
      PaGlobal_Menu_Remake._searchResultGroup[ii] = {}
      PaGlobal_Menu_Remake._searchResultGroup[ii].radiobtn = radiobtn_result
      PaGlobal_Menu_Remake._searchResultGroup[ii].icon = stc_menuIcon
      PaGlobal_Menu_Remake._searchResultGroup[ii].hotkey = stctxt_hotkey
      PaGlobal_Menu_Remake._searchResultGroup[ii].title = stctxt_title
      PaGlobal_Menu_Remake._searchResultGroup[ii].newIcon = stc_NewIcon
      PaGlobal_Menu_Remake._searchResultGroup[ii].hotIcon = stc_HotIcon
      PaGlobal_Menu_Remake._searchResultGroup[ii].eventIcon = stc_EventIcon
      PaGlobal_Menu_Remake._searchResultGroup[ii].updateIcon = stc_UpdateIcon
    end
    local radiobtn = PaGlobal_Menu_Remake._searchResultGroup[ii].radiobtn
    local icon = PaGlobal_Menu_Remake._searchResultGroup[ii].icon
    local numIcon = PaGlobal_Menu_Remake._searchResultGroup[ii].hotkey
    local title = PaGlobal_Menu_Remake._searchResultGroup[ii].title
    local newIcon = PaGlobal_Menu_Remake._searchResultGroup[ii].newIcon
    local hotIcon = PaGlobal_Menu_Remake._searchResultGroup[ii].hotIcon
    local eventIcon = PaGlobal_Menu_Remake._searchResultGroup[ii].eventIcon
    local updateIcon = PaGlobal_Menu_Remake._searchResultGroup[ii].updateIcon
    local textureUV = PaGlobal_Menu_Remake._searchResult[ii].ddsGrid
    local textureDDS = PaGlobal_Menu_Remake._searchResult[ii].ddsUrl
    radiobtn:SetShow(true)
    PaGlobal_Menu_Remake._ui.stctxt_header_button_title:SetText("")
    PaGlobal_Menu_Remake._ui.stc_header_title_shape1:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_header_title_shape2:SetShow(false)
    if nil ~= textureUV and nil ~= textureDDS then
      icon:ChangeTextureInfoNameAsync(textureDDS)
      icon:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUV.x1, textureUV.y1, textureUV.x2, textureUV.y2)
    else
      icon:ChangeTextureInfoNameAsync("")
      icon:setRenderTexture(icon:getBaseTexture())
    end
    title:SetText("")
    if nil ~= PaGlobal_Menu_Remake._searchResult[ii].title then
      title:SetText(PaGlobal_Menu_Remake._searchResult[ii].title)
    end
    if nil ~= PaGlobal_Menu_Remake._searchResult[ii].index then
      local mainIndex = PaGlobal_Menu_Remake:findMainIndex(PaGlobal_Menu_Remake._searchResult[ii].index)
      local menuString = title:GetText() .. " <PAColor0xFFDDC39E>(" .. PaGlobal_Menu_Remake._menuHotKey[mainIndex].title .. ")<PAOldColor>"
      title:SetText(menuString)
      UI.setLimitAutoWrapTextAndAddTooltip(title, 2, "", menuString)
    end
    if nil ~= PaGlobal_Menu_Remake._searchResult[ii].isNew and true == PaGlobal_Menu_Remake._searchResult[ii].isNew then
      newIcon:SetShow(true)
    else
      newIcon:SetShow(false)
    end
    if nil ~= PaGlobal_Menu_Remake._searchResult[ii].isHot and true == PaGlobal_Menu_Remake._searchResult[ii].isHot then
      hotIcon:SetShow(true)
    else
      hotIcon:SetShow(false)
    end
    if nil ~= PaGlobal_Menu_Remake._searchResult[ii].isEvent and true == PaGlobal_Menu_Remake._searchResult[ii].isEvent then
      eventIcon:SetShow(true)
    else
      eventIcon:SetShow(false)
    end
    if nil ~= PaGlobal_Menu_Remake._searchResult[ii].isUpdate and true == PaGlobal_Menu_Remake._searchResult[ii].isUpdate then
      updateIcon:SetShow(true)
    else
      updateIcon:SetShow(false)
    end
    if false == _ContentsGroup_UsePadSnapping then
      radiobtn:addInputEvent("Mouse_LUp", "HandleEventLUp_MenuRemake_SearchingMenu(" .. ii .. ")")
    elseif false == _ContentsGroup_RenewUI then
      radiobtn:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Menu_Remake_PressedConfirm()")
    end
    radiobtn:addInputEvent("Mouse_On", "HandleEventOn_MenuRemake_SearchingMenu(" .. ii .. ")")
    radiobtn:SetPosY(tempPosY)
    tempPosY = tempPosY + radiobtn:GetSizeY()
  end
  PaGlobal_Menu_Remake:searchMenu_toggle(1, true)
end
function PaGlobal_Menu_Remake:searchMenu_select(searchMenuIndex)
  if nil == searchMenuIndex then
    return
  end
  local searchMenuGroup = PaGlobal_Menu_Remake._searchResult[searchMenuIndex]
  if nil == searchMenuGroup or nil == searchMenuGroup.func then
    return
  end
  if nil ~= searchMenuGroup.isConditionOpen and false == searchMenuGroup.isConditionOpen then
    return
  end
  if false == PaGlobal_Menu_Remake._isCustomizeMode then
    searchMenuGroup.func()
    local mainIndex, subIndex = PaGlobal_Menu_Remake:findMainIndex(searchMenuGroup.index)
    PaGlobal_Menu_Remake:addRecentMenu(mainIndex, subIndex, false)
    PaGlobal_Menu_Remake:setRecentMenuInfo()
    PaGlobal_Menu_Remake:prepareClose()
  else
    local maxHeaderCount = PaGlobal_Menu_Remake._MAX_HEADERMENU
    if true == _ContentsGroup_ESCMenuAddNewLine then
      maxHeaderCount = PaGlobal_Menu_Remake._MAX_HEADERMENU * 2
    end
    for index = 1, maxHeaderCount do
      if nil ~= PaGlobal_Menu_Remake._headerHotKey[index] and searchMenuGroup.index == PaGlobal_Menu_Remake._headerHotKey[index].index then
        PaGlobal_Menu_Remake._headerHotKey[index] = nil
      end
    end
    PaGlobal_Menu_Remake._headerHotKey[PaGlobal_Menu_Remake._selected_customize_headerIndex] = searchMenuGroup
    PaGlobal_Menu_Remake:setHeaderHotKey()
  end
end
function PaGlobal_Menu_Remake:searchMenu_toggle(searchMenuIndex, isOn)
  local textureUVOn = PaGlobal_Menu_Remake._searchMenuGrid.on
  local textureUVOut = PaGlobal_Menu_Remake._searchMenuGrid.normal
  local textureDDS = PaGlobal_Menu_Remake._searchMenuGrid.ddsUrl
  if false == PaGlobal_Menu_Remake._isCustomizeMode then
    PaGlobal_Menu_Remake._ui.stctxt_header_button_title:SetText("")
    PaGlobal_Menu_Remake._ui.stc_header_title_shape1:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_header_title_shape2:SetShow(false)
    local headertextureUVOut = PaGlobal_Menu_Remake._headerGrid.normal
    local headertextureDDS = PaGlobal_Menu_Remake._headerGrid.ddsUrl
    for index, controlGroup in pairs(PaGlobal_Menu_Remake._headerHotKeyGroup) do
      controlGroup.radiobtn:ChangeTextureInfoNameAsync(headertextureDDS)
      controlGroup.radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, headertextureUVOut.x1, headertextureUVOut.y1, headertextureUVOut.x2, headertextureUVOut.y2)
    end
  end
  for index, controlGroup in pairs(PaGlobal_Menu_Remake._searchResultGroup) do
    if nil ~= controlGroup and nil ~= controlGroup.radiobtn then
      controlGroup.radiobtn:ChangeTextureInfoNameAsync(textureDDS)
      controlGroup.radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUVOut.x1, textureUVOut.y1, textureUVOut.x2, textureUVOut.y2)
    end
  end
  if true == isOn and nil ~= PaGlobal_Menu_Remake._searchResultGroup[searchMenuIndex] then
    PaGlobal_Menu_Remake._nowMenuMode = "search"
    PaGlobal_Menu_Remake._nowMenuIndex = searchMenuIndex
    PaGlobal_Menu_Remake._searchResultGroup[searchMenuIndex].radiobtn:ChangeTextureInfoNameAsync(textureDDS)
    PaGlobal_Menu_Remake._searchResultGroup[searchMenuIndex].radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUVOn.x1, textureUVOn.y1, textureUVOn.x2, textureUVOn.y2)
  end
end
function PaGlobal_Menu_Remake:GetMenuInfo(saveIndex)
  if nil == PaGlobal_Menu_Remake._menuHotKey then
    return nil
  end
  for ii = 2, #PaGlobal_Menu_Remake._menuHotKey do
    if nil == PaGlobal_Menu_Remake._menuHotKey[ii] or nil == PaGlobal_Menu_Remake._menuHotKey[ii].subMenu then
      return nil
    end
    local submenuGroup = PaGlobal_Menu_Remake._menuHotKey[ii].subMenu
    for index = 1, #submenuGroup do
      if nil ~= submenuGroup[index].index and submenuGroup[index].index == saveIndex then
        return submenuGroup[index]
      end
    end
  end
  return nil
end
function PaGlobal_Menu_Remake:setHeadHotKeyInfo()
  local maxHeaderCount = PaGlobal_Menu_Remake._MAX_HEADERMENU
  if true == _ContentsGroup_ESCMenuAddNewLine then
    maxHeaderCount = PaGlobal_Menu_Remake._MAX_HEADERMENU * 2
  end
  for index = 1, maxHeaderCount do
    PaGlobal_Menu_Remake._headerHotKey[index] = {}
    local saveIndex = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(PaGlobal_Menu_Remake.UIOPTION_TYPE_MENU[index])
    if nil ~= saveIndex and 0 ~= saveIndex then
      local value = PaGlobal_Menu_Remake:GetMenuInfo(saveIndex)
      PaGlobal_Menu_Remake._headerHotKey[index] = value
    elseif true == _ContentsGroup_UsePadSnapping then
      if nil ~= PaGlobal_Menu_Remake.DEFAULT_HEADER_MENU_INDEX_CONSOLE[index] then
        ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.UIOPTION_TYPE_MENU[index], PaGlobal_Menu_Remake.DEFAULT_HEADER_MENU_INDEX_CONSOLE[index], CppEnums.VariableStorageType.eVariableStorageType_User)
        PaGlobal_Menu_Remake._headerHotKey[index] = PaGlobal_Menu_Remake:GetMenuInfo(PaGlobal_Menu_Remake.DEFAULT_HEADER_MENU_INDEX_CONSOLE[index])
      end
    elseif nil ~= PaGlobal_Menu_Remake.DEFAULT_HEADER_MENU_INDEX[index] then
      ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.UIOPTION_TYPE_MENU[index], PaGlobal_Menu_Remake.DEFAULT_HEADER_MENU_INDEX[index], CppEnums.VariableStorageType.eVariableStorageType_User)
      PaGlobal_Menu_Remake._headerHotKey[index] = PaGlobal_Menu_Remake:GetMenuInfo(PaGlobal_Menu_Remake.DEFAULT_HEADER_MENU_INDEX[index])
    end
  end
end
function PaGlobal_Menu_Remake:resizeMenu()
  if true == Panel_Widget_Menu_Remake:GetShow() then
    PaGlobal_Menu_Remake:ShowAni()
  end
end
function PaGlobal_Menu_Remake:setHeaderHotKey()
  local panelScaleX = Panel_Widget_Menu_Remake:GetScale().x
  local startPosX = 25
  local tempPosX = startPosX * panelScaleX
  local gapX = UI.getChildControl(PaGlobal_Menu_Remake._ui.stc_header_button_group, "RadioButton_Header_Button"):GetSizeX() / 6.3
  local menuAddCnt = 0
  local maxSizeX = 0
  local tempPosY = 0
  local maxHeaderCount = PaGlobal_Menu_Remake._MAX_HEADERMENU
  local startShowHeaderIndex = 1 + self._startHeaderIndex * PaGlobal_Menu_Remake._MAX_HEADERMENU
  local lastShowHeaderIndex = PaGlobal_Menu_Remake._MAX_HEADERMENU + self._startHeaderIndex * PaGlobal_Menu_Remake._MAX_HEADERMENU
  if true == _ContentsGroup_ESCMenuAddNewLine then
    maxHeaderCount = PaGlobal_Menu_Remake._MAX_HEADERMENU * 2
  end
  for ii = 1, maxHeaderCount do
    if nil == PaGlobal_Menu_Remake._headerHotKeyGroup[ii] then
      local radiobtn_headerMenu = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.stc_header_button_group, "RadioButton_Header_Button", PaGlobal_Menu_Remake._ui.stc_header_button_group, "RadioButton_Header_Button_" .. ii)
      local radiobtn_headerMenu_highLight = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.stc_header_button, "Static_Header_Button_Highlight", radiobtn_headerMenu, "Static_Header_Button_Highlight")
      local radiobtn_headerMenu_icon = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.stc_header_button, "Static_Header_Button_Icon", radiobtn_headerMenu, "Static_Header_Button_Icon")
      local radiobtn_headerMenu_plus_icon = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.stc_header_button, "Static_Header_Plus_Icon", radiobtn_headerMenu, "Static_Header_Plus_Icon")
      PaGlobal_Menu_Remake._headerHotKeyGroup[ii] = {}
      PaGlobal_Menu_Remake._headerHotKeyGroup[ii].highLight = radiobtn_headerMenu_highLight
      PaGlobal_Menu_Remake._headerHotKeyGroup[ii].radiobtn = radiobtn_headerMenu
      PaGlobal_Menu_Remake._headerHotKeyGroup[ii].icon = radiobtn_headerMenu_icon
      PaGlobal_Menu_Remake._headerHotKeyGroup[ii].plusIcon = radiobtn_headerMenu_plus_icon
    end
    if nil ~= PaGlobal_Menu_Remake._headerHotKeyGroup[ii] then
      local radiobtn = PaGlobal_Menu_Remake._headerHotKeyGroup[ii].radiobtn
      local icon = PaGlobal_Menu_Remake._headerHotKeyGroup[ii].icon
      local plusIcon = PaGlobal_Menu_Remake._headerHotKeyGroup[ii].plusIcon
      local highLight = PaGlobal_Menu_Remake._headerHotKeyGroup[ii].highLight
      if true == _ContentsGroup_RenewUI then
        radiobtn:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Menu_Remake_PressedConfirm()")
      end
      if nil ~= PaGlobal_Menu_Remake._headerHotKey[ii] then
        local textureUV = PaGlobal_Menu_Remake._headerHotKey[ii].ddsGrid
        local textureDDS = PaGlobal_Menu_Remake._headerHotKey[ii].ddsUrl
        if nil ~= textureUV and nil ~= textureDDS then
          icon:ChangeTextureInfoNameAsync(textureDDS)
          icon:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUV.x1, textureUV.y1, textureUV.x2, textureUV.y2)
        else
          icon:ChangeTextureInfoNameAsync("")
          icon:setRenderTexture(icon:getBaseTexture())
        end
        if true == PaGlobal_Menu_Remake._isCustomizeMode then
          radiobtn:SetIgnore(false)
        elseif nil == PaGlobal_Menu_Remake._headerHotKey[ii].isConditionOpen or true == PaGlobal_Menu_Remake._headerHotKey[ii].isConditionOpen then
          radiobtn:SetIgnore(false)
        else
          radiobtn:SetIgnore(true)
        end
        PaGlobal_Menu_Remake._headerHotKeyGroup[ii].title = PaGlobal_Menu_Remake._headerHotKey[ii].title
        PaGlobal_Menu_Remake._headerHotKeyGroup[ii].isNoSetting = false
      else
        PaGlobal_Menu_Remake._headerHotKeyGroup[ii].title = PAGetString(Defines.StringSheet_GAME, "LUA_MENU_NOTSETTING")
        PaGlobal_Menu_Remake._headerHotKeyGroup[ii].isNoSetting = true
      end
      if nil ~= PaGlobal_Menu_Remake._headerHotKey[ii] then
        plusIcon:SetShow(false)
        icon:SetShow(true)
      else
        plusIcon:SetShow(true)
        icon:SetShow(false)
      end
      local textureDDS = PaGlobal_Menu_Remake._headerGrid.ddsUrl
      local normalTextureUV = PaGlobal_Menu_Remake._headerGrid.normal
      local onTextureUV = PaGlobal_Menu_Remake._headerGrid.on
      if nil ~= normalTextureUV then
        radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, normalTextureUV.x1, normalTextureUV.y1, normalTextureUV.x2, normalTextureUV.y2)
      end
      if nil ~= onTextureUV then
        radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeOn, onTextureUV.x1, onTextureUV.y1, onTextureUV.x2, onTextureUV.y2)
      end
      menuAddCnt = menuAddCnt + 1
      if false == _ContentsGroup_RenewUI then
        radiobtn:addInputEvent("Mouse_LUp", "HandleEventLUp_MenuRemake_HeadMenu(" .. ii .. ")")
        radiobtn:addInputEvent("Mouse_DownScroll", "PaGlobalFunc_menu_All_SwitchHeaderMenu(true)")
        radiobtn:addInputEvent("Mouse_UpScroll", "PaGlobalFunc_menu_All_SwitchHeaderMenu(false)")
      end
      radiobtn:addInputEvent("Mouse_Out", "HandleEventOut_MenuRemake_HeadMenu(" .. ii .. ")")
      radiobtn:addInputEvent("Mouse_On", "HandleEventOn_MenuRemake_HeadMenu(" .. ii .. ")")
      if 0 == PaGlobal_Menu_Remake._selected_customize_headerIndex then
        radiobtn:ChangeTextureInfoNameAsync(textureDDS)
        radiobtn:SetCheck(false)
        radiobtn:setRenderTexture(radiobtn:getBaseTexture())
      end
      radiobtn:SetPosX(tempPosX)
      local tempPosY = 0
      if true == _ContentsGroup_ESCMenuAddNewLine then
        tempPosX = tempPosX + radiobtn:GetSizeX() + gapX
        if ii == self._MAX_LINE_SHOWHEADER then
          tempPosX = startPosX * panelScaleX
        elseif ii > self._MAX_LINE_SHOWHEADER then
        end
      else
        tempPosX = tempPosX + radiobtn:GetSizeX() + gapX
        if maxSizeX < tempPosX then
          maxSizeX = tempPosX
        end
      end
      if ii >= startShowHeaderIndex and ii <= lastShowHeaderIndex then
        radiobtn:SetShow(true)
      else
        radiobtn:SetShow(false)
      end
      if 0 == menuAddCnt % PaGlobal_Menu_Remake._MAX_LINE_SHOWHEADER then
      end
    end
  end
  PaGlobal_Menu_Remake._ui.stc_topGroup:SetSize(PaGlobal_Menu_Remake._ui.stc_topGroup:GetSizeX(), PaGlobal_Menu_Remake._ui.stc_header_interface_group:GetSizeY() + PaGlobal_Menu_Remake._ui.stc_header_button_group:GetSizeY())
  PaGlobal_Menu_Remake._ui.stc_searchGroup:SetPosY(PaGlobal_Menu_Remake._ui.stc_topGroup:GetPosY() + PaGlobal_Menu_Remake._ui.stc_topGroup:GetSizeY())
  PaGlobal_Menu_Remake._ui.stc_header_button_group:ComputePos()
end
function PaGlobal_Menu_Remake:SetShapePosition()
  if false == _ContentsGroup_RenewUI then
    return
  end
  local textSize = self._ui.stctxt_header_button_title:GetTextSizeX()
  local shapeInterval = self._beforeTitleShape2SpanX - self._beforeTitleShape1SpanX
  if textSize < shapeInterval then
    self._ui.stc_header_title_shape2:SetSpanSize(self._beforeTitleShape2SpanX, self._ui.stc_header_title_shape2:GetSpanSize().y)
    self._ui.stc_header_title_shape1:SetSpanSize(self._beforeTitleShape1SpanX, self._ui.stc_header_title_shape2:GetSpanSize().y)
  else
    local diff = (textSize - shapeInterval) * 0.5
    diff = diff + self._ui.stc_header_title_shape2:GetSizeX()
    self._ui.stc_header_title_shape2:SetSpanSize(self._beforeTitleShape2SpanX + diff, self._ui.stc_header_title_shape2:GetSpanSize().y)
    self._ui.stc_header_title_shape1:SetSpanSize(self._beforeTitleShape1SpanX - diff, self._ui.stc_header_title_shape2:GetSpanSize().y)
  end
end
function PaGlobal_Menu_Remake:resetHeadMenuTitle(headermenuIndex)
  if true == PaGlobal_Menu_Remake._isCustomizeMode then
    if 0 ~= PaGlobal_Menu_Remake._selected_customize_headerIndex and PaGlobal_Menu_Remake._selected_customize_headerIndex == headermenuIndex then
      if nil ~= PaGlobal_Menu_Remake._headerHotKeyGroup[PaGlobal_Menu_Remake._selected_customize_headerIndex].title then
        PaGlobal_Menu_Remake._ui.stctxt_header_button_title:SetText(PaGlobal_Menu_Remake._headerHotKeyGroup[PaGlobal_Menu_Remake._selected_customize_headerIndex].title)
        PaGlobal_Menu_Remake._ui.stc_header_title_shape1:SetShow(true)
        PaGlobal_Menu_Remake._ui.stc_header_title_shape2:SetShow(true)
        PaGlobal_Menu_Remake:SetShapePosition()
      else
        PaGlobal_Menu_Remake._ui.stctxt_header_button_title:SetText("")
        PaGlobal_Menu_Remake._ui.stc_header_title_shape1:SetShow(false)
        PaGlobal_Menu_Remake._ui.stc_header_title_shape2:SetShow(false)
      end
    else
      PaGlobal_Menu_Remake:cancleHeadMenuToggle(headermenuIndex)
    end
  else
    PaGlobal_Menu_Remake:cancleHeadMenuToggle(headermenuIndex)
  end
end
function PaGlobal_Menu_Remake:cancleHeadMenuToggle(headermenuIndex)
  if 0 ~= headermenuIndex then
    local textureUVOut = PaGlobal_Menu_Remake._headerGrid.normal
    local textureDDS = PaGlobal_Menu_Remake._headerGrid.ddsUrl
    PaGlobal_Menu_Remake._headerHotKeyGroup[headermenuIndex].radiobtn:ChangeTextureInfoNameAsync(textureDDS)
    PaGlobal_Menu_Remake._headerHotKeyGroup[headermenuIndex].radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUVOut.x1, textureUVOut.y1, textureUVOut.x2, textureUVOut.y2)
    PaGlobal_Menu_Remake._ui.stctxt_header_button_title:SetText("")
    PaGlobal_Menu_Remake._ui.stc_header_title_shape1:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_header_title_shape2:SetShow(false)
  end
end
function PaGlobal_Menu_Remake:setHighLight(mode)
  if nil == PaGlobal_Menu_Remake then
    return
  end
  for index, controlGroup in pairs(PaGlobal_Menu_Remake._headerHotKeyGroup) do
    controlGroup.highLight:SetShow(false)
  end
  PaGlobal_Menu_Remake._ui.stc_menu_highlight:SetShow(false)
  PaGlobal_Menu_Remake._ui.stc_submenu_highlight:SetShow(false)
  if true == PaGlobal_Menu_Remake._isCustomizeMode and nil ~= mode then
    if mode == "header" then
      for index, controlGroup in pairs(PaGlobal_Menu_Remake._headerHotKeyGroup) do
        controlGroup.highLight:SetShow(true)
      end
    elseif mode == "menu" then
      PaGlobal_Menu_Remake._ui.stc_menu_highlight:SetShow(true)
    elseif mode == "submenu" then
      PaGlobal_Menu_Remake._ui.stc_submenu_highlight:SetShow(true)
    end
  end
end
function PaGlobal_Menu_Remake:headMenu_toggle(headermenuIndex)
  if nil == PaGlobal_Menu_Remake then
    return
  end
  if nil == headermenuIndex or nil == PaGlobal_Menu_Remake._headerHotKeyGroup[headermenuIndex] then
    return
  end
  if true == PaGlobal_Menu_Remake._isCustomizeMode then
    if nil ~= PaGlobal_Menu_Remake._headerHotKeyGroup[headermenuIndex].title then
      PaGlobal_Menu_Remake._ui.stctxt_header_button_title:SetText(PaGlobal_Menu_Remake._headerHotKeyGroup[headermenuIndex].title)
      PaGlobal_Menu_Remake._ui.stc_header_title_shape1:SetShow(true)
      PaGlobal_Menu_Remake._ui.stc_header_title_shape2:SetShow(true)
    else
      PaGlobal_Menu_Remake._ui.stctxt_header_button_title:SetText("")
      PaGlobal_Menu_Remake._ui.stc_header_title_shape1:SetShow(false)
      PaGlobal_Menu_Remake._ui.stc_header_title_shape2:SetShow(false)
    end
    local textureUVOut = PaGlobal_Menu_Remake._headerGrid.normal
    local textureDDS = PaGlobal_Menu_Remake._headerGrid.ddsUrl
    for index, controlGroup in pairs(PaGlobal_Menu_Remake._headerHotKeyGroup) do
      controlGroup.radiobtn:ChangeTextureInfoNameAsync(textureDDS)
      controlGroup.radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUVOut.x1, textureUVOut.y1, textureUVOut.x2, textureUVOut.y2)
    end
    local texureUVOn = PaGlobal_Menu_Remake._headerGrid.on
    PaGlobal_Menu_Remake._headerHotKeyGroup[headermenuIndex].radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, texureUVOn.x1, texureUVOn.y1, texureUVOn.x2, texureUVOn.y2)
    if nil ~= PaGlobal_Menu_Remake._selected_customize_headerIndex and 0 ~= PaGlobal_Menu_Remake._selected_customize_headerIndex and nil ~= PaGlobal_Menu_Remake._headerHotKeyGroup[PaGlobal_Menu_Remake._selected_customize_headerIndex] then
      PaGlobal_Menu_Remake._headerHotKeyGroup[PaGlobal_Menu_Remake._selected_customize_headerIndex].radiobtn:SetCheck(true)
    end
  else
    local textureUVOut = PaGlobal_Menu_Remake._headerGrid.normal
    local textureDDS = PaGlobal_Menu_Remake._headerGrid.ddsUrl
    for index, controlGroup in pairs(PaGlobal_Menu_Remake._headerHotKeyGroup) do
      controlGroup.radiobtn:ChangeTextureInfoNameAsync(textureDDS)
      controlGroup.radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUVOut.x1, textureUVOut.y1, textureUVOut.x2, textureUVOut.y2)
    end
    local texureUVOn = PaGlobal_Menu_Remake._headerGrid.on
    PaGlobal_Menu_Remake._headerHotKeyGroup[headermenuIndex].radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, texureUVOn.x1, texureUVOn.y1, texureUVOn.x2, texureUVOn.y2)
    if nil ~= PaGlobal_Menu_Remake._headerHotKeyGroup[headermenuIndex].title then
      PaGlobal_Menu_Remake._ui.stctxt_header_button_title:SetText(PaGlobal_Menu_Remake._headerHotKeyGroup[headermenuIndex].title)
      PaGlobal_Menu_Remake._ui.stc_header_title_shape1:SetShow(true)
      PaGlobal_Menu_Remake._ui.stc_header_title_shape2:SetShow(true)
    else
      PaGlobal_Menu_Remake._ui.stctxt_header_button_title:SetText("")
      PaGlobal_Menu_Remake._ui.stc_header_title_shape1:SetShow(false)
      PaGlobal_Menu_Remake._ui.stc_header_title_shape2:SetShow(false)
    end
  end
  PaGlobal_Menu_Remake:SetShapePosition()
  PaGlobal_Menu_Remake._nowMenuMode = "header"
  PaGlobal_Menu_Remake._nowMenuIndex = headermenuIndex
end
function PaGlobal_Menu_Remake:setMenuHotKey()
  local tempPosY = PaGlobal_Menu_Remake._ui.stc_topGroup:GetPosY() + PaGlobal_Menu_Remake._ui.stc_topGroup:GetSizeY() + PaGlobal_Menu_Remake._ui.stc_searchGroup:GetSizeY()
  PaGlobal_Menu_Remake._ui.stc_searchResultGroup:SetPosY(tempPosY - 1)
  PaGlobal_Menu_Remake._ui.stc_menuGroup:SetPosY(tempPosY)
  PaGlobal_Menu_Remake._ui.stc_submenu_BG:SetPosY(tempPosY - 1)
  PaGlobal_Menu_Remake._ui.stc_submenu_highlight:SetPosY(tempPosY)
  PaGlobal_Menu_Remake._ui.stc_menu_highlight:SetPosY(tempPosY)
  PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:SetPosY(PaGlobal_Menu_Remake._ui.stc_submenu_BG:GetPosY() + (PaGlobal_Menu_Remake._ui.stc_submenu_BG:GetSizeY() - PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:GetSizeY()) / 2)
  tempPosY = 0
  for ii = 1, #PaGlobal_Menu_Remake._menuHotKey do
    if nil == PaGlobal_Menu_Remake._menuHotKey[ii].isContentOpen or true == PaGlobal_Menu_Remake._menuHotKey[ii].isContentOpen then
      if nil == PaGlobal_Menu_Remake._menuHotKeyGroup[ii] then
        do
          local radiobtn_menu_btn = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.stc_menuGroup, "RadioButton_Menu_Btn", PaGlobal_Menu_Remake._ui.stc_menuGroup, "RadioButton_Menu_Btn_" .. ii)
          local radiobtn_menu_icon = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.radiobtn_menu, "Static_Menu_Icon", radiobtn_menu_btn, "Static_Menu_Icon")
          local radiobtn_menu_hotkey = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.radiobtn_menu, "StaticText_Hotkey", radiobtn_menu_btn, "StaticText_Hotkey")
          local radiobtn_menu_title = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.radiobtn_menu, "StaticText_Title", radiobtn_menu_btn, "StaticText_Title")
          local stc_menu_newIcon = UI.createAndCopyBasePropertyControl(Panel_Widget_Menu_Remake, "Static_NEW", radiobtn_menu_btn, "Static_NEW")
          local stc_menu_hotIcon = UI.createAndCopyBasePropertyControl(Panel_Widget_Menu_Remake, "Static_HOT", radiobtn_menu_btn, "Static_HOT")
          local stc_menu_eventIcon = UI.createAndCopyBasePropertyControl(Panel_Widget_Menu_Remake, "Static_EVENT", radiobtn_menu_btn, "Static_EVENT")
          local stc_menu_updateIcon = UI.createAndCopyBasePropertyControl(Panel_Widget_Menu_Remake, "Static_UPDATE", radiobtn_menu_btn, "Static_UPDATE")
          if nil ~= PaGlobal_Menu_Remake._menuHotKey[ii].hotKey then
            PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake._menuHotKey[ii].hotKey] = {}
            PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake._menuHotKey[ii].hotKey].func = nil
            PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake._menuHotKey[ii].hotKey].index = ii
            PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake._menuHotKey[ii].hotKey].type = "menu"
            local hotKeyString = PaGlobal_Menu_Remake._keyString[PaGlobal_Menu_Remake._menuHotKey[ii].hotKey]
            local iconOffset = radiobtn_menu_btn:GetSizeX() - radiobtn_menu_hotkey:GetPosX()
            if false == _ContentsGroup_UsePadSnapping and nil ~= hotKeyString then
              radiobtn_menu_hotkey:SetText(hotKeyString)
            else
              iconOffset = iconOffset - radiobtn_menu_hotkey:GetSizeX()
              radiobtn_menu_hotkey:SetShow(false)
            end
            radiobtn_menu_title:SetTextMode(__eTextMode_AutoWrap)
            radiobtn_menu_title:SetText(PaGlobal_Menu_Remake._menuHotKey[ii].title)
            stc_menu_newIcon:SetVerticalMiddle()
            stc_menu_newIcon:SetHorizonRight()
            stc_menu_newIcon:SetSpanSize(iconOffset)
            stc_menu_hotIcon:SetVerticalMiddle()
            stc_menu_hotIcon:SetHorizonRight()
            stc_menu_hotIcon:SetSpanSize(iconOffset)
            stc_menu_eventIcon:setPixelUVAndLoadTexture(__eUITextureTypeBase, 458, 455, 511, 477)
            stc_menu_eventIcon:SetVerticalMiddle()
            stc_menu_eventIcon:SetHorizonRight()
            stc_menu_eventIcon:SetSpanSize(iconOffset)
            stc_menu_updateIcon:SetVerticalMiddle()
            stc_menu_updateIcon:SetHorizonRight()
            stc_menu_updateIcon:SetSpanSize(iconOffset)
            local textureUV = PaGlobal_Menu_Remake._menuHotKey[ii].ddsGrid
            local textureDDS = PaGlobal_Menu_Remake._menuHotKey[ii].ddsUrl
            radiobtn_menu_icon:ChangeTextureInfoNameAsync(textureDDS)
            radiobtn_menu_icon:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUV.x1, textureUV.y1, textureUV.x2, textureUV.y2)
            PaGlobal_Menu_Remake._menuHotKeyGroup[ii] = {}
            PaGlobal_Menu_Remake._menuHotKeyGroup[ii].radiobtn = radiobtn_menu_btn
            PaGlobal_Menu_Remake._menuHotKeyGroup[ii].title = radiobtn_menu_title
            PaGlobal_Menu_Remake._menuHotKeyGroup[ii].hotkey = radiobtn_menu_hotkey
            PaGlobal_Menu_Remake._menuHotKeyGroup[ii].icon = radiobtn_menu_icon
            PaGlobal_Menu_Remake._menuHotKeyGroup[ii].newIcon = stc_menu_newIcon
            PaGlobal_Menu_Remake._menuHotKeyGroup[ii].hotIcon = stc_menu_hotIcon
            PaGlobal_Menu_Remake._menuHotKeyGroup[ii].eventIcon = stc_menu_eventIcon
            PaGlobal_Menu_Remake._menuHotKeyGroup[ii].updateIcon = stc_menu_updateIcon
          end
        end
      else
      end
      local stc_menu_newIcon = PaGlobal_Menu_Remake._menuHotKeyGroup[ii].newIcon
      local stc_menu_hotIcon = PaGlobal_Menu_Remake._menuHotKeyGroup[ii].hotIcon
      local stc_menu_eventIcon = PaGlobal_Menu_Remake._menuHotKeyGroup[ii].eventIcon
      local stc_menu_updateIcon = PaGlobal_Menu_Remake._menuHotKeyGroup[ii].updateIcon
      stc_menu_newIcon:SetShow(PaGlobal_Menu_Remake._menuHotKey[ii].isNew)
      stc_menu_hotIcon:SetShow(PaGlobal_Menu_Remake._menuHotKey[ii].isHot)
      stc_menu_eventIcon:SetShow(PaGlobal_Menu_Remake._menuHotKey[ii].isEvent)
      stc_menu_updateIcon:SetShow(PaGlobal_Menu_Remake._menuHotKey[ii].isUpdate)
      if true == stc_menu_eventIcon:GetShow() then
        stc_menu_hotIcon:SetShow(false)
        stc_menu_newIcon:SetShow(false)
        stc_menu_updateIcon:SetShow(false)
      end
      if true == stc_menu_newIcon:GetShow() then
        stc_menu_hotIcon:SetShow(false)
        stc_menu_updateIcon:SetShow(false)
      end
      if true == stc_menu_updateIcon:GetShow() then
        stc_menu_hotIcon:SetShow(false)
      end
      if nil ~= PaGlobal_Menu_Remake._menuHotKeyGroup[ii] then
        local radiobtn = PaGlobal_Menu_Remake._menuHotKeyGroup[ii].radiobtn
        local title = PaGlobal_Menu_Remake._menuHotKeyGroup[ii].title
        local icon = PaGlobal_Menu_Remake._menuHotKeyGroup[ii].icon
        if true == _ContentsGroup_UsePadSnapping then
          radiobtn:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Menu_Remake_PressedConfirm()")
        end
        if PaGlobal_Menu_Remake._menuHotKey[ii].isNew or PaGlobal_Menu_Remake._menuHotKey[ii].isHot then
          title:SetFontColor(UI_color.C_FFF5BA3A)
        end
        local textureDDS = PaGlobal_Menu_Remake._menuGrid.ddsUrl
        local normalTextureUV = PaGlobal_Menu_Remake._menuGrid.normal
        local onTextureUV = PaGlobal_Menu_Remake._menuGrid.on
        local clickTextureUV = PaGlobal_Menu_Remake._menuGrid.click
        if PaGlobal_Menu_Remake._menuHotKey[ii].isNew or PaGlobal_Menu_Remake._menuHotKey[ii].isHot then
          normalTextureUV = PaGlobal_Menu_Remake._newMenuGrid.normal
          onTextureUV = PaGlobal_Menu_Remake._newMenuGrid.on
          clickTextureUV = PaGlobal_Menu_Remake._newMenuGrid.click
        end
        radiobtn:ChangeTextureInfoNameAsync(textureDDS)
        if nil ~= normalTextureUV then
          radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, normalTextureUV.x1, normalTextureUV.y1, normalTextureUV.x2, normalTextureUV.y2)
        end
        if nil ~= onTextureUV then
          radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeOn, onTextureUV.x1, onTextureUV.y1, onTextureUV.x2, onTextureUV.y2)
        end
        if nil ~= clickTextureUV then
          radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeClick, clickTextureUV.x1, clickTextureUV.y1, clickTextureUV.x2, clickTextureUV.y2)
        end
        radiobtn:addInputEvent("Mouse_LUp", "HandleEventLUp_MenuRemake_Menu(" .. ii .. ")")
        radiobtn:addInputEvent("Mouse_On", "HandleEventOn_MenuRemake_Menu(" .. ii .. ")")
        radiobtn:SetPosY(tempPosY)
        tempPosY = tempPosY + radiobtn:GetSizeY()
      end
    end
  end
end
function PaGlobal_Menu_Remake:setSubmenu(menuIndex)
  if nil == menuIndex then
    PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:SetShow(true)
    return
  end
  if nil == PaGlobal_Menu_Remake._menuHotKeyGroup[menuIndex] then
    PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:SetShow(true)
    return
  end
  local menuHotKey = PaGlobal_Menu_Remake._menuHotKey[menuIndex]
  if nil == menuHotKey or nil == menuHotKey.subMenu then
    PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:SetShow(true)
    return
  end
  local isFavorite = menuIndex == PaGlobal_Menu_Remake._IDX_FAVORITE
  PaGlobal_Menu_Remake._ui.stctxt_header_button_title:SetText("")
  PaGlobal_Menu_Remake._ui.stc_header_title_shape1:SetShow(false)
  PaGlobal_Menu_Remake._ui.stc_header_title_shape2:SetShow(false)
  local tempPosY = 0
  local addCnt = 0
  for ii = 1, PaGlobal_Menu_Remake._MAX_SUBMENU do
    if ii <= PaGlobal_Menu_Remake._MAX_SUBMENUHOTKEY_COUNT then
      PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake.numberKeySetting[ii]] = {}
      PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake.numberPadKeySetting[ii]] = {}
    end
    if nil == PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii] then
      local radiobtn_menu_btn = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.stc_subMenuGroup, "RadioButton_SubMenu", PaGlobal_Menu_Remake._ui.stc_subMenuGroup, "RadioButton_SubMenu" .. ii)
      local radiobtn_menu_icon = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.radiobtn_sub_menu, "Static_SubMenu_Icon", radiobtn_menu_btn, "Static_SubMenu_Icon")
      local radiobtn_menu_numIcon = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.radiobtn_sub_menu, "StaticText_SubMenu_KeyIcon", radiobtn_menu_btn, "StaticText_SubMenu_KeyIcon")
      local radiobtn_menu_title = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.radiobtn_sub_menu, "StaticText_Title", radiobtn_menu_btn, "StaticText_Title")
      local radiobtn_menu_pin = UI.createAndCopyBasePropertyControl(PaGlobal_Menu_Remake._ui.radiobtn_sub_menu, "Static_Pin", radiobtn_menu_btn, "Static_Pin")
      local stc_menu_newIcon = UI.createAndCopyBasePropertyControl(Panel_Widget_Menu_Remake, "Static_NEW", radiobtn_menu_btn, "Static_NEW")
      local stc_menu_hotIcon = UI.createAndCopyBasePropertyControl(Panel_Widget_Menu_Remake, "Static_HOT", radiobtn_menu_btn, "Static_HOT")
      local stc_menu_eventIcon = UI.createAndCopyBasePropertyControl(Panel_Widget_Menu_Remake, "Static_EVENT", radiobtn_menu_btn, "Static_EVENT")
      local stc_menu_updateIcon = UI.createAndCopyBasePropertyControl(Panel_Widget_Menu_Remake, "Static_UPDATE", radiobtn_menu_btn, "Static_UPDATE")
      stc_menu_newIcon:SetVerticalMiddle()
      stc_menu_newIcon:SetHorizonLeft()
      stc_menu_newIcon:SetSpanSize(radiobtn_menu_numIcon:GetPosX() - stc_menu_newIcon:GetSizeX())
      stc_menu_hotIcon:SetVerticalMiddle()
      stc_menu_hotIcon:SetHorizonLeft()
      stc_menu_hotIcon:SetSpanSize(radiobtn_menu_numIcon:GetPosX() - stc_menu_hotIcon:GetSizeX())
      stc_menu_eventIcon:SetVerticalMiddle()
      stc_menu_eventIcon:SetHorizonLeft()
      stc_menu_eventIcon:SetSpanSize(radiobtn_menu_numIcon:GetPosX() - stc_menu_eventIcon:GetSizeX())
      stc_menu_updateIcon:SetVerticalMiddle()
      stc_menu_updateIcon:SetHorizonLeft()
      stc_menu_updateIcon:SetSpanSize(radiobtn_menu_numIcon:GetPosX() - stc_menu_eventIcon:GetSizeX())
      radiobtn_menu_title:SetIgnore(true)
      PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii] = {}
      PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].radiobtn = radiobtn_menu_btn
      PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].icon = radiobtn_menu_icon
      PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].numIcon = radiobtn_menu_numIcon
      PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].title = radiobtn_menu_title
      PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].pin = radiobtn_menu_pin
      PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].newIcon = stc_menu_newIcon
      PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].hotIcon = stc_menu_hotIcon
      PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].eventIcon = stc_menu_eventIcon
      PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].updateIcon = stc_menu_updateIcon
      ToClient_padSnapRefreshTarget(radiobtn_menu_btn)
    end
    local numIcon = PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].numIcon
    local icon = PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].icon
    local radiobtn = PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].radiobtn
    local title = PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].title
    local pinIcon = PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].pin
    local newIcon = PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].newIcon
    local hotIcon = PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].hotIcon
    local eventIcon = PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].eventIcon
    local updateIcon = PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].updateIcon
    if ii <= #menuHotKey.subMenu then
      if nil ~= menuHotKey.subMenu[ii] and nil ~= menuHotKey.subMenu[ii].func then
        if true == _ContentsGroup_UsePadSnapping then
          radiobtn:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Menu_Remake_PressedConfirm()")
          radiobtn:registerPadEvent(__eConsoleUIPadEvent_Up_RSClick, "HandleEventRUp_MenuRemake_setSubMenu(" .. ii .. ")")
        end
        addCnt = addCnt + 1
        if ii <= PaGlobal_Menu_Remake._MAX_SUBMENUHOTKEY_COUNT then
          PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake.numberKeySetting[addCnt]].func = menuHotKey.subMenu[ii].func
          PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake.numberKeySetting[addCnt]].index = ii
          PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake.numberKeySetting[addCnt]].type = "submenu"
          PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake.numberPadKeySetting[addCnt]].func = menuHotKey.subMenu[ii].func
          PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake.numberPadKeySetting[addCnt]].index = ii
          PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake.numberPadKeySetting[addCnt]].type = "submenu"
          if addCnt >= 10 then
            numIcon:SetText(math.abs(addCnt - 10))
          else
            numIcon:SetText(addCnt)
          end
          numIcon:SetShow(false == _ContentsGroup_UsePadSnapping)
        else
          numIcon:SetShow(false)
        end
        radiobtn:SetShow(true)
        icon:SetPosX(icon:GetSizeX() / 35 * 20)
        title:SetPosX(icon:GetPosX() + icon:GetSizeX() / 7 * 8)
        numIcon:SetPosX(radiobtn:GetSizeX() - numIcon:GetSizeX() * 1.5)
        newIcon:SetShow(menuHotKey.subMenu[ii].isNew)
        hotIcon:SetPosX(radiobtn:GetSizeX() - hotIcon:GetSizeX() * 1.5)
        hotIcon:SetShow(menuHotKey.subMenu[ii].isHot)
        eventIcon:SetPosX(radiobtn:GetSizeX() - eventIcon:GetSizeX() * 1.5)
        eventIcon:SetShow(menuHotKey.subMenu[ii].isEvent)
        updateIcon:SetPosX(radiobtn:GetSizeX() - updateIcon:GetSizeX() * 1.5)
        updateIcon:SetShow(menuHotKey.subMenu[ii].isUpdate)
        local textSizeOffset = 0
        if false == _ContentsGroup_UsePadSnapping then
          textSizeOffset = radiobtn:GetSizeX() - numIcon:GetPosX()
        end
        if true == isFavorite and ii <= PaGlobal_Menu_Remake._recentFixedCount then
          pinIcon:SetShow(true)
          textSizeOffset = radiobtn:GetSizeX() - pinIcon:GetPosX()
          newIcon:SetSpanSize(pinIcon:GetPosX() - newIcon:GetSizeX())
          hotIcon:SetSpanSize(pinIcon:GetPosX() - hotIcon:GetSizeX())
          eventIcon:SetSpanSize(pinIcon:GetPosX() - eventIcon:GetSizeX())
          updateIcon:SetSpanSize(pinIcon:GetPosX() - updateIcon:GetSizeX())
        else
          pinIcon:SetShow(false)
          newIcon:SetSpanSize(numIcon:GetPosX() - newIcon:GetSizeX())
          hotIcon:SetSpanSize(numIcon:GetPosX() - hotIcon:GetSizeX())
          eventIcon:SetSpanSize(numIcon:GetPosX() - eventIcon:GetSizeX())
          updateIcon:SetSpanSize(numIcon:GetPosX() - updateIcon:GetSizeX())
        end
        if true == newIcon:GetShow() or true == hotIcon:GetShow() or true == eventIcon:GetShow() or true == updateIcon:GetShow() then
          textSizeOffset = radiobtn:GetSizeX() - updateIcon:GetPosX()
        end
        title:SetSize(radiobtn:GetSizeX() - title:GetPosX() - textSizeOffset, title:GetSizeY())
        title:SetTextMode(__eTextMode_Limit_AutoWrap)
        title:setLineCountByLimitAutoWrap(2)
        title:SetText(menuHotKey.subMenu[ii].title)
        title:SetIgnore(true)
        if title:IsLimitText() == true then
          radiobtn:addInputEvent("Mouse_On", "TooltipSimple_Show_MenuRemake(" .. ii .. ")")
          radiobtn:addInputEvent("Mouse_Out", "TooltipSimple_Hide_MenuRemake(" .. ii .. ")")
        else
          radiobtn:addInputEvent("Mouse_On", "HandleEventOn_MenuRemake_subMenu(" .. ii .. ")")
          radiobtn:addInputEvent("Mouse_Out", "HandleEventOut_MenuRemake_subMenu(" .. ii .. ")")
        end
        radiobtn:addInputEvent("Mouse_LUp", "HandleEventLUp_MenuRemake_subMenu(" .. ii .. ")")
        if false == _ContentsGroup_UsePadSnapping then
          radiobtn:addInputEvent("Mouse_RUp", "HandleEventRUp_MenuRemake_setSubMenu(" .. ii .. ")")
        else
          radiobtn:registerPadEvent(__eConsoleUIPadEvent_Up_RSClick, "HandleEventRUp_MenuRemake_setSubMenu(" .. ii .. ")")
        end
        local textureUV = menuHotKey.subMenu[ii].ddsGrid
        local textureDDS = menuHotKey.subMenu[ii].ddsUrl
        if nil ~= textureUV and nil ~= textureDDS then
          icon:ChangeTextureInfoNameAsync(textureDDS)
          icon:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUV.x1, textureUV.y1, textureUV.x2, textureUV.y2)
        else
          icon:ChangeTextureInfoNameAsync("")
          icon:setRenderTexture(icon:getBaseTexture())
        end
        if nil == menuHotKey.subMenu[ii].isConditionOpen or true == menuHotKey.subMenu[ii].isConditionOpen then
          radiobtn:SetIgnore(false)
          icon:SetMonoTone(false)
          title:SetFontColor(UI_color.C_FFDDC39E)
          if menuHotKey.subMenu[ii].isNew or menuHotKey.subMenu[ii].isHot then
            title:SetFontColor(UI_color.C_FFF5BA3A)
          end
        else
          radiobtn:SetIgnore(true)
          icon:SetMonoTone(true)
          title:SetFontColor(UI_color.C_FF888888)
          if true == _ContentsOption_CH_GameType then
            radiobtn:SetIgnore(false)
            radiobtn:addInputEvent("Mouse_LUp", "HandleEventLUp_MenuRemake_ShowNakDisabledMenu()")
          end
        end
        radiobtn:SetPosY(tempPosY)
        tempPosY = tempPosY + radiobtn:GetSizeY() + 5
        if 1 == ii and true == _ContentsGroup_UsePadSnapping then
          ToClient_padSnapChangeToTarget(radiobtn)
        end
      else
        radiobtn:addInputEvent("Mouse_LUp", "")
        radiobtn:SetShow(false)
      end
    else
      radiobtn:SetShow(false)
    end
  end
  menuHotKey.submenuCnt = addCnt
  local defaultPosY = PaGlobal_Menu_Remake._ui.stc_searchGroup:GetPosY() + PaGlobal_Menu_Remake._ui.stc_searchGroup:GetSizeY()
  local menuPosY = PaGlobal_Menu_Remake._menuHotKeyGroup[menuIndex].radiobtn:GetPosY()
end
function PaGlobal_Menu_Remake:headMenu_select(headermenuIndex)
  local headerMenuGroup = PaGlobal_Menu_Remake._headerHotKey[headermenuIndex]
  local headerMenuKeyGroup = PaGlobal_Menu_Remake._headerHotKeyGroup[headermenuIndex]
  if nil == headermenuIndex then
    return
  end
  if nil == headerMenuKeyGroup then
    return
  end
  if false == PaGlobal_Menu_Remake._isCustomizeMode then
    headerMenuKeyGroup.radiobtn:SetCheck(false)
    if nil == headerMenuGroup then
      if nil ~= headerMenuKeyGroup.isNoSetting and true == headerMenuKeyGroup.isNoSetting then
        PaGlobal_Menu_Remake._isCustomizeMode = true
        PaGlobal_Menu_Remake:setCustomize_menu(true)
        PaGlobal_Menu_Remake:resetMenu(true)
        PaGlobal_Menu_Remake:headMenu_select(headermenuIndex)
      end
      return
    elseif nil == headerMenuGroup.func then
      return
    end
    if nil == headerMenuGroup.isConditionOpen or true == headerMenuGroup.isConditionOpen then
      headerMenuGroup.func()
      PaGlobal_Menu_Remake:prepareClose()
    end
  else
    local textureUVOut = PaGlobal_Menu_Remake._headerGrid.normal
    local textureDDS = PaGlobal_Menu_Remake._headerGrid.ddsUrl
    for index, controlGroup in pairs(PaGlobal_Menu_Remake._headerHotKeyGroup) do
      controlGroup.radiobtn:ChangeTextureInfoNameAsync(textureDDS)
      controlGroup.radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUVOut.x1, textureUVOut.y1, textureUVOut.x2, textureUVOut.y2)
    end
    for index, controlGroup in pairs(PaGlobal_Menu_Remake._menuHotKeyGroup) do
      if nil ~= controlGroup and nil ~= controlGroup.radiobtn then
        textureUVOut = PaGlobal_Menu_Remake._menuGrid.normal
        if PaGlobal_Menu_Remake._menuHotKey[index].isNew or PaGlobal_Menu_Remake._menuHotKey[index].isHot then
          textureUVOut = PaGlobal_Menu_Remake._newMenuGrid.normal
        end
        controlGroup.radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUVOut.x1, textureUVOut.y1, textureUVOut.x2, textureUVOut.y2)
        controlGroup.radiobtn:SetCheck(false)
      end
    end
    PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:SetShow(true)
    headerMenuKeyGroup.radiobtn:SetCheck(true)
    PaGlobal_Menu_Remake._selected_customize_headerIndex = headermenuIndex
    PaGlobal_Menu_Remake:setHighLight("menu")
  end
  PaGlobal_Menu_Remake:AlignkeyGuide()
end
function PaGlobal_Menu_Remake:menu_toggle(menuIndex, isOn)
  if nil == menuIndex then
    return
  end
  if nil == PaGlobal_Menu_Remake._menuHotKeyGroup[menuIndex] then
    return
  end
  if false == PaGlobal_Menu_Remake._isCustomizeMode then
    PaGlobal_Menu_Remake._ui.stctxt_header_button_title:SetText("")
    PaGlobal_Menu_Remake._ui.stc_header_title_shape1:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_header_title_shape2:SetShow(false)
    local headertextureUVOut = PaGlobal_Menu_Remake._headerGrid.normal
    local headertextureDDS = PaGlobal_Menu_Remake._headerGrid.ddsUrl
    for index, controlGroup in pairs(PaGlobal_Menu_Remake._headerHotKeyGroup) do
      controlGroup.radiobtn:ChangeTextureInfoNameAsync(headertextureDDS)
      controlGroup.radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, headertextureUVOut.x1, headertextureUVOut.y1, headertextureUVOut.x2, headertextureUVOut.y2)
    end
  end
  local textureUVOn = PaGlobal_Menu_Remake._menuGrid.on
  local textureDDS = PaGlobal_Menu_Remake._menuGrid.ddsUrl
  if PaGlobal_Menu_Remake._menuHotKey[menuIndex].isNew or PaGlobal_Menu_Remake._menuHotKey[menuIndex].isHot then
    textureUVOn = PaGlobal_Menu_Remake._newMenuGrid.on
  end
  for index, controlGroup in pairs(PaGlobal_Menu_Remake._menuHotKeyGroup) do
    if index ~= PaGlobal_Menu_Remake._nowSelectedMenuIndex then
      local textureUVOut = PaGlobal_Menu_Remake._menuGrid.normal
      if PaGlobal_Menu_Remake._menuHotKey[index].isNew or PaGlobal_Menu_Remake._menuHotKey[index].isHot then
        textureUVOut = PaGlobal_Menu_Remake._newMenuGrid.normal
      end
      controlGroup.radiobtn:ChangeTextureInfoNameAsync(textureDDS)
      controlGroup.radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUVOut.x1, textureUVOut.y1, textureUVOut.x2, textureUVOut.y2)
    end
  end
  if true == isOn and (false == PaGlobal_Menu_Remake._isCustomizeMode or 0 ~= PaGlobal_Menu_Remake._selected_customize_headerIndex) then
    if menuIndex ~= PaGlobal_Menu_Remake._nowSelectedMenuIndex then
      PaGlobal_Menu_Remake._menuHotKeyGroup[menuIndex].radiobtn:ChangeTextureInfoNameAsync(textureDDS)
      PaGlobal_Menu_Remake._menuHotKeyGroup[menuIndex].radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUVOn.x1, textureUVOn.y1, textureUVOn.x2, textureUVOn.y2)
    end
    PaGlobal_Menu_Remake._nowMenuMode = "menu"
    PaGlobal_Menu_Remake._nowMenuIndex = menuIndex
  end
end
function PaGlobal_Menu_Remake:menu_select(menuIndex)
  if true == PaGlobal_Menu_Remake:isEmptyRecentMenu(menuIndex) then
    return
  end
  if nil == menuIndex then
    PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:SetShow(true)
    return
  end
  if nil == PaGlobal_Menu_Remake._menuHotKeyGroup[menuIndex] then
    PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:SetShow(true)
    return
  end
  local menuHotKey = PaGlobal_Menu_Remake._menuHotKey[menuIndex]
  local menuHotKeyBtnGroup = PaGlobal_Menu_Remake._menuHotKeyGroup[menuIndex]
  local textureUV = PaGlobal_Menu_Remake._menuGrid.normal
  if true == PaGlobal_Menu_Remake._isCustomizeMode and (nil == PaGlobal_Menu_Remake._selected_customize_headerIndex or 0 == PaGlobal_Menu_Remake._selected_customize_headerIndex) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_ALERT_BEFOREMENU"))
    if nil ~= menuHotKeyBtnGroup.radiobtn then
      menuHotKeyBtnGroup.radiobtn:SetCheck(false)
      menuHotKeyBtnGroup.radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUV.x1, textureUV.y1, textureUV.x2, textureUV.y2)
    end
    return
  end
  PaGlobal_Menu_Remake._ui.stc_subMenuKeyGuide:SetShow(false)
  PaGlobal_Menu_Remake._ui_console.stc_subMenuKeyGuide:SetShow(false)
  if nil == menuHotKey.subMenu then
    PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(false)
    PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:SetShow(true)
  else
    if PaGlobal_Menu_Remake._IDX_FAVORITE == menuIndex then
      PaGlobal_Menu_Remake._ui.stc_subMenuKeyGuide:SetShow(not _ContentsGroup_UsePadSnapping)
      PaGlobal_Menu_Remake._ui_console.stc_subMenuKeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
    end
    for ii = 1, #PaGlobal_Menu_Remake._menuHotKeyGroup do
      if nil ~= PaGlobal_Menu_Remake._menuHotKeyGroup[ii] and nil ~= PaGlobal_Menu_Remake._menuHotKeyGroup[ii].radiobtn then
        textureUV = PaGlobal_Menu_Remake._menuGrid.normal
        if PaGlobal_Menu_Remake._menuHotKey[ii].isNew or PaGlobal_Menu_Remake._menuHotKey[ii].isHot then
          textureUV = PaGlobal_Menu_Remake._newMenuGrid.normal
        end
        PaGlobal_Menu_Remake._menuHotKeyGroup[ii].radiobtn:SetCheck(false)
        PaGlobal_Menu_Remake._menuHotKeyGroup[ii].radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUV.x1, textureUV.y1, textureUV.x2, textureUV.y2)
      end
    end
    if nil ~= menuHotKeyBtnGroup.radiobtn then
      menuHotKeyBtnGroup.radiobtn:SetCheck(true)
      PaGlobal_Menu_Remake._selectMenuIndex = menuIndex
      PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(true)
      PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:SetShow(false)
      PaGlobal_Menu_Remake:setSubmenu(menuIndex)
      PaGlobal_Menu_Remake:submenu_toggle(1, true)
    else
      PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(false)
      PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:SetShow(true)
    end
  end
  PaGlobal_Menu_Remake._nowMenuMode = "submenu"
  PaGlobal_Menu_Remake._nowMenuIndex = 1
  PaGlobal_Menu_Remake._nowSelectedMenuIndex = menuIndex
  PaGlobal_Menu_Remake:setHighLight("submenu")
end
function PaGlobal_Menu_Remake:submenu_toggle(submenuIndex, isOn)
  local textureUVOn = PaGlobal_Menu_Remake._subMenuGrid.on
  local textureDDS = PaGlobal_Menu_Remake._subMenuGrid.ddsUrl
  for ii = 1, PaGlobal_Menu_Remake._MAX_SUBMENU do
    if nil ~= PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii] then
      local textureUVOut = PaGlobal_Menu_Remake._subMenuGrid.normal
      local menuHotKey = PaGlobal_Menu_Remake._menuHotKey[PaGlobal_Menu_Remake._selectMenuIndex]
      local submenu
      if nil ~= menuHotKey then
        submenu = menuHotKey.subMenu[ii]
      end
      if nil ~= submenu and (true == submenu.isNew or true == submenu.isHot) then
        textureUVOut = PaGlobal_Menu_Remake._newSubMenuGrid.normal
      end
      PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].radiobtn:ChangeTextureInfoNameAsync(textureDDS)
      PaGlobal_Menu_Remake._subMenuHotKeyGroup[ii].radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUVOut.x1, textureUVOut.y1, textureUVOut.x2, textureUVOut.y2)
    end
  end
  if true == isOn then
    local menuHotKey = PaGlobal_Menu_Remake._menuHotKey[PaGlobal_Menu_Remake._selectMenuIndex]
    if nil ~= menuHotKey then
      submenu = menuHotKey.subMenu[submenuIndex]
    end
    if nil ~= submenu and (true == submenu.isNew or true == submenu.isHot) then
      textureUVOn = PaGlobal_Menu_Remake._newSubMenuGrid.on
    end
    PaGlobal_Menu_Remake._nowMenuMode = "submenu"
    PaGlobal_Menu_Remake._nowMenuIndex = submenuIndex
    PaGlobal_Menu_Remake._subMenuHotKeyGroup[submenuIndex].radiobtn:ChangeTextureInfoNameAsync(textureDDS)
    PaGlobal_Menu_Remake._subMenuHotKeyGroup[submenuIndex].radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUVOn.x1, textureUVOn.y1, textureUVOn.x2, textureUVOn.y2)
  end
end
function PaGlobal_Menu_Remake:submenu_select(submenuIndex)
  if nil == PaGlobal_Menu_Remake._selectMenuIndex or nil == submenuIndex then
    return
  end
  local menuHotKey = PaGlobal_Menu_Remake._menuHotKey[PaGlobal_Menu_Remake._selectMenuIndex]
  if nil == menuHotKey then
    return
  end
  local subMenuGroup = menuHotKey.subMenu[submenuIndex]
  if nil == subMenuGroup or nil == subMenuGroup.func then
    return
  end
  if nil ~= subMenuGroup.isConditionOpen and false == subMenuGroup.isConditionOpen then
    return
  end
  if false == PaGlobal_Menu_Remake._isCustomizeMode then
    PaGlobal_Menu_Remake:addRecentMenu(PaGlobal_Menu_Remake._selectMenuIndex, submenuIndex, false)
    PaGlobal_Menu_Remake:setRecentMenuInfo()
    subMenuGroup.func()
    PaGlobal_Menu_Remake:prepareClose()
  else
    local maxHeaderCount = PaGlobal_Menu_Remake._MAX_HEADERMENU
    if true == _ContentsGroup_ESCMenuAddNewLine then
      maxHeaderCount = PaGlobal_Menu_Remake._MAX_HEADERMENU * 2
    end
    for index = 1, maxHeaderCount do
      if nil ~= PaGlobal_Menu_Remake._headerHotKey[index] and subMenuGroup.index == PaGlobal_Menu_Remake._headerHotKey[index].index then
        PaGlobal_Menu_Remake._headerHotKey[index] = nil
      end
    end
    PaGlobal_Menu_Remake._headerHotKey[PaGlobal_Menu_Remake._selected_customize_headerIndex] = PaGlobal_Menu_Remake:GetMenuInfo(subMenuGroup.index)
    PaGlobal_Menu_Remake:setHeaderHotKey()
  end
end
function PaGlobal_Menu_Remake_Customize_Reset()
  PaGlobal_Menu_Remake._isCustomizeMode = false
  PaGlobal_Menu_Remake:setCustomize_menu(PaGlobal_Menu_Remake._isCustomizeMode)
  PaGlobal_Menu_Remake:resetMenu(true)
end
function PaGlobal_Menu_Remake:headmenuCustomize_confirm()
  local maxHeaderCount = PaGlobal_Menu_Remake._MAX_HEADERMENU
  if true == _ContentsGroup_ESCMenuAddNewLine then
    maxHeaderCount = PaGlobal_Menu_Remake._MAX_HEADERMENU * 2
  end
  for index = 1, maxHeaderCount do
    if nil ~= PaGlobal_Menu_Remake._headerHotKey[index] and nil ~= PaGlobal_Menu_Remake._headerHotKey[index].index then
      ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.UIOPTION_TYPE_MENU[index], PaGlobal_Menu_Remake._headerHotKey[index].index, CppEnums.VariableStorageType.eVariableStorageType_User)
    else
      ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.UIOPTION_TYPE_MENU[index], 999, CppEnums.VariableStorageType.eVariableStorageType_User)
    end
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_ALERT_COMPLETE_MESSAGE"))
  if true == _ContentsGroup_RenewUI then
    ToClient_saveUserCache()
  end
  PaGlobal_Menu_Remake_Customize_Reset()
end
function PaGlobal_Menu_Remake:headmenuCustomize_cancel()
  PaGlobal_Menu_Remake_Customize_Reset()
  if PaGlobal_Menu_Remake._isLeft == (0 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMenuOpenWay)) then
    PaGlobal_Menu_Remake:prepareOpen()
  end
  PaGlobal_Menu_Remake:AlignkeyGuide()
end
function PaGlobal_Menu_Remake:registEventHandler()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake._CONFIRM_KEY] = {}
  PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake._CONFIRM_KEY].func = PaGlobal_Menu_Remake_PressedConfirm
  PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake._CONFIRM_KEY].index = 0
  PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake._CONFIRM_KEY].type = "confirmKey"
  PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake._SEARCH_KEY] = {}
  PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake._SEARCH_KEY].func = PaGlobal_Menu_Remake_ToggleSearchMode
  PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake._SEARCH_KEY].index = 0
  PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake._SEARCH_KEY].type = "confirmKey"
  for index, key in pairs(PaGlobal_Menu_Remake._ARROW_KEY) do
    PaGlobal_Menu_Remake._hotKeyFunction[key] = {}
    PaGlobal_Menu_Remake._hotKeyFunction[key].func = HandleEventKeyBoard_MenuRemake_arrowKey
    PaGlobal_Menu_Remake._hotKeyFunction[key].index = 0
    PaGlobal_Menu_Remake._hotKeyFunction[key].type = "arrowKey"
  end
  Panel_Widget_Menu_Remake:RegisterShowEventFunc(true, "PaGlobal_Menu_Remake:ShowAni()")
  Panel_Widget_Menu_Remake:RegisterShowEventFunc(false, "PaGlobal_Menu_Remake:HideAni()")
  PaGlobal_Menu_Remake._ui.btn_changeUi:addInputEvent("Mouse_LUp", "PaGlobal_Menu_Remake_MenuChange()")
  PaGlobal_Menu_Remake._ui.btn_changeUi:addInputEvent("Mouse_On", "HandleEventOn_MenuRemake_ChangeUi()")
  PaGlobal_Menu_Remake._ui.btn_changeUi:addInputEvent("Mouse_Out", "PaGlobal_Menu_Remake_HideToolTip()")
  PaGlobal_Menu_Remake._ui.btn_openway:addInputEvent("Mouse_LUp", "HandleEventLUp_MenuRemake_ChangeOpenWay()")
  PaGlobal_Menu_Remake._ui.btn_openway:addInputEvent("Mouse_On", "HandleEventOn_MenuRemake_ChangeOpenWay()")
  PaGlobal_Menu_Remake._ui.btn_openway:addInputEvent("Mouse_Out", "PaGlobal_Menu_Remake_HideToolTip()")
  PaGlobal_Menu_Remake._ui.btn_customizeUi:addInputEvent("Mouse_LUp", "HandleEventLUp_MenuRemake_ChangeCustomizeMode()")
  PaGlobal_Menu_Remake._ui.btn_customizeUi:addInputEvent("Mouse_On", "HandleEventOn_MenuRemake_ChangeCustomizeMode()")
  PaGlobal_Menu_Remake._ui.btn_customizeUi:addInputEvent("Mouse_Out", "PaGlobal_Menu_Remake_HideToolTip()")
  PaGlobal_Menu_Remake._ui.btn_cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_MenuRemake_Cancel()")
  PaGlobal_Menu_Remake._ui.btn_commit:addInputEvent("Mouse_LUp", "HandleEventLUp_MenuRemake_Commit()")
  PaGlobal_Menu_Remake._ui.edit_searchTxt:addInputEvent("Mouse_LUp", "HandleEventLUp_MenuRemake_searchText()")
  PaGlobal_Menu_Remake._ui.edit_searchTxt:RegistReturnKeyEvent("HandleEventKeyBoard_MenuRemake_searchingMenu()")
  PaGlobal_Menu_Remake._ui.btn_scaleResize_left:addInputEvent("Mouse_LDown", "HandleEventLUp_Menu_ScaleResizeLDown()")
  PaGlobal_Menu_Remake._ui.btn_scaleResize_left:addInputEvent("Mouse_LPress", "HandleEventLUp_Menu_ScaleResizeLPress_Right()")
  PaGlobal_Menu_Remake._ui.btn_scaleResize_left:addInputEvent("Mouse_LUp", "HandleEventLUp_Menu_ScaleResizeLUp()")
  PaGlobal_Menu_Remake._ui.btn_scaleResize_left:setOnMouseCursorType(16)
  PaGlobal_Menu_Remake._ui.btn_scaleResize_left:setClickMouseCursorType(16)
  PaGlobal_Menu_Remake._ui.btn_scaleResize_right:addInputEvent("Mouse_LDown", "HandleEventLUp_Menu_ScaleResizeLDown()")
  PaGlobal_Menu_Remake._ui.btn_scaleResize_right:addInputEvent("Mouse_LPress", "HandleEventLUp_Menu_ScaleResizeLPress()")
  PaGlobal_Menu_Remake._ui.btn_scaleResize_right:addInputEvent("Mouse_LUp", "HandleEventLUp_Menu_ScaleResizeLUp()")
  PaGlobal_Menu_Remake._ui.btn_nextHeaderMenu:addInputEvent("Mouse_LUp", "PaGlobalFunc_menu_All_SwitchHeaderMenu(true)")
  PaGlobal_Menu_Remake._ui.btn_prevHeaderMenu:addInputEvent("Mouse_LUp", "PaGlobalFunc_menu_All_SwitchHeaderMenu(false)")
  registerEvent("onScreenResize", "FromClient_Menu_Remake_OnScreenResize")
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Widget_Menu_Remake:ignorePadSnapMoveToOtherPanel()
    Panel_Widget_Menu_Remake:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "PaGlobalFunc_menu_All_SwitchHeaderMenu(true)")
    Panel_Widget_Menu_Remake:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "PaGlobalFunc_menu_All_SwitchHeaderMenu(false)")
    if true == _ContentsGroup_RenewUI then
      Panel_Widget_Menu_Remake:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_Menu_Remake_PressedConfirm()")
    end
    Panel_Widget_Menu_Remake:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_MenuRemake_searchText()")
    Panel_Widget_Menu_Remake:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_MenuRemake_Commit()")
    Panel_Widget_Menu_Remake:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandleEventLUp_MenuRemake_ChangeCustomizeMode()")
    Panel_Widget_Menu_Remake:registerPadEvent(__eConsoleUIPadEvent_Up_LSClick, "HandleEventLUp_MenuRemake_ChangeOpenWay()")
    if true == ToClient_isConsole() then
      PaGlobal_Menu_Remake._ui.edit_searchTxt:setXboxVirtualKeyBoardEndEvent("HandleEventPad_MenuRemake_searchText")
    else
      PaGlobal_Menu_Remake._ui.edit_searchTxt:RegistReturnKeyEvent("HandleEventKeyBoard_MenuRemake_searchingMenu()")
      Panel_Widget_Menu_Remake:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "PaGlobal_Menu_Remake_MenuChange()")
    end
  end
  PaGlobal_Menu_Remake._ui.stc_eventBanner:addInputEvent("Mouse_LUp", "PaGlobalFunc_EventGuide_Total_Open()")
end
function HandleEventLUp_Menu_ScaleResizeLDown()
  if true == PaGlobal_Menu_Remake._isCustomizeMode then
    PaGlobal_Menu_Remake:headmenuCustomize_cancel()
  end
  UI.PanelDynamicSacle_ResizeStart(Panel_Widget_Menu_Remake)
end
function HandleEventLUp_Menu_ScaleResizeLPress()
  UI.PanelDynamicSacle_ResizePressing(Panel_Widget_Menu_Remake)
  PaGlobal_Menu_Remake:setHeaderHotKey()
  PaGlobal_Menu_Remake:setMenuHotKey()
  PaGlobal_Menu_Remake:setCustomize_menu(false)
  PaGlobal_Menu_Remake:resetMenu(false)
  PaGlobal_Menu_Remake:headMenu_toggle(1)
  HandleEventLUp_MenuRemake_Menu(1)
end
function HandleEventLUp_Menu_ScaleResizeLPress_Right()
  UI.PanelDynamicSacle_ResizePressing_Reverse(Panel_Widget_Menu_Remake)
  PaGlobal_Menu_Remake:setHeaderHotKey()
  PaGlobal_Menu_Remake:setMenuHotKey()
  PaGlobal_Menu_Remake:setCustomize_menu(false)
  PaGlobal_Menu_Remake:resetMenu(false)
  PaGlobal_Menu_Remake:headMenu_toggle(1)
  HandleEventLUp_MenuRemake_Menu(1)
end
function HandleEventLUp_Menu_ScaleResizeLUp()
  if true == PaGlobal_Menu_Remake._isCustomizeMode then
    PaGlobal_Menu_Remake:headmenuCustomize_cancel()
  end
  UI.PanelDynamicSacle_ResizeEnd(Panel_Widget_Menu_Remake)
end
function PaGlobal_Menu_Remake:showCustomizeToolTip()
  if true == PaGlobal_Menu_Remake._isCustomizeMode then
    TooltipSimple_Show(PaGlobal_Menu_Remake._ui.btn_customizeUi, PAGetString(Defines.StringSheet_GAME, "LUA_MENU_EDITCLOSE"))
  else
    TooltipSimple_Show(PaGlobal_Menu_Remake._ui.btn_customizeUi, PAGetString(Defines.StringSheet_GAME, "LUA_MENU_DOEDIT"))
  end
end
function PaGlobal_Menu_Remake_HideToolTip()
  PaGlobal_Menu_Remake:hideTooltip()
end
function PaGlobal_Menu_Remake:hideTooltip()
  TooltipSimple_Hide()
end
function PaGlobal_Menu_Remake_PressedConfirm()
  if PaGlobal_Menu_Remake._nowMenuMode == nil or PaGlobal_Menu_Remake._nowMenuMode == "" then
    return
  end
  if PaGlobal_Menu_Remake._nowMenuIndex == nil or PaGlobal_Menu_Remake._nowMenuIndex == 0 then
    return
  end
  if PaGlobal_Menu_Remake._nowMenuMode == "recentmenu" or PaGlobal_Menu_Remake._nowMenuMode == "changeWay" then
    return
  end
  if PaGlobal_Menu_Remake._nowMenuMode == "header" then
    PaGlobal_Menu_Remake:headMenu_select(PaGlobal_Menu_Remake._nowMenuIndex)
  elseif PaGlobal_Menu_Remake._nowMenuMode == "menu" then
    PaGlobal_Menu_Remake:menu_select(PaGlobal_Menu_Remake._nowMenuIndex)
  elseif PaGlobal_Menu_Remake._nowMenuMode == "submenu" then
    PaGlobal_Menu_Remake:submenu_select(PaGlobal_Menu_Remake._nowMenuIndex)
  elseif PaGlobal_Menu_Remake._nowMenuMode == "search" then
    PaGlobal_Menu_Remake:searchMenu_select(PaGlobal_Menu_Remake._nowMenuIndex)
  end
end
function PaGlobal_Menu_Remake:ShowAni()
  PaGlobal_Menu_Remake._isLeft = 0 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMenuOpenWay)
  local gap = getOriginScreenSizeX() - getScreenSizeX()
  if gap > 0 then
    gap = gap * 0.5
  end
  if true == PaGlobal_Menu_Remake._isLeft then
    local ImageMoveAni = Panel_Widget_Menu_Remake:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    ImageMoveAni:SetStartPosition(0 - Panel_Widget_Menu_Remake:GetSizeX(), Panel_Widget_Menu_Remake:GetPosY())
    ImageMoveAni:SetEndPosition(gap, Panel_Widget_Menu_Remake:GetPosY())
    ImageMoveAni.IsChangeChild = true
    Panel_Widget_Menu_Remake:CalcUIAniPos(ImageMoveAni)
    ImageMoveAni:SetDisableWhileAni(true)
    ImageMoveAni:SetIgnoreUpdateSnapping(true)
  else
    local ImageMoveAni = Panel_Widget_Menu_Remake:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    ImageMoveAni:SetStartPosition(getOriginScreenSizeX(), Panel_Widget_Menu_Remake:GetPosY())
    ImageMoveAni:SetEndPosition(getScreenSizeX() - Panel_Widget_Menu_Remake:GetSizeX() + gap, Panel_Widget_Menu_Remake:GetPosY())
    ImageMoveAni.IsChangeChild = true
    Panel_Widget_Menu_Remake:CalcUIAniPos(ImageMoveAni)
    ImageMoveAni:SetDisableWhileAni(true)
    ImageMoveAni:SetIgnoreUpdateSnapping(true)
  end
end
function PaGlobal_Menu_Remake:HideAni()
  local ImageMoveAni = Panel_Widget_Menu_Remake:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(Panel_Widget_Menu_Remake:GetPosX(), Panel_Widget_Menu_Remake:GetPosY())
  if Panel_Widget_Menu_Remake:GetPosX() < getScreenSizeX() / 2 then
    ImageMoveAni:SetEndPosition(0 - Panel_Widget_Menu_Remake:GetSizeX(), Panel_Widget_Menu_Remake:GetPosY())
  else
    ImageMoveAni:SetEndPosition(getScreenSizeX(), Panel_Widget_Menu_Remake:GetPosY())
  end
  ImageMoveAni.IsChangeChild = true
  Panel_Widget_Menu_Remake:CalcUIAniPos(ImageMoveAni)
  ImageMoveAni:SetDisableWhileAni(true)
  ImageMoveAni:SetHideAtEnd(true)
  ImageMoveAni:SetDisableWhileAni(true)
  ImageMoveAni:SetIgnoreUpdateSnapping(true)
end
function PaGlobal_Menu_Remake:WayButtonShowAni()
  PaGlobal_Menu_Remake._isLeft = 0 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMenuOpenWay)
  PaGlobal_Menu_Remake:headmenuCustomize_cancel()
  if true == PaGlobal_Menu_Remake._isCustomizeMode then
    PaGlobal_Menu_Remake._ui.btn_scaleResize_left:SetShow(false)
    PaGlobal_Menu_Remake._ui.btn_scaleResize_right:SetShow(false)
  elseif true == PaGlobal_Menu_Remake._isLeft then
    PaGlobal_Menu_Remake._ui.btn_scaleResize_left:SetShow(false)
    PaGlobal_Menu_Remake._ui.btn_scaleResize_right:SetShow(true)
  else
    PaGlobal_Menu_Remake._ui.btn_scaleResize_left:SetShow(true)
    PaGlobal_Menu_Remake._ui.btn_scaleResize_right:SetShow(false)
  end
end
function PaGlobal_Menu_Remake:prepareOpen()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  if _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel() then
    return
  end
  PaGlobal_Menu_Remake:setCustomize_menu(false)
  PaGlobal_Menu_Remake:resetMenu(true)
  PaGlobal_Menu_Remake:headMenu_toggle(1)
  PaGlobal_Menu_Remake:open()
  HandleEventLUp_MenuRemake_Menu(self._IDX_FAVORITE)
  if false == _ContentsGroup_UsePadSnapping then
    if true == PaGlobal_Menu_Remake._isLeft then
      PaGlobal_Menu_Remake._ui.btn_scaleResize_left:SetShow(false)
      PaGlobal_Menu_Remake._ui.btn_scaleResize_right:SetShow(true)
    else
      PaGlobal_Menu_Remake._ui.btn_scaleResize_left:SetShow(true)
      PaGlobal_Menu_Remake._ui.btn_scaleResize_right:SetShow(false)
    end
  end
  if true == PaGlobal_Menu_Remake._isLeft then
    Panel_Widget_Menu_Remake:SetHorizonLeft()
  else
    Panel_Widget_Menu_Remake:SetHorizonRight()
  end
  if true == _ContentsGroup_UsePadSnapping then
    if nil ~= PaGlobal_Menu_Remake._headerHotKeyGroup[self._IDX_FAVORITE].radiobtn then
      ToClient_padSnapChangeToTarget(PaGlobal_Menu_Remake._headerHotKeyGroup[self._IDX_FAVORITE].radiobtn)
    end
    PaGlobal_Menu_Remake:AlignkeyGuide()
  else
    self:submenu_toggle(1, false)
  end
  if true == _ContentsGroup_SeasonContents and true == _ContentsGroup_RenewUI then
    self:showSeasonPassBanner()
  end
  if true == _ContentsGroup_GrowthPass then
    self:showGrowthPassBanner()
  end
  self:showEventBanner()
end
function PaGlobal_Menu_Remake:open()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  Panel_Widget_Menu_Remake:SetShow(true, true)
end
function PaGlobal_Menu_Remake:menuCustomize_toggle()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake._isCustomizeMode = not PaGlobal_Menu_Remake._isCustomizeMode
  PaGlobal_Menu_Remake._selected_customize_headerIndex = 0
  PaGlobal_Menu_Remake:setCustomize_menu(PaGlobal_Menu_Remake._isCustomizeMode)
  PaGlobal_Menu_Remake:resetMenu(true)
end
function PaGlobal_Menu_Remake:setCustomize_menu(isMode)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake._ui.stctxt_header_button_title:SetText("")
  PaGlobal_Menu_Remake._ui.stc_header_title_shape1:SetShow(false)
  PaGlobal_Menu_Remake._ui.stc_header_title_shape2:SetShow(false)
  if true == isMode then
    PaGlobal_Menu_Remake._ui.stctxt_title_icon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_EDITTITLE"))
  else
    PaGlobal_Menu_Remake._ui.stctxt_title_icon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_RENEW_MENU_TITLE"))
  end
  PaGlobal_Menu_Remake:setMenuGrid(isMode)
  PaGlobal_Menu_Remake:setHighLight("header")
  PaGlobal_Menu_Remake._ui.btn_openway:SetShow(not isMode)
  PaGlobal_Menu_Remake._ui.btn_customizeUi:SetShow(not isMode and not _ContentsGroup_UsePadSnapping)
  PaGlobal_Menu_Remake._ui.btn_changeUi:SetShow(not isMode and _ContentsOption_CH_GameType == false and not isGameTypeGT() and not _ContentsGroup_UsePadSnapping)
  PaGlobal_Menu_Remake._ui.btn_cancel:SetShow(isMode and not _ContentsGroup_UsePadSnapping)
  PaGlobal_Menu_Remake._ui.btn_commit:SetShow(isMode and not _ContentsGroup_UsePadSnapping)
  if true == isMode then
    local textureDDS = PaGlobal_Menu_Remake._headerTitleGrid.ddsUrl
    local textureUV = PaGlobal_Menu_Remake._headerTitleGrid.customize
    PaGlobal_Menu_Remake._ui.stc_header_interface_group:ChangeTextureInfoNameAsync(textureDDS)
    PaGlobal_Menu_Remake._ui.stc_header_interface_group:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUV.x1, textureUV.y1, textureUV.x2, textureUV.y2)
  else
    local textureDDS = PaGlobal_Menu_Remake._headerTitleGrid.ddsUrl
    local textureUV = PaGlobal_Menu_Remake._headerTitleGrid.normal
    PaGlobal_Menu_Remake._ui.stc_header_interface_group:ChangeTextureInfoNameAsync(textureDDS)
    PaGlobal_Menu_Remake._ui.stc_header_interface_group:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUV.x1, textureUV.y1, textureUV.x2, textureUV.y2)
  end
end
function PaGlobal_Menu_Remake:prepareClose()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake._selectMenuIndex = 0
  for ii = 1, PaGlobal_Menu_Remake._MAX_SUBMENUHOTKEY_COUNT do
    PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake.numberKeySetting[ii]] = {}
    PaGlobal_Menu_Remake._hotKeyFunction[PaGlobal_Menu_Remake.numberPadKeySetting[ii]] = {}
  end
  PaGlobal_Menu_Remake._isCustomizeMode = false
  PaGlobal_Menu_Remake:setCustomize_menu(PaGlobal_Menu_Remake._isCustomizeMode)
  PaGlobal_Menu_Remake._selected_customize_headerIndex = 0
  PaGlobal_Menu_Remake:recentmenu_setHide()
  PaGlobal_Menu_Remake:close()
end
function PaGlobal_Menu_Remake:close(showAni)
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  if false == Panel_Widget_Menu_Remake:GetShow() then
    return
  end
  if nil == showAni then
    showAni = true
  end
  Panel_Widget_Menu_Remake:SetShow(false, showAni)
end
function PaGlobal_Menu_Remake:update()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
end
function PaGlobal_Menu_Remake_ShowToggle()
  local isShow = Panel_Widget_Menu_Remake:GetShow()
  if false == isShow then
    PaGlobal_Menu_Remake:prepareOpen()
  else
    PaGlobal_Menu_Remake:prepareClose()
  end
  return isShow
end
function PaGlobal_Menu_Remake_MenuChange()
  PaGlobal_Menu_Remake_Close()
  PaGlobal_Menu_Remake:prepareClose()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eMenuType, 1, CppEnums.VariableStorageType.eVariableStorageType_User)
  Panel_Menu_ShowToggle()
end
function PaGlobal_Menu_Remake:checkPressedHotKey()
  if true == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_MENU) then
    return false
  end
  for index, funcGroup in pairs(PaGlobal_Menu_Remake._hotKeyFunction) do
    if true == GlobalKeyBinder_CheckKeyPressed(index) then
      setUiInputProcessed(index)
      if nil ~= funcGroup and nil ~= funcGroup.index and nil ~= funcGroup.type then
        if funcGroup.type == "menu" then
          HandleEventLUp_MenuRemake_Menu(funcGroup.index)
        elseif funcGroup.type == "confirmKey" then
          if nil ~= funcGroup.func then
            funcGroup.func()
          end
        elseif funcGroup.type == "arrowKey" then
          if nil ~= funcGroup.func then
            funcGroup.func(index)
          end
        elseif funcGroup.type == "submenu" then
          if nil ~= funcGroup.func then
            PaGlobal_Menu_Remake:submenu_select(funcGroup.index)
          end
        elseif funcGroup.type == "search" then
          if nil ~= funcGroup.func then
            PaGlobal_Menu_Remake:searchMenu_select(funcGroup.index)
          end
        else
          if nil ~= funcGroup.func then
            funcGroup.func()
          end
          PaGlobal_Menu_Remake:prepareClose()
        end
        return true
      end
    end
  end
  return false
end
function PaGlobal_Menu_Remake:checkPressedDPad()
  local DpadCodes = {
    [__eJoyPadInputType_DPad_Up] = CppEnums.VirtualKeyCode.KeyCode_UP,
    [__eJoyPadInputType_DPad_Down] = CppEnums.VirtualKeyCode.KeyCode_DOWN,
    [__eJoyPadInputType_DPad_Left] = CppEnums.VirtualKeyCode.KeyCode_LEFT,
    [__eJoyPadInputType_DPad_Right] = CppEnums.VirtualKeyCode.KeyCode_RIGHT,
    [__eJoyPadInputType_LeftStick_Up] = CppEnums.VirtualKeyCode.KeyCode_UP,
    [__eJoyPadInputType_LeftStick_Down] = CppEnums.VirtualKeyCode.KeyCode_DOWN,
    [__eJoyPadInputType_LeftStick_Left] = CppEnums.VirtualKeyCode.KeyCode_LEFT,
    [__eJoyPadInputType_LeftStick_Right] = CppEnums.VirtualKeyCode.KeyCode_RIGHT
  }
  for dpadCode, keyCode in pairs(DpadCodes) do
    if isPadDown(dpadCode) then
      PaGlobal_Menu_Remake:pressedArrowKey(keyCode)
    end
  end
end
function PaGlobal_Menu_Remake:setBeforeSearch()
  PaGlobal_Menu_Remake._searchResult = {}
  PaGlobal_Menu_Remake._ui.edit_searchTxt:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_SEARCHTEXT"))
  PaGlobal_Menu_Remake._ui.stc_searchResultGroup:SetShow(false)
  PaGlobal_Menu_Remake._ui.stc_menuGroup:SetShow(true)
  PaGlobal_Menu_Remake._ui.stc_submenu_BG:SetShow(true)
  ClearFocusEdit()
  if nil ~= PaGlobal_Menu_Remake._beforeSearchMenuMode and nil ~= PaGlobal_Menu_Remake._beforeSearchSelectedMenuIndex then
    PaGlobal_Menu_Remake:menu_toggle(PaGlobal_Menu_Remake._beforeSearchSelectedMenuIndex, false)
    if "header" == PaGlobal_Menu_Remake._beforeSearchMenuMode then
      PaGlobal_Menu_Remake:headMenu_toggle(PaGlobal_Menu_Remake._beforeSearchSelectedMenuIndex)
    elseif "menu" == PaGlobal_Menu_Remake._beforeSearchMenuMode then
      PaGlobal_Menu_Remake:menu_toggle(PaGlobal_Menu_Remake._beforeSearchSelectedMenuIndex, true)
    elseif "submenu" == PaGlobal_Menu_Remake._beforeSearchMenuMode then
      PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(true)
      PaGlobal_Menu_Remake:menu_select(PaGlobal_Menu_Remake._beforeSelectedMenuIndex)
      PaGlobal_Menu_Remake:submenu_toggle(PaGlobal_Menu_Remake._beforeSearchSelectedMenuIndex, true)
    end
  end
  PaGlobal_Menu_Remake._beforeSearchMenuMode = nil
end
function PaGlobal_Menu_Remake_Close()
  if true == PaGlobal_Menu_Remake._ui.stc_searchResultGroup:GetShow() then
    PaGlobal_Menu_Remake:setBeforeSearch()
    return
  end
  if true == PaGlobal_Menu_Remake._isCustomizeMode then
    PaGlobal_Menu_Remake:headmenuCustomize_cancel()
    if true == _ContentsGroup_UsePadSnapping then
      PaGlobal_Menu_Remake:headMenu_toggle(1)
    end
    return
  end
  PaGlobal_Menu_Remake:prepareClose()
end
function PaGlobal_Menu_Remake_GetShow()
  return Panel_Widget_Menu_Remake:GetShow()
end
function PaGlobal_Menu_Remake:resetMenu(runResize)
  if false == _ContentsGroup_UsePadSnapping then
    if true == PaGlobal_Menu_Remake._isCustomizeMode then
      PaGlobal_Menu_Remake._ui.btn_scaleResize_left:SetShow(false)
      PaGlobal_Menu_Remake._ui.btn_scaleResize_right:SetShow(false)
    elseif true == PaGlobal_Menu_Remake._isLeft then
      PaGlobal_Menu_Remake._ui.btn_scaleResize_left:SetShow(false)
      PaGlobal_Menu_Remake._ui.btn_scaleResize_right:SetShow(true)
    else
      PaGlobal_Menu_Remake._ui.btn_scaleResize_left:SetShow(true)
      PaGlobal_Menu_Remake._ui.btn_scaleResize_right:SetShow(false)
    end
  end
  if true == runResize then
    PaGlobal_Menu_Remake:resizeMenu()
  end
  PaGlobal_Menu_Remake._nowMenuMode = ""
  PaGlobal_Menu_Remake._nowMenuIndex = 0
  PaGlobal_Menu_Remake._nowSelectedMenuIndex = 0
  local textureUVOut = PaGlobal_Menu_Remake._menuGrid.normal
  local textureDDS = PaGlobal_Menu_Remake._menuGrid.ddsUrl
  for ii = 1, #PaGlobal_Menu_Remake._menuHotKey do
    if nil ~= PaGlobal_Menu_Remake._menuHotKeyGroup[ii] then
      textureUVOut = PaGlobal_Menu_Remake._menuGrid.normal
      if PaGlobal_Menu_Remake._menuHotKey[ii].isNew or PaGlobal_Menu_Remake._menuHotKey[ii].isHot then
        textureUVOut = PaGlobal_Menu_Remake._newMenuGrid.normal
      end
      local radiobtn = PaGlobal_Menu_Remake._menuHotKeyGroup[ii].radiobtn
      radiobtn:SetCheck(false)
      local x1, y1, x2, y2 = setTextureUV_Func(radiobtn, textureUVOut.x1, textureUVOut.y1, textureUVOut.x2, textureUVOut.y2)
      radiobtn:ChangeTextureInfoNameAsync(textureDDS)
      radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, x1, y1, x2, y2)
    end
  end
  textureUVOut = PaGlobal_Menu_Remake._headerGrid.normal
  textureDDS = PaGlobal_Menu_Remake._headerGrid.ddsUrl
  for index, controlGroup in pairs(PaGlobal_Menu_Remake._headerHotKeyGroup) do
    controlGroup.radiobtn:ChangeTextureInfoNameAsync(textureDDS)
    controlGroup.radiobtn:setPixelUVAndLoadTexture(__eUITextureTypeBase, textureUVOut.x1, textureUVOut.y1, textureUVOut.x2, textureUVOut.y2)
  end
  PaGlobal_Menu_Remake:setBeforeSearch()
  PaGlobal_Menu_Remake:setMenuCondition()
  PaGlobal_Menu_Remake:SetSubmenuHotKeyInfo()
  PaGlobal_Menu_Remake:CheckAndSetHeaderPage()
  PaGlobal_Menu_Remake:setHeadHotKeyInfo()
  PaGlobal_Menu_Remake:setRecentMenuInfo()
  PaGlobal_Menu_Remake:setHeaderHotKey()
  PaGlobal_Menu_Remake:setMenuHotKey()
  PaGlobal_Menu_Remake._ui.stc_subMenuGroup:SetShow(false)
  PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:SetShow(true)
  PaGlobal_Menu_Remake:hideTooltip()
end
function PaGlobal_Menu_Remake_ToggleSearchMode()
  PaGlobal_Menu_Remake:toggle_searchMode()
end
function PaGlobal_Menu_Remake:toggle_searchMode()
  if true == PaGlobal_Menu_Remake._ui.edit_searchTxt:GetFocusEdit() then
    PaGlobal_Menu_Remake:setBeforeSearch()
  else
    PaGlobal_Menu_Remake:selected_searchText()
  end
end
function PaGlobal_Menu_Remake:selected_searchText()
  PaGlobal_Menu_Remake._ui.edit_searchTxt:SetEditText("")
  SetFocusEdit(PaGlobal_Menu_Remake._ui.edit_searchTxt)
end
function PaGlobal_Menu_Remake:validate()
  if nil == Panel_Widget_Menu_Remake then
    return
  end
  PaGlobal_Menu_Remake._ui.stc_topGroup:isValidate()
  PaGlobal_Menu_Remake._ui.stc_menuGroup:isValidate()
  PaGlobal_Menu_Remake._ui.stc_subMenuGroup:isValidate()
  PaGlobal_Menu_Remake._ui.stc_menuSelect_desc_Group:isValidate()
  PaGlobal_Menu_Remake._ui.stc_submenu_BG:isValidate()
  PaGlobal_Menu_Remake._ui.stc_submenu_highlight:isValidate()
  PaGlobal_Menu_Remake._ui.stc_header_button_group:isValidate()
  PaGlobal_Menu_Remake._ui.stc_header_button:isValidate()
  PaGlobal_Menu_Remake._ui.stc_header_interface_group:isValidate()
  PaGlobal_Menu_Remake._ui.stctxt_header_button_title:isValidate()
  PaGlobal_Menu_Remake._ui.stctxt_customize_desc:isValidate()
  PaGlobal_Menu_Remake._ui.btn_changeUi:isValidate()
  PaGlobal_Menu_Remake._ui.btn_openway:isValidate()
  PaGlobal_Menu_Remake._ui.btn_customizeUi:isValidate()
  PaGlobal_Menu_Remake._ui.stc_menuSelect_desc:isValidate()
  PaGlobal_Menu_Remake._ui.stc_menu_highlight:isValidate()
  PaGlobal_Menu_Remake._ui.radiobtn_menu:isValidate()
  PaGlobal_Menu_Remake._ui.radiobtn_sub_menu:isValidate()
end
function PaGlobal_Menu_Remake:showOpenWayToolTip()
  if 0 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMenuOpenWay) then
    TooltipSimple_Show(PaGlobal_Menu_Remake._ui.btn_openway, PAGetString(Defines.StringSheet_GAME, "LUA_MENU_RIGHTSLIDE"))
  else
    TooltipSimple_Show(PaGlobal_Menu_Remake._ui.btn_openway, PAGetString(Defines.StringSheet_GAME, "LUA_MENU_LEFTSLIDE"))
  end
end
function PaGlobal_Menu_Remake:showChangeUiToolTip()
  TooltipSimple_Show(PaGlobal_Menu_Remake._ui.btn_changeUi, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_NEW_TRANSFER_OLD"))
end
function PaGlobal_Menu_Remake:setMenuOpenWay()
  local way = 0
  if 0 == ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMenuOpenWay) then
    way = 1
  end
  if 1 == way then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_MENUOPEN_RIGHT"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHANGE_MENUOPEN_LEFT"))
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eMenuOpenWay, way, CppEnums.VariableStorageType.eVariableStorageType_User)
  PaGlobal_Menu_Remake:WayButtonShowAni()
  if true == ToClient_isConsole() then
    ToClient_saveUserCache()
  end
  PaGlobal_Menu_Remake:setMenuOpenWayBtn()
end
function PaGlobal_Menu_Remake:setRecentMenuInfo()
  PaGlobal_Menu_Remake._recentGroup = {}
  PaGlobal_Menu_Remake._recentFixedCount = 0
  local disapearSubMenuCount = 0
  for idx = 1, PaGlobal_Menu_Remake._MAX_FAVORITEMENU do
    local modifiedIdx = idx - disapearSubMenuCount
    local saveIndex = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx])
    PaGlobal_Menu_Remake._menuHotKey[PaGlobal_Menu_Remake._IDX_FAVORITE].subMenu[modifiedIdx] = {}
    if saveIndex ~= nil and saveIndex ~= 0 then
      local realIndex = saveIndex
      if 0 < realIndex - 1000 then
        realIndex = realIndex - 1000
        PaGlobal_Menu_Remake._recentFixedCount = PaGlobal_Menu_Remake._recentFixedCount + 1
      end
      local menuInfo = PaGlobal_Menu_Remake:GetMenuInfo(realIndex)
      if menuInfo ~= nil then
        PaGlobal_Menu_Remake._menuHotKey[PaGlobal_Menu_Remake._IDX_FAVORITE].subMenu[modifiedIdx] = menuInfo
        PaGlobal_Menu_Remake._recentGroup[modifiedIdx] = saveIndex
        if disapearSubMenuCount >= 1 then
          ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[modifiedIdx], saveIndex, CppEnums.VariableStorageType.eVariableStorageType_User)
          ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx], 0, CppEnums.VariableStorageType.eVariableStorageType_User)
        end
      else
        disapearSubMenuCount = disapearSubMenuCount + 1
        ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx], 0, CppEnums.VariableStorageType.eVariableStorageType_User)
        PaGlobal_Menu_Remake._recentGroup[modifiedIdx] = nil
      end
    else
      disapearSubMenuCount = disapearSubMenuCount + 1
      ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx], 0, CppEnums.VariableStorageType.eVariableStorageType_User)
      PaGlobal_Menu_Remake._recentGroup[modifiedIdx] = nil
    end
  end
end
function PaGlobal_Menu_Remake:addRecentMenu(mainIdx, subIdx, isFix)
  local menuHotKey = PaGlobal_Menu_Remake._menuHotKey[mainIdx]
  if nil == menuHotKey then
    return
  end
  local subMenuGroup = menuHotKey.subMenu[subIdx]
  if nil == subMenuGroup or nil == subMenuGroup.func then
    return
  end
  local writeIndex = subMenuGroup.index
  local isSamething = false
  for idx = 1, #PaGlobal_Menu_Remake._recentGroup do
    if writeIndex == PaGlobal_Menu_Remake._recentGroup[idx] then
      isSamething = true
      break
    end
    if writeIndex + 1000 == PaGlobal_Menu_Remake._recentGroup[idx] then
      isSamething = true
      break
    end
  end
  if true == isSamething then
    return
  end
  for idx = PaGlobal_Menu_Remake._recentFixedCount + 1, PaGlobal_Menu_Remake._MAX_FAVORITEMENU do
    local saveIndex = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx])
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx], writeIndex, CppEnums.VariableStorageType.eVariableStorageType_User)
    PaGlobal_Menu_Remake._recentGroup[idx] = writeIndex
    if nil ~= saveIndex and 0 ~= saveIndex then
      writeIndex = saveIndex
    else
      break
    end
  end
end
function PaGlobal_Menu_Remake:recentmenu_setToggle(submenuIndex)
  if PaGlobal_Menu_Remake._IDX_FAVORITE ~= PaGlobal_Menu_Remake._selectMenuIndex then
    return
  end
  if false == PaGlobal_Menu_Remake._ui.stc_recentMenuSet:GetShow() then
    PaGlobal_Menu_Remake._ui.stc_recentMenuSet:SetShow(true)
    local panelPosX = Panel_Widget_Menu_Remake:GetPosX()
    local panelPosY = Panel_Widget_Menu_Remake:GetPosY()
    local calcPosX = 0
    local calcPosY = 0
    if true == PaGlobal_Menu_Remake._isLeft then
      calcPosX = panelPosX + Panel_Widget_Menu_Remake:GetSizeX() + 10
      calcPosY = 0
    else
      calcPosX = -PaGlobal_Menu_Remake._ui.stc_recentMenuSet:GetSizeX() - 10
      calcPosY = 0
    end
    local subMenuGroupPosY = PaGlobal_Menu_Remake._ui.stc_subMenuGroup:GetPosY()
    local rdoPosY = (PaGlobal_Menu_Remake._subMenuHotKeyGroup[1].radiobtn:GetSizeY() + 5) * (submenuIndex - 1)
    calcPosY = subMenuGroupPosY + rdoPosY
    local screenSizeY = getScreenSizeY() - 10
    if screenSizeY < panelPosY + calcPosY + PaGlobal_Menu_Remake._ui.stc_recentMenuSet:GetSizeY() then
      calcPosY = screenSizeY - panelPosY - PaGlobal_Menu_Remake._ui.stc_recentMenuSet:GetSizeY()
    end
    PaGlobal_Menu_Remake._ui.stc_recentMenuSet:SetPosXY(calcPosX, calcPosY)
    PaGlobal_Menu_Remake._ui.stc_recentMenuSet:ComputePos()
    local menuHotKey = PaGlobal_Menu_Remake._menuHotKey[PaGlobal_Menu_Remake._IDX_FAVORITE]
    if nil == menuHotKey then
      return
    end
    local subMenuGroup = menuHotKey.subMenu[submenuIndex]
    if nil == subMenuGroup or nil == subMenuGroup.func then
      return
    end
    PaGlobal_Menu_Remake._recentSubMenuIdx = subMenuGroup.index
    PaGlobal_Menu_Remake._recentSubMenuGroupIdx = submenuIndex
    if submenuIndex <= PaGlobal_Menu_Remake._recentFixedCount then
      PaGlobal_Menu_Remake._ui.btn_recentMenuFixed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_RECENTMENU_UNFIXED"))
      PaGlobal_Menu_Remake._ui.btn_recentMenuFixed:addInputEvent("Mouse_LUp", "HandleEventLUp_Menu_RecentSubMenuUnFixed()")
      PaGlobal_Menu_Remake._ui.btn_recentMenuDelete:addInputEvent("Mouse_LUp", "HandleEventLUp_Menu_RecentSubMenuDeleted()")
    else
      PaGlobal_Menu_Remake._ui.btn_recentMenuFixed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MENU_REMAKE_RECENTMENU_FIXED"))
      PaGlobal_Menu_Remake._ui.btn_recentMenuFixed:addInputEvent("Mouse_LUp", "HandleEventLUp_Menu_RecentSubMenuFixed()")
      PaGlobal_Menu_Remake._ui.btn_recentMenuDelete:addInputEvent("Mouse_LUp", "HandleEventLUp_Menu_RecentSubMenuDeleted()")
    end
    if true == _ContentsGroup_UsePadSnapping then
      PaGlobal_Menu_Remake._ui.btn_recentMenuFixed:addInputEvent("Mouse_On", "HandleEventPadOnOut_Menu_RecentSubMenuOn(true)")
      PaGlobal_Menu_Remake._ui.btn_recentMenuDelete:addInputEvent("Mouse_On", "HandleEventPadOnOut_Menu_RecentSubMenuOn(true)")
    end
  else
    PaGlobal_Menu_Remake._ui.stc_recentMenuSet:SetShow(false)
    PaGlobal_Menu_Remake._recentSubMenuIdx = 0
    PaGlobal_Menu_Remake._recentSubMenuGroupIdx = 0
  end
end
function PaGlobal_Menu_Remake:recentmenu_setHide()
  if false == PaGlobal_Menu_Remake._ui.stc_recentMenuSet:GetShow() then
    return
  end
  PaGlobal_Menu_Remake._ui.stc_recentMenuSet:SetShow(false)
  PaGlobal_Menu_Remake._recentSubMenuIdx = 0
  PaGlobal_Menu_Remake._recentSubMenuGroupIdx = 0
end
function PaGlobal_Menu_Remake:setRecentMenuFixed()
  local targetIdx = PaGlobal_Menu_Remake._recentSubMenuIdx
  local targetGroupIdx = PaGlobal_Menu_Remake._recentSubMenuGroupIdx
  local mainIdx = PaGlobal_Menu_Remake:findMainIndex(targetIdx)
  if -1 == mainIdx then
    return
  end
  PaGlobal_Menu_Remake:setRecentMenuDelete(targetIdx)
  targetIdx = targetIdx + 1000
  for idx = PaGlobal_Menu_Remake._recentFixedCount + 1, PaGlobal_Menu_Remake._MAX_FAVORITEMENU do
    local saveIndex = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx])
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx], targetIdx, CppEnums.VariableStorageType.eVariableStorageType_User)
    PaGlobal_Menu_Remake._recentGroup[idx] = targetIdx
    if nil ~= saveIndex and 0 ~= saveIndex then
      targetIdx = saveIndex
    else
      break
    end
  end
  PaGlobal_Menu_Remake:updateRecentMenu()
end
function PaGlobal_Menu_Remake:setRecentMenuUnFixed()
  local targetIdx = PaGlobal_Menu_Remake._recentSubMenuIdx
  local targetGroupIdx = PaGlobal_Menu_Remake._recentSubMenuGroupIdx
  local mainIdx = PaGlobal_Menu_Remake:findMainIndex(targetIdx)
  if -1 == mainIdx then
    return
  end
  local delIndex = targetIdx + 1000
  PaGlobal_Menu_Remake:setRecentMenuDelete(delIndex)
  PaGlobal_Menu_Remake:setRecentMenuInfo()
  for idx = PaGlobal_Menu_Remake._recentFixedCount + 1, PaGlobal_Menu_Remake._MAX_FAVORITEMENU do
    local saveIndex = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx])
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx], targetIdx, CppEnums.VariableStorageType.eVariableStorageType_User)
    PaGlobal_Menu_Remake._recentGroup[idx] = targetIdx
    if nil ~= saveIndex and 0 ~= saveIndex then
      targetIdx = saveIndex
    else
      break
    end
  end
  PaGlobal_Menu_Remake:updateRecentMenu()
end
function PaGlobal_Menu_Remake:setRecentMenuDelete(delIndex)
  local isDeleted = false
  for idx = 1, PaGlobal_Menu_Remake._MAX_FAVORITEMENU do
    local getIndex = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx])
    if nil ~= getIndex and 0 ~= getIndex and (delIndex == getIndex or delIndex + 1000 == getIndex) then
      ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx], 0, CppEnums.VariableStorageType.eVariableStorageType_User)
      isDeleted = true
    end
    if true == isDeleted then
      local copyIndex
      if idx + 1 <= PaGlobal_Menu_Remake._MAX_FAVORITEMENU then
        copyIndex = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx + 1])
      end
      if nil ~= copyIndex and 0 ~= copyIndex then
        ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx], copyIndex, CppEnums.VariableStorageType.eVariableStorageType_User)
      else
        ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(PaGlobal_Menu_Remake.FAVORITE_MENU[idx], 0, CppEnums.VariableStorageType.eVariableStorageType_User)
      end
    end
  end
end
function PaGlobal_Menu_Remake:updateRecentMenu()
  PaGlobal_Menu_Remake:setRecentMenuInfo()
  PaGlobal_Menu_Remake:setSubmenu(PaGlobal_Menu_Remake._IDX_FAVORITE)
  PaGlobal_Menu_Remake:recentmenu_setHide()
end
function PaGlobal_Menu_Remake:findMainIndex(subIndex)
  for Idx = 2, #PaGlobal_Menu_Remake._menuHotKey do
    if nil ~= PaGlobal_Menu_Remake._menuHotKey[Idx].subMenu then
      for subIdx = 1, #PaGlobal_Menu_Remake._menuHotKey[Idx].subMenu do
        if subIndex == PaGlobal_Menu_Remake._menuHotKey[Idx].subMenu[subIdx].index then
          return Idx, subIdx
        end
      end
    end
  end
  return -1
end
function PaGlobal_Menu_Remake:isEmptyRecentMenu(menuIndex)
  if PaGlobal_Menu_Remake._IDX_FAVORITE ~= menuIndex then
    return false
  end
  local isEmptyRecent = true
  for idx = 1, PaGlobal_Menu_Remake._MAX_FAVORITEMENU do
    if PaGlobal_Menu_Remake._recentGroup[idx] ~= nil then
      isEmptyRecent = false
    end
  end
  return isEmptyRecent
end
function PaGlobal_Menu_Remake:AlignkeyGuide()
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  self._ui_console.stc_saveLeftKeyGuide:SetShow(self._isCustomizeMode)
  self._ui_console.stc_saveRightKeyGuide:SetShow(self._isCustomizeMode)
  self._ui_console.stc_openwayLeftKeyGuide:SetShow(not self._isCustomizeMode)
  self._ui_console.stc_openwayRightKeyGuide:SetShow(not self._isCustomizeMode)
  self._ui_console.stc_keyGuideLeftBg:SetShow(self._isLeft)
  self._ui_console.stc_keyGuideRightBg:SetShow(not self._isLeft)
  local leftKeyGuides = {
    self._ui_console.stc_changeLeftKeyGuide,
    self._ui_console.stc_customLeftKeyGuide,
    self._ui_console.stc_openwayLeftKeyGuide,
    self._ui_console.stc_saveLeftKeyGuide,
    self._ui_console.stc_searchLeftKeyGuide
  }
  local rightKeyGuides = {
    self._ui_console.stc_changeRightKeyGuide,
    self._ui_console.stc_customRightKeyGuide,
    self._ui_console.stc_openwayRightKeyGuide,
    self._ui_console.stc_saveRightKeyGuide,
    self._ui_console.stc_searchRightKeyGuide
  }
  local maxSizeX = 0
  for key, value in ipairs(leftKeyGuides) do
    if true == value:GetShow() then
      local textSize = value:GetTextSizeX() + value:GetSizeX() + value:GetSpanSize().x
      if maxSizeX < textSize then
        maxSizeX = textSize
      end
    end
  end
  local defaultKeyGuideBGSizeGap = 25
  if maxSizeX >= self._defaultKeyGuideBGSizeX then
    self._ui_console.stc_keyGuideLeftBg:SetSize(maxSizeX + defaultKeyGuideBGSizeGap, self._ui_console.stc_keyGuideLeftBg:GetSizeY())
    self._ui_console.stc_keyGuideRightBg:SetSize(maxSizeX + defaultKeyGuideBGSizeGap, self._ui_console.stc_keyGuideRightBg:GetSizeY())
    self._ui_console.stc_keyGuideRightBg:SetSpanSize((maxSizeX + defaultKeyGuideBGSizeGap) * -1, self._ui_console.stc_keyGuideRightBg:GetSpanSize().y)
  else
    self._ui_console.stc_keyGuideLeftBg:SetSize(self._defaultKeyGuideBGSizeX, self._ui_console.stc_keyGuideLeftBg:GetSizeY())
    self._ui_console.stc_keyGuideRightBg:SetSize(self._defaultKeyGuideBGSizeX, self._ui_console.stc_keyGuideRightBg:GetSizeY())
    self._ui_console.stc_keyGuideRightBg:SetSpanSize(self._defaultKeyGuideBGSizeX * -1, self._ui_console.stc_keyGuideRightBg:GetSpanSize().y)
  end
  local maxSizeX = 0
  for key, value in ipairs(rightKeyGuides) do
    if true == value:GetShow() then
      value:ComputePos()
    end
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(leftKeyGuides, self._ui_console.stc_keyGuideLeftBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM, nil, 0)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(rightKeyGuides, self._ui_console.stc_keyGuideRightBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_BOTTOM, nil, 0)
end
function PaGlobal_Menu_Remake:CheckAndSetHeaderPage()
  local uiManagerWrapper = ToClient_getGameUIManagerWrapper()
  local headerPage = 0
  if nil ~= uiManagerWrapper then
    headerPage = uiManagerWrapper:getLuaCacheDataListNumber(__eMenuHeaderPage)
    headerPage = Int64toInt32(headerPage)
  end
  PaGlobal_Menu_Remake._startHeaderIndex = headerPage
  if PaGlobal_Menu_Remake._MAX_HEADERINDEX < PaGlobal_Menu_Remake._startHeaderIndex then
    PaGlobal_Menu_Remake._startHeaderIndex = 0
  elseif 0 > PaGlobal_Menu_Remake._startHeaderIndex then
    PaGlobal_Menu_Remake._startHeaderIndex = PaGlobal_Menu_Remake._MAX_HEADERINDEX
  end
end
function PaGlobal_Menu_Remake:showEventBanner()
  if ToClient_isConsole() == true then
    self._ui.stc_eventBanner:SetShow(false)
    return
  end
  if self._isLeft == true then
    self._ui.stc_eventBanner:SetHorizonRight()
  else
    self._ui.stc_eventBanner:SetHorizonLeft()
  end
end
function PaGlobal_Menu_Remake:showSeasonPassBanner()
  if false == _ContentsGroup_SeasonContents then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    if true == selfPlayer:get():isSeasonCharacter() then
      self._ui_console.stc_seasonPassBanner:SetShow(true)
      Panel_Widget_Menu_Remake:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "PaGlobalFunc_menu_All_OpenSeasonPass()")
      if true == self._isLeft then
        self._ui_console.stc_seasonPassBanner:SetHorizonRight()
      else
        self._ui_console.stc_seasonPassBanner:SetHorizonLeft()
      end
    else
      self._ui_console.stc_seasonPassBanner:SetShow(false)
      Panel_Widget_Menu_Remake:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
    end
  end
end
function PaGlobal_Menu_Remake:showGrowthPassBanner()
  self._ui_console.stc_growthPassBanner:SetShow(false)
  self._ui_console.stc_growthPassBanner_PS:SetShow(false)
  if false == _ContentsGroup_GrowthPass then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == selfPlayer:get():isSeasonCharacter() then
    return
  end
  if true == ToClient_isPremiumCharacter() then
    return
  end
  local isConsole = true == ToClient_isConsole()
  local isPS4 = true == ToClient_isPS()
  local isPadMode = true == isConsole or true == isPS4 or true == _ContentsGroup_UsePadSnapping
  if false == isPadMode then
    Panel_Widget_Menu_Remake:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
    return
  end
  if true == isPS4 then
    self._ui_console.stc_growthPassBanner_PS:SetShow(true)
    if true == self._isLeft then
      self._ui_console.stc_growthPassBanner_PS:SetHorizonRight()
    else
      self._ui_console.stc_growthPassBanner_PS:SetHorizonLeft()
    end
  else
    self._ui_console.stc_growthPassBanner:SetShow(true)
    if true == self._isLeft then
      self._ui_console.stc_growthPassBanner:SetHorizonRight()
    else
      self._ui_console.stc_growthPassBanner:SetHorizonLeft()
    end
  end
  Panel_Widget_Menu_Remake:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "HandleEventLUp_MenuRemake_GrowthPass()")
end
