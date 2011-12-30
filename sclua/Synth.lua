Synth = {}
Synth.__index = Synth

function Synth:new(name, args)
   local snth = {}
   setmetatable(snth, Synth)
   local nodeID = nextNodeID()
   snth.nodeID = nodeID
   snth.name = name
   snth.args = parseArgsX(args) -- convert the arg table into a string
   s:sendMsg('/s_new', snth.name, snth.nodeID, 0, 1, unpack(snth.args)) -- WORKS!
   return snth
end

function Synth:set(args)
	local args = parseArgsX(args)
	s:sendMsg('/n_set', self.nodeID, unpack(args) )
end

function Synth:setn(args)
	local args = parseArgsX(args)
	s:sendMsg('/n_set', self.nodeID, unpack(args) )
end

function Synth:above(aSynth)
	s:sendMsg('/n_before', self.nodeID, aSynth.nodeID )
end

function Synth:below(aSynth)
	s:sendMsg('/n_after', self.nodeID, aSynth.nodeID )
end

function Synth:moveToHead(aNode)
	s:sendMsg('/g_head', aNode.nodeID, self.nodeID )
end

function Synth:moveToTail(aNode)
	s:sendMsg('/g_tail', aNode.nodeID, self.nodeID )
end

function Synth:free()
	s:sendMsg('/n_free', self.nodeID )
end

function Synth:run(arg)
	s:sendMsg('/n_run', self.nodeID, arg)
end

function Synth:getNodeID()
	return self.nodeID
end