function PaGlobal_GuildDocumentManagement_All:initialize()
  if PaGlobal_GuildDocumentManagement_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local mainBg = UI.getChildControl(Panel_Window_GuildDocumentManagement_All, "Static_Main_Bg")
  self._ui_pc.btn_Close = UI.getChildControl(mainBg, "Button_Close")
  local buttonArea = UI.getChildControl(Panel_Window_GuildDocumentManagement_All, "Static_RadioButtonArea")
  self._ui.radio_Unapproved = UI.getChildControl(buttonArea, "RadioButton_Unapproved")
  self._ui.radio_Approval = UI.getChildControl(buttonArea, "RadioButton_Approval")
  self._ui.radio_Return = UI.getChildControl(buttonArea, "RadioButton_Return")
  self._ui.stc_SelectBar = UI.getChildControl(buttonArea, "Static_SelectBar")
  local documentArea = UI.getChildControl(Panel_Window_GuildDocumentManagement_All, "Static_DocumentArea")
  self._ui.btn_SelectApproval = UI.getChildControl(documentArea, "Button_SelectApproval")
  self._ui.btn_SelectReturn = UI.getChildControl(documentArea, "Button_SelectReturn")
  self._ui_pc.btn_AllApproval = UI.getChildControl(documentArea, "Button_AllApproval")
  self._ui_pc.btn_Close2 = UI.getChildControl(Panel_Window_GuildDocumentManagement_All, "Button_Close")
  self._ui_pc.btn_AllApproval:SetShow(not self._isConsole)
  self._ui.btn_SelectApproval:SetShow(false)
  self._ui.btn_SelectReturn:SetShow(false)
  self._ui.list2 = UI.getChildControl(documentArea, "List2_1")
  self._ui.list2_content = UI.getChildControl(self._ui.list2, "List2_1_Content")
  local lbBtn = UI.getChildControl(buttonArea, "Static_LB_ConsoleUI")
  local rbBtn = UI.getChildControl(buttonArea, "Static_RB_ConsoleUI")
  lbBtn:SetShow(self._isConsole)
  rbBtn:SetShow(self._isConsole)
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_Window_GuildDocumentManagement_All, "Static_ConsoleUI")
  self._ui_console.txt_KeyGuideX = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_X_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_A_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_B_ConsoleUI")
  self._ui_console.txt_KeyGuideY = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Y_ConsoleUI")
  local keyguides = {
    self._ui_console.txt_KeyGuideY,
    self._ui_console.txt_KeyGuideA,
    self._ui_console.txt_KeyGuideX,
    self._ui_console.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_GuildDocumentManagement_All:registEventHandler()
  PaGlobal_GuildDocumentManagement_All:changePlatform()
  PaGlobal_GuildDocumentManagement_All:validate()
  PaGlobal_GuildDocumentManagement_All._initialize = true
end
function PaGlobal_GuildDocumentManagement_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_GuildDocumentManagement_All:registEventHandler()
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
  self._ui.list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_GuildDocumentManagement_All_CreateContent")
  self._ui.list2:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_GuildDocumentManagement_All_Close()")
  self._ui_pc.btn_Close2:addInputEvent("Mouse_LUp", "PaGlobal_GuildDocumentManagement_All_Close()")
  self._ui.radio_Unapproved:addInputEvent("Mouse_LUp", "PaGlobal_GuildDocumentManagement_All_SelectTab(0)")
  self._ui.radio_Approval:addInputEvent("Mouse_LUp", "PaGlobal_GuildDocumentManagement_All_SelectTab(1)")
  self._ui.radio_Return:addInputEvent("Mouse_LUp", "PaGlobal_GuildDocumentManagement_All_SelectTab(2)")
  self._ui_pc.btn_AllApproval:addInputEvent("Mouse_LUp", "PaGlobal_GuildDocumentManagement_All_Confirm(true," .. tostring(-1) .. ",1)")
  Panel_Window_GuildDocumentManagement_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_GuildDocumentManagement_All_SelectTabConsole( false )")
  Panel_Window_GuildDocumentManagement_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_GuildDocumentManagement_All_SelectTabConsole( true )")
  Panel_Window_GuildDocumentManagement_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_GuildDocumentManagement_All_Confirm(true," .. tostring(-1) .. ",1)")
  registerEvent("FromClient_LoadGuildActivityPoint", "PaGlobal_GuildDocumentManagement_All_LoadGuildActivityPoint")
  registerEvent("FromClient_ConfirmGuildActivityPoint", "FromClient_ConfirmGuildActivityPoint")
end
function PaGlobal_GuildDocumentManagement_All:prepareOpen()
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
  self._isOpenReq = false
  PaGlobal_GuildDocumentManagement_All:update(self._eTab.eNone)
  PaGlobal_GuildDocumentManagement_All:open()
end
function PaGlobal_GuildDocumentManagement_All:open()
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
  Panel_Window_GuildDocumentManagement_All:SetShow(true)
end
function PaGlobal_GuildDocumentManagement_All:prepareClose()
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
  self._isOpenReq = false
  self._selectType = nil
  PaGlobal_GuildDocumentManagement_All:close()
end
function PaGlobal_GuildDocumentManagement_All:close()
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
  Panel_Window_GuildDocumentManagement_All:SetShow(false)
end
function PaGlobal_GuildDocumentManagement_All:update(selectType)
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
  if selectType == nil then
    return
  end
  self._ui.radio_Unapproved:addInputEvent("Mouse_LUp", "PaGlobal_GuildDocumentManagement_All_SelectTab(0)")
  self._ui.radio_Approval:addInputEvent("Mouse_LUp", "PaGlobal_GuildDocumentManagement_All_SelectTab(1)")
  self._ui.radio_Return:addInputEvent("Mouse_LUp", "PaGlobal_GuildDocumentManagement_All_SelectTab(2)")
  local listCount = ToClient_GetActivityPointListAllCount()
  local count1 = 0
  local count2 = 0
  local count3 = 0
  for index = 0, listCount - 1 do
    local listWrapper = ToClient_GetGuildActivityPointByIndex(index)
    if listWrapper == nil then
      return
    end
    if listWrapper:getConfirmType() == 0 then
      count1 = count1 + 1
    elseif listWrapper:getConfirmType() == 1 then
      count2 = count2 + 1
    elseif listWrapper:getConfirmType() == 2 then
      count3 = count3 + 1
    end
  end
  self._ui.radio_Unapproved:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_POINTMANAGEMENT_UNAPPROVED_TITLE", "count", count1))
  self._ui.radio_Approval:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_POINTMANAGEMENT_APPROVAL_TITLE", "count", count2))
  self._ui.radio_Return:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_POINTMANAGEMENT_RETURN_TITLE", "count", count3))
  self._ui.list2:getElementManager():clearKey()
  for index = 0, listCount - 1 do
    local listWrapper = ToClient_GetGuildActivityPointByIndex(index)
    if listWrapper == nil then
      return
    end
    if self._eTab.eNone == selectType then
      self._ui.radio_Unapproved:SetCheck(true)
      self._ui.radio_Approval:SetCheck(false)
      self._ui.radio_Return:SetCheck(false)
      self._ui.stc_SelectBar:SetPosX(self._ui.radio_Unapproved:GetPosX() + self._ui.radio_Unapproved:GetSizeX() / 2 - self._ui.stc_SelectBar:GetSizeX() / 2)
      if listWrapper:getConfirmType() == 0 then
        self._ui.list2:getElementManager():pushKey(toInt64(0, index))
      end
      self._ui_pc.btn_AllApproval:SetShow(true)
    elseif self._eTab.eAccept == selectType then
      self._ui.radio_Unapproved:SetCheck(false)
      self._ui.radio_Approval:SetCheck(true)
      self._ui.radio_Return:SetCheck(false)
      self._ui.stc_SelectBar:SetPosX(self._ui.radio_Approval:GetPosX())
      self._ui.stc_SelectBar:SetPosX(self._ui.radio_Approval:GetPosX() + self._ui.radio_Approval:GetSizeX() / 2 - self._ui.stc_SelectBar:GetSizeX() / 2)
      if listWrapper:getConfirmType() == 1 then
        self._ui.list2:getElementManager():pushKey(toInt64(0, index))
      end
      self._ui_pc.btn_AllApproval:SetShow(false)
    elseif self._eTab.eRefuse == selectType then
      self._ui.radio_Unapproved:SetCheck(false)
      self._ui.radio_Approval:SetCheck(false)
      self._ui.radio_Return:SetCheck(true)
      self._ui.stc_SelectBar:SetPosX(self._ui.radio_Return:GetPosX())
      self._ui.stc_SelectBar:SetPosX(self._ui.radio_Return:GetPosX() + self._ui.radio_Return:GetSizeX() / 2 - self._ui.stc_SelectBar:GetSizeX() / 2)
      if listWrapper:getConfirmType() == 2 then
        self._ui.list2:getElementManager():pushKey(toInt64(0, index))
      end
      self._ui_pc.btn_AllApproval:SetShow(false)
    end
  end
  if self._isConsole == true then
    self._ui_pc.btn_AllApproval:SetShow(false)
  end
  self._selectType = selectType
end
function PaGlobal_GuildDocumentManagement_All:validate()
  if Panel_Window_GuildDocumentManagement_All == nil then
    return
  end
end
function PaGlobal_GuildDocumentManagement_All:createControl(content, key)
  local index = Int64toInt32(key)
  local listWrapper = ToClient_GetGuildActivityPointByIndex(index)
  if listWrapper == nil then
    return
  end
  local point = UI.getChildControl(content, "StaticText_Point_Template")
  local familyName = UI.getChildControl(content, "StaticText_FamilyName_Template")
  local contentStr = UI.getChildControl(content, "StaticText_Content_Template")
  local acceptButton = UI.getChildControl(content, "Button_Approval_Template")
  local refuseButton = UI.getChildControl(content, "Button_Return_Template")
  point:SetText(listWrapper:getPoint())
  familyName:SetText(listWrapper:getRequestUserName())
  local contents = listWrapper:getContents()
  local optionType = listWrapper:getOptionType()
  if contents == "" then
    contents = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGEDATATABLE_GUILDCONTRIBUTION_CONTENT_" .. tostring(optionType + 1))
  end
  contentStr:SetText(contents)
  acceptButton:addInputEvent("Mouse_LUp", "PaGlobal_GuildDocumentManagement_All_Confirm(false," .. tostring(index) .. ",1)")
  refuseButton:addInputEvent("Mouse_LUp", "PaGlobal_GuildDocumentManagement_All_Confirm(false," .. tostring(index) .. ",2)")
  familyName:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_GuildDocumentManagement_All_Confirm(false," .. tostring(index) .. ",1)")
  familyName:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_GuildDocumentManagement_All_Confirm(false," .. tostring(index) .. ",2)")
  if self._selectType ~= self._eTab.eNone or self._isConsole == true then
    acceptButton:SetShow(false)
    refuseButton:SetShow(false)
  else
    acceptButton:SetShow(true)
    refuseButton:SetShow(true)
  end
end
