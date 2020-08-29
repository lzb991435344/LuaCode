


local function func(argv1, argv2)
    --if agrv2 == nil then
    --    argv2 = true
    --end

    if argv1 then
        print("argv1 is not nil",argv1)
    else
        print("argv is nil", argv)
    end

    if argv2 then
        print("argv2 value is "..(type(argv2) == 'boolean' and 'true' or argv2)..'\n')
    else
        print("argv2 value is false", argv2)
    end

end

func(123)  --argv2为nil
func(123, 0) --0为真
func(123, 456)
func(123, nil)
func(123, 'abc')
func(123, true)
func(123, false)
func('lua', 'web')

--[[
argv1 is not nil    123
argv2 value is false    nil
argv1 is not nil    123
argv2 value is 0

argv1 is not nil    123
argv2 value is 456

argv1 is not nil    123
argv2 value is false    nil
argv1 is not nil    123
argv2 value is abc

argv1 is not nil    123
argv2 value is true

argv1 is not nil    123
argv2 value is false    false
argv1 is not nil    lua
argv2 value is web

]]