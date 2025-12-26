function PaGlobal_RentInstanceField_List_Open()
  PaGlobal_RentInstanceField_List:prepareOpen()
end
function PaGlobal_RentInstanceField_List_List2Update(content, hostUserNo)
  local self = PaGlobal_RentInstanceField_List
  local fieldWrapper = ToClient_rentInstanceFieldInfoWrapper(hostUserNo)
  if nil == fieldWrapper then
    return
  end
  local stc_tempBG = UI.getChildControl(content, "Static_TempleteBG")
  local txt_fieldName = UI.getChildControl(stc_tempBG, "StaticText_Templete_ServerName")
  local txt_memberCount = UI.getChildControl(stc_tempBG, "StaticText_Templete_Member")
  local txt_remainTime = UI.getChildControl(stc_tempBG, "StaticText_Templete_Time")
  local txt_host = UI.getChildControl(stc_tempBG, "StaticText_Templete_Master")
  local btn_enter = UI.getChildControl(stc_tempBG, "Button_Enter")
  local btn_option = UI.getChildControl(stc_tempBG, "Button_Option")
  local fieldName = ""
  local fieldMapSSW = ToClient_GetInstanceMapStaticStatusWrapper(fieldWrapper:getInstanceFieldMapKey())
  if nil ~= fieldMapSSW and nil ~= fieldMapSSW:getFieldNameStringKey() then
    fieldName = PAGetString(Defines.StringSheet_GAME, fieldMapSSW:getFieldNameStringKey())
  end
  txt_fieldName:SetText(tostring(fieldName))
  local membercount = fieldWrapper:getJoinPlayerCount()
  local maxMemberCount = ToClient_GetInstanceFieldPlayerMaxCountByMapKey(fieldWrapper:getInstanceFieldMapKey())
  if 0 ~= maxMemberCount and membercount >= maxMemberCount then
    membercount = maxMemberCount
  end
  txt_memberCount:SetText(tostring(membercount))
  txt_remainTime:SetText(convertStringFromDatetimeAll(fieldWrapper:getRemainTime()))
  txt_host:SetText(fieldWrapper:getHostUserNickName())
  btn_enter:addInputEvent("Mouse_LUp", "PaGlobal_RentInstanceField_List:enterToField(" .. tostring(hostUserNo) .. ")")
  if fieldWrapper:getHostUserNo() == getSelfPlayer():get():getUserNo() then
    btn_option:addInputEvent("Mouse_LUp", "PaGlobal_RentInstanceField_Option:prepareOpen()")
    btn_option:SetShow(true)
  else
    btn_option:addInputEvent("Mouse_LUp", "")
    btn_option:SetShow(false)
  end
end
function PaGlobal_RentInstanceField_UpdatePerFrame(deltaTime)
  local self = PaGlobal_RentInstanceField_List
  self._toTime = self._toTime + deltaTime
  if self._toTime - self._fromTime < 1 then
    return
  end
  self._fromTime = self._toTime
  local fieldList = ToClient_getInvitedRentInstanceFieldList()
  if nil == fieldList then
    return
  end
  for ii = 0, #fieldList do
    local userNo = fieldList[ii]:getUserNo()
    self._ui._list2_fieldList:requestUpdateByKey(userNo)
  end
end
function FromClient_RentInstanceFieldList_useRentInstanceFieldOpenItem(fromWhereType, fromSlotNo)
  local function requestRentInstanceField()
    ToClient_requestRentInstanceField(fromWhereType, fromSlotNo)
  end
  local itemWrapper = getInventoryItemByType(fromWhereType, fromSlotNo)
  if nil == itemWrapper then
    return
  end
  if __eContentsType_RentInstanceField ~= itemWrapper:getStaticStatus():getContentsEventType() then
    _PA_ASSERT(false, "ContentsEventType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  local mapKey = itemWrapper:getStaticStatus():getContentsEventParam1()
  local minute = itemWrapper:getStaticStatus():getContentsEventParam2()
  local hour = minute / 60
  local fieldName = ""
  local fieldMapSSW = ToClient_GetInstanceMapStaticStatusWrapper(mapKey)
  if nil ~= fieldMapSSW and nil ~= fieldMapSSW:getFieldNameStringKey() then
    fieldName = PAGetString(Defines.StringSheet_GAME, fieldMapSSW:getFieldNameStringKey())
  end
  local txt_content = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_PERSONAL_SERVER_START_MSG", "itemName", itemName, "mapName", fieldName, "minute", tostring(hour))
  local messageBoxData = {
    title = "",
    content = txt_content,
    functionYes = requestRentInstanceField,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_RentInstanceFieldList_updateRentInstanceFieldList()
  ToClient_requestUpdateRentInstanceFieldPlayerCount()
end
function FromClient_RentInstanceFieldList_responseUpdateRentInstanceFieldPlayerCount()
  if nil == Panel_RentInstanceField_List then
    return
  end
  if false == Panel_RentInstanceField_List:GetShow() then
    return
  end
  PaGlobal_RentInstanceField_List._ui._list2_fieldList:requestUpdateVisible()
end
