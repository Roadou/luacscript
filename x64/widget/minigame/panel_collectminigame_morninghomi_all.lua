_eTileState = {
  FLOWER = 0,
  TILE1 = 1,
  TILE2 = 2,
  TILE3 = 3,
  SHALLOWGROUND = 4,
  DEEPGROUND = 5,
  SHALLOWROOT = 6,
  DEEPROOT = 7,
  COUNT = 8
}
PaGlobal_MiniGame_MorningHomi_All = {
  _ui = {
    _txt_resurtBG = nil,
    _stc_success = nil,
    _stc_fail = nil,
    _stc_fieldBG = nil,
    _stc_leftFieldBG = nil,
    _stc_rightFieldBG = nil,
    _stc_leftField = nil,
    _stc_rightField = nil,
    _stc_leftplant = nil,
    _stc_right_plant = nil,
    _stc_left_flower = nil,
    _stc_right_flower = nil,
    _stc_currentPoint = nil,
    _stc_left_tile = nil,
    _stc_right_tile = nil,
    _stc_howTo = nil,
    _stc_progressBG = nil,
    _stc_leftTimeBar = nil,
    _txt_leftTime = nil,
    _txt_desc = nil,
    _stc_purpose = nil,
    _txt_purpose = nil
  },
  _curPrevTime = 0,
  _maxPrevTime = 5,
  _curGameTime = 0,
  _maxGameTime = 25,
  _curResultTime = 0,
  _maxResultTime = 0.6,
  _eGameState = {
    PREV = 0,
    GAME = 1,
    RESULT = 2,
    END = 3
  },
  _state = 0,
  _result = 0,
  _maxTileCount = 6,
  _minRootCount = 4,
  _maxRootCount = 5,
  _eRootAngle = {
    LEFTDOWN = 1,
    DOWN = 2,
    RIGHTDOWN = 3,
    RIGHT = 4,
    RIGHTUP = 5,
    UP = 6,
    LEFTUP = 7,
    LEFT = 8,
    COUNT = 9
  },
  _eRoute = {
    [0] = {
      _route = {
        _eTileState.FLOWER,
        _eTileState.FLOWER,
        _eTileState.FLOWER
      },
      _index = 1
    },
    [1] = {
      _route = {
        _eTileState.TILE1,
        _eTileState.SHALLOWGROUND,
        _eTileState.DEEPGROUND
      },
      _index = 1
    },
    [2] = {
      _route = {
        _eTileState.TILE2,
        _eTileState.SHALLOWGROUND,
        _eTileState.DEEPGROUND
      },
      _index = 1
    },
    [3] = {
      _route = {
        _eTileState.TILE3,
        _eTileState.SHALLOWGROUND,
        _eTileState.DEEPGROUND
      },
      _index = 1
    },
    [4] = {
      _route = {
        _eTileState.TILE1,
        _eTileState.SHALLOWGROUND,
        _eTileState.DEEPROOT
      },
      _index = 1
    },
    [5] = {
      _route = {
        _eTileState.TILE1,
        _eTileState.SHALLOWROOT,
        _eTileState.DEEPGROUND
      },
      _index = 1
    },
    [6] = {
      _route = {
        _eTileState.TILE2,
        _eTileState.SHALLOWGROUND,
        _eTileState.DEEPROOT
      },
      _index = 1
    },
    [7] = {
      _route = {
        _eTileState.TILE2,
        _eTileState.SHALLOWROOT,
        _eTileState.DEEPGROUND
      },
      _index = 1
    },
    [8] = {
      _route = {
        _eTileState.TILE3,
        _eTileState.SHALLOWGROUND,
        _eTileState.DEEPROOT
      },
      _index = 1
    },
    [9] = {
      _route = {
        _eTileState.TILE3,
        _eTileState.SHALLOWROOT,
        _eTileState.DEEPGROUND
      },
      _index = 1
    }
  },
  _curPosition = {x = 0, y = 0},
  _baseCurPointPos = {x = 0, y = 0},
  _baseCurPointSize = {x = 0, y = 0},
  _curPointGapSize = 13,
  _tileMatrix = {},
  _eFieldState = {LEFT = 0, RIGHT = 1},
  _flowerSize = 2,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_MorningHomi_All_Init")
function FromClient_MiniGame_MorningHomi_All_Init()
  PaGlobal_MiniGame_MorningHomi_All:initialize()
end
function PaGlobal_MiniGame_MorningHomi_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._txt_resurtBG = UI.getChildControl(Panel_MiniGame_MorningHomi_All, "StaticText_Resurt_BG")
  self._ui._stc_success = UI.getChildControl(self._ui._txt_resurtBG, "Static_Success")
  self._ui._stc_fail = UI.getChildControl(self._ui._txt_resurtBG, "Static_Fail")
  self._ui._stc_fieldBG = UI.getChildControl(Panel_MiniGame_MorningHomi_All, "Static_FieldBg")
  self._ui._stc_leftFieldBG = UI.getChildControl(self._ui._stc_fieldBG, "Static_LeftFieldBG")
  self._ui._stc_rightFieldBG = UI.getChildControl(self._ui._stc_fieldBG, "Static_RightFieldBG")
  self._ui._stc_leftField = UI.getChildControl(self._ui._stc_leftFieldBG, "Static_LeftField")
  self._ui._stc_rightField = UI.getChildControl(self._ui._stc_rightFieldBG, "Static_RightField")
  self._ui._stc_left_plant = UI.getChildControl(self._ui._stc_leftField, "Static_Plant")
  self._ui._stc_left_flower = UI.getChildControl(self._ui._stc_leftField, "Static_Flower")
  self._ui._stc_left_tile = UI.getChildControl(self._ui._stc_leftField, "Static_Tile1_Template")
  self._ui._stc_currentPoint = UI.getChildControl(self._ui._stc_rightField, "Static_CurrentPoint")
  self._ui._stc_right_plant = UI.getChildControl(self._ui._stc_rightField, "Static_Plant")
  self._ui._stc_right_flower = UI.getChildControl(self._ui._stc_rightField, "Static_Flower")
  self._ui._stc_right_tile = UI.getChildControl(self._ui._stc_rightField, "Static_Tile1_Template")
  self._ui._stc_howTo = UI.getChildControl(Panel_MiniGame_MorningHomi_All, "Static_HowTo")
  self._ui._stc_progressBG = UI.getChildControl(self._ui._stc_howTo, "Static_ProgressBg")
  self._ui._stc_leftTimeBar = UI.getChildControl(self._ui._stc_progressBG, "Progress2_LeftTime")
  self._ui._txt_leftTime = UI.getChildControl(self._ui._stc_howTo, "StaticText_LeftTime")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_howTo, "StaticText_Desc")
  self._ui._stc_purpose = UI.getChildControl(Panel_MiniGame_MorningHomi_All, "Static_Purpose")
  self._ui._txt_purpose = UI.getChildControl(self._ui._stc_purpose, "StaticText_Purpose")
  self:registEventHandler()
  self:validate()
  self:createTileTemplate()
  self._initialize = true
end
function PaGlobal_MiniGame_MorningHomi_All:validate()
  if Panel_MiniGame_MorningHomi_All == nil then
    return
  end
  self._ui._txt_resurtBG:isValidate()
  self._ui._stc_success:isValidate()
  self._ui._stc_fail:isValidate()
  self._ui._stc_fieldBG:isValidate()
  self._ui._stc_leftField:isValidate()
  self._ui._stc_rightField:isValidate()
  self._ui._stc_left_plant:isValidate()
  self._ui._stc_left_flower:isValidate()
  self._ui._stc_left_tile:isValidate()
  self._ui._stc_currentPoint:isValidate()
  self._ui._stc_right_plant:isValidate()
  self._ui._stc_right_flower:isValidate()
  self._ui._stc_right_tile:isValidate()
  self._ui._stc_howTo:isValidate()
  self._ui._stc_progressBG:isValidate()
  self._ui._stc_leftTimeBar:isValidate()
  self._ui._txt_leftTime:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._stc_purpose:isValidate()
  self._ui._txt_purpose:isValidate()
end
function PaGlobal_MiniGame_MorningHomi_All:registEventHandler()
  if Panel_MiniGame_MorningHomi_All == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_MiniGame_MorningHomi_All_ResizePanel")
  Panel_MiniGame_MorningHomi_All:RegisterShowEventFunc(false, "PaGlobalFunc_CollectMiniGame_SetHideAnim(" .. __eCollectToolType_Hoe .. ")")
  self._baseCurPointPos.x = self._ui._stc_currentPoint:GetPosX()
  self._baseCurPointPos.y = self._ui._stc_currentPoint:GetPosY()
  self._baseCurPointSize.x = self._ui._stc_currentPoint:GetSizeX()
  self._baseCurPointSize.y = self._ui._stc_currentPoint:GetSizeY()
  local left_currentPoint = UI.getChildControl(self._ui._stc_leftField, "Static_CurrentPoint")
  left_currentPoint:SetShow(false)
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  if self._isConsole == true then
    self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
  end
  self._ui._txt_purpose:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_HOMI_PURPOSE"))
end
function PaGlobal_MiniGame_MorningHomi_All:prepareOpen()
  if Panel_MiniGame_MorningHomi_All == nil then
    return
  end
  PaGlobalFunc_CollectMiniGame_Start()
  self:clear()
  self:createLeftField()
  if self._isConsole == false then
    self:setActionKeyText()
  end
  Panel_MiniGame_MorningHomi_All:RegisterUpdateFunc("PaGlobal_MiniGame_MorningHomi_All_Update")
  self:open()
end
function PaGlobal_MiniGame_MorningHomi_All:open()
  if Panel_MiniGame_MorningHomi_All == nil then
    return
  end
  Panel_MiniGame_MorningHomi_All:SetShow(true)
end
function PaGlobal_MiniGame_MorningHomi_All:prepareClose()
  if Panel_MiniGame_MorningHomi_All == nil then
    return
  end
  PaGlobalFunc_CollectMiniGame_End()
  self._state = self._eGameState.PREV
  Panel_MiniGame_MorningHomi_All:EraseAllEffect()
  Panel_MiniGame_MorningHomi_All:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_MiniGame_MorningHomi_All:close()
  if Panel_MiniGame_MorningHomi_All == nil then
    return
  end
  Panel_MiniGame_MorningHomi_All:SetShow(false, true)
end
function PaGlobal_MiniGame_MorningHomi_All:clear()
  if Panel_MiniGame_MorningHomi_All == nil then
    return
  end
  Panel_MiniGame_MorningHomi_All:EraseAllEffect()
  Panel_MiniGame_MorningHomi_All:ClearUpdateLuaFunc()
  self._state = self._eGameState.PREV
  self._curGameTime = self._maxGameTime
  self._curPrevTime = self._maxPrevTime
  self._curResultTime = 0
  self._result = __eCollectMiniGameState_Fail
  self._ui._txt_resurtBG:SetShow(false)
  self._ui._stc_success:SetShow(false)
  self._ui._stc_fail:SetShow(false)
  self._ui._stc_success:EraseAllEffect()
  self._ui._stc_fail:EraseAllEffect()
  self._ui._stc_leftTimeBar:SetSmoothMode(false)
  self._ui._stc_leftTimeBar:SetProgressRate(1)
  self._ui._stc_leftTimeBar:SetSmoothMode(true)
  self._ui._stc_purpose:SetShow(true)
  self._curPosition = {x = 0, y = 0}
  self._ui._stc_currentPoint:SetPosX(self._baseCurPointPos.x + self._curPosition.x * self._baseCurPointSize.x - self._curPosition.x * self._curPointGapSize)
  self._ui._stc_currentPoint:SetPosY(self._baseCurPointPos.y + self._curPosition.y * self._baseCurPointSize.y - self._curPosition.y * self._curPointGapSize)
  self._ui._stc_currentPoint:SetShow(false)
  self:gameEndAnimTile()
  self._ui._stc_leftFieldBG:SetShow(true)
  self._ui._stc_rightFieldBG:SetShow(false)
  self._ui._stc_howTo:SetPosY(self._ui._stc_fieldBG:GetPosY() + self._ui._stc_fieldBG:GetSizeY() + self._ui._txt_desc:GetTextSizeY())
end
function PaGlobal_MiniGame_MorningHomi_All:createTileTemplate()
  local width = self._ui._stc_left_tile:GetSizeX()
  local height = self._ui._stc_left_tile:GetSizeY()
  local gap = 5
  local leftRowList = {}
  for row = 0, self._maxTileCount - 1 do
    local colList = {}
    for col = 0, self._maxTileCount - 1 do
      local tileList = {}
      for tileIndex = 0, 1 do
        tileList[tileIndex] = UI.cloneControl(self._ui._stc_left_tile, self._ui._stc_leftField, "Static_MiniGame_Homi_Tile_" .. tostring(row) .. "_" .. tostring(col) .. "_" .. tostring(tileIndex))
        tileList[tileIndex]:SetPosXY(gap * (row + 1) + width * row, gap * (col + 1) + height * col)
      end
      tileIndex[2] = {}
      tileIndex[3] = self._eRootAngle.COUNT
      colList[col] = tileList
    end
    leftRowList[row] = colList
  end
  self._tileMatrix[self._eFieldState.LEFT] = leftRowList
  local rightRowList = {}
  for row = 0, self._maxTileCount - 1 do
    local colList = {}
    for col = 0, self._maxTileCount - 1 do
      local tileList = {}
      for tileIndex = 0, 1 do
        tileList[tileIndex] = UI.cloneControl(self._ui._stc_right_tile, self._ui._stc_rightField, "Static_MiniGame_Homi_Tile_" .. tostring(row) .. "_" .. tostring(col) .. "_" .. tostring(tileIndex))
        tileList[tileIndex]:SetPosXY(gap * (row + 1) + width * row, gap * (col + 1) + height * col)
      end
      tileIndex[2] = {}
      tileIndex[3] = self._eRootAngle.COUNT
      colList[col] = tileList
    end
    rightRowList[row] = colList
  end
  self._tileMatrix[self._eFieldState.RIGHT] = rightRowList
  self._ui._stc_left_tile:SetShow(false)
  self._ui._stc_right_tile:SetShow(false)
end
function PaGlobal_MiniGame_MorningHomi_All:createLeftField()
  local plantX = math.random(0, self._maxTileCount - self._flowerSize)
  local plantY = math.random(0, self._maxTileCount - self._flowerSize)
  if plantX == 2 and plantY == 2 then
    plantX = 1
    plantY = 3
  end
  local invalidFlowerPosX1 = plantX - self._flowerSize
  local invalidFlowerPosX2 = plantX + self._flowerSize
  local invalidFlowerPosY1 = plantY - self._flowerSize
  local invalidFlowerPosY2 = plantY + self._flowerSize
  if invalidFlowerPosX1 < 0 then
    invalidFlowerPosX1 = 0
  end
  if invalidFlowerPosY1 < 0 then
    invalidFlowerPosY1 = 0
  end
  if invalidFlowerPosX2 > self._maxTileCount then
    invalidFlowerPosX2 = self._maxTileCount
  end
  if invalidFlowerPosY2 > self._maxTileCount then
    invalidFlowerPosY2 = self._maxTileCount
  end
  local possibleFlowerPosList = {}
  for row = self._maxTileCount, 0, -1 do
    for col = self._maxTileCount, 0, -1 do
      if row >= invalidFlowerPosX1 and row <= invalidFlowerPosX2 and col >= invalidFlowerPosY1 and col <= invalidFlowerPosY2 or row >= self._maxTileCount - 1 or col >= self._maxTileCount - 1 then
      else
        table.insert(possibleFlowerPosList, (self._maxTileCount + 1) * row + col)
      end
    end
  end
  local randomNumber = math.random(1, #possibleFlowerPosList)
  local flowerPos = possibleFlowerPosList[randomNumber]
  local flowerPosX = math.floor(flowerPos / (self._maxTileCount + 1))
  local flowerPosY = flowerPos - (self._maxTileCount + 1) * flowerPosX
  local width = self._ui._stc_left_tile:GetSizeX()
  local height = self._ui._stc_left_tile:GetSizeY()
  local gap = 5
  self._ui._stc_left_plant:SetPosXY(gap * (plantX + 1) + width * plantX, gap * (plantY + 1) + height * plantY)
  self._ui._stc_left_flower:SetPosXY(gap * (flowerPosX + 1) + width * flowerPosX, gap * (flowerPosY + 1) + height * flowerPosY)
  self._ui._stc_right_plant:SetPosXY(gap * (plantX + 1) + width * plantX, gap * (plantY + 1) + height * plantY)
  self._ui._stc_right_flower:SetPosXY(gap * (flowerPosX + 1) + width * flowerPosX, gap * (flowerPosY + 1) + height * flowerPosY)
  local rootCount = 0
  local stageRootCount = math.random(self._minRootCount, self._maxRootCount)
  local rootIndexList = {}
  for row = 0, self._maxTileCount - 1 do
    for col = 0, self._maxTileCount - 1 do
      if row >= plantX and row <= plantX + 1 and col >= plantY and col <= plantY + 1 or row >= flowerPosX and row <= flowerPosX + 1 and col >= flowerPosY and col <= flowerPosY + 1 then
      elseif row >= plantX - 1 and row <= plantX + self._flowerSize and col >= plantY - 1 and col <= plantY + self._flowerSize or row >= flowerPosX - 1 and row <= flowerPosX + self._flowerSize and col >= flowerPosY - 1 and col <= flowerPosY + self._flowerSize then
        rootCount = rootCount + 1
        rootIndexList[rootCount] = col + row * self._maxTileCount
      end
    end
  end
  for ii = 1, rootCount do
    local rand = math.random(1, rootCount)
    if ii ~= rand then
      local tmp = rootIndexList[ii]
      rootIndexList[ii] = rootIndexList[rand]
      rootIndexList[rand] = tmp
    end
  end
  for row = 0, self._maxTileCount - 1 do
    for col = 0, self._maxTileCount - 1 do
      local leftTileInfo = self._tileMatrix[self._eFieldState.LEFT][row][col]
      local rightTileInfo = self._tileMatrix[self._eFieldState.RIGHT][row][col]
      leftTileInfo[2] = {}
      rightTileInfo[2] = {}
      leftTileInfo[3] = self._eRootAngle.COUNT
      rightTileInfo[3] = self._eRootAngle.COUNT
      if row >= plantX and row <= plantX + 1 and col >= plantY and col <= plantY + 1 then
        leftTileInfo[2] = self:copyRoute(0)
        rightTileInfo[2] = self:copyRoute(0)
      elseif row >= flowerPosX and row <= flowerPosX + 1 and col >= flowerPosY and col <= flowerPosY + 1 then
        leftTileInfo[2] = self:copyRoute(0)
        rightTileInfo[2] = self:copyRoute(0)
      elseif row >= plantX - 1 and row <= plantX + self._flowerSize and col >= plantY - 1 and col <= plantY + self._flowerSize then
        local isRoot = false
        local rootIndex = col + row * self._maxTileCount
        for ii = 1, stageRootCount do
          if rootIndexList[ii] ~= nil and rootIndexList[ii] == rootIndex then
            isRoot = true
            break
          end
        end
        if isRoot == false then
          local tileState = math.random(_eTileState.TILE1, _eTileState.TILE3)
          leftTileInfo[2] = self:copyRoute(tileState)
          rightTileInfo[2] = self:copyRoute(tileState)
        else
          local tileState = math.random(_eTileState.TILE1, _eTileState.TILE3)
          local isShallowRoot = math.random(_eTileState.SHALLOWROOT, _eTileState.DEEPROOT)
          if tileState == _eTileState.TILE1 then
            if isShallowRoot == _eTileState.DEEPROOT then
              leftTileInfo[2] = self:copyRoute(4)
              leftTileInfo[2]._index = 3
              rightTileInfo[2] = self:copyRoute(4)
              rightTileInfo[2]._index = 1
            elseif isShallowRoot == _eTileState.SHALLOWROOT then
              leftTileInfo[2] = self:copyRoute(5)
              leftTileInfo[2]._index = 2
              rightTileInfo[2] = self:copyRoute(5)
              rightTileInfo[2]._index = 1
            end
          elseif tileState == _eTileState.TILE2 then
            if isShallowRoot == _eTileState.DEEPROOT then
              leftTileInfo[2] = self:copyRoute(6)
              leftTileInfo[2]._index = 3
              rightTileInfo[2] = self:copyRoute(6)
              rightTileInfo[2]._index = 1
            elseif isShallowRoot == _eTileState.SHALLOWROOT then
              leftTileInfo[2] = self:copyRoute(7)
              leftTileInfo[2]._index = 2
              rightTileInfo[2] = self:copyRoute(7)
              rightTileInfo[2]._index = 1
            end
          elseif tileState == _eTileState.TILE3 then
            if isShallowRoot == _eTileState.DEEPROOT then
              leftTileInfo[2] = self:copyRoute(8)
              leftTileInfo[2]._index = 3
              rightTileInfo[2] = self:copyRoute(8)
              rightTileInfo[2]._index = 1
            elseif isShallowRoot == _eTileState.SHALLOWROOT then
              leftTileInfo[2] = self:copyRoute(9)
              leftTileInfo[2]._index = 2
              rightTileInfo[2] = self:copyRoute(9)
              rightTileInfo[2]._index = 1
            end
          end
          leftTileInfo[3] = self:setRootAngle(plantX, plantY, row, col)
          rightTileInfo[3] = self:setRootAngle(plantX, plantY, row, col)
        end
      elseif row >= flowerPosX - 1 and row <= flowerPosX + self._flowerSize and col >= flowerPosY - 1 and col <= flowerPosY + self._flowerSize then
        local isRoot = false
        local rootIndex = col + row * self._maxTileCount
        for ii = 1, stageRootCount do
          if rootIndexList[ii] ~= nil and rootIndexList[ii] == rootIndex then
            isRoot = true
            break
          end
        end
        if isRoot == false then
          local tileState = math.random(_eTileState.TILE1, _eTileState.TILE3)
          leftTileInfo[2] = self:copyRoute(tileState)
          rightTileInfo[2] = self:copyRoute(tileState)
        else
          local tileState = math.random(_eTileState.TILE1, _eTileState.TILE3)
          local isShallowRoot = math.random(_eTileState.SHALLOWROOT, _eTileState.DEEPROOT)
          if tileState == _eTileState.TILE1 then
            if isShallowRoot == _eTileState.DEEPROOT then
              leftTileInfo[2] = self:copyRoute(4)
              leftTileInfo[2]._index = 3
              rightTileInfo[2] = self:copyRoute(4)
              rightTileInfo[2]._index = 1
            elseif isShallowRoot == _eTileState.SHALLOWROOT then
              leftTileInfo[2] = self:copyRoute(5)
              leftTileInfo[2]._index = 2
              rightTileInfo[2] = self:copyRoute(5)
              rightTileInfo[2]._index = 1
            end
          elseif tileState == _eTileState.TILE2 then
            if isShallowRoot == _eTileState.DEEPROOT then
              leftTileInfo[2] = self:copyRoute(6)
              leftTileInfo[2]._index = 3
              rightTileInfo[2] = self:copyRoute(6)
              rightTileInfo[2]._index = 1
            elseif isShallowRoot == _eTileState.SHALLOWROOT then
              leftTileInfo[2] = self:copyRoute(7)
              leftTileInfo[2]._index = 2
              rightTileInfo[2] = self:copyRoute(7)
              rightTileInfo[2]._index = 1
            end
          elseif tileState == _eTileState.TILE3 then
            if isShallowRoot == _eTileState.DEEPROOT then
              leftTileInfo[2] = self:copyRoute(8)
              leftTileInfo[2]._index = 3
              rightTileInfo[2] = self:copyRoute(8)
              rightTileInfo[2]._index = 1
            elseif isShallowRoot == _eTileState.SHALLOWROOT then
              leftTileInfo[2] = self:copyRoute(9)
              leftTileInfo[2]._index = 2
              rightTileInfo[2] = self:copyRoute(9)
              rightTileInfo[2]._index = 1
            end
          end
          leftTileInfo[3] = self:setRootAngle(flowerPosX, flowerPosY, row, col)
          rightTileInfo[3] = self:setRootAngle(flowerPosX, flowerPosY, row, col)
        end
      else
        local isRock = math.random(1, 5)
        if isRock == 1 then
          leftTileInfo[2] = self:copyRoute(3)
          rightTileInfo[2] = self:copyRoute(3)
        else
          local tileState = math.random(_eTileState.TILE1, _eTileState.TILE2)
          leftTileInfo[2] = self:copyRoute(tileState)
          rightTileInfo[2] = self:copyRoute(tileState)
        end
      end
      self:changeTexture(self._eFieldState.LEFT, row, col)
      self:changeTexture(self._eFieldState.RIGHT, row, col)
    end
  end
end
function PaGlobal_MiniGame_MorningHomi_All:setActionKeyText()
  local actionKey_moveFront = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveFront)
  local actionKey_moveLeft = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveLeft)
  local actionKey_moveBack = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveBack)
  local actionKey_moveRight = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveRight)
  local actionKey_jump = keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Jump)
  local descText = PAGetStringParam5(Defines.StringSheet_RESOURCE, "PANEL_MINIGAME_HOMI_DESC_PC", "W", actionKey_moveFront, "A", actionKey_moveLeft, "S", actionKey_moveBack, "D", actionKey_moveRight, "Space", actionKey_jump)
  self._ui._txt_desc:SetText(descText)
end
function PaGlobal_MiniGame_MorningHomi_All:copyRoute(index)
  local route = {}
  route._route = self._eRoute[index]._route
  route._index = 1
  return route
end
function PaGlobal_MiniGame_MorningHomi_All:changeTexture(fieldState, row, col)
  local tileInfo = self._tileMatrix[fieldState][row][col]
  if tileInfo == nil then
    return
  end
  local control1 = tileInfo[0]
  local control2 = tileInfo[1]
  local tileIndex = tileInfo[2]._index
  local tileState = tileInfo[2]._route[tileIndex]
  local rootAngle = tileInfo[3]
  if control1 == nil or control2 == nil or tileState == nil then
    return
  end
  control1:ChangeTextureInfoNameAsync("combine/etc/combine_etc_minigame_09.dds")
  control2:ChangeTextureInfoNameAsync("combine/etc/combine_etc_minigame_09.dds")
  if tileState == _eTileState.FLOWER then
    local x1, y1, x2, y2 = setTextureUV_Func(control1, 66, 1, 130, 65)
    control1:getBaseTexture():setUV(x1, y1, x2, y2)
    control1:setRenderTexture(control1:getBaseTexture())
    control1:SetShow(true)
    control2:SetShow(false)
  elseif tileState == _eTileState.TILE1 then
    local x1, y1, x2, y2 = setTextureUV_Func(control1, 131, 1, 195, 65)
    control1:getBaseTexture():setUV(x1, y1, x2, y2)
    control1:setRenderTexture(control1:getBaseTexture())
    control1:SetShow(true)
    control2:SetShow(false)
  elseif tileState == _eTileState.TILE2 then
    local x1, y1, x2, y2 = setTextureUV_Func(control1, 196, 1, 260, 65)
    control1:getBaseTexture():setUV(x1, y1, x2, y2)
    control1:setRenderTexture(control1:getBaseTexture())
    control1:SetShow(true)
    control2:SetShow(false)
  elseif tileState == _eTileState.TILE3 then
    local x1, y1, x2, y2 = setTextureUV_Func(control1, 261, 1, 325, 65)
    control1:getBaseTexture():setUV(x1, y1, x2, y2)
    control1:setRenderTexture(control1:getBaseTexture())
    control1:SetShow(true)
    control2:SetShow(false)
  elseif tileState == _eTileState.SHALLOWGROUND then
    local x1, y1, x2, y2 = setTextureUV_Func(control1, 391, 1, 455, 65)
    control1:getBaseTexture():setUV(x1, y1, x2, y2)
    control1:setRenderTexture(control1:getBaseTexture())
    control1:SetShow(true)
    control2:SetShow(false)
  elseif tileState == _eTileState.DEEPGROUND then
    local x1, y1, x2, y2 = setTextureUV_Func(control1, 326, 1, 390, 65)
    control1:getBaseTexture():setUV(x1, y1, x2, y2)
    control1:setRenderTexture(control1:getBaseTexture())
    control1:SetShow(true)
    control2:SetShow(false)
  elseif tileState == _eTileState.SHALLOWROOT then
    local x1, y1, x2, y2 = setTextureUV_Func(control1, 391, 1, 455, 65)
    control1:getBaseTexture():setUV(x1, y1, x2, y2)
    control1:setRenderTexture(control1:getBaseTexture())
    control1:SetShow(true)
    local _x1, _y1, _x2, _y2
    if rootAngle == self._eRootAngle.LEFTDOWN then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 261, 274, 325, 338)
    elseif rootAngle == self._eRootAngle.DOWN then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 369, 131, 433, 195)
    elseif rootAngle == self._eRootAngle.RIGHTDOWN then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 261, 339, 325, 403)
    elseif rootAngle == self._eRootAngle.RIGHT then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 369, 66, 433, 130)
    elseif rootAngle == self._eRootAngle.RIGHTUP then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 326, 339, 390, 403)
    elseif rootAngle == self._eRootAngle.UP then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 304, 131, 368, 195)
    elseif rootAngle == self._eRootAngle.LEFTUP then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 326, 274, 390, 338)
    elseif rootAngle == self._eRootAngle.LEFT then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 304, 66, 368, 130)
    end
    control2:getBaseTexture():setUV(_x1, _y1, _x2, _y2)
    control2:setRenderTexture(control2:getBaseTexture())
    control2:SetShow(true)
    control2:AddEffect("fUI_PCM_Energy_01A", false, 0, 0)
  elseif tileState == _eTileState.DEEPROOT then
    local x1, y1, x2, y2 = setTextureUV_Func(control1, 326, 1, 390, 65)
    control1:SetShow(true)
    control1:getBaseTexture():setUV(x1, y1, x2, y2)
    control1:setRenderTexture(control1:getBaseTexture())
    local _x1, _y1, _x2, _y2
    if rootAngle == self._eRootAngle.LEFTDOWN then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 1, 404, 65, 468)
    elseif rootAngle == self._eRootAngle.DOWN then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 196, 339, 260, 403)
    elseif rootAngle == self._eRootAngle.RIGHTDOWN then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 131, 404, 195, 468)
    elseif rootAngle == self._eRootAngle.RIGHT then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 66, 339, 130, 403)
    elseif rootAngle == self._eRootAngle.RIGHTUP then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 196, 404, 260, 468)
    elseif rootAngle == self._eRootAngle.UP then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 131, 339, 195, 403)
    elseif rootAngle == self._eRootAngle.LEFTUP then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 66, 404, 130, 468)
    elseif rootAngle == self._eRootAngle.LEFT then
      _x1, _y1, _x2, _y2 = setTextureUV_Func(control2, 1, 339, 65, 403)
    end
    control2:getBaseTexture():setUV(_x1, _y1, _x2, _y2)
    control2:setRenderTexture(control2:getBaseTexture())
    control2:SetShow(true)
    control2:AddEffect("fUI_PCM_Energy_01A", false, 0, 0)
  else
    control1:SetShow(false)
    control2:SetShow(false)
  end
  if fieldState == self._eFieldState.RIGHT then
    self._ui._stc_rightField:SetChildIndex(control1, 100)
    self._ui._stc_rightField:SetChildIndex(control2, 9997)
  else
    self._ui._stc_leftField:SetChildIndex(control1, 100)
    self._ui._stc_leftField:SetChildIndex(control2, 9997)
  end
  self._ui._stc_leftField:SetChildIndex(self._ui._stc_left_plant, 9998)
  self._ui._stc_leftField:SetChildIndex(self._ui._stc_left_flower, 9998)
  self._ui._stc_rightField:SetChildIndex(self._ui._stc_right_plant, 9998)
  self._ui._stc_rightField:SetChildIndex(self._ui._stc_right_flower, 9998)
  self._ui._stc_rightField:SetChildIndex(self._ui._stc_currentPoint, 9999)
end
function PaGlobal_MiniGame_MorningHomi_All:changeRoute(row, col)
  local tileInfo = self._tileMatrix[self._eFieldState.RIGHT][row][col]
  if tileInfo == nil then
    return
  end
  tileInfo[2]._index = tileInfo[2]._index + 1
  if tileInfo[2]._index > 3 then
    tileInfo[2]._index = 1
  end
  self:changeTexture(self._eFieldState.RIGHT, row, col)
end
function PaGlobal_MiniGame_MorningHomi_All:checkField()
  for row = 0, self._maxTileCount - 1 do
    for col = 0, self._maxTileCount - 1 do
      local leftTileInfo = self._tileMatrix[self._eFieldState.LEFT][row][col]
      local rightTileInfo = self._tileMatrix[self._eFieldState.RIGHT][row][col]
      local leftTileIndex = leftTileInfo[2]._index
      local rightTileIndex = rightTileInfo[2]._index
      if leftTileIndex > 1 and leftTileInfo[2]._route[leftTileIndex] ~= rightTileInfo[2]._route[rightTileIndex] then
        return false
      end
    end
  end
  return true
end
function PaGlobal_MiniGame_MorningHomi_All:addEffectFailTile()
  for row = 0, self._maxTileCount - 1 do
    for col = 0, self._maxTileCount - 1 do
      local leftTileInfo = self._tileMatrix[self._eFieldState.LEFT][row][col]
      local rightTileInfo = self._tileMatrix[self._eFieldState.RIGHT][row][col]
      local leftTileIndex = leftTileInfo[2]._index
      local rightTileIndex = rightTileInfo[2]._index
      if leftTileInfo[2]._route[leftTileIndex] ~= rightTileInfo[2]._route[rightTileIndex] then
        leftTileInfo[1]:AddEffect("fUI_PCM_Energy_01A", false, 0, 0)
      end
    end
  end
end
function PaGlobal_MiniGame_MorningHomi_All:setRootAngle(plantX, plantY, row, col)
  local rootAngle = self._eRootAngle.COUNT
  if col >= plantY + self._flowerSize then
    if row < plantX then
      rootAngle = self._eRootAngle.LEFTDOWN
    elseif row >= plantX + self._flowerSize then
      rootAngle = self._eRootAngle.RIGHTDOWN
    else
      rootAngle = self._eRootAngle.DOWN
    end
  elseif row >= plantX + self._flowerSize then
    if col < plantY then
      rootAngle = self._eRootAngle.RIGHTUP
    else
      rootAngle = self._eRootAngle.RIGHT
    end
  elseif col < plantY then
    if row < plantX then
      rootAngle = self._eRootAngle.LEFTUP
    else
      rootAngle = self._eRootAngle.UP
    end
  else
    rootAngle = self._eRootAngle.LEFT
  end
  return rootAngle
end
function PaGlobal_MiniGame_MorningHomi_All:update(deltaTime)
  if Panel_MiniGame_MorningHomi_All == nil then
    return
  end
  if self._state == self._eGameState.PREV then
    self._curPrevTime = self._curPrevTime - deltaTime
    if keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true then
      self._curPrevTime = 0
      return
    end
    if self._curPrevTime <= 0 then
      self._curPrevTime = 0
      self._state = self._eGameState.GAME
      self:gameStartAnimTile()
      self._ui._stc_currentPoint:SetShow(true)
    end
    self._ui._txt_leftTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_POWERCONTROL_REMAINTIME", "gameEndTimer", math.floor(self._curPrevTime)))
    self._ui._stc_leftTimeBar:SetProgressRate(self._curPrevTime / self._maxPrevTime * 100)
  elseif self._state == self._eGameState.GAME then
    if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_ESCAPE) == true then
      ToClient_CollectMiniGameEnd(__eCollectMiniGameState_Cancle)
      self:prepareClose()
      return
    end
    self._curGameTime = self._curGameTime - deltaTime
    if 0 >= self._curGameTime then
      self._curGameTime = 0
      self._result = __eCollectMiniGameState_Fail
      self._state = self._eGameState.RESULT
    else
      if self._isConsole == false then
        if keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_MoveLeft) == true then
          self._curPosition.x = math.max(self._curPosition.x - 1, 0)
        end
        if keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_MoveRight) == true then
          self._curPosition.x = math.min(self._curPosition.x + 1, self._maxTileCount - 1)
        end
        if keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_MoveFront) == true then
          self._curPosition.y = math.max(self._curPosition.y - 1, 0)
        end
        if keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_MoveBack) == true then
          self._curPosition.y = math.min(self._curPosition.y + 1, self._maxTileCount - 1)
        end
      else
        if isPadUp(__eJoyPadInputType_LeftStick_Left) == true then
          self._curPosition.x = math.max(self._curPosition.x - 1, 0)
        end
        if isPadUp(__eJoyPadInputType_LeftStick_Right) == true then
          self._curPosition.x = math.min(self._curPosition.x + 1, self._maxTileCount - 1)
        end
        if isPadUp(__eJoyPadInputType_LeftStick_Up) == true then
          self._curPosition.y = math.max(self._curPosition.y - 1, 0)
        end
        if isPadUp(__eJoyPadInputType_LeftStick_Down) == true then
          self._curPosition.y = math.min(self._curPosition.y + 1, self._maxTileCount - 1)
        end
      end
      self._ui._stc_currentPoint:SetPosX(self._baseCurPointPos.x + self._curPosition.x * self._baseCurPointSize.x - self._curPosition.x * self._curPointGapSize)
      self._ui._stc_currentPoint:SetPosY(self._baseCurPointPos.y + self._curPosition.y * self._baseCurPointSize.y - self._curPosition.y * self._curPointGapSize)
      local isKeyUp = self._isConsole == true and isPadUp(__eJoyPadInputType_A) == true or keyCustom_IsUp_Action(CppEnums.ActionInputType.ActionInputType_Jump) == true
      if isKeyUp == true then
        self:changeRoute(self._curPosition.x, self._curPosition.y)
        if self:checkField() == true then
          self._state = self._eGameState.RESULT
          self._result = __eCollectMiniGameState_Success
        end
      end
    end
    self._ui._txt_leftTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAME_POWERCONTROL_REMAINTIME", "gameEndTimer", math.floor(self._curGameTime)))
    self._ui._stc_leftTimeBar:SetProgressRate(self._curGameTime / self._maxGameTime * 100)
    if self._state == self._eGameState.RESULT then
      PaGlobalFunc_CollectMiniGame_UpdateResult(self._result, self._ui._stc_success, self._ui._stc_fail, self._ui._txt_resurtBG, self._ui._stc_purpose)
      self:gameEndAnimTile()
      self:addEffectFailTile()
    end
  elseif self._state == self._eGameState.RESULT then
    self._curResultTime = self._curResultTime + deltaTime
    if self._curResultTime < self._maxResultTime then
      return
    end
    self._state = self._eGameState.END
    self:prepareClose()
  end
end
function PaGlobal_MiniGame_MorningHomi_All:gameStartAnimTile()
  local basePosX = 0
  local baseSizeX = 419
  self._ui._stc_fieldBG:SetRectClipOnArea(float2(0, 0), float2(self._ui._stc_fieldBG:GetSizeX(), self._ui._stc_fieldBG:GetSizeY()))
  local control1 = self._ui._stc_leftFieldBG
  local control2 = self._ui._stc_rightFieldBG
  control1:SetShow(true)
  control2:SetShow(true)
  control1:ResetVertexAni()
  control2:ResetVertexAni()
  local alphaAni1 = control1:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  alphaAni1:SetStartColor(Defines.Color.C_FFFFFFFF)
  alphaAni1:SetEndColor(Defines.Color.C_00FFFFFF)
  alphaAni1:SetStartIntensity(3)
  alphaAni1:SetEndIntensity(1)
  alphaAni1.IsChangeChild = true
  alphaAni1:SetHideAtEnd(true)
  control1:SetAlpha(1)
  local alphaAni2 = control2:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  alphaAni2:SetStartColor(Defines.Color.C_00FFFFFF)
  alphaAni2:SetEndColor(Defines.Color.C_FFFFFFFF)
  alphaAni2.IsChangeChild = true
end
function PaGlobal_MiniGame_MorningHomi_All:gameEndAnimTile()
  local basePosX = 0
  local baseSizeX = 419
  self._ui._stc_fieldBG:SetRectClipOnArea(float2(0, 0), float2(self._ui._stc_fieldBG:GetSizeX(), self._ui._stc_fieldBG:GetSizeY()))
  local control1 = self._ui._stc_rightFieldBG
  local control2 = self._ui._stc_leftFieldBG
  control1:SetShow(true)
  control2:SetShow(true)
  control1:ResetVertexAni()
  control2:ResetVertexAni()
end
function PaGlobal_MiniGame_MorningHomi_All_Open()
  PaGlobal_MiniGame_MorningHomi_All:prepareOpen()
end
function PaGlobal_MiniGame_MorningHomi_All_Close()
  if Panel_MiniGame_MorningHomi_All ~= nil and Panel_MiniGame_MorningHomi_All:GetShow() == true then
    ToClient_CollectMiniGameEnd(__eCollectMiniGameState_Cancle)
  end
  PaGlobal_MiniGame_MorningHomi_All:prepareClose()
end
function PaGlobal_MiniGame_MorningHomi_All_Update(deltaTime)
  PaGlobal_MiniGame_MorningHomi_All:update(deltaTime)
end
function PaGlobal_MiniGame_MorningHomi_All_IsOpen()
  if Panel_MiniGame_MorningHomi_All == nil then
    return false
  end
  return Panel_MiniGame_MorningHomi_All:GetShow()
end
function FromClient_MiniGame_MorningHomi_All_ResizePanel()
  if Panel_MiniGame_MorningHomi_All == nil then
    return
  end
  Panel_MiniGame_MorningHomi_All:ComputePosAllChild()
end
