local RadianOffset = 90
PaGlobal_MiniGame_GalleyPaddle_All = {
  _ui = {
    _stc_game = nil,
    _circularProgress_InputRange = nil,
    _stc_target_1 = nil,
    _stc_target_2 = nil,
    _circularProgress_JudgementRange = nil,
    _circularProgress_BorderRange = nil,
    _stc_paddle = nil,
    _stc_ship = nil,
    _stc_noticeBox = nil,
    _stc_spaceBar = nil,
    _stc_result = nil,
    _txt_timer = nil,
    _stc_gameResultBoard = nil,
    _stc_gameResultList = {},
    _stc_gameInfo = nil,
    _btn_gameStart = nil,
    _txt_Multiline = nil
  },
  _resultType = {
    None = 0,
    Perfect = 1,
    Good = 2,
    Bad = 3
  },
  _isDebugModeOn = false,
  _debugModeType = 0,
  _isConsole = false,
  _initialize = false,
  _resultRateList = {85, 60},
  _scoreList = {
    100,
    90,
    50
  },
  _maxRound = 5,
  _roundTime = 10,
  _readyTime = 3,
  _borderLineDepth = math.pi / 180 * 1,
  _judgeCorrctionValue = math.pi / 180 * 3,
  _offsetRadian = math.pi / 180 * RadianOffset,
  _startPaddleRadian = math.pi / 180 * -1 * 10,
  _endPaddleRadian = math.pi / 180 * -1 * 170,
  _minStartJudgeRangeRadian = math.pi / 180 * (RadianOffset + 35),
  _maxEndJudgeRangeRadian = math.pi / 180 * (RadianOffset + 155),
  _minimumJudgeRangeRadian = math.pi / 180 * 40,
  _startPaddleSpeed = 1.3,
  _minPaddleSpeed = 0.2,
  _maxPaddleSpeed = 2.5,
  _paddleAccelateConst = 1,
  _returnPaddleSpeed = 6.2,
  _startGame = false,
  _startRound = false,
  _endRound = false,
  _endGame = false,
  _inputEnd = false,
  _isAFK = false,
  _paddleDown = true,
  _paddleStop = false,
  _canPushSpace = false,
  _pushSpace = false,
  _isOverInputPiDegree = false,
  _isOverJudgePiDegree = false,
  _currentRound = 0,
  _judgeStartPaddleRadian = 0,
  _judgeEndPaddleRadian = 0,
  _inputStartPaddleRadian = 0,
  _inputEndPaddleRadian = 0,
  _score = 0,
  _outterTimer = 0,
  _innerTimer = 0,
  _paddleSpeed = 1,
  _paddlePlayingAudioID = 0,
  _paddlePlayingAudioIDConsole = 0,
  _resultList = {}
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_GalleyPaddle_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_GalleyPaddle_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_GalleyPaddle_All_Init")
registerEvent("FromClient_StartGuildShipPaddleMiniGame", "FromClient_StartGuildShipPaddleMiniGame")
registerEvent("FromClient_PaddleMiniGameAllEnd", "FromClient_PaddleMiniGameAllEnd")
function FromClient_MiniGame_GalleyPaddle_All_Init()
  PaGlobal_MiniGame_GalleyPaddle_All:initialize()
end
