function PaGlobal_HardCoreRanking_ShowAni()
  if PaGlobal_HardCoreRanking == nil then
    return
  end
end
function PaGlobal_HardCoreRanking_HideAni()
  if PaGlobal_HardCoreRanking == nil then
    return
  end
end
function PaGlobal_HardCoreRanking_Open()
  if PaGlobal_HardCoreRanking == nil then
    return
  end
  ToClient_RequestOpenHardCoreRankingPage()
end
function PaGlobal_HardCoreRanking_ShowPage()
  if PaGlobal_HardCoreRanking == nil then
    return
  end
  PaGlobal_HardCoreRanking:prepareOpen()
end
function PaGlobal_HardCoreRanking_UpdatSelfInfo()
  if PaGlobal_HardCoreRanking == nil then
    return
  end
  PaGlobal_HardCoreRanking:updateSelfCharacterData()
end
function PaGlobal_HardCoreRanking_UpdatRankingList()
  if PaGlobal_HardCoreRanking == nil then
    return
  end
  PaGlobal_HardCoreRanking:updateRankingListUI()
end
function PaGlobal_HardCoreRanking_Close()
  if PaGlobal_HardCoreRanking == nil then
    return
  end
  PaGlobal_HardCoreRanking:prepareClose()
end
