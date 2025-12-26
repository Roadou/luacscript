PaGlobal_SkillShowAllClasses_All = {
  _ui = {
    _stc_titleBar = nil,
    _txt_titleIcon = nil,
    _btn_close = nil,
    _stc_descBox = nil,
    _txt_desc = nil,
    _list2_classList = nil,
    _scroll_vertical = nil,
    _scroll_horizontal = nil,
    _btn_back = nil,
    _btn_reset = nil,
    _stc_consoleKeyGuide = nil,
    _keyguide_A = nil,
    _keyguide_B = nil,
    _keyguide_Y = nil
  },
  _selectClassType = -1,
  _isPadSnapping = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_SkillShowAllClasses_All_luaLoadComplete")
function FromClient_SkillShowAllClasses_All_luaLoadComplete()
  PaGlobal_SkillShowAllClasses_All:initialize()
end
function PaGlobal_SkillShowAllClasses_All:initialize()
  if Panel_Window_Skill_ShowAllClasses_All == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._ui._stc_titleBar = UI.getChildControl(Panel_Window_Skill_ShowAllClasses_All, "Static_TitleBar")
  self._ui._txt_titleIcon = UI.getChildControl(self._ui._stc_titleBar, "StaticText_TitleIcon")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBar, "Button_Close")
  self._ui._stc_descBox = UI.getChildControl(Panel_Window_Skill_ShowAllClasses_All, "Static_DescBox")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_descBox, "StaticText_Desc")
  self._ui._list2_classList = UI.getChildControl(Panel_Window_Skill_ShowAllClasses_All, "List2_ClassList")
  self._ui._scroll_vertical = UI.getChildControl(self._ui._list2_classList, "List2_1_VerticalScroll")
  self._ui._scroll_horizontal = UI.getChildControl(self._ui._list2_classList, "List2_1_HorizontalScroll")
  self._ui._btn_back = UI.getChildControl(Panel_Window_Skill_ShowAllClasses_All, "Button_Back")
  self._ui._btn_reset = UI.getChildControl(Panel_Window_Skill_ShowAllClasses_All, "Button_Reset")
  self._ui._stc_consoleKeyGuide = UI.getChildControl(Panel_Window_Skill_ShowAllClasses_All, "Static_ConsoleKeyGuide")
  self._ui._keyguide_A = UI.getChildControl(self._ui._stc_consoleKeyGuide, "StaticText_KeyGuide_A_ConsoleUI")
  self._ui._keyguide_B = UI.getChildControl(self._ui._stc_consoleKeyGuide, "StaticText_KeyGuide_B_ConsoleUI")
  self._ui._keyguide_Y = UI.getChildControl(self._ui._stc_consoleKeyGuide, "StaticText_KeyGuide_Y_ConsoleUI")
  self._isPadSnapping = ToClient_isUsePadSnapping()
  if self._isPadSnapping == true then
    self._ui._stc_consoleKeyGuide:SetShow(true)
    self._ui._btn_close:SetShow(false)
    self._ui._btn_back:SetShow(false)
    self._ui._btn_reset:SetShow(false)
    Panel_Window_Skill_ShowAllClasses_All:SetSize(Panel_Window_Skill_ShowAllClasses_All:GetSizeX(), Panel_Window_Skill_ShowAllClasses_All:GetSizeY() - (self._ui._btn_back:GetSizeY() + 10))
    self._ui._stc_consoleKeyGuide:SetPosY(self._ui._stc_consoleKeyGuide:GetPosY() - (self._ui._btn_back:GetSizeY() + 10))
    local keyGuides = {}
    keyGuides[1] = self._ui._keyguide_Y
    keyGuides[2] = self._ui._keyguide_A
    keyGuides[3] = self._ui._keyguide_B
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_consoleKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
  else
    self._ui._stc_consoleKeyGuide:SetShow(false)
    self._ui._btn_close:SetShow(true)
    self._ui._btn_back:SetShow(true)
    self._ui._btn_reset:SetShow(true)
  end
  self:registEventHandler()
  self:validate()
  self:setControl()
  self._initialize = true
end
function PaGlobal_SkillShowAllClasses_All:registEventHandler()
  if Panel_Window_Skill_ShowAllClasses_All == nil then
    return
  end
  self._ui._list2_classList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_SkillShowAllClasses_All_UpdateClassTypeList")
  self._ui._list2_classList:createChildContent(__ePAUIList2ElementManagerType_List)
  if self._isPadSnapping == true then
    Panel_Window_Skill_ShowAllClasses_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_SkillShowAllClasses_All_Close()")
    Panel_Window_Skill_ShowAllClasses_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_SkillShowAllClasses_All_ResetToMyClass()")
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_SkillShowAllClasses_All_Close()")
    self._ui._btn_back:addInputEvent("Mouse_LUp", "PaGlobal_SkillShowAllClasses_All_Close()")
    self._ui._btn_reset:addInputEvent("Mouse_LUp", "PaGlobal_SkillShowAllClasses_All_ResetToMyClass()")
  end
end
function PaGlobal_SkillShowAllClasses_All:prepareOpen()
  if Panel_Window_Skill_ShowAllClasses_All == nil then
    return
  end
  if self._selectClassType == -1 then
    local selfPlayer = getSelfPlayer()
    if selfPlayer == true then
      return false
    end
    self._selectClassType = selfPlayer:getClassType()
  end
  self:update()
  self:open()
end
function PaGlobal_SkillShowAllClasses_All:open()
  if Panel_Window_Skill_ShowAllClasses_All == nil then
    return
  end
  Panel_Window_Skill_ShowAllClasses_All:SetShow(true)
end
function PaGlobal_SkillShowAllClasses_All:prepareClose()
  if Panel_Window_Skill_ShowAllClasses_All == nil then
    return
  end
  self:close()
end
function PaGlobal_SkillShowAllClasses_All:close()
  if Panel_Window_Skill_ShowAllClasses_All == nil then
    return
  end
  Panel_Window_Skill_ShowAllClasses_All:SetShow(false)
end
function PaGlobal_SkillShowAllClasses_All:update()
  if Panel_Window_Skill_ShowAllClasses_All == nil then
    return
  end
  for classType = 0, __eClassType_Count - 1 do
    if NewClassData.newClass_ContentOption[classType] ~= nil and NewClassData.newClass_ContentOption[classType]._classContentsOption == true then
      local content = self._ui._list2_classList:GetContentByKey(toInt64(0, classType))
      if content ~= nil then
        local rdoButton = UI.getChildControl(content, "Radiobutton_Class")
        if self._selectClassType == classType then
          rdoButton:SetCheck(true)
        else
          rdoButton:SetCheck(false)
        end
      end
    end
  end
  local index = self._ui._list2_classList:getIndexByKey(toInt64(0, self._selectClassType))
  self._ui._list2_classList:moveIndex(index)
end
function PaGlobal_SkillShowAllClasses_All:setControl()
  if Panel_Window_Skill_ShowAllClasses_All == nil then
    return
  end
  self._ui._list2_classList:getElementManager():clearKey()
  for classType = 0, __eClassType_Count - 1 do
    if NewClassData.newClass_ContentOption[classType] ~= nil and NewClassData.newClass_ContentOption[classType]._classContentsOption == true then
      self._ui._list2_classList:getElementManager():pushKey(toInt64(0, classType))
    end
  end
  if Panel_Window_SkillGroup_All ~= nil and PaGlobal_SkillGroup_Controller ~= nil then
    local posX = Panel_Window_SkillGroup_All:GetPosX() - Panel_Window_Skill_ShowAllClasses_All:GetSizeX()
    local posY = PaGlobal_SkillGroup_Controller._ui._txt_skillNeedResource:GetPosY() - Panel_Window_Skill_ShowAllClasses_All:GetSizeY()
    if self._isPadSnapping == true then
      posY = posY - self._ui._stc_consoleKeyGuide:GetSizeY() + self._ui._btn_back:GetSizeY()
    end
    Panel_Window_Skill_ShowAllClasses_All:SetPosXY(posX, posY)
  end
end
function PaGlobal_SkillShowAllClasses_All:validate()
  if Panel_Window_Skill_ShowAllClasses_All == nil then
    return
  end
  self._ui._stc_titleBar:isValidate()
  self._ui._txt_titleIcon:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._stc_descBox:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._list2_classList:isValidate()
  self._ui._scroll_vertical:isValidate()
  self._ui._scroll_horizontal:isValidate()
  self._ui._btn_back:isValidate()
  self._ui._stc_consoleKeyGuide:isValidate()
  self._ui._keyguide_A:isValidate()
  self._ui._keyguide_B:isValidate()
end
function PaGlobal_SkillShowAllClasses_All_Open()
  local self = PaGlobal_SkillShowAllClasses_All
  if self == nil then
    return
  end
  if _ContentsGroup_ShowOtherClassSkill == false then
    return
  end
  if Panel_Window_Skill_ShowAllClasses_All:GetShow() == true then
    return
  end
  self:prepareOpen()
end
function PaGlobal_SkillShowAllClasses_All_Close()
  local self = PaGlobal_SkillShowAllClasses_All
  if self == nil then
    return
  end
  if _ContentsGroup_ShowOtherClassSkill == false then
    return
  end
  if Panel_Window_Skill_ShowAllClasses_All:GetShow() == false then
    return
  end
  if PaGlobal_SkillGroup_All ~= nil then
    PaGlobal_SkillGroup_All._ui._stc_presetBG:SetShow(true)
  end
  self:prepareClose()
end
function PaGlobal_SkillShowAllClasses_All_UpdateClassTypeList(content, key)
  local self = PaGlobal_SkillShowAllClasses_All
  if self == nil then
    return
  end
  local classType = Int64toInt32(key)
  local rdoButton = UI.getChildControl(content, "Radiobutton_Class")
  local txt_className = UI.getChildControl(rdoButton, "StaticText_ClassName")
  local stc_classIcon = UI.getChildControl(rdoButton, "Static_ClassIcon_BG")
  stc_classIcon:ChangeTextureInfoTextureIDAsync(NewClassData.newClass_Texture_ID[classType]._classSymbolIconTID)
  stc_classIcon:setRenderTexture(stc_classIcon:getBaseTexture())
  txt_className:SetText(NewClassData.newClass_String[classType]._classType2String)
  rdoButton:addInputEvent("Mouse_LUp", "PaGlobal_SkillShowAllClasses_All_SelectClassType(" .. classType .. ")")
  if self._selectClassType == classType then
    rdoButton:SetCheck(true)
  else
    rdoButton:SetCheck(false)
  end
end
function PaGlobal_SkillShowAllClasses_All_SelectClassType(classType)
  local self = PaGlobal_SkillShowAllClasses_All
  if self == nil then
    return
  end
  self._selectClassType = classType
  PaGlobalFunc_SkillGroup_All_ShowOtherClassSkill(self._selectClassType)
  self:prepareClose()
end
function PaGlobal_SkillShowAllClasses_All_ResetToMyClass()
  local self = PaGlobal_SkillShowAllClasses_All
  if self == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == true then
    return false
  end
  self._selectClassType = selfPlayer:getClassType()
  PaGlobalFunc_SkillGroup_All_ShowOtherClassSkill(self._selectClassType)
  if Panel_Window_Skill_ShowAllClasses_All:GetShow() == true then
    self:prepareClose()
  end
end
