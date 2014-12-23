//import Foundation
//import Graphite
//import Lua
//
//final class Hotkey: Lua.CustomType {
//    let fn: Int
//    let hotkey: Graphite.Hotkey
//    
//    class func typeName() -> String { return "<Hotkey>" }
//    
//    init(fn: Int, hotkey: Graphite.Hotkey) {
//        self.fn = fn
//        self.hotkey = hotkey
//    }
//    
//    func enable(L: Lua.VirtualMachine) -> Lua.ReturnValue {
//        hotkey.enable()
//        return .Nothing
//    }
//    
//    func disable(L: Lua.VirtualMachine) -> Lua.ReturnValue {
//        hotkey.disable()
//        return .Nothing
//    }
//    
//    class func bind(L: Lua.VirtualMachine) -> Lua.ReturnValue {
//        let key = String(fromLua: L, at: 1)!
//        let modStrings = Lua.SequentialTable<String>(fromLua: L, at: 2)!.elements
//        
//        L.pushFromStack(3)
//        let i = L.ref(Lua.RegistryIndex)
//        
//        let downFn: Graphite.Hotkey.Callback = {
//            L.rawGet(tablePosition: Lua.RegistryIndex, index: i)
//            L.call(arguments: 0, returnValues: 0)
//        }
//        
//        let hotkey = Graphite.Hotkey(key: key, mods: modStrings, downFn: downFn, upFn: nil)
//        switch hotkey.enable() {
//        case let .Error(error):
//            return .Error(error)
//        case .Success:
//            return .Value(Lua.Userdata(Hotkey(fn: i, hotkey: hotkey)))
//        }
//    }
//    
//    func cleanup(L: Lua.VirtualMachine) {
//        hotkey.disable()
//        L.unref(Lua.RegistryIndex, fn)
//    }
//    
//    func equals(other: Hotkey) -> Bool {
//        return fn == other.fn
//    }
//    
//    class func classMethods() -> [(String, [Lua.TypeChecker], Lua.VirtualMachine -> Lua.ReturnValue)] {
//        return [
//            ("bind", [String.arg(), Lua.SequentialTable<String>.arg(), Lua.FunctionBox.arg()], Hotkey.bind),
//        ]
//    }
//    
//    class func instanceMethods() -> [(String, [Lua.TypeChecker], Hotkey -> Lua.VirtualMachine -> Lua.ReturnValue)] {
//        return [
//            ("enable", [], Hotkey.enable),
//            ("disable", [], Hotkey.enable),
//        ]
//    }
//    
//    class func metaMethods() -> [Lua.MetaMethod<Hotkey>] {
//        return [
//            .GC(Hotkey.cleanup),
//            .EQ(Hotkey.equals),
//        ]
//    }
//}
