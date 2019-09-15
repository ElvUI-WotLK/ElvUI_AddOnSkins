local E, L, V, P, G = unpack(ElvUI)
local AS = E:GetModule("AddOnSkins")

local ipairs = ipairs
local select = select
local floor = math.floor

local EnumerateFrames = EnumerateFrames

local function round(x)
	return floor(x + 0.5)
end

function AS:GetObjectChildren(obj, childID, list)
	if not obj then return end

	if not childID then
		childID = obj:GetNumChildren()
	elseif childID < 0 then
		childID = obj:GetNumChildren() + childID
	end

	if not list then
		return (select(childID, obj:GetChildren()))
	else
		return select(childID, obj:GetChildren())
	end
end

function AS:FindChildFrameByPoint(parent, objType, point1, relativeTo, point2, x, y)
	if not parent then return end

	local childPoint1, childParent, childPoint2, childX, childY

	x = round(x)
	y = round(y)

	for id, child in ipairs({parent:GetChildren()}) do
		if not child:GetName() and (not objType or (objType and child:IsObjectType(objType))) then
			childPoint1, childParent, childPoint2, childX, childY = child:GetPoint()
			childX = childX and round(childX) or 0
			childY = childY and round(childY) or 0

			if childPoint1 == point1
			and childParent == relativeTo
			and (not point2 or (childPoint2 == point2))
			and x == childX
			and y == childY
			then
				return child, id
			end
		end
	end
end

function AS:FindChildFrameBySize(parent, objType, width, height)
	if not parent then return end

	width = round(width)
	height = round(height)

	for id, child in ipairs({parent:GetChildren()}) do
		if not child:GetName() then
			if not objType or (objType and child:IsObjectType(objType)) then
				if round(child:GetWidth()) == width and round(child:GetHeight()) == width and round(child:GetHeight()) == height then
					return child, id
				end
			end
		end
	end
end

function AS:FindFrameBySizeChild(childTypes, width, height)
	if not childTypes then return end

	local singleChild = type(childTypes) == "string"
	local obj = EnumerateFrames()

	width = round(width)
	height = round(height)

	while obj do
		if obj.IsObjectType and obj:IsObjectType("Frame") and (not (obj:GetName() and obj:GetParent())) then
			if round(obj:GetWidth()) == width and round(obj:GetHeight()) == height then
				local childs = {}

				for _, child in pairs({obj:GetChildren()}) do
					childs[#childs + 1] = child:GetObjectType()
				end

				local matched = 0
				for _, cType1 in ipairs(childs) do
					if not singleChild then
						for _, cType2 in ipairs(childTypes) do
							if cType1 == cType2 then
								matched = matched + 1
							end
						end
					elseif cType1 == childTypes then
						return obj
					end
				end

				if matched == #childTypes then
					return obj
				end
			end
		end

		obj = EnumerateFrames(obj)
	end
end

function AS:FindFrameByPoint(point1, relativeTo, point2, x, y, multipleFrames)
	if not relativeTo then return end

	local frame
	if multipleFrames then
		frame = {}
	end

	local childPoint1, childParent, childPoint2, childX, childY
	local obj = EnumerateFrames()

	x = round(x)
	y = round(y)

	while obj do
		if obj.IsObjectType and obj:IsObjectType("Frame") and (not (obj:GetName() and obj:GetParent())) then
			childPoint1, childParent, childPoint2, childX, childY = obj:GetPoint()
			childX = childX and round(childX) or 0
			childY = childY and round(childY) or 0

			if childPoint1 == point1
			and childParent == relativeTo
			and (not point2 or (childPoint2 == point2))
			and x == childX
			and y == childY
			then
				if multipleFrames then
					frame[#frame + 1] = obj
				else
					frame = obj
					break
				end
			end
		end

		obj = EnumerateFrames(obj)
	end

	return frame
end