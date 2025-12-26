PaGlobal_HorseRacing_KeyGuide = {
  _ui = {txt_Desc = nil},
  _isInitialized = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseRacing_KeyGuideInit")
function FromClient_HorseRacing_KeyGuideInit()
  PaGlobal_HorseRacing_KeyGuide:initialize()
end
function PaGlobal_HorseRacing_KeyGuide:initialize()
end
function PaGlobal_HorseRacing_KeyGuide:validate()
end
function PaGlobal_HorseRacing_KeyGuide:prepareOpen()
  PaGlobal_HorseRacing_KeyGuide:open()
end
function PaGlobal_HorseRacing_KeyGuide:open()
  local keyGuideBG = UI.getChildControl(Panel_HorseRacing_KeyGuide, "Static_KeyGuideBG")
  local commandList = {}
  local skillList = {}
  local key01A = UI.getChildControl(keyGuideBG, "StaticText_Key01A")
  local key01B = UI.getChildControl(keyGuideBG, "StaticText_Key01B")
  local key02A = UI.getChildControl(keyGuideBG, "StaticText_Key02A")
  local key02B = UI.getChildControl(keyGuideBG, "StaticText_Key02B")
  local key03A = UI.getChildControl(keyGuideBG, "StaticText_Key03A")
  local key03B = UI.getChildControl(keyGuideBG, "StaticText_Key03B")
  local key04A = UI.getChildControl(keyGuideBG, "StaticText_Key04A")
  local key04B = UI.getChildControl(keyGuideBG, "StaticText_Key04B")
  local key05A = UI.getChildControl(keyGuideBG, "StaticText_Key05A")
  local key05B = UI.getChildControl(keyGuideBG, "StaticText_Key05B")
  table.insert(commandList, key01A)
  table.insert(commandList, key02A)
  table.insert(commandList, key03A)
  table.insert(commandList, key04A)
  table.insert(commandList, key05A)
  table.insert(skillList, key01B)
  table.insert(skillList, key02B)
  table.insert(skillList, key03B)
  table.insert(skillList, key04B)
  table.insert(skillList, key05B)
  for idx, value in pairs(commandList) do
    value:SetSize(value:GetTextSizeX(), value:GetSizeY())
  end
  for idx, value in pairs(skillList) do
    value:SetSize(value:GetTextSizeX(), value:GetSizeY())
  end
  local indent = 20
  local longestCommandTextSize = 0
  local longestSkillTextSize = 0
  for idx, value in pairs(commandList) do
    if longestCommandTextSize < value:GetSizeX() then
      longestCommandTextSize = value:GetSizeX()
    end
  end
  for idx, value in pairs(skillList) do
    if longestSkillTextSize < value:GetSizeX() then
      longestSkillTextSize = value:GetSizeX()
    end
  end
  key01B:SetPosX(keyGuideBG:GetSizeX() - longestSkillTextSize - indent)
  key02B:SetPosX(keyGuideBG:GetSizeX() - longestSkillTextSize - indent)
  key03B:SetPosX(keyGuideBG:GetSizeX() - longestSkillTextSize - indent)
  key04B:SetPosX(keyGuideBG:GetSizeX() - longestSkillTextSize - indent)
  key05B:SetPosX(keyGuideBG:GetSizeX() - longestSkillTextSize - indent)
  key01A:SetPosX(key01B:GetPosX() - key01A:GetSizeX() - indent)
  key02A:SetPosX(key02B:GetPosX() - key02A:GetSizeX() - indent)
  key03A:SetPosX(key03B:GetPosX() - key03A:GetSizeX() - indent)
  key04A:SetPosX(key04B:GetPosX() - key04A:GetSizeX() - indent)
  key05A:SetPosX(key05B:GetPosX() - key05A:GetSizeX() - indent)
  Panel_HorseRacing_KeyGuide:SetShow(true)
end
function PaGlobal_HorseRacing_KeyGuide:prepareClose()
  self:close()
end
function PaGlobal_HorseRacing_KeyGuide:close()
  Panel_HorseRacing_KeyGuide:SetShow(false)
end
function PaGlobal_HorseRacing_KeyGuide_Open()
  PaGlobal_HorseRacing_KeyGuide:prepareOpen()
end
function PaGlobal_HorseRacing_KeyGuide_Close()
  PaGlobal_HorseRacing_KeyGuide:prepareClose()
end
