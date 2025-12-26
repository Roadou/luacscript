local NakRenewel = {
  _ui = {
    _static_MainBg = UI.getChildControl(Panel_NakMessage_Renewel, "Static_MainBg"),
    _static_SubBg = nil,
    _static_EffectBg = nil,
    _static_MainText = nil,
    _static_SubText = nil,
    _stc_leftNPC = nil,
    _stc_leftNPCIcon = nil,
    _txt_leftNPCMessage = nil,
    _stc_rightNPC = nil,
    _stc_rightNPCIcon = nil,
    _txt_rightNPCMessage = nil,
    _stc_itemIcon = nil,
    _stc_itemGrade = nil,
    _stc_knowledgeLevel = nil,
    _itemGradeBorderData = {
      [0] = {
        texture = "new_ui_common_forlua/default/default_etc_00.dds",
        x1 = 103,
        y1 = 176,
        x2 = 153,
        y2 = 226
      },
      [1] = {
        texture = "new_ui_common_forlua/window/skill/skill_ui_00.dds",
        x1 = 172,
        y1 = 44,
        x2 = 214,
        y2 = 86
      },
      [2] = {
        texture = "new_ui_common_forlua/window/skill/skill_ui_00.dds",
        x1 = 172,
        y1 = 1,
        x2 = 214,
        y2 = 43
      },
      [3] = {
        texture = "new_ui_common_forlua/window/skill/skill_ui_00.dds",
        x1 = 129,
        y1 = 1,
        x2 = 171,
        y2 = 43
      },
      [4] = {
        texture = "new_ui_common_forlua/window/skill/skill_ui_00.dds",
        x1 = 129,
        y1 = 44,
        x2 = 171,
        y2 = 86
      }
    },
    _knowledgeLevelData = {
      [1] = {
        texture = "new_ui_common_forlua/window/knowledge/knowledge_01.dds",
        x1 = 311,
        y1 = 132,
        x2 = 340,
        y2 = 161
      },
      [2] = {
        texture = "new_ui_common_forlua/window/knowledge/knowledge_01.dds",
        x1 = 281,
        y1 = 133,
        x2 = 310,
        y2 = 162
      },
      [3] = {
        texture = "new_ui_common_forlua/window/knowledge/knowledge_01.dds",
        x1 = 251,
        y1 = 133,
        x2 = 280,
        y2 = 162
      },
      [4] = {
        texture = "new_ui_common_forlua/window/knowledge/knowledge_01.dds",
        x1 = 221,
        y1 = 133,
        x2 = 250,
        y2 = 162
      },
      [5] = {
        texture = "new_ui_common_forlua/window/knowledge/knowledge_01.dds",
        x1 = 191,
        y1 = 132,
        x2 = 220,
        y2 = 161
      }
    }
  },
  _currentNakType = nil,
  _animationEndTime = nil,
  _npcMessage = {
    [__eNakMessage_RichMerchantRing] = {messageCount = 0},
    [__eNakMessage_PanOkSeonPersonal] = {messageCount = 0}
  },
  _npcMessageIndex = nil,
  _npcMessageTime = nil,
  _totalMessageTime = nil,
  _elapsedTotalMessageTime = nil,
  _elapsedMessageTime = nil,
  _npcShowTime = nil,
  _itemIconOriginSpanSizeY = 0
}
function NakMessageRenewel_initialize()
  NakRenewel._ui._static_SubBg = UI.getChildControl(NakRenewel._ui._static_MainBg, "Static_SubBg")
  NakRenewel._ui._static_EffectBg = UI.getChildControl(NakRenewel._ui._static_MainBg, "Static_EffectBg")
  NakRenewel._ui._static_MainText = UI.getChildControl(NakRenewel._ui._static_MainBg, "StaticText_Main")
  NakRenewel._ui._static_SubText = UI.getChildControl(NakRenewel._ui._static_MainBg, "StaticText_Sub")
  NakRenewel._ui._stc_leftNPC = UI.getChildControl(NakRenewel._ui._static_MainBg, "Static_LeftNPC")
  NakRenewel._ui._txt_leftNPCMessage = UI.getChildControl(NakRenewel._ui._stc_leftNPC, "StaticText_LeftDesc")
  NakRenewel._ui._stc_leftNPCIcon = UI.getChildControl(NakRenewel._ui._stc_leftNPC, "Static_LeftBG")
  NakRenewel._ui._stc_rightNPC = UI.getChildControl(NakRenewel._ui._static_MainBg, "Static_RightNPC")
  NakRenewel._ui._txt_rightNPCMessage = UI.getChildControl(NakRenewel._ui._stc_rightNPC, "StaticText_RightDesc")
  NakRenewel._ui._stc_rightNPCIcon = UI.getChildControl(NakRenewel._ui._stc_rightNPC, "Static_RightBG")
  NakRenewel._ui._stc_itemIcon = UI.getChildControl(NakRenewel._ui._static_MainBg, "Static_ItemIcon")
  NakRenewel._ui._stc_itemGrade = UI.getChildControl(NakRenewel._ui._static_MainBg, "Static_ItemGrade")
  NakRenewel._ui._stc_knowledgeLevel = UI.getChildControl(NakRenewel._ui._static_MainBg, "Static_Knowledge_Level")
  NakRenewel._npcMessageIndex = 1
  NakRenewel._npcMessageTime = 5
  NakRenewel._totalMessageTime = 0
  NakRenewel._elapsedTotalMessageTime = 0
  NakRenewel._elapsedMessageTime = 5.4
  NakRenewel._npcShowTime = 0.4
  NakRenewel._itemIconOriginSpanSizeY = NakRenewel._ui._stc_itemIcon:GetSpanSize().y
end
function FromClient_NakMessageRenewelClear()
  NakMessageRenewel_SetDefaultShow()
end
function FromClient_NakMessageRenewelRequest(nakMessageType, mainStr, subStr, iconPath, iconUV, itemGrade, knowledgeLevel, onlyChat)
  NakMessageRenewel_SetDefaultShow()
  if nakMessageType < 0 or nakMessageType >= __eNakMessage_Count then
    return
  end
  local nakMessageData = ToClient_GetNakMessageRenewelData(nakMessageType)
  if nakMessageData == nil then
    return
  end
  if nakMessageData._onlyChat == true or onlyChat == true then
    NakMessageRenewel_SendChat(nakMessageData, mainStr, subStr)
    return
  end
  local nakMsgPos = nakMessageData:getNakMessagePosition()
  if nakMsgPos == __eNakPosition_Top then
    Panel_NakMessage_Renewel:SetPosY(50)
  elseif nakMsgPos == __eNakPosition_Center then
    Panel_NakMessage_Renewel:SetPosY(getScreenSizeY() / 2 - 200)
  else
    Panel_NakMessage_Renewel:SetPosY(0)
  end
  local nakMainBgData = {
    _tId = nakMessageData:getMainBgTID(),
    _isUsingGrid = nakMessageData:getMainBgUseGrid(),
    _gridPosX = nakMessageData:getMainBgGridPosX(),
    _gridPosY = nakMessageData:getMainBgGridPosY(),
    _gridUVX = nakMessageData:getMainBgGridUVX(),
    _gridUVY = nakMessageData:getMainBgGridUVY(),
    _size = nakMessageData:getMainBgSize(),
    _spanY = nakMessageData:getMainBgSpanY(),
    _useFixedSize = nakMessageData:getMainBgUseFixedSize()
  }
  NakMessageRenewel_SetBg(NakRenewel._ui._static_MainBg, nakMainBgData)
  local nakMainData = {
    _string = mainStr,
    _font = nakMessageData:getMainTextFont(),
    _color = nakMessageData:getMainTextColor(),
    _spanY = nakMessageData:getMainTextSpanY()
  }
  NakMessageRenewel_SetText(NakRenewel._ui._static_MainText, nakMainData)
  if nakMessageData._isExistSubBg == true then
    local nakSubBgData = {
      _tId = nakMessageData:getSubBgTID(),
      _isUsingGrid = nakMessageData:getSubBgUseGrid(),
      _gridPosX = nakMessageData:getSubBgGridPosX(),
      _gridPosY = nakMessageData:getSubBgGridPosY(),
      _gridUVX = nakMessageData:getSubBgGridUVX(),
      _gridUVY = nakMessageData:getSubBgGridUVY(),
      _spanY = nakMessageData:getSubBgSpanY(),
      _useFixedSize = nakMessageData:getSubBgUseFixedSize(),
      _size = nakMessageData:getSubBgSize()
    }
    NakMessageRenewel_SetBg(NakRenewel._ui._static_SubBg, nakSubBgData)
    if 0 >= NakRenewel._ui._static_MainText:GetPosY() - NakRenewel._ui._static_SubBg:GetSizeY() then
      Panel_NakMessage_Renewel:SetPosY(Panel_NakMessage_Renewel:GetPosY() + NakRenewel._ui._static_SubBg:GetSizeY())
    end
  end
  if nakMessageData._isExistSubText == true then
    NakRenewel._ui._static_MainText:SetPosY(NakRenewel._ui._static_MainText:GetPosY() + 10)
    local nakSubData = {
      _string = subStr,
      _font = nakMessageData:getSubTextFont(),
      _color = nakMessageData:getSubTextColor(),
      _spanY = nakMessageData:getSubTextSpanY()
    }
    NakMessageRenewel_SetText(NakRenewel._ui._static_SubText, nakSubData)
    if nakMessageType == __eNakMessage_LearnMentalCard then
      if knowledgeLevel > 0 and knowledgeLevel <= 5 then
        local knowledgeLevelData = NakRenewel._ui._knowledgeLevelData[knowledgeLevel]
        NakRenewel._ui._stc_knowledgeLevel:ChangeTextureInfoNameAsync(knowledgeLevelData.texture)
        local x1, y1, x2, y2 = setTextureUV_Func(NakRenewel._ui._stc_knowledgeLevel, knowledgeLevelData.x1, knowledgeLevelData.y1, knowledgeLevelData.x2, knowledgeLevelData.y2)
        NakRenewel._ui._stc_knowledgeLevel:getBaseTexture():setUV(x1, y1, x2, y2)
        NakRenewel._ui._stc_knowledgeLevel:setRenderTexture(NakRenewel._ui._stc_knowledgeLevel:getBaseTexture())
        NakRenewel._ui._stc_knowledgeLevel:SetShow(true)
        local spanSizeX = NakRenewel._ui._static_SubText:GetTextSizeX() / 2 + NakRenewel._ui._stc_knowledgeLevel:GetSizeX()
        NakRenewel._ui._stc_knowledgeLevel:SetSpanSize(spanSizeX, NakRenewel._ui._stc_knowledgeLevel:GetSpanSize().y)
      else
        NakRenewel._ui._stc_knowledgeLevel:ReleaseTexture()
        NakRenewel._ui._stc_knowledgeLevel:ChangeTextureInfoNameAsync("")
      end
    end
  end
  if nakMessageData._isExistIcon == true then
    local nakIconData = {
      _iconPath = iconPath,
      _spanY = nakMessageData:getIconSpanY(),
      _iconUV = iconUV,
      _iconSize = nakMessageData:getIconSize(),
      _itemGrade = itemGrade
    }
    NakMessageRenewel_SetItemIcon(nakIconData)
  end
  NakMessageRenewel_SendChat(nakMessageData, mainStr, subStr)
  if nakMessageData._isExistEffectBg == true then
    NakMessageRenewel_SetEffect(nakMessageData)
  end
  if nakMessageData._isExistSoundList == true then
    NakMessageRenewel_SetAudio(nakMessageData)
  end
  NakRenewel._currentNakType = nakMessageType
  NakRenewel._animationEndTime = nakMessageData._AniTime
  if NakRenewel._currentNakType == __eNakMessage_RichMerchantRing then
    local playerName = subStr
    NakMessageRenewel_NpcPerfomanceNakSetting(playerName)
  end
  if NakRenewel._currentNakType == __eNakMessage_PanOkSeonPersonal then
    local selfPlayer = getSelfPlayer()
    if selfPlayer == nil then
      return
    end
    local playerName = selfPlayer:getUserNickname()
    NakMessageRenewel_NpcPerfomanceNakSetting(playerName)
  end
  Panel_NakMessage_Renewel:SetPosX(Panel_NakMessage_Renewel:GetSpanSize().x + (getScreenSizeX() - Panel_NakMessage_Renewel:GetSizeX()) * 0.5)
  Panel_NakMessage_Renewel:SetShow(true)
  NakMessageRenewel_Animation()
end
function NakMessageRenewel_SetBg(control, nakData)
  if control == nil then
    return
  end
  if nakData._tId == nil then
    return
  end
  local baseTexture = control:getBaseTexture()
  control:ChangeTextureInfoTextureIDAsync(nakData._tId)
  local textureSize
  if nakData._useFixedSize == true then
    textureSize = nakData._size
  else
    textureSize = baseTexture:getTextureSize(nakData._tId)
  end
  control:SetSize(textureSize.x, textureSize.y)
  if nakData._isUsingGrid == true then
    control:SetGridType(1)
    control:SetGridPosX(nakData._gridPosX.x, nakData._gridPosX.y, nakData._gridPosX.z, nakData._gridPosX.w)
    control:SetGridPosY(nakData._gridPosY.x, nakData._gridPosY.y, nakData._gridPosY.z, nakData._gridPosY.w)
    control:SetGridUVX(nakData._gridUVX.x, nakData._gridUVX.y, nakData._gridUVX.z, nakData._gridUVX.w)
    control:SetGridUVY(nakData._gridUVY.x, nakData._gridUVY.y, nakData._gridUVY.z, nakData._gridUVY.w)
    local x1, y1, x2, y2 = setTextureUV_Func(control, baseTexture:getUV(0).x, baseTexture:getUV(0).y, baseTexture:getUV(3).x, baseTexture:getUV(3).y)
    baseTexture:setUV(x1, y1, x2, y2)
  else
    control:SetGridType(0)
  end
  control:setRenderTexture(baseTexture)
  control:ComputePos()
  control:SetPosY(control:GetPosY() + nakData._spanY)
  control:SetShow(true)
end
function NakMessageRenewel_SetText(control, nakData)
  if control == nil then
    return
  end
  if nakData._string == nil or nakData._string == "" or nakData._font == nil or nakData._color == nil then
    return
  end
  local fontWrapper = ToClient_getFontWrapper(nakData._font)
  if fontWrapper == nil then
    fontWrapper = ToClient_getFontWrapper("TitleFont_18")
  end
  control:SetFont(fontWrapper:get())
  control:SetText(nakData._string)
  local colorValue = tonumber(nakData._color, 16)
  if _ContentsGroup_ChinaFontColor == true and colorValue == tonumber("ffff8181", 16) then
    colorValue = tonumber("FFFFEDD4", 16)
  end
  control:SetFontColor(colorValue)
  control:ComputePos()
  control:SetPosY(control:GetPosY() + nakData._spanY)
  control:SetShow(true)
end
function NakMessageRenewel_SetEffect(nakMessage)
  local effectCount = nakMessage:getEffectFileCount()
  for idx = 0, effectCount - 1 do
    local effectPath = nakMessage:getEffectBgFilePath(idx)
    local effectData = nakMessage:getEffectBg(idx)
    NakRenewel._ui._static_EffectBg:ComputePos()
    NakRenewel._ui._static_EffectBg:AddEffect(effectPath, effectData._loop, effectData._posX, effectData._posY)
  end
  NakRenewel._ui._static_EffectBg:SetShow(true)
end
function NakMessageRenewel_SetAudio(nakMessage)
  local soundCount = nakMessage:getSoundListCount()
  for idx = 0, soundCount - 1 do
    local soundData = nakMessage:getSoundIndex(idx)
    audioPostEvent_SystemUi(soundData._audioIndex, soundData._audioIndexB)
    if soundData._consolePlay == true then
      _AudioPostEvent_SystemUiForXBOX(soundData._audioIndex, soundData._audioIndexB)
    end
  end
end
function NakMessageRenewel_SendChatMessage(string)
  if string == nil then
    return
  end
  chatting_sendMessage("", string, CppEnums.ChatType.System)
end
function NakMessageRenewel_SendChat(nakMessageData, mainStr, subStr)
  if nakMessageData:getMainTextSendChat() == true and nakMessageData:getSubTextSendChat() == true then
    NakMessageRenewel_SendChatMessage(mainStr .. " " .. subStr)
  else
    if nakMessageData:getMainTextSendChat() == true then
      NakMessageRenewel_SendChatMessage(mainStr)
    end
    if nakMessageData:getSubTextSendChat() == true then
      NakMessageRenewel_SendChatMessage(subStr)
    end
  end
end
function NakMessageRenewel_SetDefaultShow()
  Panel_NakMessage_Renewel:SetShow(false)
  NakRenewel._ui._static_MainBg:SetShow(false)
  NakRenewel._ui._static_SubBg:SetShow(false)
  NakRenewel._ui._static_EffectBg:SetShow(false)
  NakRenewel._ui._static_EffectBg:EraseAllEffect()
  NakRenewel._ui._static_MainText:SetShow(false)
  NakRenewel._ui._static_SubText:SetShow(false)
  NakRenewel._ui._stc_leftNPC:SetShow(false)
  NakRenewel._ui._txt_leftNPCMessage:SetShow(false)
  NakRenewel._ui._stc_leftNPCIcon:SetShow(false)
  NakRenewel._ui._stc_rightNPC:SetShow(false)
  NakRenewel._ui._txt_rightNPCMessage:SetShow(false)
  NakRenewel._ui._stc_rightNPCIcon:SetShow(false)
  NakRenewel._ui._stc_itemIcon:SetShow(false)
  NakRenewel._ui._stc_itemGrade:SetShow(false)
  NakRenewel._ui._stc_knowledgeLevel:SetShow(false)
end
function NakMessageRenewel_SetItemIcon(nakIconData)
  if NakRenewel._ui._stc_itemIcon == nil then
    return
  end
  if nakIconData._iconPath == nil then
    NakRenewel._ui._stc_itemIcon:SetShow(false)
    return
  end
  if nakIconData._iconPath ~= "" then
    NakRenewel._ui._stc_itemIcon:ChangeTextureInfoNameAsync(nakIconData._iconPath)
    local x1, y1, x2, y2 = setTextureUV_Func(NakRenewel._ui._stc_itemIcon, nakIconData._iconUV.x, nakIconData._iconUV.y, nakIconData._iconUV.z, nakIconData._iconUV.w)
    NakRenewel._ui._stc_itemIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    NakRenewel._ui._stc_itemIcon:setRenderTexture(NakRenewel._ui._stc_itemIcon:getBaseTexture())
    NakRenewel._ui._stc_itemIcon:SetSize(nakIconData._iconSize.x, nakIconData._iconSize.y)
    NakRenewel._ui._stc_itemIcon:SetShow(true)
    if nakIconData._itemGrade >= __eItemGradeNormal and nakIconData._itemGrade < __eItemGradeTemp then
      local itemBorderData = NakRenewel._ui._itemGradeBorderData[nakIconData._itemGrade]
      NakRenewel._ui._stc_itemGrade:ChangeTextureInfoNameAsync(itemBorderData.texture)
      x1, y1, x2, y2 = setTextureUV_Func(NakRenewel._ui._stc_itemGrade, itemBorderData.x1, itemBorderData.y1, itemBorderData.x2, itemBorderData.y2)
      NakRenewel._ui._stc_itemGrade:getBaseTexture():setUV(x1, y1, x2, y2)
      NakRenewel._ui._stc_itemGrade:setRenderTexture(NakRenewel._ui._stc_itemGrade:getBaseTexture())
      NakRenewel._ui._stc_itemGrade:SetShow(true)
    else
      NakRenewel._ui._stc_itemGrade:ReleaseTexture()
      NakRenewel._ui._stc_itemGrade:ChangeTextureInfoNameAsync("")
    end
  else
    NakRenewel._ui._stc_itemIcon:SetShow(false)
  end
  NakRenewel._ui._stc_itemIcon:SetSpanSize(NakRenewel._ui._stc_itemIcon:GetSpanSize().x, NakRenewel._itemIconOriginSpanSizeY + nakIconData._spanY)
  NakRenewel._ui._stc_itemIcon:ComputePos()
  NakRenewel._ui._stc_itemGrade:SetSize(nakIconData._iconSize.x + 1.5, nakIconData._iconSize.y + 1.5)
  NakRenewel._ui._stc_itemGrade:SetSpanSize(NakRenewel._ui._stc_itemIcon:GetSpanSize().x + 1, NakRenewel._ui._stc_itemIcon:GetSpanSize().y + 1)
  NakRenewel._ui._stc_itemGrade:ComputePos()
end
function NakMessageRenewel_Animation()
  local aniInfo = Panel_NakMessage_Renewel:addColorAnimation(0, 0.25, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
  local aniInfo2 = Panel_NakMessage_Renewel:addColorAnimation(NakRenewel._animationEndTime - 0.15, NakRenewel._animationEndTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo2.IsChangeChild = true
end
function NakMessageRenewel_NpcPerfomanceNakSetting(playerName)
  if Panel_NakMessage_Renewel == nil then
    return
  end
  local npcMessageData
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  NakRenewel._npcMessageIndex = 1
  local leftNpcBg = NakRenewel._ui._stc_leftNPC
  local leftNpcIcon = NakRenewel._ui._stc_leftNPCIcon
  local leftNpcMessage = NakRenewel._ui._txt_leftNPCMessage
  local rightNpcBg = NakRenewel._ui._stc_rightNPC
  local rightNpcIcon = NakRenewel._ui._stc_rightNPCIcon
  local rightNpcMessage = NakRenewel._ui._txt_rightNPCMessage
  if NakRenewel._currentNakType == __eNakMessage_RichMerchantRing then
    NakRenewel._ui._static_SubText:SetShow(false)
    if PaGlobal_RewardSelect_RichMerchantRing_CheckLanguage() == true then
      leftNpcMessage:SetSize(590, leftNpcMessage:GetSizeY())
      rightNpcMessage:SetSize(590, rightNpcMessage:GetSizeY())
      leftNpcMessage:ComputePos()
      rightNpcMessage:ComputePos()
    end
    npcMessageData = NakRenewel._npcMessage[__eNakMessage_RichMerchantRing]
    if npcMessageData ~= nil then
      npcMessageData.message = {
        [1] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SHAKATU_MSG_1"),
        [2] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_FATRIGIO_MSG_1"),
        [3] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SHAKATU_MSG_2", "familyName", playerName),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_FATRIGIO_MSG_2_1") .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_FATRIGIO_MSG_2_2", "familyName", playerName),
        [5] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SHAKATU_MSG_3_1", "familyName", playerName) .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_SHAKATU_MSG_3_2"),
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_FATRIGIO_MSG_3_1") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_FATRIGIO_MSG_3_2")
      }
      npcMessageData.messageCount = 6
    end
    leftNpcIcon:ChangeTextureInfoTextureIDAsync("Combine_ETC_Nak_MerchantRing_NPC_1")
    leftNpcIcon:setRenderTexture(leftNpcIcon:getBaseTexture())
    leftNpcIcon:SetSize(170, 265)
    leftNpcIcon:SetPosX(0)
    leftNpcMessage:SetPosX(95)
    rightNpcIcon:ChangeTextureInfoTextureIDAsync("Combine_ETC_Nak_MerchantRing_NPC_2")
    rightNpcIcon:setRenderTexture(rightNpcIcon:getBaseTexture())
    rightNpcIcon:SetSize(250, 265)
    rightNpcMessage:SetPosX(-525)
    NakRenewel._elapsedMessageTime = 5.4
  elseif NakRenewel._currentNakType == __eNakMessage_PanOkSeonPersonal then
    npcMessageData = NakRenewel._npcMessage[__eNakMessage_PanOkSeonPersonal]
    if npcMessageData ~= nil then
      npcMessageData.message = {
        [1] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_GOO_MSG_1", "playerName", playerName),
        [2] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_MYO_MSG_1", "playerName", playerName),
        [3] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_GOO_MSG_2"),
        [4] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_MYO_MSG_2"),
        [5] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_GOO_MSG_3"),
        [6] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_MYO_MSG_3")
      }
      npcMessageData.messageCount = 6
    end
    leftNpcIcon:ChangeTextureInfoTextureIDAsync("Combine_ETC_Nak_Panokseon_NPC_1")
    leftNpcIcon:setRenderTexture(leftNpcIcon:getBaseTexture())
    leftNpcIcon:SetSize(270, 265)
    leftNpcIcon:SetPosX(-100)
    leftNpcMessage:SetPosX(40)
    rightNpcIcon:ChangeTextureInfoTextureIDAsync("Combine_ETC_Nak_Panokseon_NPC_2")
    rightNpcIcon:setRenderTexture(rightNpcIcon:getBaseTexture())
    rightNpcIcon:SetSize(210, 315)
    rightNpcMessage:SetPosX(-465)
    NakRenewel._elapsedMessageTime = 5
  else
    return
  end
  NakRenewel._totalMessageTime = NakRenewel._npcMessageTime * npcMessageData.messageCount + NakRenewel._npcShowTime * 2 + 0.5
  NakRenewel._animationEndTime = NakRenewel._totalMessageTime
  NakRenewel._elapsedTotalMessageTime = 0
  rightNpcIcon:ComputePos()
  leftNpcBg:ComputePos()
  rightNpcBg:ComputePos()
  leftNpcBg:SetShow(true)
  rightNpcBg:SetShow(true)
end
function NakMessageRenewel_Update(updateTime)
  if NakRenewel._currentNakType == __eNakMessage_RichMerchantRing or NakRenewel._currentNakType == __eNakMessage_PanOkSeonPersonal then
    NakMessageRenewel_ShowNPCMessage(updateTime)
  end
end
function NakMessageRenewel_ShowNPCMessage(deltaTime)
  local npcMessageData = NakRenewel._npcMessage[NakRenewel._currentNakType]
  if npcMessageData == nil then
    return
  end
  local leftNpcIcon = NakRenewel._ui._stc_leftNPCIcon
  local rightNpcIcon = NakRenewel._ui._stc_rightNPCIcon
  NakRenewel._elapsedTotalMessageTime = NakRenewel._elapsedTotalMessageTime + deltaTime
  if NakRenewel._elapsedTotalMessageTime < NakRenewel._totalMessageTime then
    local npcMessageCount = npcMessageData.messageCount
    NakRenewel._elapsedMessageTime = NakRenewel._elapsedMessageTime + deltaTime
    if NakRenewel._npcMessageTime + NakRenewel._npcShowTime < NakRenewel._elapsedMessageTime then
      if npcMessageCount < NakRenewel._npcMessageIndex then
        return
      end
      if NakRenewel._npcMessageIndex == 1 then
        if leftNpcIcon ~= nil then
          leftNpcIcon:SetShow(true)
          local showAni = leftNpcIcon:addColorAnimation(0, NakRenewel._npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
          showAni:SetStartColor(Defines.Color.C_00FFFFFF)
          showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
          local moveAni = leftNpcIcon:addMoveAnimation(0, NakRenewel._npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
          moveAni:SetStartPosition(leftNpcIcon:GetPosX() + 20, leftNpcIcon:GetPosY())
          moveAni:SetEndPosition(leftNpcIcon:GetPosX(), leftNpcIcon:GetPosY())
        end
      elseif NakRenewel._npcMessageIndex == 2 and rightNpcIcon ~= nil then
        rightNpcIcon:SetShow(true)
        local showAni = rightNpcIcon:addColorAnimation(0, NakRenewel._npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
        showAni:SetStartColor(Defines.Color.C_00FFFFFF)
        showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
        local moveAni = rightNpcIcon:addMoveAnimation(0, NakRenewel._npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
        moveAni:SetStartPosition(rightNpcIcon:GetPosX() - 20, rightNpcIcon:GetPosY())
        moveAni:SetEndPosition(rightNpcIcon:GetPosX(), rightNpcIcon:GetPosY())
      end
      if NakRenewel._npcMessageIndex >= 3 then
        NakRenewel._npcShowTime = 0
      end
      local messageControl = NakRenewel._ui._txt_leftNPCMessage
      local startPosX = messageControl:GetPosX()
      if NakRenewel._npcMessageIndex % 2 == 1 then
        messageControl = NakRenewel._ui._txt_leftNPCMessage
        startPosX = messageControl:GetPosX() - 20
      else
        messageControl = NakRenewel._ui._txt_rightNPCMessage
        startPosX = messageControl:GetPosX() + 20
      end
      local string = npcMessageData.message[NakRenewel._npcMessageIndex]
      if messageControl ~= nil and string ~= nil then
        messageControl:SetTextMode(__eTextMode_AutoWrap)
        messageControl:SetText(string)
        messageControl:SetShow(true)
        if NakRenewel._npcShowTime ~= 0 then
          local showAni = messageControl:addColorAnimation(0, NakRenewel._npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
          showAni:SetStartColor(Defines.Color.C_00FFFFFF)
          showAni:SetEndColor(Defines.Color.C_00FFFFFF)
          luaTimer_AddEvent(NakMessageRenewel_RichMerchantRing_AudioEvent, NakRenewel._npcShowTime * 1000, false, 0)
        else
          NakMessageRenewel_RichMerchantRing_AudioEvent()
        end
        local showAni = messageControl:addColorAnimation(0 + NakRenewel._npcShowTime, 0.25 + NakRenewel._npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
        showAni:SetStartColor(Defines.Color.C_00FFFFFF)
        showAni:SetEndColor(Defines.Color.C_FFFFFFFF)
        local moveAni = messageControl:addMoveAnimation(0 + NakRenewel._npcShowTime, 0.4 + NakRenewel._npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
        moveAni:SetStartPosition(startPosX, messageControl:GetPosY())
        moveAni:SetEndPosition(messageControl:GetPosX(), messageControl:GetPosY())
        local hideAni = messageControl:addColorAnimation(NakRenewel._npcMessageTime - 0.25 + NakRenewel._npcShowTime, NakRenewel._npcMessageTime + NakRenewel._npcShowTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
        hideAni:SetStartColor(Defines.Color.C_FFFFFFFF)
        hideAni:SetEndColor(Defines.Color.C_00FFFFFF)
        hideAni:SetHideAtEnd(true)
      end
      NakRenewel._elapsedMessageTime = 0
      NakRenewel._npcMessageIndex = NakRenewel._npcMessageIndex + 1
    end
  else
    NakRenewel._currentNakType = -1
    NakRenewel._npcMessageIndex = 1
    NakRenewel._npcShowTime = 0.4
    NakRenewel._elapsedTotalMessageTime = 0
    NakRenewel._elapsedMessageTime = NakRenewel._npcMessageTime + NakRenewel._npcShowTime
    Panel_NakMessage_Renewel:SetShow(false)
    NakRenewel._ui._static_EffectBg:SetShow(false)
    NakRenewel._ui._static_EffectBg:EraseAllEffect()
  end
end
function NakMessageRenewel_RichMerchantRing_AudioEvent()
  if NakRenewel._currentNakType ~= __eNakMessage_RichMerchantRing then
    return
  end
  audioPostEvent_SystemUi(1, 49)
  _AudioPostEvent_SystemUiForXBOX(1, 49)
end
function FromClient_NakMessageRenewelInit()
  NakMessageRenewel_initialize()
end
Panel_NakMessage_Renewel:RegisterUpdateFunc("NakMessageRenewel_Update")
registerEvent("FromClient_NakMessageRenewelClear", "FromClient_NakMessageRenewelClear")
registerEvent("FromClient_NakMessageRenewelRequest", "FromClient_NakMessageRenewelRequest")
registerEvent("FromClient_luaLoadComplete", "FromClient_NakMessageRenewelInit")
function PaGlobal_RewardSelect_RichMerchantRing_CheckLanguage()
  local languageType = ToClient_getResourceType()
  local needChange = languageType == CppEnums.ServiceResourceType.eServiceResourceType_EN or languageType == CppEnums.ServiceResourceType.eServiceResourceType_DE or languageType == CppEnums.ServiceResourceType.eServiceResourceType_FR or languageType == CppEnums.ServiceResourceType.eServiceResourceType_ES or languageType == CppEnums.ServiceResourceType.eServiceResourceType_SP
  return needChange
end
