PaGlobal_WorldMap_KnowledgeList = {
  _ui = {
    stc_title = nil,
    txt_titleIcon = nil,
    txt_closeIcon = nil,
    stc_mainBG = nil,
    list2_knowledge = nil,
    list2_content = nil,
    stc_keyGuide = nil
  },
  _uiStatic = nil,
  _identifiedCount = 0,
  _unidentifiedCount = 0,
  _idCounter = 0,
  _unidCounter = 0
}
function PaGlobal_WorldMap_KnowledgeList:initialize()
  self._ui.stc_title = UI.getChildControl(Panel_Worldmap_KnowledgeList, "Static_TitleBar")
  self._ui.txt_titleIcon = UI.getChildControl(self._ui.stc_title, "StaticText_TitleIcon")
  self._ui.txt_closeIcon = UI.getChildControl(self._ui.stc_title, "Static_CloseIcon")
  self._ui.stc_mainBG = UI.getChildControl(Panel_Worldmap_KnowledgeList, "Static_MainBG_Stack_Normal")
  self._ui.list2_knowledge = UI.getChildControl(self._ui.stc_mainBG, "List2_Knowledge")
  self._ui.list2_content = UI.getChildControl(self._ui.list2_knowledge, "List2_1_Content")
  self._ui.stc_keyGuide = UI.getChildControl(Panel_Worldmap_KnowledgeList, "Static_ConsoleKeyGuide")
  self:registEventHandler()
  self:validate()
end
function PaGlobal_WorldMap_KnowledgeList:registEventHandler()
  self._ui.txt_closeIcon:addInputEvent("Mouse_LUp", "PaGlobal_WorldMap_KnowledgeList:prepareClose()")
  self._ui.list2_knowledge:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_WorldMap_KnowledgeListUpdate")
  self._ui.list2_knowledge:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_WorldMap_KnowledgeList:validate()
  self._ui.txt_closeIcon:isValidate()
  self._ui.list2_knowledge:isValidate()
end
function PaGlobal_WorldMap_KnowledgeList:prepareOpen()
  if ToClient_WorldMapIsShow() == true then
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Worldmap_KnowledgeList, true)
    local sizeX = Panel_Worldmap_KnowledgeList:GetSizeX()
    local sizeY = Panel_Worldmap_KnowledgeList:GetSizeY()
    local mouseX = getMousePosX()
    local mouseY = getMousePosY()
    local openPosX = mouseX - sizeX * 0.5
    local openPosY = mouseY - sizeY * 0.5
    local limitX = getScreenSizeX() - sizeX * 0.5
    local limitY = getScreenSizeY() - sizeY * 0.5
    if mouseX > limitX then
      openPosX = limitX - sizeX * 0.5
    end
    if mouseX < sizeX * 0.5 then
      openPosX = 0
    end
    if mouseY > limitY then
      openPosY = limitY - sizeY * 0.5
    end
    if mouseY < sizeY * 0.5 then
      openPosY = 0
    end
    Panel_Worldmap_KnowledgeList:SetPosX(openPosX)
    Panel_Worldmap_KnowledgeList:SetPosY(openPosY)
    self:open()
  end
end
function PaGlobal_WorldMap_KnowledgeList:open()
  Panel_Worldmap_KnowledgeList:SetShow(true)
end
function PaGlobal_WorldMap_KnowledgeList:prepareClose()
  if ToClient_WorldMapIsShow() then
    WorldMapPopupManager:pop()
  end
  self:close()
end
function PaGlobal_WorldMap_KnowledgeList:close()
  Panel_Worldmap_KnowledgeList:SetShow(false)
end
function PaGlobal_WorldMap_KnowledgeListOpen_ByNode(isWaypointKey, key)
  local self = PaGlobal_WorldMap_KnowledgeList
  if self == nil then
    return
  end
  if isWaypointKey == nil then
    return
  end
  if isWaypointKey == true then
    self._uiStatic = Toclient_FindUiNodeKnowledgeStaticByKey(key)
    local name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_KNOWLEDGELIST_PANELNAME", "region", Toclient_GetUiNodeNameByKey(key))
    self._ui.txt_titleIcon:SetText(name)
  else
    self._uiStatic = Toclient_FindUiTerritoryKnowledgeStaticByKeyRaw(key)
    local name = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_KNOWLEDGELIST_PANELNAME", "region", Toclient_GetUiTerritoryNameByKey(key))
    self._ui.txt_titleIcon:SetText(name)
  end
  self._identifiedCount = self._uiStatic:getIdentifiedCount()
  self._unidentifiedCount = self._uiStatic:getUnidentifiedCount()
  self._ui.list2_knowledge:getElementManager():clearKey()
  for index = 0, self._identifiedCount - 1 do
    self._ui.list2_knowledge:getElementManager():pushKey(index)
  end
  for index = self._identifiedCount, self._identifiedCount + self._unidentifiedCount - 1 do
    self._ui.list2_knowledge:getElementManager():pushKey(index)
  end
  self:prepareOpen()
end
function PaGlobal_WorldMap_KnowledgeListUpdate(content, key)
  local self = PaGlobal_WorldMap_KnowledgeList
  if self == nil then
    return
  end
  local key32 = Int64toInt32(key)
  if self._uiStatic ~= nil then
    local name = UI.getChildControl(content, "StaticText_Name")
    local has = UI.getChildControl(content, "StaticText_Has")
    name:SetShow(true)
    has:SetShow(true)
    if key32 < self._identifiedCount then
      name:SetText("<PAColor0xFF4898D0>" .. self._uiStatic:getIdentifiedNameByIndex(key32) .. "<PAOldColor>")
      has:SetText("<PAColor0xFF4898D0>" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_KNOWLEDGELIST_IDENTIFIED") .. "<PAOldColor>")
    else
      local hint = self._uiStatic:getUnidentifiedKeywordByIndex(key32 - self._identifiedCount)
      local count = 0
      for _ in string.gmatch(hint, "<PAColor") do
        count = count + 1
      end
      local result = hint
      for index = 1, count do
        local openPosStart = string.find(result, "<PAColor")
        local openColorCode = string.sub(result, openPosStart, openPosStart + 18)
        result = string.gsub(string.gsub(result, openColorCode, ""), "<PAOldColor>", "")
      end
      name:SetText("<PAColor0xFFa4a4a4>" .. result .. "<PAOldColor>")
      UI.setLimitTextAndAddTooltip(name, name:GetText())
      has:SetText("<PAColor0xFFa4a4a4>" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_KNOWLEDGELIST_UNIDENTIFIED") .. "<PAOldColor>")
    end
  end
end
function PaGlobal_WorldMap_KnowledgeListClose()
  local self = PaGlobal_WorldMap_KnowledgeList
  if self == nil then
    return
  end
  self:prepareClose()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_WorldMapKnowledgeList_Init")
function FromClient_PaGlobal_WorldMapKnowledgeList_Init()
  PaGlobal_WorldMap_KnowledgeList:initialize()
end
