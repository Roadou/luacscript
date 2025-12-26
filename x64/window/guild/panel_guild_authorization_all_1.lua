function PaGlobal_Guild_Authorization_All:initialize()
  if PaGlobal_Guild_Authorization_All._initialize == true then
    return
  end
  self._ui.stc_title = UI.getChildControl(Panel_Guild_Authorization_All, "Static_TitleArea")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_title, "StaticText_Title")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_title, "Button_Close")
  self._ui.stc_main = UI.getChildControl(Panel_Guild_Authorization_All, "Static_MainArea")
  self._ui.frame_1 = UI.getChildControl(self._ui.stc_main, "Frame_1")
  self._ui.frame_1_content = UI.getChildControl(self._ui.frame_1, "Frame_1_Content")
  self._ui.checkBtn_groupTemplate = UI.getChildControl(self._ui.frame_1_content, "CheckButton_GroupTemplate")
  self._ui.stcText_groupTitle = UI.getChildControl(self._ui.frame_1_content, "StaticText_GroupTitle")
  self._ui.checkBtn_template = UI.getChildControl(self._ui.frame_1_content, "CheckButton_Template")
  self._ui.stcText_right = UI.getChildControl(self._ui.checkBtn_template, "StaticText_RightTemplate")
  self._ui.verticalScroll = UI.getChildControl(self._ui.frame_1, "Frame_1_VerticalScroll")
  self._ui.vs_upBtn = UI.getChildControl(self._ui.verticalScroll, "Frame_1_VerticalScroll_UpButton")
  self._ui.vs_downBtn = UI.getChildControl(self._ui.verticalScroll, "Frame_1_VerticalScroll_DownButton")
  self._ui.vs_ctrlBtn = UI.getChildControl(self._ui.verticalScroll, "Frame_1_VerticalScroll_CtrlButton")
  self._ui.horizontalScroll = UI.getChildControl(self._ui.frame_1, "Frame_1_HorizontalScroll")
  self._ui.hs_upBtn = UI.getChildControl(self._ui.horizontalScroll, "Frame_1_HorizontalScroll_UpButton")
  self._ui.hs_downBtn = UI.getChildControl(self._ui.horizontalScroll, "Frame_1_HorizontalScroll_DownButton")
  self._ui.hs_ctrlBtn = UI.getChildControl(self._ui.horizontalScroll, "Frame_1_HorizontalScroll_CtrlButton")
  self._ui.stc_1 = UI.getChildControl(self._ui.stc_main, "Static_1")
  self._ui.stc_keyGuide_consoleUI = UI.getChildControl(Panel_Guild_Authorization_All, "Static_KeyGuide_ConsoleUI")
  self._ui.txt_b_consoleUI = UI.getChildControl(self._ui.stc_keyGuide_consoleUI, "StaticText_B_ConsoleUI")
  self._ui.txt_a_consoleUI = UI.getChildControl(self._ui.stc_keyGuide_consoleUI, "StaticText_A_ConsoleUI")
  self._ui.btn_reset = UI.getChildControl(Panel_Guild_Authorization_All, "Button_Reset")
  self._ui.stc_reset = UI.getChildControl(self._ui.btn_reset, "Static_Icon")
  self._ui.btn_admin = UI.getChildControl(Panel_Guild_Authorization_All, "Button_Admin")
  self._ui.btn_cancel = UI.getChildControl(Panel_Guild_Authorization_All, "Button_Cancel")
  self._ui.btn_close2 = UI.getChildControl(Panel_Guild_Authorization_All, "Button_Close2")
  PaGlobal_Guild_Authorization_All:setData()
  PaGlobal_Guild_Authorization_All:registEventHandler()
  PaGlobal_Guild_Authorization_All:validate()
  PaGlobal_Guild_Authorization_All._initialize = true
end
function PaGlobal_Guild_Authorization_All:registEventHandler()
  if Panel_Guild_Authorization_All == nil then
    return
  end
  self._ui.btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Authorization_All_Reset()")
  self._ui.btn_reset:addInputEvent("Mouse_On", "HandleEventLUp_Guild_Authorization_All_Reset_Tooltip(true)")
  self._ui.btn_reset:addInputEvent("Mouse_Out", "HandleEventLUp_Guild_Authorization_All_Reset_Tooltip()")
  self._ui.btn_admin:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Authorization_All_Apply()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Guild_Authorization_All_Close()")
  self._ui.btn_close2:addInputEvent("Mouse_LUp", "PaGlobal_Guild_Authorization_All_Close()")
  self._ui.btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_Guild_Authorization_All_Close()")
  registerEvent("FromClient_GuildMemberRight_AlertChange", "FromClient_GuildMemberRight_AlertChange")
  registerEvent("FromClient_GuildMemberRight_ChangeSuccess", "FromClient_GuildMemberRight_ChangeSuccess")
end
function PaGlobal_Guild_Authorization_All:prepareOpen()
  if Panel_Guild_Authorization_All == nil then
    return
  end
  PaGlobal_Guild_Authorization_All:laodMemberRight()
  if _ContentsGroup_UsePadSnapping == true then
    PaGlobal_Guild_Authorization_All:alignKeyGuides()
  end
  PaGlobal_Guild_Authorization_All:open()
end
function PaGlobal_Guild_Authorization_All:open()
  if Panel_Guild_Authorization_All == nil then
    return
  end
  Panel_Guild_Authorization_All:SetShow(true)
end
function PaGlobal_Guild_Authorization_All:prepareClose()
  if Panel_Guild_Authorization_All == nil then
    return
  end
  self._targetMemberUserNo = 0
  PaGlobal_Guild_Authorization_All:close()
end
function PaGlobal_Guild_Authorization_All:close()
  if Panel_Guild_Authorization_All == nil then
    return
  end
  Panel_Guild_Authorization_All:SetShow(false)
end
function PaGlobal_Guild_Authorization_All:validate()
  if Panel_Guild_Authorization_All == nil then
    return
  end
  self._ui.stc_title:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_main:isValidate()
  self._ui.frame_1:isValidate()
  self._ui.frame_1_content:isValidate()
  self._ui.stcText_groupTitle:isValidate()
  self._ui.checkBtn_groupTemplate:isValidate()
  self._ui.checkBtn_template:isValidate()
  self._ui.stcText_right:isValidate()
  self._ui.verticalScroll:isValidate()
  self._ui.vs_upBtn:isValidate()
  self._ui.vs_downBtn:isValidate()
  self._ui.vs_ctrlBtn:isValidate()
  self._ui.horizontalScroll:isValidate()
  self._ui.hs_upBtn:isValidate()
  self._ui.hs_downBtn:isValidate()
  self._ui.hs_ctrlBtn:isValidate()
  self._ui.stc_1:isValidate()
  self._ui.stc_keyGuide_consoleUI:isValidate()
  self._ui.txt_b_consoleUI:isValidate()
  self._ui.txt_a_consoleUI:isValidate()
  self._ui.btn_reset:isValidate()
  self._ui.btn_admin:isValidate()
  self._ui.btn_cancel:isValidate()
  self._ui.btn_close2:isValidate()
end
function PaGlobal_Guild_Authorization_All:laodMemberRight()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if myGuildListInfo == nil then
    return
  end
  local myGuildMemberInfo = myGuildListInfo:getMemberByUserNo(self._targetMemberUserNo)
  if myGuildMemberInfo == nil then
    return
  end
  local isSelf = myGuildMemberInfo:isSelf()
  local memberRight = myGuildMemberInfo:getGuildRight()
  local isRight = PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_ChangeMemberRight)
  local rightListIdx = 1
  local rightList = {}
  local myGrade = getSelfPlayer():getGuildMemberGrade()
  local mySelfGuildMaster = myGrade == __eGuildMemberGradeMaster
  for num in memberRight:gmatch("(.-),") do
    table.insert(rightList, tonumber(num))
  end
  for ii = 1, self._groupCount do
    for jj = 0, self._rightCount[ii] - 1 do
      self._rightControlList[ii][jj]:SetCheck(false)
      self._rightControlList[ii][jj]:SetMonoTone(true)
    end
  end
  for idx = 1, #rightList do
    for ii = 1, self._groupCount do
      for jj = 0, self._rightCount[ii] - 1 do
        if self._rightInfoList[ii][jj]:getRightNo() == rightList[idx] then
          self._rightControlList[ii][jj]:SetCheck(true)
          self._rightControlList[ii][jj]:SetMonoTone(false)
        end
      end
    end
  end
  for ii = 1, self._groupCount do
    local isGroupOn = true
    for jj = 0, self._rightCount[ii] - 1 do
      if self._rightControlList[ii][jj]:IsCheck() == false then
        isGroupOn = false
      end
    end
    self._groupControlList[ii]:SetCheck(isGroupOn)
  end
  if isSelf == true and (mySelfGuildMaster == true or isRight == false) then
    self._ui.btn_cancel:SetShow(false)
    self._ui.btn_reset:SetShow(false)
    self._ui.btn_admin:SetShow(false)
    self._ui.btn_close2:SetShow(true)
    if _ContentsGroup_UsePadSnapping == true then
      self._ui.txt_b_consoleUI:SetShow(true)
      self._ui.txt_a_consoleUI:SetShow(false)
      for ii = 1, self._groupCount do
        self._groupControlList[ii]:SetEnable(false)
        self._groupControlList[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
        for jj = 0, self._rightCount[ii] - 1 do
          self._rightControlList[ii][jj]:SetEnable(false)
          self._rightControlList[ii][jj]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
        end
      end
    end
  else
    self._ui.btn_cancel:SetShow(true)
    self._ui.btn_reset:SetShow(true)
    self._ui.btn_admin:SetShow(true)
    self._ui.btn_close2:SetShow(false)
    if _ContentsGroup_UsePadSnapping == true then
      self._ui.txt_b_consoleUI:SetShow(true)
      self._ui.txt_a_consoleUI:SetShow(true)
      for ii = 1, self._groupCount do
        self._groupControlList[ii]:SetEnable(true)
        self._groupControlList[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Guild_Authorization_All_CheckGroup(" .. ii .. ")")
        for jj = 0, self._rightCount[ii] - 1 do
          self._rightControlList[ii][jj]:SetEnable(true)
          self._rightControlList[ii][jj]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Guild_Authorization_All_CheckRight(" .. ii .. "," .. jj .. ")")
        end
      end
    end
  end
end
function PaGlobal_Guild_Authorization_All:setData()
  if _ContentsGroup_GuildAuthoritySeparation == false then
    return
  end
  self._rightControlList = {}
  self._groupControlList = {}
  self._rightInfoList = {}
  local padding = 20
  local gap = 10
  local accumulatedPosY = gap * 2
  local oneThirdX = (self._ui.frame_1:GetSizeX() - 2 * padding) / 3
  self._groupCount = ToClient_getGuildRightGroupCount()
  for ii = 1, self._groupCount do
    local staticStatus = ToClient_GetGuildRightNewStaticStatus(ii)
    local groupNo = staticStatus:getGroupNo()
    local groupName = staticStatus:getGroupName()
    self._rightCount[ii] = staticStatus:getRightCount()
    local clonedGroupTemplate = UI.cloneControl(self._ui.checkBtn_groupTemplate, self._ui.frame_1_content, "Static_CheckGroup_" .. tostring(ii))
    local stcText_groupTitle = UI.cloneControl(self._ui.stcText_groupTitle, self._ui.frame_1_content, "StaticText_GroupTitle_" .. tostring(ii))
    stcText_groupTitle:SetText(groupName)
    stcText_groupTitle:SetSize(stcText_groupTitle:GetTextSizeX() + clonedGroupTemplate:GetSizeX() + padding, stcText_groupTitle:GetSizeY())
    stcText_groupTitle:SetPosX(padding)
    clonedGroupTemplate:SetPosX(stcText_groupTitle:GetTextSizeX() + padding + gap)
    stcText_groupTitle:SetPosY(accumulatedPosY)
    clonedGroupTemplate:SetPosY(accumulatedPosY - 1)
    stcText_groupTitle:SetShow(true)
    clonedGroupTemplate:SetShow(true)
    stcText_groupTitle:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Authorization_All_CheckGroup(" .. ii .. ")")
    table.insert(self._groupControlList, clonedGroupTemplate)
    accumulatedPosY = accumulatedPosY + clonedGroupTemplate:GetSizeY() + gap
    self._rightInfoList[ii] = {}
    self._rightControlList[ii] = {}
    for jj = 0, self._rightCount[ii] - 1 do
      local rightInfo = staticStatus:getRightInfo(jj)
      local rightNo = rightInfo:getRightNo()
      local rightName = rightInfo:getRightName()
      local rightDesc = rightInfo:getRightDesc()
      local clonedControl = UI.cloneControl(self._ui.checkBtn_template, self._ui.frame_1_content, "Static_CheckButton_" .. tostring(rightNo))
      local stcText_right = UI.getChildControl(clonedControl, "StaticText_RightTemplate")
      stcText_right:SetTextMode(__eTextMode_Limit_AutoWrap)
      stcText_right:SetText(rightName)
      stcText_right:addInputEvent("Mouse_On", "HandleEventOnOut_Guild_Authorization_All_Tooltip(" .. ii .. "," .. jj .. ", true)")
      stcText_right:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_Authorization_All_Tooltip(" .. ii .. "," .. jj .. ", false)")
      clonedControl:addInputEvent("Mouse_On", "HandleEventOnOut_Guild_Authorization_All_Tooltip(" .. ii .. "," .. jj .. ", true)")
      clonedControl:addInputEvent("Mouse_Out", "HandleEventOnOut_Guild_Authorization_All_Tooltip(" .. ii .. "," .. jj .. ", false)")
      stcText_right:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Authorization_All_CheckRight(" .. ii .. "," .. jj .. ")")
      clonedControl:addInputEvent("Mouse_LUp", "HandleEventLUp_Guild_Authorization_All_CheckRight(" .. ii .. "," .. jj .. ")")
      local posX = padding + oneThirdX * (jj % 3)
      if jj % 3 == 0 and jj ~= 0 then
        accumulatedPosY = accumulatedPosY + clonedControl:GetSizeY() + gap
      end
      clonedControl:SetPosX(posX)
      clonedControl:SetPosY(accumulatedPosY)
      stcText_right:SetSize(stcText_right:GetTextSizeX() + clonedControl:GetSizeX() + 20, stcText_right:GetSizeY())
      self._rightInfoList[ii][jj] = rightInfo
      self._rightControlList[ii][jj] = clonedControl
      if jj == self._rightCount[ii] - 1 then
        accumulatedPosY = accumulatedPosY + clonedControl:GetSizeY() + gap * 2
      end
    end
  end
  if self._ui.frame_1:GetSizeY() < accumulatedPosY - gap then
    self._ui.verticalScroll:SetShow(true)
    self._ui.verticalScroll:SetControlTop()
    self._ui.frame_1_content:SetIgnore(false)
    self._ui.frame_1_content:addInputEvent("Mouse_DownScroll", "RightList_ScrollEvent( true )")
    self._ui.frame_1_content:addInputEvent("Mouse_UpScroll", "RightList_ScrollEvent( false )")
    self._ui.frame_1:UpdateContentScroll()
    self._ui.frame_1:UpdateContentPos()
  else
    self._ui.verticalScroll:SetShow(false)
  end
  self._ui.checkBtn_template:SetShow(false)
  self._ui.checkBtn_groupTemplate:SetShow(false)
  self._ui.stcText_groupTitle:SetShow(false)
end
function PaGlobal_Guild_Authorization_All:alignKeyGuides()
  if _ContentsGroup_UsePadSnapping == false then
    return
  end
  local keyGuides = {
    self._ui.txt_a_consoleUI,
    self._ui.txt_b_consoleUI
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyGuide_consoleUI, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
end
