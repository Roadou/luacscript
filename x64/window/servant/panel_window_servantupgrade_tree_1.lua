function PaGlobal_ServantUpgrade_Tree:init()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_SelectMyShip = UI.getChildControl(self._ui._stc_base, "Static_MyShip")
  self._ui._stc_Tier_0 = UI.getChildControl(self._ui._stc_base, "StaticText_Tier_0")
  self._ui._stc_Tier_0_SubText = UI.getChildControl(self._ui._stc_Tier_0, "StaticText_1")
  self._ui._stc_Tier_0_pad = UI.getChildControl(self._ui._stc_Tier_0, "Static_1")
  self._ui._stc_Tier_1_1 = UI.getChildControl(self._ui._stc_base, "StaticText_Tier_1_1")
  self._ui._stc_Tier_1_1_SubText = UI.getChildControl(self._ui._stc_Tier_1_1, "StaticText_1")
  self._ui._stc_Tier_1_1_pad = UI.getChildControl(self._ui._stc_Tier_1_1, "Static_1")
  self._ui._stc_Tier_1_2 = UI.getChildControl(self._ui._stc_base, "StaticText_Tier_1_2")
  self._ui._stc_Tier_1_2_SubText = UI.getChildControl(self._ui._stc_Tier_1_2, "StaticText_1")
  self._ui._stc_Tier_1_2_pad = UI.getChildControl(self._ui._stc_Tier_1_2, "Static_1")
  self._ui._stc_Tier_1_3 = UI.getChildControl(self._ui._stc_base, "StaticText_Tier_1_3")
  self._ui._stc_Tier_1_3_SubText = UI.getChildControl(self._ui._stc_Tier_1_3, "StaticText_1")
  self._ui._stc_Tier_1_3_pad = UI.getChildControl(self._ui._stc_Tier_1_3, "Static_1")
  self._ui._stc_Tier_1_4 = UI.getChildControl(self._ui._stc_base, "StaticText_Tier_1_4")
  self._ui._stc_Tier_1_4_SubText = UI.getChildControl(self._ui._stc_Tier_1_4, "StaticText_1")
  self._ui._stc_Tier_1_4_pad = UI.getChildControl(self._ui._stc_Tier_1_4, "Static_1")
  self._ui._stc_Tier_10 = UI.getChildControl(self._ui._stc_base, "StaticText_Tier_10")
  self._ui._stc_Tier_10_SubText = UI.getChildControl(self._ui._stc_Tier_10, "StaticText_1")
  self._ui._stc_Tier_10_pad = UI.getChildControl(self._ui._stc_Tier_10, "Static_1")
  self._ui._stc_Tier_12 = UI.getChildControl(self._ui._stc_base, "StaticText_Tier_12")
  self._ui._stc_Tier_12_SubText = UI.getChildControl(self._ui._stc_Tier_12, "StaticText_1")
  self._ui._stc_Tier_12_pad = UI.getChildControl(self._ui._stc_Tier_12, "Static_1")
  self._ui._stc_Tier_17 = UI.getChildControl(self._ui._stc_base, "StaticText_Tier_17")
  self._ui._stc_Tier_17_SubText = UI.getChildControl(self._ui._stc_Tier_17, "StaticText_1")
  self._ui._stc_Tier_17_pad = UI.getChildControl(self._ui._stc_Tier_17, "Static_1")
  self._ui._stc_Tier_18 = UI.getChildControl(self._ui._stc_base, "StaticText_Tier_18")
  self._ui._stc_Tier_18_SubText = UI.getChildControl(self._ui._stc_Tier_18, "StaticText_1")
  self._ui._stc_Tier_18_pad = UI.getChildControl(self._ui._stc_Tier_18, "Static_1")
  self._ui._stc_Tier_19 = UI.getChildControl(self._ui._stc_base, "StaticText_Tier_19")
  self._ui._stc_Tier_19_SubText = UI.getChildControl(self._ui._stc_Tier_19, "StaticText_1")
  self._ui._stc_Tier_19_pad = UI.getChildControl(self._ui._stc_Tier_19, "Static_1")
  self._ui._stc_Tier_20 = UI.getChildControl(self._ui._stc_base, "StaticText_Tier_20")
  self._ui._stc_Tier_20_SubText = UI.getChildControl(self._ui._stc_Tier_20, "StaticText_1")
  self._ui._stc_Tier_20_pad = UI.getChildControl(self._ui._stc_Tier_20, "Static_1")
  self._ui._stc_Tier_0_SubText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_Tier_1_1_SubText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_Tier_1_2_SubText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_Tier_1_3_SubText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_Tier_1_4_SubText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_Tier_10_SubText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_Tier_12_SubText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_Tier_17_SubText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_Tier_18_SubText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_Tier_19_SubText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_Tier_20_SubText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_Tier_0_SubText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPTREE_NAME_DESC_00"))
  self._ui._stc_Tier_1_1_SubText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPTREE_NAME_DESC_02"))
  self._ui._stc_Tier_1_2_SubText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPTREE_NAME_DESC_01"))
  self._ui._stc_Tier_1_3_SubText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPTREE_NAME_DESC_03"))
  self._ui._stc_Tier_1_4_SubText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPTREE_NAME_DESC_04"))
  self._ui._stc_Tier_10_SubText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPTREE_NAME_DESC_06"))
  self._ui._stc_Tier_12_SubText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPTREE_NAME_DESC_05"))
  self._ui._stc_Tier_17_SubText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPTREE_NAME_DESC_09"))
  self._ui._stc_Tier_18_SubText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPTREE_NAME_DESC_10"))
  self._ui._stc_Tier_19_SubText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPTREE_NAME_DESC_08"))
  self._ui._stc_Tier_20_SubText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPTREE_NAME_DESC_07"))
  self._ui._stc_keyGuideB = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_B_ConsoleUI")
  self._ui._stc_keyGuideA = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui._stc_keyGuideX = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_X_ConsoleUI")
  self:setConsoleUI()
  self:registEventHandler()
end
function PaGlobal_ServantUpgrade_Tree:registEventHandler()
  if true == self._isConsole then
    self._ui._btn_Close:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_ServantUpgrade_Tree_Close()")
    self._ui._stc_Tier_0_pad:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31053)")
    self._ui._stc_Tier_1_1_pad:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31003)")
    self._ui._stc_Tier_1_1_pad:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31053, 1 )")
    self._ui._stc_Tier_1_2_pad:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31001)")
    self._ui._stc_Tier_1_2_pad:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31053, 2 )")
    self._ui._stc_Tier_1_3_pad:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31059)")
    self._ui._stc_Tier_1_3_pad:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31003, 3 )")
    self._ui._stc_Tier_1_4_pad:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31058)")
    self._ui._stc_Tier_1_4_pad:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31001, 4 )")
    self._ui._stc_Tier_10_pad:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31049)")
    self._ui._stc_Tier_10_pad:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31003, 5 )")
    self._ui._stc_Tier_12_pad:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31048)")
    self._ui._stc_Tier_12_pad:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31001, 6 )")
    self._ui._stc_Tier_17_pad:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31056)")
    self._ui._stc_Tier_17_pad:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31049, 7 )")
    self._ui._stc_Tier_18_pad:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31057)")
    self._ui._stc_Tier_18_pad:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31049, 8 )")
    self._ui._stc_Tier_19_pad:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31055)")
    self._ui._stc_Tier_19_pad:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31048, 9 )")
    self._ui._stc_Tier_20_pad:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31054)")
    self._ui._stc_Tier_20_pad:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31048, 10 )")
  else
    self._ui._stc_Tier_0:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31053)")
    self._ui._stc_Tier_0:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo()")
    self._ui._stc_Tier_1_1:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31053, 1 )")
    self._ui._stc_Tier_1_1:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31003)")
    self._ui._stc_Tier_1_1:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo()")
    self._ui._stc_Tier_1_2:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31053, 2 )")
    self._ui._stc_Tier_1_2:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31001)")
    self._ui._stc_Tier_1_2:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo()")
    self._ui._stc_Tier_1_3:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31003, 3 )")
    self._ui._stc_Tier_1_3:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31059)")
    self._ui._stc_Tier_1_3:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo()")
    self._ui._stc_Tier_1_4:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31001, 4 )")
    self._ui._stc_Tier_1_4:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31058)")
    self._ui._stc_Tier_1_4:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo()")
    self._ui._stc_Tier_10:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31003, 5 )")
    self._ui._stc_Tier_10:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31049)")
    self._ui._stc_Tier_10:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo()")
    self._ui._stc_Tier_12:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31001, 6 )")
    self._ui._stc_Tier_12:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31048)")
    self._ui._stc_Tier_12:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo()")
    self._ui._stc_Tier_17:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31049, 7 )")
    self._ui._stc_Tier_17:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31056)")
    self._ui._stc_Tier_17:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo()")
    self._ui._stc_Tier_18:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31049, 8 )")
    self._ui._stc_Tier_18:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31057)")
    self._ui._stc_Tier_18:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo()")
    self._ui._stc_Tier_19:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31048, 9 )")
    self._ui._stc_Tier_19:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31055)")
    self._ui._stc_Tier_19:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo()")
    self._ui._stc_Tier_20:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade_Tree:OpenUpgrade( 31048, 10 )")
    self._ui._stc_Tier_20:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(31054)")
    self._ui._stc_Tier_20:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo()")
    self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade_Tree_Close()")
  end
end
function PaGlobal_ServantUpgrade_Tree:setConsoleUI()
  if nil == Panel_Dialog_ServantExtension_All_Tree then
    return
  end
  if true == self._isConsole then
    self._ui._stc_keyGuideBG:SetShow(true)
    self._ui._stc_keyGuideB:SetShow(true)
    self._ui._stc_keyGuideA:SetShow(true)
    self._ui._stc_keyGuideX:SetShow(true)
    PaGlobal_ServantUpgrade_Tree:alignKeyGuide()
    self._ui._stc_Tier_0_pad:SetIgnore(false)
    self._ui._stc_Tier_1_1_pad:SetIgnore(false)
    self._ui._stc_Tier_1_1_pad:SetIgnore(false)
    self._ui._stc_Tier_1_2_pad:SetIgnore(false)
    self._ui._stc_Tier_1_2_pad:SetIgnore(false)
    self._ui._stc_Tier_1_3_pad:SetIgnore(false)
    self._ui._stc_Tier_1_3_pad:SetIgnore(false)
    self._ui._stc_Tier_1_4_pad:SetIgnore(false)
    self._ui._stc_Tier_1_4_pad:SetIgnore(false)
    self._ui._stc_Tier_10_pad:SetIgnore(false)
    self._ui._stc_Tier_10_pad:SetIgnore(false)
    self._ui._stc_Tier_12_pad:SetIgnore(false)
    self._ui._stc_Tier_12_pad:SetIgnore(false)
    self._ui._stc_Tier_17_pad:SetIgnore(false)
    self._ui._stc_Tier_17_pad:SetIgnore(false)
    self._ui._stc_Tier_18_pad:SetIgnore(false)
    self._ui._stc_Tier_18_pad:SetIgnore(false)
    self._ui._stc_Tier_19_pad:SetIgnore(false)
    self._ui._stc_Tier_19_pad:SetIgnore(false)
    self._ui._stc_Tier_20_pad:SetIgnore(false)
    self._ui._stc_Tier_20_pad:SetIgnore(false)
    self._ui._btn_Close:SetShow(false)
  else
    self._ui._stc_keyGuideBG:SetShow(false)
    self._ui._stc_keyGuideB:SetShow(false)
    self._ui._stc_keyGuideA:SetShow(false)
    self._ui._stc_keyGuideX:SetShow(false)
    self._ui._stc_Tier_0_pad:SetIgnore(true)
    self._ui._stc_Tier_1_1_pad:SetIgnore(true)
    self._ui._stc_Tier_1_1_pad:SetIgnore(true)
    self._ui._stc_Tier_1_2_pad:SetIgnore(true)
    self._ui._stc_Tier_1_2_pad:SetIgnore(true)
    self._ui._stc_Tier_1_3_pad:SetIgnore(true)
    self._ui._stc_Tier_1_3_pad:SetIgnore(true)
    self._ui._stc_Tier_1_4_pad:SetIgnore(true)
    self._ui._stc_Tier_1_4_pad:SetIgnore(true)
    self._ui._stc_Tier_10_pad:SetIgnore(true)
    self._ui._stc_Tier_10_pad:SetIgnore(true)
    self._ui._stc_Tier_12_pad:SetIgnore(true)
    self._ui._stc_Tier_12_pad:SetIgnore(true)
    self._ui._stc_Tier_17_pad:SetIgnore(true)
    self._ui._stc_Tier_17_pad:SetIgnore(true)
    self._ui._stc_Tier_18_pad:SetIgnore(true)
    self._ui._stc_Tier_18_pad:SetIgnore(true)
    self._ui._stc_Tier_19_pad:SetIgnore(true)
    self._ui._stc_Tier_19_pad:SetIgnore(true)
    self._ui._stc_Tier_20_pad:SetIgnore(true)
    self._ui._stc_Tier_20_pad:SetIgnore(true)
    self._ui._btn_Close:SetShow(true)
  end
end
function PaGlobal_ServantUpgrade_Tree:alignKeyGuide()
  local keyGuide = {
    self._ui._stc_keyGuideX,
    self._ui._stc_keyGuideA,
    self._ui._stc_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_ServantUpgrade_Tree:myShipSelected(shipKey)
  self._ui._stc_SelectMyShip:SetShow(false)
  if 31053 == shipKey then
    self._ui._stc_SelectMyShip:SetShow(true)
    self._ui._stc_SelectMyShip:SetHorizonCenter()
    self._ui._stc_SelectMyShip:SetVerticalTop()
    self._ui._stc_SelectMyShip:SetPosX(self._ui._stc_Tier_0:GetPosX() + self._ui._stc_Tier_0:GetSizeX() / 2 - self._ui._stc_SelectMyShip:GetSizeX() / 2)
    self._ui._stc_SelectMyShip:SetPosY(self._ui._stc_Tier_0:GetPosY() - 15)
  elseif 31003 == shipKey then
    self._ui._stc_SelectMyShip:SetShow(true)
    self._ui._stc_SelectMyShip:SetPosX(self._ui._stc_Tier_1_1:GetPosX() + self._ui._stc_Tier_1_1:GetSizeX() / 2 - self._ui._stc_SelectMyShip:GetSizeX() / 2)
    self._ui._stc_SelectMyShip:SetPosY(self._ui._stc_Tier_1_1:GetPosY() - 15)
  elseif 31001 == shipKey then
    self._ui._stc_SelectMyShip:SetShow(true)
    self._ui._stc_SelectMyShip:SetPosX(self._ui._stc_Tier_1_2:GetPosX() + self._ui._stc_Tier_1_2:GetSizeX() / 2 - self._ui._stc_SelectMyShip:GetSizeX() / 2)
    self._ui._stc_SelectMyShip:SetPosY(self._ui._stc_Tier_1_2:GetPosY() - 15)
  elseif 31059 == shipKey then
    self._ui._stc_SelectMyShip:SetShow(true)
    self._ui._stc_SelectMyShip:SetPosX(self._ui._stc_Tier_1_3:GetPosX() + self._ui._stc_Tier_1_3:GetSizeX() / 2 - self._ui._stc_SelectMyShip:GetSizeX() / 2)
    self._ui._stc_SelectMyShip:SetPosY(self._ui._stc_Tier_1_3:GetPosY() - 15)
  elseif 31058 == shipKey then
    self._ui._stc_SelectMyShip:SetShow(true)
    self._ui._stc_SelectMyShip:SetPosX(self._ui._stc_Tier_1_4:GetPosX() + self._ui._stc_Tier_1_4:GetSizeX() / 2 - self._ui._stc_SelectMyShip:GetSizeX() / 2)
    self._ui._stc_SelectMyShip:SetPosY(self._ui._stc_Tier_1_4:GetPosY() - 15)
  elseif 31049 == shipKey then
    self._ui._stc_SelectMyShip:SetShow(true)
    self._ui._stc_SelectMyShip:SetPosX(self._ui._stc_Tier_10:GetPosX() + self._ui._stc_Tier_10:GetSizeX() / 2 - self._ui._stc_SelectMyShip:GetSizeX() / 2)
    self._ui._stc_SelectMyShip:SetPosY(self._ui._stc_Tier_10:GetPosY() - 15)
  elseif 31048 == shipKey then
    self._ui._stc_SelectMyShip:SetShow(true)
    self._ui._stc_SelectMyShip:SetPosX(self._ui._stc_Tier_12:GetPosX() + self._ui._stc_Tier_12:GetSizeX() / 2 - self._ui._stc_SelectMyShip:GetSizeX() / 2)
    self._ui._stc_SelectMyShip:SetPosY(self._ui._stc_Tier_12:GetPosY() - 15)
  elseif 31056 == shipKey then
    self._ui._stc_SelectMyShip:SetShow(true)
    self._ui._stc_SelectMyShip:SetPosX(self._ui._stc_Tier_17:GetPosX() + self._ui._stc_Tier_17:GetSizeX() / 2 - self._ui._stc_SelectMyShip:GetSizeX() / 2)
    self._ui._stc_SelectMyShip:SetPosY(self._ui._stc_Tier_17:GetPosY() - 15)
  elseif 31057 == shipKey then
    self._ui._stc_SelectMyShip:SetShow(true)
    self._ui._stc_SelectMyShip:SetPosX(self._ui._stc_Tier_18:GetPosX() + self._ui._stc_Tier_18:GetSizeX() / 2 - self._ui._stc_SelectMyShip:GetSizeX() / 2)
    self._ui._stc_SelectMyShip:SetPosY(self._ui._stc_Tier_18:GetPosY() - 15)
  elseif 31055 == shipKey then
    self._ui._stc_SelectMyShip:SetShow(true)
    self._ui._stc_SelectMyShip:SetPosX(self._ui._stc_Tier_19:GetPosX() + self._ui._stc_Tier_19:GetSizeX() / 2 - self._ui._stc_SelectMyShip:GetSizeX() / 2)
    self._ui._stc_SelectMyShip:SetPosY(self._ui._stc_Tier_19:GetPosY() - 15)
  elseif 31054 == shipKey then
    self._ui._stc_SelectMyShip:SetShow(true)
    self._ui._stc_SelectMyShip:SetPosX(self._ui._stc_Tier_20:GetPosX() + self._ui._stc_Tier_20:GetSizeX() / 2 - self._ui._stc_SelectMyShip:GetSizeX() / 2)
    self._ui._stc_SelectMyShip:SetPosY(self._ui._stc_Tier_20:GetPosY() - 15)
  else
    self._ui._stc_SelectMyShip:SetShow(false)
  end
end
function PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeTree_SpecInfo(upgradeKey)
  if nil == upgradeKey then
    PaGlobal_ServantUpgradeInfo_Close()
    return
  end
  self._upgradeKey = upgradeKey
  PaGlobal_ServantUpgradeInfo_Tooltip(self._fixedShipKey, upgradeKey)
end
function PaGlobal_ServantUpgrade_Tree:OpenUpgrade(key, index)
  if nil == index then
    return
  end
  if PaGlobalFunc_ServantFunction_All_GetIsGuild() == true then
    return
  end
  if 1 == index then
    PaGlobal_ServantUpgrade:open(key, false, 1)
  elseif 2 == index then
    PaGlobal_ServantUpgrade:open(key, false, 0)
  elseif 3 == index then
    PaGlobal_ServantUpgrade:open(key, false, 0)
  elseif 4 == index then
    PaGlobal_ServantUpgrade:open(key, false, 0)
  elseif 5 == index then
    PaGlobal_ServantUpgrade:open(key, false, 1)
  elseif 6 == index then
    PaGlobal_ServantUpgrade:open(key, false, 1)
  elseif 7 == index then
    PaGlobal_ServantUpgrade:open(key, false, 0)
  elseif 8 == index then
    PaGlobal_ServantUpgrade:open(key, false, 1)
  elseif 9 == index then
    PaGlobal_ServantUpgrade:open(key, false, 1)
  else
    if 10 == index then
      PaGlobal_ServantUpgrade:open(key, false, 0)
    else
    end
  end
end
function PaGlobal_ServantUpgrade_Tree:open(shipKey, upgradeKey, isWharf)
  if nil == shipKey then
    return
  end
  self._shipKey = shipKey
  self._upgradeKey = upgradeKey
  local servantInfo = PaGlobalFunc_ServantList_All_GetSealedTypeServantInfo()
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipInfo_All._actorKeyRaw)
  if _ContentsGroup_EmployeePresetJob == true then
    servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipInfo_Renewal_All._actorKeyRaw)
  end
  if true == isWharf then
    if nil ~= servantInfo then
      self._fixedShipKey = servantInfo:getCharacterKeyRaw()
    end
  elseif nil ~= servantWrapper then
    self._fixedShipKey = servantWrapper:getCharacterKeyRaw()
  end
  PaGlobal_ServantUpgrade_Tree:myShipSelected(self._fixedShipKey)
  PaGlobal_ServantUpgrade_Close()
  Panel_Dialog_ServantExtension_All_Tree:ComputePos()
  Panel_Dialog_ServantExtension_All_Tree:SetShow(true)
end
function PaGlobal_ServantUpgrade_Tree_Open(shipKey, upgradeKey)
  PaGlobal_ServantUpgrade_Tree:open(shipKey, upgradeKey)
end
function PaGlobal_ServantUpgrade_Tree:close()
  if nil == Panel_Dialog_ServantExtension_All_Tree or false == Panel_Dialog_ServantExtension_All_Tree:GetShow() then
    return
  end
  Panel_Dialog_ServantExtension_All_Tree:SetShow(false)
  PaGlobal_ServantUpgradeInfo_Close()
end
function PaGlobal_ServantUpgrade_Tree:handleClickedUpgradeInfoButton()
  if false == Panel_Window_ServantUpgradeInfo:GetShow() then
    PaGlobal_ServantUpgradeInfo:open(self._fixedShipKey, self._toCharacterKey)
  else
    PaGlobal_ServantUpgradeInfo:close()
  end
end
function PaGlobal_ServantUpgrade_Tree_Close()
  local self = PaGlobal_ServantUpgrade_Tree
  self:close()
end
