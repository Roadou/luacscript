function HandleEventOn_ImportantNotice_NoticeList()
  local listBg = PaGlobal_ImportantNotice._ui._static_noticeListBG
  local frame = PaGlobal_ImportantNotice._ui._frame_noticeList
  local frameContent = PaGlobal_ImportantNotice._ui._frame_content
  listBg:SetShow(true)
  frameContent:DestroyAllChild()
  PaGlobal_ImportantNotice._ui._frameContent_List = {}
  local noticeCount = ToClient_getWorldNoticeCount()
  local sizeX = PaGlobal_ImportantNotice._defaultListSizeX
  local sizeY = PaGlobal_ImportantNotice._defaultContentsSizeY * noticeCount
  frame:SetSize(sizeX, sizeY)
  listBg:SetSize(sizeX + 20, sizeY + 30)
  listBg:ComputePosAllChild()
  local posY = 0
  for i = 0, noticeCount - 1 do
    local msgInfo = ToClient_getWorldNoticeInfo(i)
    local listData = {}
    listData.noticeText = UI.createAndCopyBasePropertyControl(Panel_Important_Notice, "StaticText_Notice", frameContent, "StaticText_Notice_" .. i)
    listData.noticeText:SetShow(true)
    listData.noticeText:SetFontColor(Chatting_MessageColor(CppEnums.ChatType.Notice, msgInfo:getNoticeType()))
    listData.noticeText:SetText(msgInfo:getMessage())
    listData.noticeText:SetPosY(posY)
    posY = posY + listData.noticeText:GetSizeY()
    sizeX = math.max(sizeX, listData.noticeText:GetTextSizeX())
    PaGlobal_ImportantNotice._ui._frameContent_List[i] = listData
  end
  frame:SetSize(sizeX, sizeY)
  listBg:SetSize(sizeX + 20, sizeY + 30)
end
function HandleEventOut_ImportantNotice_NoticeList()
  PaGlobal_ImportantNotice._ui._static_noticeListBG:SetShow(false)
end
function HandleEventLUp_ImportantNotice_WebLink()
  PaGlobal_ImportantNotice:goToWebLink()
end
function FromClient_ImportantNotice_EventNotifyManagerAlertMessage(noticeIndex, isFlag)
  if nil == Panel_Important_Notice then
    return
  end
  if false == PaGlobal_ImportantNotice._isNoticeOpen then
    PaGlobal_ImportantNotice:updateStringList()
    PaGlobal_ImportantNotice:showNoticeText(PaGlobal_ImportantNotice._currentNoticeIndex)
    PaGlobal_ImportantNotice:prepareOpen()
  else
    PaGlobal_ImportantNotice._isFinishMessage = true
  end
end
function FromClient_ImportantNotice_EventNotifyManagerAlertMessageDelete(noticeIndex)
  PaGlobal_ImportantNotice._isFinishMessage = true
end
function PaGlobal_ImportantNotice_Reposition(panel, listBG, poolIndex, isClickedResize)
  local self = PaGlobal_ImportantNotice
  if false == PaGlobal_ImportantNotice._initialize then
    PaGlobal_ImportantNotice._isResizeFailed = true
    return
  end
  if 0 ~= poolIndex then
    return
  end
  Panel_Important_Notice:SetPosX(panel:GetPosX())
  local sizeX = listBG:GetSizeX()
  local adjustY = 0
  if _ContentsGroup_RenewUI == true then
    adjustY = 30
  end
  Panel_Important_Notice:SetPosY(panel:GetPosY() + Panel_Important_Notice:GetSizeY() - adjustY)
  if _ContentsGroup_RenewUI == true then
    sizeX = sizeX - 100
    local textSizeX = sizeX - 40
    self._ui._staticText_message:SetText(self._ui._staticText_message:GetText())
    self._applyBGSizeY = self._ui._staticText_message:GetTextSizeY()
    self._ui._static_noticeBG:SetSize(sizeX, self._applyBGSizeY)
    self._ui._staticText_message:SetSize(textSizeX, self._applyBGSizeY)
    self._ui._staticText_calculate:SetSize(textSizeX, self._applyBGSizeY)
    PaGlobal_Chat_UpdatTopClipingPanel(0, PaGlobal_ImportantNotice_GetNoticeSize())
    PaGlobal_ImportantNotice_SetShow(true)
  else
    local textSizeX = sizeX - 40
    self._applyBGSizeY = PaGlobal_ImportantNotice:getApplyBGSizeY(textSizeX)
    self._ui._static_noticeBG:SetSize(sizeX, self._applyBGSizeY)
    self._ui._staticText_message:SetSize(textSizeX, self._applyBGSizeY)
    self._ui._staticText_message:SetText(self._ui._staticText_message:GetText())
    self._ui._staticText_calculate:SetSize(textSizeX, self._applyBGSizeY)
    PaGlobal_Chat_UpdatTopClipingPanel(0, PaGlobal_ImportantNotice_GetNoticeSize())
    local isSave = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, poolIndex, CppEnums.PanelSaveType.PanelSaveType_IsSaved)
    local isShow = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ChattingWindow, poolIndex, CppEnums.PanelSaveType.PanelSaveType_IsShow)
    if isSave > 0 then
      PaGlobal_ImportantNotice_SetShow(isShow > 0)
    else
      PaGlobal_ImportantNotice_SetShow(true)
    end
  end
end
