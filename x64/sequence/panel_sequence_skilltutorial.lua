local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
PaGlobal_Sequence_SkillTutorial = {
  _skillIcon = nil,
  _skillName = nil,
  _skillBg = nil,
  _skillCommandTemplate = nil,
  _skillCommandTemplateAdd = nil,
  _skillCommandMouseL = nil,
  _skillCommandMouseR = nil,
  _skillCommandConsoleUI = nil,
  _skillCommand = {},
  _controlIndex = 0,
  _controlPos = 0,
  _skillNo = 0,
  _posRatioX = 0,
  _posRatioY = 0
}
function PaGlobal_Sequence_SkillTutorial:InitSkillTutorial()
  self._skillIcon = UI.getChildControl(Panel_Sequence_SkillTutorial, "Static_SkillIcon")
  self._skillName = UI.getChildControl(Panel_Sequence_SkillTutorial, "StaticText_SkillName")
  self._skillBg = UI.getChildControl(Panel_Sequence_SkillTutorial, "Static_BG")
  self._skillCommandTemplate = UI.getChildControl(Panel_Sequence_SkillTutorial, "StaticText_Command_Template")
  self._skillCommandTemplateAdd = UI.getChildControl(Panel_Sequence_SkillTutorial, "StaticText_Plus_Template")
  self._skillCommandMouseL = UI.getChildControl(Panel_Sequence_SkillTutorial, "Static_Mouse_L")
  self._skillCommandMouseR = UI.getChildControl(Panel_Sequence_SkillTutorial, "Static_Mouse_R")
  self._skillCommandConsoleUI = UI.getChildControl(Panel_Sequence_SkillTutorial, "Static_PadKey_Template_ConsoleUI")
  Panel_Sequence_SkillTutorial:SetShow(false)
  self:registEventHandler()
end
function PaGlobal_Sequence_SkillTutorial:registEventHandler()
  registerEvent("FromClient_ShowSequenceSkillTutorial", "FromClient_ShowSequenceSkillTutorial")
  registerEvent("FromClient_StopSequence", "FromClient_SequenceSkillTutorialClose")
  registerEvent("FromClient_StopSequence_Ocean", "FromClient_SequenceSkillTutorialClose")
  registerEvent("onScreenResize", "FromClient_SequenceSkillTutorial_ResizePanel")
end
function PaGlobal_Sequence_SkillTutorial:open()
  if Panel_Sequence_SkillTutorial == nil then
    return
  end
  self:ResetCommand()
  Panel_Sequence_SkillTutorial:SetShow(true)
end
function PaGlobal_Sequence_SkillTutorial:close()
  if Panel_Sequence_SkillTutorial == nil then
    return
  end
  self:ResetCommand()
  Panel_Sequence_SkillTutorial:SetShow(false)
end
function PaGlobal_Sequence_SkillTutorial:SetSkillCommandControl(skillCommandWrapper)
  if skillCommandWrapper == nil then
    return
  end
  self._controlIndex = 0
  local command = ""
  if _ContentsGroup_UsePadSnapping == true then
    command = skillCommandWrapper:getConsoleCommand()
  else
    command = skillCommandWrapper:getCommand()
  end
  command = self:SearchCommand(command)
end
function PaGlobal_Sequence_SkillTutorial:SearchCommand(command)
  local commandIndex = string.find(command, "<")
  local stringIndex = string.find(command, "[%[]")
  local plusIndex = string.find(command, "+")
  local swapIndex = self:StringMatchForCommand(commandIndex, stringIndex, plusIndex)
  if swapIndex == 0 then
    local text = string.sub(command, commandIndex + 1, string.find(command, ">") - 1)
    self:commandControlSet(0, text)
    command = string.gsub(command, "<" .. text .. ">", "", 1)
  elseif swapIndex == 1 then
    local text = string.sub(command, stringIndex + 1, string.find(command, "[%]]") - 1)
    self:commandControlSet(1, text)
    command = string.gsub(command, "[%[]" .. text .. "[%]]", "", 1)
  elseif swapIndex == 2 then
    local text = string.sub(command, plusIndex, plusIndex)
    self:commandControlSet(2, text)
    command = string.gsub(command, "+", "", 1)
  else
    return
  end
  command = self:SearchCommand(command)
end
function PaGlobal_Sequence_SkillTutorial:StringMatchForCommand(commandIndex, stringIndex, plusIndex)
  local returnValue
  if nil ~= commandIndex then
    returnValue = 0
    if nil ~= stringIndex then
      if stringIndex < commandIndex then
        returnValue = 1
      end
      if nil ~= plusIndex and plusIndex < math.min(commandIndex, stringIndex) then
        returnValue = 2
      end
    elseif nil ~= plusIndex and plusIndex < commandIndex then
      returnValue = 2
    end
  elseif nil ~= stringIndex then
    returnValue = 1
    if nil ~= plusIndex and plusIndex < stringIndex then
      returnValue = 2
    end
  elseif nil ~= plusIndex then
    returnValue = 2
  end
  return returnValue
end
function PaGlobal_Sequence_SkillTutorial:commandControlSet(controlType, text)
  local LBString = ""
  local RBString = ""
  if _ContentsGroup_UsePadSnapping == true then
    LBString = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_MouseLB")
    RBString = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_MouseRB")
  else
    LBString = "LB"
    RBString = "RB"
  end
  local randValue = math.random(1, 100)
  if controlType == 0 then
    if LBString == text then
      tempControl = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillTutorial, "Static_Mouse_L", Panel_Sequence_SkillTutorial, "StaticText_Command_SkillTutorial_" .. randValue .. "_" .. self._controlIndex)
    elseif RBString == text then
      tempControl = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillTutorial, "Static_Mouse_R", Panel_Sequence_SkillTutorial, "StaticText_Command_SkillTutorial_" .. randValue .. "_" .. self._controlIndex)
    else
      tempControl = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillTutorial, "StaticText_Command_Template", Panel_Sequence_SkillTutorial, "StaticText_Command_SkillTutorial_" .. randValue .. "_" .. self._controlIndex)
      tempControl:SetText(text)
      tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
      tempControl:SetPosY(2)
    end
  elseif controlType == 1 then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillTutorial, "StaticText_Command_Template", Panel_Sequence_SkillTutorial, "StaticText_Command_SkillTutorial_" .. randValue .. "_" .. self._controlIndex)
    tempControl:SetText(text)
    tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
  elseif controlType == 2 then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillTutorial, "StaticText_Plus_Template", Panel_Sequence_SkillTutorial, "StaticText_Plus_Template_" .. randValue .. "_" .. self._controlIndex)
    tempControl:SetPosY(6)
  end
  tempControl:SetShow(true)
  local tempPosX = self._controlPos
  tempControl:SetPosX(self._controlPos)
  tempControl:SetPosY(self._skillCommandTemplate:GetPosY())
  self._controlPos = self._controlPos + tempControl:GetSizeX() + 5
  self._skillCommand[self._controlIndex] = tempControl
  self._controlIndex = self._controlIndex + 1
  self:AddAlphaAnimationToControl(tempControl, 0.5)
end
function PaGlobal_Sequence_SkillTutorial:AddAlphaAnimationToControl(control, endTime)
  if control == nil then
    return
  end
  control:SetAlpha(0)
  local anim = control:addColorAnimation(0, endTime, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  anim:SetStartColor(UI_color.C_00FFFFFF)
  anim:SetEndColor(UI_color.C_FFFFFFFF)
end
function PaGlobal_Sequence_SkillTutorial:ResetCommand()
  for controlCountIndex = 0, self._controlIndex - 1 do
    if self._skillCommand[controlCountIndex] ~= nil then
      UI.deleteControl(self._skillCommand[controlCountIndex])
      self._skillCommand[controlCountIndex] = nil
    end
  end
  self._skillCommand = {}
  self._controlIndex = 0
  self._controlPos = 0
  self._skillNo = 0
  self._posRatioX = 0
  self._posRatioY = 0
  self._skillCommandTemplate:SetShow(false)
  self._skillCommandTemplateAdd:SetShow(false)
  self._skillCommandMouseL:SetShow(false)
  self._skillCommandMouseR:SetShow(false)
  self._skillCommandConsoleUI:SetShow(false)
end
function FromClient_ShowSequenceSkillTutorial(isOn, skillNo, posRatioX, posRatioY)
  local self = PaGlobal_Sequence_SkillTutorial
  if self == nil or Panel_Sequence_SkillTutorial == nil then
    return
  end
  if isOn == false then
    self:close()
    return
  end
  local skillCommandWrapper = getSkillCommandStatus(skillNo)
  if skillCommandWrapper == nil then
    return
  end
  self:open()
  self._skillNo = skillNo
  self._posRatioX = posRatioX
  self._posRatioY = posRatioY
  self._skillBg:SetShow(true)
  self:AddAlphaAnimationToControl(self._skillBg, 0.5)
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  local centerRatio = 0.5
  local textSizeX = Panel_Sequence_SkillTutorial:GetSizeX()
  local textSizeY = Panel_Sequence_SkillTutorial:GetSizeY()
  local newPosX = screenX * posRatioX * 0.01 - textSizeX * centerRatio
  local newPosY = screenY * posRatioY * 0.01 - textSizeY * centerRatio
  Panel_Sequence_SkillTutorial:SetPosX(newPosX)
  Panel_Sequence_SkillTutorial:SetPosY(newPosY)
  Panel_Sequence_SkillTutorial:ComputePosAllChild()
  self._skillName:SetText(skillCommandWrapper:getName())
  self:AddAlphaAnimationToControl(self._skillName, 0.5)
  self._skillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillCommandWrapper:getIconPath())
  self:AddAlphaAnimationToControl(self._skillIcon, 0.5)
  self._controlPos = self._skillName:GetPosX()
  self:SetSkillCommandControl(skillCommandWrapper)
end
function FromClient_SequenceSkillTutorialClose()
  PaGlobal_Sequence_SkillTutorial:close()
end
function FromClient_SequenceSkillTutorial_ResizePanel()
  local self = PaGlobal_Sequence_SkillTutorial
  if self == nil then
    return
  end
  if Panel_Sequence_SkillTutorial == nil then
    return
  end
  if Panel_Sequence_SkillTutorial:GetShow() == false then
    return
  end
  FromClient_ShowSequenceSkillTutorial(true, self._skillNo, self._posRatioX, self._posRatioY)
end
PaGlobal_Sequence_SkillTutorial:InitSkillTutorial()
