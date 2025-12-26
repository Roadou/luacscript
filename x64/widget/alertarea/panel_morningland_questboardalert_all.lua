PaGlobal_MorningLand_QuestBoardAlert_All = {
  _ui = {stc_Title = nil},
  _ui_pc = {btn_Close = nil},
  _ui_console = {},
  _showTime = 5,
  _startTime = 0,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_MorningLand_QuestBoardAlert_All")
function FromClient_PaGlobal_MorningLand_QuestBoardAlert_All()
  PaGlobal_MorningLand_QuestBoardAlert_All:initialize()
end
function PaGlobal_MorningLand_QuestBoardAlert_All:initialize()
  if PaGlobal_MorningLand_QuestBoardAlert_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_Title = UI.getChildControl(Panel_MorningLand_QuestBoardAlert_All, "StaticText_Title")
  self._ui_pc.btn_Close = UI.getChildControl(Panel_MorningLand_QuestBoardAlert_All, "Button_Win_Close")
  PaGlobal_MorningLand_QuestBoardAlert_All:changePlatform()
  PaGlobal_MorningLand_QuestBoardAlert_All:registEventHandler()
  PaGlobal_MorningLand_QuestBoardAlert_All:validate()
  PaGlobal_MorningLand_QuestBoardAlert_All._initialize = true
end
function PaGlobal_MorningLand_QuestBoardAlert_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_MorningLand_QuestBoardAlert_All:registEventHandler()
  if Panel_MorningLand_QuestBoardAlert_All == nil then
    return
  end
  self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_QuestBoardAlert_All_Close()")
  Panel_MorningLand_QuestBoardAlert_All:addInputEvent("Mouse_LUp", "PaGlobal_Journal_All_OpenMorningLand()")
end
function PaGlobal_MorningLand_QuestBoardAlert_All:prepareOpen()
  if Panel_MorningLand_QuestBoardAlert_All == nil then
    return
  end
  Panel_MorningLand_QuestBoardAlert_All:EraseAllEffect()
  Panel_MorningLand_QuestBoardAlert_All:AddEffect("fUI_Morning_Book_02A", false, 0, 0)
  Panel_MorningLand_QuestBoardAlert_All:AddEffect("fUI_Morning_Book_01A", true, 0, 0)
  audioPostEvent_SystemUi(10, 8)
  _AudioPostEvent_SystemUiForXBOX(10, 8)
  if self._isConsole == true then
    Panel_MorningLand_QuestBoardAlert_All:RegisterUpdateFunc("PaGlobal_MorningLand_QuestBoardAlert_All_Update")
  end
  PaGlobal_MorningLand_QuestBoardAlert_All:open()
end
function PaGlobal_MorningLand_QuestBoardAlert_All:open()
  if Panel_MorningLand_QuestBoardAlert_All == nil then
    return
  end
  Panel_MorningLand_QuestBoardAlert_All:SetShow(true)
end
function PaGlobal_MorningLand_QuestBoardAlert_All:prepareClose()
  if Panel_MorningLand_QuestBoardAlert_All == nil then
    return
  end
  self._startTime = 0
  Panel_MorningLand_QuestBoardAlert_All:ClearUpdateLuaFunc()
  Panel_MorningLand_QuestBoardAlert_All:EraseAllEffect()
  Panel_MorningLand_QuestBoardAlert_All:AddEffect("fUI_Morning_Book_03A", false, 0, 0)
  audioPostEvent_SystemUi(10, 9)
  _AudioPostEvent_SystemUiForXBOX(10, 9)
  PaGlobal_MorningLand_QuestBoardAlert_All:close()
end
function PaGlobal_MorningLand_QuestBoardAlert_All:close()
  if Panel_MorningLand_QuestBoardAlert_All == nil then
    return
  end
  Panel_MorningLand_QuestBoardAlert_All:SetShow(false)
end
function PaGlobal_MorningLand_QuestBoardAlert_All:update(deltaTime)
  if Panel_MorningLand_QuestBoardAlert_All == nil then
    return
  end
  self._startTime = self._startTime + deltaTime
  if self._startTime >= self._showTime then
    PaGlobal_MorningLand_QuestBoardAlert_All_Close()
  end
end
function PaGlobal_MorningLand_QuestBoardAlert_All:validate()
  if Panel_MorningLand_QuestBoardAlert_All == nil then
    return
  end
end
function PaGlobal_MorningLand_QuestBoardAlert_All_Open()
  if Panel_MorningLand_QuestBoardAlert_All == nil then
    return
  end
  if questList_isClearQuest(8515, 10) == true then
    return
  end
  if _ContentsGroup_RenewUI == true then
    return
  end
  PaGlobal_MorningLand_QuestBoardAlert_All:prepareOpen()
end
function PaGlobal_MorningLand_QuestBoardAlert_All_Close()
  if Panel_MorningLand_QuestBoardAlert_All == nil then
    return
  end
  if Panel_MorningLand_QuestBoardAlert_All:GetShow() == false then
    return
  end
  PaGlobal_MorningLand_QuestBoardAlert_All:prepareClose()
end
function PaGlobal_MorningLand_QuestBoardAlert_All_Update(deltaTime)
  PaGlobal_MorningLand_QuestBoardAlert_All:update(deltaTime)
end
function FromClient_PaGlobal_MorningLand_QuestBoardAlert_All_CheckClose(questGropuID, questIndex)
  if PaGlobal_MorningLand_QuestBoard_All_IsMorningQuestBordQuest(questGropuID) == true then
    PaGlobal_MorningLand_QuestBoardAlert_All_Close()
  end
end
registerEvent("FromClient_UpdateQuestList", "FromClient_PaGlobal_MorningLand_QuestBoardAlert_All_CheckClose")
