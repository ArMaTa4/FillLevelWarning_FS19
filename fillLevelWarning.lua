--
-- FillLevel Warning for LS 19
--
-- # Author:  	LSM/Sachsenfarmer
-- # date: 		25.11.19
--

fillLevelWarning = {}
fillLevelWarning.MOD_NAME = g_currentModName

AGCOBeepSound = createSample("AGCOBeep")
local file = g_currentModDirectory.."sounds/AGCO_beep.wav"
loadSample(AGCOBeepSound, file, false)

ClaasBeepSound = createSample("ClaasBeep")
local file = g_currentModDirectory.."sounds/Claas_beep.wav"
loadSample(ClaasBeepSound, file, false)

GrimmeBeepSound = createSample("GrimmeBeep")
local file = g_currentModDirectory.."sounds/Grimme_beep.wav"
loadSample(GrimmeBeepSound, file, false)

HolmerBeepSound = createSample("HolmerBeep")
local file = g_currentModDirectory.."sounds/Holmer_beep.wav"
loadSample(HolmerBeepSound, file, false)

JohnDeereSound = createSample("JohnDeereBeep")
local file = g_currentModDirectory.."sounds/JohnDeere_beep.wav"
loadSample(JohnDeereSound, file, false)

NewHollandSound = createSample("NewHollandBeep")
local file = g_currentModDirectory.."sounds/NH_beep.wav"
loadSample(NewHollandSound, file, false)

RopaSound = createSample("RopaBeep")
local file = g_currentModDirectory.."sounds/Ropa_beep.wav"
loadSample(RopaSound, file, false)

local tempo = 0

function fillLevelWarning.prerequisitesPresent(specializations)
  return true
end

function fillLevelWarning.registerEventListeners(vehicleType)
  SpecializationUtil.registerEventListener(vehicleType, "onPreLoad", fillLevelWarning)
  SpecializationUtil.registerEventListener(vehicleType, "onUpdate", fillLevelWarning)
end

function fillLevelWarning:onPreLoad(vehicle)
	self.RULaktive = false
	self.BeepAktive1 = false
	self.brand = self.xmlFile:getValue ("vehicle.storeData.brand" , false)
	self.loud = 1
end

function fillLevelWarning:onUpdate(dt)
	if self:getIsActive() and self:getIsTurnedOn() then
	local fillLevel = self:getFillUnitFillLevelPercentage(self:getCurrentDischargeNode().fillUnitIndex)  
		if fillLevel > 0 then
			if not	self.BeepAktive1 then
				if fillLevel >= 0.5 then
					if self:getIsEntered() then			
						if self.brand == "AGCO" or self.brand == "FENDT" or self.brand == "MASSEYFERGUSON" or self.brand == "CHALLENGER" then
							playSample(AGCOBeepSound ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "CLAAS" then
							playSample(ClaasBeepSound ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "GRIMME" then
							playSample(GrimmeBeepSound ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "HOLMER" then
							playSample(HolmerBeepSound ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "JOHNDEERE" then
							playSample(JohnDeereSound ,self.loud ,self.loud ,1 ,0 ,0)	
						elseif self.brand == "NEWHOLLAND" or self.brand == "CASEIH" then
							playSample(NewHollandSound ,self.loud ,self.loud ,1 ,0 ,0)	
						elseif self.brand == "ROPA" then
							playSample(RopaSound ,self.loud ,self.loud ,1 ,0 ,0)
						end	
					end
					self.BeepAktive1 = true
				end
			else
				if fillLevel < 0.5 then
					self.BeepAktive1 = false
				end
			end
			if not self.RULaktive then
				if fillLevel >= 0.8 then
					self:setBeaconLightsVisibility(true)
					if self:getIsEntered() then				
						if self.brand == "AGCO" or self.brand == "FENDT" or self.brand == "MASSEYFERGUSON" or self.brand == "CHALLENGER" then
							playSample(AGCOBeepSound ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "CLAAS" then
							playSample(ClaasBeepSound ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "GRIMME" then
							playSample(GrimmeBeepSound ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "HOLMER" then
							playSample(HolmerBeepSound ,self.loud ,self.loud ,1 ,0 ,0)
						elseif self.brand == "JOHNDEERE" then
							playSample(JohnDeereSound ,self.loud ,self.loud ,1 ,0 ,0)	
						elseif self.brand == "NEWHOLLAND" or self.brand == "CASEIH" then
							playSample(NewHollandSound ,self.loud ,self.loud ,1 ,0 ,0)	
						elseif self.brand == "ROPA" then
							playSample(RopaSound ,self.loud ,self.loud ,1 ,0 ,0)
						end
					end
				self.RULaktive = true
				end
			else
				if fillLevel < 0.8 then
					self:setBeaconLightsVisibility(false)
					self.RULaktive = false
				end	
			end
			if fillLevel >= 0.9 and fillLevel < 1 then
				if self:getIsEntered() and tempo>=(1820-1800*fillLevel) then				
					if self.brand == "AGCO" or self.brand == "FENDT" or self.brand == "MASSEYFERGUSON" or self.brand == "CHALLENGER" then
						playSample(AGCOBeepSound ,self.loud ,self.loud ,1 ,0 ,0)
					elseif self.brand == "CLAAS" then
						playSample(ClaasBeepSound ,self.loud ,self.loud ,1 ,0 ,0)
					elseif self.brand == "GRIMME" then
						playSample(GrimmeBeepSound ,self.loud ,self.loud ,1 ,0 ,0)
					elseif self.brand == "HOLMER" then
						playSample(HolmerBeepSound ,self.loud ,self.loud ,1 ,0 ,0)
					elseif self.brand == "JOHNDEERE" then
						playSample(JohnDeereSound ,self.loud ,self.loud ,1 ,0 ,0)	
					elseif self.brand == "NEWHOLLAND" or self.brand == "CASEIH" then
						playSample(NewHollandSound ,self.loud ,self.loud ,1 ,0 ,0)	
					elseif self.brand == "ROPA" then
						playSample(RopaSound ,self.loud ,self.loud ,1 ,0 ,0)
					end
                    tempo = 0 
				else
					tempo = tempo + 1
				end
			end
		end
		g_inputBinding:setActionEventText(fillLevelWarning.actionEventId, Vehicle.togglesound)
	end

end
