_addon.name = 'AutoTarget'
_addon.author = 'Gimlic'
_addon.version = '0.1'
_addon.language = 'english'
_addon.commands = {'AutoTarget', 'AT'}


require('logger')
require('coroutine')

running = false


function loop()
	while running == true do
	player = windower.ffxi.get_player()
		if player.status == 1 then			
			coroutine.sleep(.5)
		else
			-- windower.add_to_chat(200, 'Trying')
			--AssistParty()
			target1()
			coroutine.sleep(.1)
		end
	end
	windower.add_to_chat(200, 'Something went wrong! Please try your command again after reloading AutoTarget.')
end



function target1()
	windower.send_command('setkey TAB down')
    coroutine.sleep(0.01)
    windower.send_command('setkey TAB up')
    coroutine.sleep(0.1)
		
		player = windower.ffxi.get_player()
		
		if windower.ffxi.get_mob_by_target( 't' ) == nil then
            windower.add_to_chat(200, 'AutoTarget: No target, cycling.' )
			coroutine.sleep (0.1)
			target1()
		elseif windower.ffxi.get_mob_by_target('t').name == "Apex Toad" then
			windower.add_to_chat(200, 'AutoTarget: Found Depthswalker Crab')
			coroutine.sleep(0.5)
			windower.chat.input('/attack <t>')
			coroutine.sleep(2)
        else
            coroutine.sleep(0.1)
			target1()
		end
end	


function AssistParty()
	party = windower.ffxi.get_party()
	for i=1,party.count do
		if player.status == 'Engaged' then
			return
		end
		if party[i].mob == nil or i==1 then
			coroutine.sleep (0.1)
		else		
			windower.chat.input('/assist ..party[i].name..')
			coroutine.sleep (0.1)
			if windower.ffxi.get_mob_by_target( 't' ) ~= nil then
				windower.chat.input('/attack <t>')
				coroutine.sleep (2)
			coroutine.sleep (0.1)
			end
		end
	end
end




function AutoTarget_command(...)
    if #arg > 1 then
        windower.add_to_chat(167, 'Invalid command.')
    elseif #arg == 1 and arg[ 1 ]:lower() == 'start' then
        if running == false then
            running = true
            windower.add_to_chat(200, 'AutoTarget: Begin loop...')
            loop()
        elseif running == true then
            windower.add_to_chat(200, 'It appears AutoTarget is already running an action, please use //AutoTarget abort to reload the addon and try again.')
        end
    elseif #arg == 1 and arg[ 1 ]:lower() == 'stop' then
        if running == false then
            windower.add_to_chat(200, 'AutoTarget: There are no current actions to stop. Use //AutoTarget abort to force-reload the addon if necessary.')
		elseif running == true then
			windower.add_to_chat(200, 'AutoTarget: Aborting all actions and reloading.')
			windower.send_command('lua reload AutoTarget')
        end
	elseif #arg == 1 and arg[ 1 ]:lower() == 'abort' then
        windower.add_to_chat(200, 'AutoTarget: Aborting all actions and reloading.')
		windower.send_command('lua reload AutoTarget')
	elseif #arg == 1 and arg[ 1 ]:lower() == 'help' then
        windower.add_to_chat(200, 'AutoTarget commands: start stop abort plant harvest. See readme for additional information.')
	elseif #arg == 1 and arg[ 1 ]:lower() == 'ki' then
        windower.add_to_chat(200, 'Checking Key Items')
		Check_KI()
	else
		end
end

windower.register_event('addon command', AutoTarget_command)