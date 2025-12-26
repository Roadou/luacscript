function PaGlobal_MorningLand_Scenario_All:initialize()
  if PaGlobal_MorningLand_Scenario_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local titleArea = UI.getChildControl(Panel_MorningLand_Scenario_All, "Static_TitleArea")
  self._ui_pc.btn_Close = UI.getChildControl(titleArea, "Button_Win_Close")
  self._ui_pc.btn_Navi = UI.getChildControl(Panel_MorningLand_Scenario_All, "CheckBtn_Quest_Navi")
  self._ui_pc.btn_AutoNavi = UI.getChildControl(Panel_MorningLand_Scenario_All, "CheckBtn_Quest_AutoNavi")
  local subBg = UI.getChildControl(Panel_MorningLand_Scenario_All, "Static_SubBg")
  self._ui.frame_list = UI.getChildControl(subBg, "Frame_ScenarioDesc")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_list, "Frame_1_Content")
  self._ui.txt_desc = UI.getChildControl(self._ui.frame_content, "StaticText_Desc")
  self._ui.scroll_vs = UI.getChildControl(self._ui.frame_list, "Frame_1_VerticalScroll")
  self._ui.scroll_vsCtrl = UI.getChildControl(self._ui.scroll_vs, "Frame_1_VerticalScroll_CtrlButton")
  PaGlobal_MorningLand_Scenario_All:changePlatform()
  PaGlobal_MorningLand_Scenario_All:registEventHandler()
  PaGlobal_MorningLand_Scenario_All:validate()
  PaGlobal_MorningLand_Scenario_All._initialize = true
end
function PaGlobal_MorningLand_Scenario_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
end
function PaGlobal_MorningLand_Scenario_All:registEventHandler()
  if Panel_MorningLand_Scenario_All == nil then
    return
  end
  Panel_MorningLand_Scenario_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_MorningLand_Scenario_All_Close()")
  self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Scenario_All_Close()")
end
function PaGlobal_MorningLand_Scenario_All:prepareOpen(sIndex, index)
  if Panel_MorningLand_Scenario_All == nil then
    return
  end
  local x = PaGlobal_MorningLand_QuestBoard_All_GetBgPosX(sIndex, index)
  local y = PaGlobal_MorningLand_QuestBoard_All_GetBgPosY(sIndex, index)
  if sIndex == 2 or sIndex == 4 then
    y = y + math.floor(Panel_MorningLand_Scenario_All:GetSizeY() / 2)
  else
    x = x + 30
    y = y + 50
  end
  Panel_MorningLand_Scenario_All:SetPosX(x)
  Panel_MorningLand_Scenario_All:SetPosY(y)
  PaGlobal_MorningLand_Scenario_All:update(sIndex, index)
  PaGlobal_MorningLand_Scenario_All:open()
end
function PaGlobal_MorningLand_Scenario_All:open()
  if Panel_MorningLand_Scenario_All == nil then
    return
  end
  Panel_MorningLand_Scenario_All:SetShow(true)
end
function PaGlobal_MorningLand_Scenario_All:prepareClose()
  if Panel_MorningLand_Scenario_All == nil then
    return
  end
  PaGlobal_MorningLand_Scenario_All:close()
end
function PaGlobal_MorningLand_Scenario_All:close()
  if Panel_MorningLand_Scenario_All == nil then
    return
  end
  Panel_MorningLand_Scenario_All:SetShow(false)
end
function PaGlobal_MorningLand_Scenario_All:update(sIndex, index)
  if Panel_MorningLand_Scenario_All == nil then
    return
  end
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  local groupId = 0
  if sIndex == 1 then
    self._ui.txt_desc:SetText(self._normalDetailInfo[index]._desc)
    groupId = self._normalDetailInfo[index]._groupId
  elseif sIndex == 2 then
    self._ui.txt_desc:SetText(self._hiddenDetailInfo[index]._desc)
    groupId = self._hiddenDetailInfo[index]._groupId
  elseif sIndex == 3 then
    self._ui.txt_desc:SetText(self._normalDetailInfo2[index]._desc)
    groupId = self._normalDetailInfo2[index]._groupId
  else
    self._ui.txt_desc:SetText(self._hiddenDetailInfo2[index]._desc)
    groupId = self._hiddenDetailInfo2[index]._groupId
  end
  if PaGlobal_MorningLand_QuestBoard_All:isHideNavi(index) == false then
    self._ui_pc.btn_Navi:SetShow(true)
    self._ui_pc.btn_AutoNavi:SetShow(true)
  else
    self._ui_pc.btn_Navi:SetShow(false)
    self._ui_pc.btn_AutoNavi:SetShow(false)
  end
  self._ui_pc.btn_Navi:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Scenario_All_FindNavi(" .. tostring(groupId) .. "," .. tostring(1) .. ", false )")
  self._ui_pc.btn_AutoNavi:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_Scenario_All_FindNavi(" .. tostring(groupId) .. "," .. tostring(1) .. ", true )")
  self._ui.frame_content:SetSize(self._ui.frame_content:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  self._ui.frame_list:ComputePosAllChild()
  self._ui.scroll_vs:SetControlTop()
  self._ui.frame_list:ComputePos()
  self._ui.frame_list:UpdateContentPos()
  self._ui.frame_list:UpdateContentScroll()
  self._ui_pc.btn_Navi:SetCheck(false)
  self._ui_pc.btn_AutoNavi:SetCheck(false)
  if self._naviGroup ~= nil and self._naviGroup == groupId then
    if self._isAuto == false then
      self._ui_pc.btn_Navi:SetCheck(true)
    else
      self._ui_pc.btn_Navi:SetCheck(true)
      self._ui_pc.btn_AutoNavi:SetCheck(true)
    end
  end
end
function PaGlobal_MorningLand_Scenario_All:validate()
  if Panel_MorningLand_Scenario_All == nil then
    return
  end
end
