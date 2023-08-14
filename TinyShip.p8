pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
spr(1,64,64)
--called once at launch
function _init()
 cls(0)
 shipx=64
 shipy=115
 shipspeed=2
 shipspr=1
 shiphp=3
 
 bulx=-1
 buly=0
 
 starx={}
 stary={}
 starspd={}
 
 for i=1,100 do
 	add(starx,rnd(128))
 	add(stary,rnd(128))
 	add(starspd,rnd(1.5)+0.5)
	end 
	
	mode="title"
	
end
--called every frame
--cannot be dropped
function _update()
	if mode == "game" then
		update_game()
	elseif mode=="title" then
		update_title()
	elseif mode=="pause" then
		update_pause()
	end
end

--called every frame draw
--can be dropped
function _draw()
	if mode=="game" then
		draw_game()
	end
	if mode=="title" then
		draw_title()
	end
end

-->8
--star animations
function starfield()
	for i=1,#starx do
		local starcolor=6
		
		if starspd[i]<1 then
			starcolor=1
		elseif starspd[i]<1.5 then
			starcolor=13
		end
		pset(starx[i],stary[i],starcolor)
	end
end
function animatestars()
	for i=1,#stary do
		local sy=stary[i]
		sy+=starspd[i]
		if sy>128 then
			sy-=128
		end
		stary[i]=sy
	end
end
-->8
--update
function update_game()
	--reset ship to middle sprite
	shipspr=1
 --left button
 if btn(0) and shipx>0 then
 	shipx-=shipspeed
 	shipspr=2
 end
 --right button 
 if btn(1) and shipx<120 then
 	shipx+=shipspeed
 	shipspr=3
 end
 --up button
 if btn(2) and shipy>0 then
 	shipy-=shipspeed
 end 
 --down button
 if btn(3) and shipy<120 then
 	shipy+=shipspeed
 end
 --fire button
 if btnp(5) then
		sfx(0)
 	buly=shipy-1
 	bulx=shipx
	end
	--rotate button
	if btnp(4) then
		--poke(24364,133)
	end
	--move bullet up
	buly-=4
	animatestars()
end

function update_title()
	animatestars()
	if btnp(4) or btnp(5) then
		mode="game"
	end
end
-->8
--draw
function draw_game()
	cls(0)
	starfield()
 spr(shipspr,shipx,shipy)
	spr(7,bulx,buly)
	for i=0,shiphp-1 do
		spr(4,i*9,0)
	end
	for i=0,2 do
		spr(5,i*9,0)
	end
end

function draw_title()
	cls(1)
	starfield()
	print("★shmup★",44,64,12)
	print("press any key to start",20,80,12)
	
end
__gfx__
00000000006060000606000000006060000000000000000000080000008880000000000000000000000000000000000000000000000000000000000000000000
00000000006060000606000000006060088088000880880089999980088988000000000000000000000000000000000000000000000000000000000000000000
00700700060006000606000000006060888888808008008080949080089998000000000000000000000000000000000000000000000000000000000000000000
00077000060606000600600000060060888888808000008080949080089998000000000000000000000000000000000000000000000000000000000000000000
00077000066a660006a0600000060a60888888808000008000949000008980000000000000000000000000000000000000000000000000000000000000000000
00700700066966000696600000066960088888000800080000999000008980000000000000000000000000000000000000000000000000000000000000000000
00000000116561100151100000011510008880000080800000080000000800000000000000000000000000000000000000000000000000000000000000000000
00000000000500000050000000000500000800000008000000080000000800000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000305502a5502755024550225501f5501d5501b5501a5501955018550175501655016550155501455013550125501155010550105500e5500d5500d5500c5500b5500a5500955009550085500755006550
00010000335502a5502655023550205501e5501c550195501755015550145501255011550105500e5500d5500c5500b5500a55009550095500855007550065500555005550045500455004550045500355003550
__music__
00 01424344

