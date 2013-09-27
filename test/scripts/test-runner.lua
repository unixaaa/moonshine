-- Lua VM test suite.
-- (c) Gamesys Limited 2013


do
	local passed, failed = 0, 0
	local startTime
	local currentFile


	if getTimestamp then
		startTime = getTimestamp()
	end


	function assertTrue (condition, message)
		if not condition then 
			failed = failed + 1
			reportError(message)
		else
			passed = passed + 1
		end
		
		return condition
	end
	
	
	function assertEqual (actual, expected, message)
		if actual ~= expected and (actual == actual or expected == expected) then 
			failed = failed + 1
			reportError(message..'; expected "'..tostring(expected)..'", got "'..tostring(actual)..'".')
		else
			passed = passed + 1
		end
		
		return condition
	end
	
	
	function run (modName)
		currentFile = modName
		require(modName)
	end


	function reportError (message)
		if currentFile ~= lastErrorFile then
			print('\n-['..currentFile..']-----------------------------------------')
		end

		lastErrorFile = currentFile
		print('- '..message)
	end


	function showResults ()		
		local durationStr = ''

		if getTimestamp then
			local endTime = getTimestamp()
			durationStr = '\nCompleted in '..(endTime - startTime)..'ms.'
		end

		print "\n------------------------"
		if failed == 0 then
			print " Passed."
		else
			print "FAILED!"
		end

		print "------------------------\n"		
		print ("Total asserts: "..(passed + failed).."; Passed: "..passed.."; Failed: "..failed..durationStr)
	end

end




run 'scripts.operators'
run 'scripts.functions'
run 'scripts.tables'
run 'scripts.control-structures'
run 'scripts.coercion'
run 'scripts.metamethods'
run 'scripts.lib'
run 'scripts.lib-string'
run 'scripts.lib-table'
run 'scripts.lib-math'
run 'scripts.lib-coroutine'
run 'scripts.lib-date'



showResults()

