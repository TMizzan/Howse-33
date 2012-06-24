
-- Display Variables
local deck
local dealerCard1
local dealerCard2
local dealerCard3
local dealerCard4
local dealerCard5
local card1 
local card2 
local card3 
local card4 
local card5
local t 
local cardCount   = 0 
local dealerCount = 0
local score       = 0
local dealerScore = 0 
local displayText
local dealerText 
local scoreText
local betText
local gameText 
local total       = 0
local dealerTotal = 0
local bet         = 5
local bank        = 1000
local endGame     = false
local dealerY     = 380
local playerY     = 220
local deckY       = 300
local firstLoad   = true
local backButton
local ruleText
local motionOn   = true
local dealing    = false
local freezing   = false
local hitting    = false

-- Graphic Variables
local background
local fiveChip
local tenChip
local tfChip
local fChip
local oChip
local hitButton
local holdButton
local dealButton
local winnerStatus
local house
local playButton
local rulesButton


function LoadBackground()

	-- Background
	background    = display.newImage( "BlueRadialBackground.png", true )
	background.x  = display.contentWidth / 2
	background.y  = display.contentHeight / 2

	-- Logo
	logo    = display.newImage( "Howse33Logo.png", true )
	logo.x  = display.contentWidth / 2
	logo.y  = display.contentHeight - 450

end

function LoadIntro()

	house    = display.newImage("HowseMain.png")
	house.x  = display.contentWidth / 2
	house.y  = display.contentHeight / 2 - 30
	house.xScale = .9
	house.yScale = .9

	-- Text Fade In Transition
    transition.to( house, { time=0, delay=0, alpha=.0 } )
    transition.to( house, { time=500, delay=0, alpha=1.0} )
	
	playButton    = display.newImage("Play.png")
	playButton.x  = display.contentWidth / 2 - (playButton.contentWidth / 2)
	playButton.y  = house.y + 200

	rulesButton    = display.newImage("Rules.png")
	rulesButton.x  = playButton.x + rulesButton.contentWidth + 2
	rulesButton.y  = playButton.y

	playButton:addEventListener("touch", onPlay)
	rulesButton:addEventListener("touch", onRules)

end

function LoadDisplay()

	deck           = display.newImage("HouseDeck.png")
	deck.x         = display.contentWidth / 2
	deck.y         = display.contentHeight - deckY
	deck.xScale    = .8
	deck.yScale    = .8

	-- 5 Chip
	fiveChip      = display.newImage( "5Chip.png", true )
	fiveChip.x    = 35
	fiveChip.y    = display.contentHeight - 145

	-- 10 Chip
	tenChip       = display.newImage( "10Chip.png", true )
	tenChip.x     = fiveChip.x + 40
	tenChip.y     = fiveChip.y + 50

	-- 25 Chip 
	tfChip        = display.newImage( "25Chip.png", true )
	tfChip.x      = fiveChip.x - 5
	tfChip.y      = tenChip.y + 45

	-- 50 Chip
	fChip         = display.newImage( "50Chip.png", true )
	fChip.x       = 260
	fChip.y       = display.contentHeight - 145

	-- 100 Chip
	oChip         = display.newImage( "100Chip.png", true )
	oChip.x       = fChip.x + 10
	oChip.y       = fChip.y + 70

	-- Hit Button
	hitButton     = display.newImage("Hit.png")
	hitButton.x   = display.contentWidth / 2
	hitButton.y   = display.contentHeight - hitButton.contentHeight - 100

	-- Freeze Button
	holdButton    = display.newImage("Freeze.png")
	holdButton.x  = display.contentWidth / 2 
	holdButton.y  = hitButton.y + 50

	-- Deal Button
	dealButton    = display.newImage("Deal.png")
	dealButton.x  = display.contentWidth / 2 
	dealButton.y  = holdButton.y + 50

end

function ShuffleCards()

  local count = 0
  local cardDeck = {}

  while (count <= 10) do
      local cardFound = false
	  local cardValue = math.random(1, 51)
      if cardValue <= 51 then
	     for i = 1, count do
		    if cardDeck[i] == cardValue then
			   cardFound = true
			end 
		 end 
         if cardFound == false then
			count = count + 1
            cardDeck[count] = cardValue		 
	     end
	 end
  end

  return cardDeck
  
end

function DealCards()

    dealerCard1    = display.newImage(GetCardImage(t[7]))
    dealerCard1.x  = deck.x
	dealerCard1.y  = deck.y
	dealerCard1.xScale = .8
	dealerCard1.yScale = .8
   	transition.to( dealerCard1, { time=200, alpha=0, x=((display.contentWidth / 2) - dealerCard1.contentWidth - 2), y=(display.contentHeight - dealerY) } )
	transition.to( dealerCard1, { time=200, delay=200, alpha=1.0 } )

	dealerCard2    = display.newImage("HouseBackVertical.png")
    dealerCard2.x  = deck.x
	dealerCard2.y  = deck.y
	dealerCard2.xScale = .8
	dealerCard2.yScale = .8
   	transition.to( dealerCard2, { time=200, alpha=0, x=(display.contentWidth / 2), y=(display.contentHeight - dealerY) } )
    transition.to( dealerCard2, { time=200, delay=200, alpha=1.0 } )


    dealerCard3    = display.newImage(GetCardImage(t[9]))
    dealerCard3.x  = deck.x
	dealerCard3.y  = deck.y
	dealerCard3.xScale = .8
	dealerCard3.yScale = .8
   	transition.to( dealerCard3, { time=200, alpha=0, x=(dealerCard2.x + dealerCard3.contentWidth + 2), y=(display.contentHeight - dealerY) } )
    transition.to( dealerCard3, { time=200, delay=200, alpha=1.0 } )

	card1          = display.newImage(GetCardImage(t[1]))
    card1.x        = deck.x
	card1.y        = deck.y
	card1.xScale   = .8
	card1.yScale   = .8
   	transition.to( card1, { time=200, alpha=0, x=((display.contentWidth  / 2) - card1.contentWidth - 2), y=(display.contentHeight - playerY) } )
    transition.to( card1, { time=200, delay=200, alpha=1.0 } )

	card2          = display.newImage(GetCardImage(t[2]))
    card2.x        = deck.x
	card2.y        = deck.y
	card2.xScale   = .8
	card2.yScale   = .8
   	transition.to( card2, { time=200, alpha=0, x=(display.contentWidth  / 2), y=(display.contentHeight - playerY) } )
    transition.to( card2, { time=200, delay=200, alpha=1.0 } )

	card3          = display.newImage(GetCardImage(t[3]))
    card3.x        = deck.x
	card3.y        = deck.y
	card3.xScale   = .8
	card3.yScale   = .8
   	transition.to( card3, { time=200, alpha=0, x=(card2.x + card3.contentWidth + 2), y=(display.contentHeight - playerY) } )
    transition.to( card3, { time=200, delay=200, alpha=1.0 } )
  
    score = GetCardValue(t[1]) + GetCardValue(t[2]) + GetCardValue(t[3]) 
   
    CheckBank()
    DisplayScore(score)
	DisplayDealerScore("Dealer")
    DisplayBank(bank)	
	DisplayBet(bet)
	
    cardCount   = 3
	dealerCount = 3
    endGame = false

end

function Hit()

    local hitCount = 0

	hitting = true
	
    if (cardCount == 5) or (endGame == true) then
	 hitting = false
     return cardCount
    end

    -- Set First Load Flag
	firstLoad   = false
	
	 if cardCount == 3 then
		card4    = display.newImage(GetCardImage(t[4]))
        card4.x  = deck.x
		card4.y  = deck.y
	    card4.xScale   = .8
	    card4.yScale   = .8
		hitCount = hitCount + 1
   	    transition.to( card4, { time=250, alpha=0, x=(card1.x - card4.contentWidth - 2), y=(display.contentHeight -  playerY) } )
        transition.to( card4, { time=200, delay=200, alpha=1.0 } )
        score = GetCardValue(t[1]) + GetCardValue(t[2]) + GetCardValue(t[3])  + GetCardValue(t[4])
  	    DisplayScore(score)
  	    if (score >= 33) or (cardCount == 5) then
	       Freeze()
        end
 	    cardCount = cardCount + 1
    	hitting = false
        return cardCount
	elseif cardCount == 4 then
		card5    = display.newImage(GetCardImage(t[5]))
        card5.x  = deck.x
		card5.y  = deck.y
  	    card5.xScale   = .8
	    card5.yScale   = .8
   	    transition.to( card5, { time=250, alpha=0, x=(card3.x + card5.contentWidth + 2), y=(display.contentHeight - playerY) } )
        transition.to( card5, { time=200, delay=200, alpha=1.0 } )
        score = score + GetCardValue(t[5])
        score = GetCardValue(t[1]) + GetCardValue(t[2]) + GetCardValue(t[3])  + GetCardValue(t[4]) + GetCardValue(t[5])
		DisplayScore(score)
	    Freeze()
 	    cardCount = cardCount + 1
    	hitting = false
		return cardCount
    end 

	
end

function Freeze()
  
    local scoreFound = false
  
	if endGame == true then
       freezing = false
	   return
	end 

    freezing = true	
  
    -- Set First Load Flag
	firstLoad   = false

    endGame = true
  
	dealerCard2:removeSelf()
	dealerCard2    = display.newImage(GetCardImage(t[8]))
	dealerCard2.x  = display.contentWidth / 2
	dealerCard2.y  = display.contentHeight - dealerY
  	dealerCard2.xScale = .8
	dealerCard2.yScale = .8

    dealerScore = GetCardValue(t[7]) + GetCardValue(t[8]) + GetCardValue(t[9])
    DisplayDealerScore(dealerScore)
  
    for i = 1, 2 do
        if dealerScore < score and score <= 33 then
			  if dealerCount == 3  then
				 -- Hit Dealer
				 dealerCard4    = display.newImage(GetCardImage(t[10]))
				 dealerCard4.x  = deck.x
				 dealerCard4.y  = deck.y
 				 dealerCard4.xScale = .8
				 dealerCard4.yScale = .8
				 transition.to( dealerCard4, { time=250, alpha=0, x=(dealerCard1.x - dealerCard4.contentWidth - 2), y=(display.contentHeight -  dealerY) } )
				 transition.to( dealerCard4, { time=200, delay=200, alpha=1.0 } )
				 dealerScore = GetCardValue(t[7]) + GetCardValue(t[8]) + GetCardValue(t[9])  + GetCardValue(t[10])
				 DisplayDealerScore(dealerScore)
				 dealerCount = dealerCount + 1
			  elseif dealerCount == 4 then
				  -- Hit Dealer
				 dealerCard5    = display.newImage(GetCardImage(t[11]))
				 dealerCard5.x  = deck.x
				 dealerCard5.y  = deck.y
				 dealerCard5.xScale = .8
				 dealerCard5.yScale = .8
				 transition.to( dealerCard5, { time=250, alpha=0, x=(dealerCard3.x + dealerCard4.contentWidth + 2), y=(display.contentHeight -  dealerY) } )
				 transition.to( dealerCard5, { time=200, delay=200, alpha=1.0 } )
				 dealerScore = GetCardValue(t[7]) + GetCardValue(t[8]) + GetCardValue(t[9])  + GetCardValue(t[10]) + GetCardValue(t[11]) 
				 DisplayDealerScore(dealerScore)
				 dealerCount = dealerCount + 1
			  end
		end
	end 
	
	if dealerScore > 33 and score > 33 and scoreFound == false then
  	   -- Push
	   bank = bank - bet
	   DisplayGameStatus("Push")
       freezing = false
	   scoreFound = true
	end
	
	if dealerScore <= 33 and score <= 33 and dealerScore == score and scoreFound == false then
	   -- Push
	   DisplayGameStatus("Push")
	   scoreFound = true
	end
	
	if dealerScore <= 33 and score <= 33 and dealerScore == score and scoreFound == false then
	   -- Push
	   DisplayGameStatus("Push")
	   scoreFound = true
	end

	if dealerScore <= 33 and score <= 33 and dealerScore >= score and scoreFound == false then
	   -- Dealer Wins
	   bank = bank - bet
	   DisplayGameStatus("House")
	   scoreFound = true
	end
	
	if dealerScore <= 33 and score <= 33 and dealerScore <= score and scoreFound == false then
	   -- Player Wins
	   bank = bank + bet
	   DisplayGameStatus("Player")
	   scoreFound = true
	end
	
	if dealerScore <= 33 and score > 33 and scoreFound == false then
	   -- Dealer Wins
	   bank = bank - bet
	   DisplayGameStatus("House")
	   scoreFound = true
	end

	if dealerScore >= 33 and score <= 33 and scoreFound == false then
	   -- Dealer Wins
	   bank = bank + bet
	   DisplayGameStatus("Player")
	   scoreFound = true
	end

   DisplayBank(bank)
	
	if (bank <= 0) then
	   bank = 0
       freezing = false
	   DisplayBank(bank)
	   -- Show alert with five buttons
 	  local alert = native.showAlert( "House 33", "$0 Left In Bank.  Restart Game?", 
                                    { "Restart" }, onComplete )   
	end 

   freezing = false
	
	
end 

function DisplayRules()

	local rule1 = "Aces, Kings, Queens, and Jacks count\n\nas 11. Cards 10, 9, 8, 7, 6, 5, 4, 3 and\n\n2 all have their face value.\n\n"
	local rule2 = "All players start with $1000 in the Bank.\nBets are placed before each hand and\nplayers can bet $5, $10, $25, $50, or\n$100 on each hand.\n\n"
	local rule3 = "Each hand begins with 3 cards. A player\nhas the option to get cards using\nthe Hit button and a player can hold using\nthe Freeze button.\n\n"
	local rule4 = "A maximum of 5 cards are allowed for each\nplayer.\n\n"
	local rule5 = "The goal of the game is to get a card total\nof 33. The player that is closest to 33\n without going over wins.\n\n"
	local rule6 = "The House has the option to Hit after all\nplayers Freeze."
	
	ruleText    = display.newImage("RuleText.png")
	ruleText.xScale = 1
	ruleText.yScale = 1
	ruleText.x      = display.contentWidth / 2 + 10
	ruleText.y      = display.contentHeight / 2 + ruleText.contentHeight / 2 - 240

	-- Text Fade In Transition
    transition.to( ruleText, { time=0, delay=0, alpha=.0} )
    transition.to( ruleText, { time=500, delay=500, alpha=1.0} )
	
    -- Back Button
	backButton    = display.newImage("Back.png")
	backButton.x  = display.contentWidth / 2 
	backButton.y  = display.contentHeight - 20
 	backButton:addEventListener("touch", onBack)

end

function DisplayScore(score)

	--if not frameUpdate then return end

    if displayText ~= nil then
	   displayText:removeSelf()
	end
	displayText  = display.newText(score, 0, 0, native.systemFont, 52)
	displayText.xScale = .5
	displayText.yScale = .5
	displayText:setReferencePoint(display.BottomLeftReferencePoint)
	displayText.x      = deck.x + 40
	displayText.y      = deck.y + 45
	return

end

function DisplayDealerScore(dScore)

  if dealerText ~= nil then
	 dealerText:removeSelf()
  end
  dealerText        = display.newText(dScore, 0, 0, native.systemFont, 52)
  dealerText.xScale = .5
  dealerText.yScale = .5
  dealerText:setReferencePoint(display.BottomLeftReferencePoint)
  dealerText.x      = deck.x + 40
  dealerText.y      = deck.y - 5
  return
  
 end
  
 function DisplayGameStatus(gStatus)
 
 if (gStatus == "House") then
      winnerStatus    = display.newImage( "HouseWins.png", true )
  end
  
  if (gStatus == "Player") then
      winnerStatus    = display.newImage( "YouWin.png", true )
  end
  
  if (gStatus == "Push") then
      winnerStatus    = display.newImage( "Push.png", true )
  end

  winnerStatus.x  = display.contentWidth / 2
  winnerStatus.y  = display.contentHeight / 2 - 60
  
  return
 
 end
 
function DisplayBank(cash)
    if scoreText ~= nil then
	   scoreText:removeSelf()
	end
	local strText = ""
	if (cash == "") then
	   strText = ""
	else
	   strText =  " Bank $"..cash
	end
	scoreText        = display.newText(strText, 0, 0, native.systemFont, 42)
	scoreText.xScale = .5
	scoreText.yScale = .5
	scoreText:setReferencePoint(display.BottomLeftReferencePoint)
	scoreText.x      =   190
	scoreText.y      = holdButton.y + 105
	return
end

function DisplayBet(bet)
    if betText ~= nil then
	   betText:removeSelf()
	end
	local strText = ""
	if (bet == "") then
	   strText = ""
	else
	   strText =  "Bet $"..bet
	end
	betText        = display.newText(strText, 0, 0, native.systemFont, 42)
	betText.xScale = .5
	betText.yScale = .5
	betText:setReferencePoint(display.BottomLeftReferencePoint)
	betText.x      = 10
	betText.y      = holdButton.y + 105
return
end
  
function UpdateCount()
end

function ClearCards()

    DisplayGameStatus("")
    DisplayDealerScore("Dealer")
	
    dealerCard1:removeSelf()
    dealerCard2:removeSelf()
    dealerCard3:removeSelf()
    card1:removeSelf()
    card2:removeSelf()
    card3:removeSelf()
	if (winnerStatus ~= nil) then
        winnerStatus:removeSelf()
	end 
	
	if cardCount >= 4 then
       card4:removeSelf()
	end 
	if cardCount >= 5 then
       card5:removeSelf()
	end
	if dealerCount >= 4 then
       dealerCard4:removeSelf()
	end 
	if dealerCount >= 5 then
       dealerCard5:removeSelf()
	end
   cardCount   = 0
   dealerCount = 0
   score       = 0
   dealerScore = 0
end 

function NewHand()
  dealing = true
  ClearCards()
  t = ShuffleCards()
  DealCards()
  dealing = false
end

function GetCardImage(cardValue)

     local imgCard

     if cardValue ==  0 then
  	    imgCard = "AceHearts.png"
     elseif cardValue ==  1 then
        imgCard = "KingHearts.png"
     elseif cardValue ==  2 then
        imgCard = "QueenHearts.png"
     elseif cardValue ==  3 then
        imgCard = "JackHearts.png"
     elseif cardValue ==  4 then
        imgCard = "10Hearts.png"
     elseif cardValue ==  5 then
        imgCard = "9Hearts.png"
     elseif cardValue ==  6 then
        imgCard = "8Hearts.png"
     elseif cardValue ==  7 then
       imgCard = "7Hearts.png"
     elseif cardValue ==  8 then
       imgCard = "6Hearts.png"
     elseif cardValue ==  9 then
       imgCard = "5Hearts.png"
     elseif cardValue ==  10 then
       imgCard = "4Hearts.png"
     elseif cardValue ==  11 then
       imgCard = "3Hearts.png"
     elseif cardValue ==  12 then
       imgCard = "2Hearts.png"
     elseif cardValue ==  13 then
       imgCard = "AceDiamonds.png"
     elseif cardValue ==  14 then
       imgCard = "KingDiamonds.png"
     elseif cardValue ==  15 then
       imgCard = "QueenDiamonds.png"
     elseif cardValue ==  16  then
       imgCard = "JackDiamonds.png"
     elseif cardValue ==  17  then
       imgCard = "10Diamonds.png"
     elseif cardValue ==  18  then
       imgCard = "9Diamonds.png"
     elseif cardValue ==  19  then
       imgCard = "8Diamonds.png"
     elseif cardValue ==  20  then
       imgCard = "7Diamonds.png"
     elseif cardValue ==  21  then
       imgCard = "6Diamonds.png"
     elseif cardValue ==  22  then
       imgCard = "5Diamonds.png"
     elseif cardValue ==  23  then
       imgCard = "4Diamonds.png"
     elseif cardValue ==  24  then
       imgCard = "3Diamonds.png"
     elseif cardValue ==  25  then
       imgCard = "2Diamonds.png"
     elseif cardValue ==  26  then
       imgCard = "AceClubs.png"
     elseif cardValue ==  27  then
		imgCard = "KingClubs.png"
	elseif cardValue ==  28  then
		imgCard = "QueenClubs.png"
	elseif cardValue ==  29  then
		imgCard = "JackClubs.png"
	elseif cardValue ==  30  then
		imgCard = "10Clubs.png"
	elseif cardValue ==  31   then
		imgCard = "9Clubs.png"
	elseif cardValue ==  32  then
		imgCard = "8Clubs.png"
	elseif cardValue ==  33  then
		imgCard = "7Clubs.png"
	elseif cardValue ==  34  then
		imgCard = "6Clubs.png"
	elseif cardValue ==  35  then
		imgCard = "5Clubs.png"
	elseif cardValue ==  36  then
		imgCard = "4Clubs.png"
	elseif cardValue ==  37  then
		imgCard = "3Clubs.png"
	elseif cardValue ==  38  then
		imgCard = "2Clubs.png"
	elseif cardValue ==  39  then 
		imgCard = "AceSpades.png"
	elseif cardValue ==  40   then
		imgCard = "KingSpades.png"
	elseif cardValue ==  41  then
		imgCard = "QueenSpades.png"
	elseif cardValue ==  42   then
		imgCard = "JackSpades.png"
	elseif cardValue ==  43  then
		imgCard = "10Spades.png" 
	elseif cardValue ==  44  then
		imgCard = "9Spades.png"
	elseif cardValue ==  45  then
		imgCard = "8Spades.png"
	elseif cardValue ==  46 then
		imgCard = "7Spades.png"
	elseif cardValue ==  47  then
		imgCard = "6Spades.png"
	elseif cardValue ==  48  then
		imgCard = "5Spades.png"
	elseif cardValue ==  49  then
		imgCard = "4Spades.png"
	elseif cardValue ==  50  then
		imgCard = "3Spades.png"
	elseif cardValue ==  51  then
		imgCard = "2Spades.png"
    end

     return imgCard
end 

function GetCardValue(card)

   local cardValue = 0

	if card == 0      then 
		cardValue = 11
	elseif card == 13 then 
		cardValue = 11
	elseif card == 26 then 
		cardValue = 11
	elseif card == 39 then 
		cardValue = 11
	elseif card == 1  then 
		cardValue = 11
	elseif card == 14 then 
		cardValue = 11
	elseif card == 27 then 
		cardValue = 11
	elseif card == 40 then 
		cardValue = 11
	elseif card == 2  then 
		cardValue = 11
	elseif card == 15 then 
		cardValue = 11
	elseif card == 28 then 
		cardValue = 11
	elseif card == 41 then 
		cardValue = 11
	elseif card == 3  then 
		cardValue = 11
	elseif card == 16 then 
		cardValue = 11
	elseif card == 29 then 
		cardValue = 11
	elseif card == 42 then
		cardValue = 11

	-- Tens
	elseif card == 4   then 
		cardValue = 10
	elseif card == 17  then 
		cardValue = 10
	elseif card == 30  then 
		cardValue = 10
	elseif card == 43  then
		cardValue = 10

	-- Nines
	elseif card == 5  then 
		cardValue = 9
	elseif card == 18 then 
		cardValue = 9
	elseif card == 31 then 
		cardValue = 9
	elseif card == 44 then
		cardValue = 9

	-- Eights
	elseif card == 6  then 
		cardValue = 8
	elseif card == 19 then 
		cardValue = 8
	elseif card == 32 then 
		cardValue = 8
	elseif card == 45 then
		cardValue = 8

	-- Sevens
	elseif card == 7  then 
		cardValue = 7
	elseif card == 20 then 
		cardValue = 7
	elseif card == 33 then 
		cardValue = 7
	elseif card == 46 then
		cardValue = 7

	-- Sixes
	elseif card == 8 then 
		cardValue = 6
	elseif card == 21 then 
		cardValue = 6
	elseif card == 34 then 
		cardValue = 6
	elseif card == 47 then
		cardValue = 6

	-- Fives
	elseif card == 9  then 
		cardValue = 5
	elseif card == 22 then 
		cardValue = 5
	elseif card == 35 then 
		cardValue = 5
	elseif card == 48 then
		cardValue = 5

	-- Fours
	elseif card == 10 then 
		cardValue = 4
	elseif card == 23 then 
		cardValue = 4
	elseif card == 36 then 
		cardValue = 4
	elseif card == 49 then
		cardValue = 4

	-- Threes
	elseif card == 11 then 
		cardValue = 3
	elseif card == 24 then 
		cardValue = 3
	elseif card == 37 then 
		cardValue = 3
	elseif card == 50 then
		cardValue = 3

	 -- Twos
	elseif card == 12 then 
		cardValue = 2
	elseif card == 25 then 
		cardValue = 2
	elseif card == 38 then 
		cardValue = 2
	elseif card == 51 then
		cardValue = 2

	end

	return cardValue

end

function moveCard(event)
  local card = event.target
  card:applyLinearImpulse(0, -0.2, card.x, card.y)
end

function onRemove(event)
  local t = event.target
  t:removeSelf()
end

function onTouch(event)
	local t = event.target

	local phase = event.phase
	if "began" == phase then

		local parent = t.parent
		parent:insert( t )
		display.getCurrentStage():setFocus( t, event.id )

		t.isFocus = true

		t.x0 = event.x - t.x
		t.y0 = event.y - t.y
	elseif t.isFocus then
		if "moved" == phase then
			t.x = event.x - t.x0
			t.y = event.y - t.y0
		elseif "ended" == phase or "cancelled" == phase then
			display.getCurrentStage():setFocus( t, nil )
			t.isFocus = false
		end
	end

	return true
end

function onHit(event)

	local t = event.target

	local phase = event.phase
    if "began" == phase then
 	   Hit()
	end
end 

function onPlay(event)

		local t = event.target

		local phase = event.phase
		if "began" == phase then
		   house:removeSelf()
		   playButton:removeSelf()
		   rulesButton:removeSelf()
           native.setActivityIndicator( true )
		   LoadGame()
	    end

end 

function onRules(event)

		local t = event.target

		local phase = event.phase
		if "began" == phase then
		   house:removeSelf()
		   playButton:removeSelf()
		   rulesButton:removeSelf()
		   DisplayRules()
	    end

end 

function onBack(event)

		local t = event.target

		local phase = event.phase
		if "began" == phase then
		   ruleText:removeSelf()
		   backButton:removeSelf()
           LoadIntro()
		end

end 

function onBet5(event)

    if (endGame == true) or (firstLoad == true) then
		local t = event.target

		local phase = event.phase
		if "began" == phase then
		   bet = 5
		   
		   DisplayBet(bet)
	   end
   end 
end 

function onBet10(event)

    if (endGame == true) or (firstLoad == true) then
		local t = event.target

		local phase = event.phase
		if "began" == phase then
		   bet = 10
		   DisplayBet(bet)
	   end
   end

end 

function onBet25(event)

    if (endGame == true) or (firstLoad == true) then
		local t = event.target

		local phase = event.phase
		if "began" == phase then
		   bet = 25
		   DisplayBet(bet)
	   end
   end
end 

function onBet50(event)

    if (endGame == true) or (firstLoad == true) then
		local t = event.target

		local phase = event.phase
		if "began" == phase then
		   bet = 50
		   DisplayBet(bet)
	   end
   end

end 

function onBet100(event)

    if (endGame == true) or (firstLoad == true) then
		local t = event.target

		local phase = event.phase
		if "began" == phase then
		   bet = 100
		   DisplayBet(bet)
	   end
   end

end 

function onFreeze(event)

	local t = event.target

	local phase = event.phase
    if "began" == phase then
 	   Freeze()
	end
end 

function onDeal(event)
   
    if (endGame == false) then
	   return
	end
  
    local t = event.target

	local phase = event.phase
	if "began" == phase then
       NewHand()
	end
	
end 

function onComplete(event)
    
	print (event.action)
	
    if "clicked" == event.action then
        local i = event.index
		print(i)
        if (i == 1) then
		   bank = 1000
           NewHand()
        end
    end
end

function LoadEventListeners()

	-- Add Event Listeners
	deck:addEventListener("touch", onHit)
    fiveChip:addEventListener("touch", onBet5)
	tenChip:addEventListener("touch", onBet10)
	tfChip:addEventListener("touch", onBet25)
	fChip:addEventListener("touch", onBet50)
	oChip:addEventListener("touch", onBet100)
	hitButton:addEventListener("touch", onHit)
	holdButton:addEventListener("touch", onFreeze)
	dealButton:addEventListener("touch", onDeal)

end

function LoadGame()

-- Load Display
LoadDisplay()

-- Shuffle Cards
t = ShuffleCards()

-- Deal Cards
DealCards()

-- Load Event Listeners
LoadEventListeners()

native.setActivityIndicator( false )
           

end

function CheckBank()

  if bank < bet then
     bet = 5
  end 

end

LoadBackground()

LoadIntro()



