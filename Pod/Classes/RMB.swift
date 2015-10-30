

import Foundation

public enum RMBChar:Character{
    case Zero = "零"
    case One = "壹"
    case Two = "贰"
    case Three = "叁"
    case Four = "肆"
    case Five = "伍"
    case Six = "陆"
    case Seven = "柒"
    case Eight = "捌"
    case Nine = "玖"
    case Ten = "拾"
    case Hundred = "佰"
    case Thousand = "仟"
    case TenThousand = "万"
    case HundredMillion = "亿"
    
    case Yuan = "元"
    case Jiao = "角"
    case Fen = "分"
    case Round = "整"
    
    static let orderedRMBChars : [RMBChar] = [
        Zero,One,Two,Three,Four,Five,Six,Seven,Eight, Nine,
        Ten,Hundred,TenThousand,HundredMillion
    ]
}



public enum RMBBaseValue:Int{
    case Zero = 0
    case One = 1
    case Two,Three,Four,Five,Six,Seven,Eight,Nine
    case Ten = 10
    case Hundred = 100
    case Thousand = 1000
    case TenThousand = 10000
    case HundredMillion = 100000000
    
    public var lowerBase:RMBBaseValue?{
        switch self{
        case .Ten:
            return .One
        case .Hundred:
            return Ten
        case .Thousand:
            return Hundred
        case .TenThousand:
            return Thousand
        case .HundredMillion:
            return TenThousand
        default:
            return nil
        }
    }
    
   public var unitChar:Character{
        switch self{
        case .Hundred:
            return RMBChar.Hundred.rawValue
        case .Thousand:
            return RMBChar.Thousand.rawValue
        case .TenThousand:
            return RMBChar.TenThousand.rawValue
        case .HundredMillion:
            return RMBChar.HundredMillion.rawValue
        default:
            return RMBChar.orderedRMBChars[self.rawValue].rawValue
        }
    }
    
    public var unitValue:Int{
        return rawValue
    }
    
    public var doubleValue:Double{
        return Double(rawValue)
    }
    
    public static func baseValueOf(number:Double) -> RMBBaseValue{
        if number >= HundredMillion.doubleValue {
            return HundredMillion
        }else if number >= TenThousand.doubleValue {
            return TenThousand
        }else if number >= Thousand.doubleValue {
            return Thousand
        }else if number >= Hundred.doubleValue {
            return Hundred
        }else if number >= Ten.doubleValue {
            return Ten
        }else{
            return One
        }
    }
}



public extension NSDecimalNumber{
    
    func bx_roundByMode(mode:NSRoundingMode = .RoundPlain,scale:Int16 = 2) -> NSDecimalNumber{
        let roundBehavior = NSDecimalNumberHandler(roundingMode: mode, scale: scale, raiseOnExactness: true, raiseOnOverflow: true, raiseOnUnderflow: true, raiseOnDivideByZero: true)
        let roundedNumber = self.decimalNumberByRoundingAccordingToBehavior(roundBehavior)
        return roundedNumber
    }
    
    
    var bx_integerPart:NSDecimalNumber{
        return self.bx_roundByMode(.RoundDown, scale: 0)
    }
    
    var bx_decimalPart: NSDecimalNumber{
        let integerPart  = self.bx_roundByMode(.RoundDown, scale: 0)
        return self.decimalNumberBySubtracting(integerPart)
    }
    
}

public extension Double{
    func bx_roundToAmountOfMoney() -> NSDecimalNumber{
        return NSDecimalNumber(double: self).bx_roundByMode()
    }
    
    func bx_roundByMode(mode:NSRoundingMode = .RoundPlain, scale:Int16 = 2) -> Double{
        return NSDecimalNumber(double: self).bx_roundByMode(mode, scale: scale).doubleValue
    }
}




public func convertNumberToAmountOfRMB(number:Double,onlyIntegerPart:Bool=false) -> String{
    let amount = number.bx_roundToAmountOfMoney()
    let integerPart = amount.bx_integerPart.doubleValue
    let decimalPart = amount.bx_decimalPart
    // integerPart
    var finalChars = [Character]()
    var reminder = integerPart
    var prevBase:RMBBaseValue?
    while reminder > RMBBaseValue.Zero.doubleValue {
        let base = RMBBaseValue.baseValueOf(reminder)
        let divisor = reminder / base.doubleValue
        reminder = reminder % base.doubleValue
        if let lowerBase = prevBase?.lowerBase{
            if lowerBase != base{
                finalChars.append(RMBChar.Zero.rawValue)
            }else if base == RMBBaseValue.TenThousand && divisor < RMBBaseValue.Thousand.doubleValue{
                finalChars.append(RMBChar.Zero.rawValue)
            }
        }
        
        if divisor > RMBBaseValue.Ten.doubleValue {
            finalChars.appendContentsOf(convertNumberToAmountOfRMB(divisor,onlyIntegerPart:true).characters)
        }else{
            let baseCount = RMBBaseValue(rawValue: Int(divisor))!
            if baseCount == RMBBaseValue.Ten{
                finalChars.append(RMBChar.One.rawValue)
            }
            finalChars.append(baseCount.unitChar)
        }
        prevBase = base
        if base == RMBBaseValue.One{
            break
        }else{
            finalChars.append(base.unitChar)
        }
        if reminder < 1.0{
            break
        }
    }
    
    
    if !onlyIntegerPart{
        if finalChars.count > 0 {
            finalChars.append(RMBChar.Yuan.rawValue)
        }
    }
    
    // decimalPart
    
    if !onlyIntegerPart{
        let cents = decimalPart.decimalNumberByMultiplyingByPowerOf10(2).doubleValue
        let jiaoCount = Int(cents / RMBBaseValue.Ten.doubleValue)
        let fenCount = Int(cents % RMBBaseValue.Ten.doubleValue)
        if jiaoCount > 0  || fenCount > 0 {
            if let prevBase = prevBase{
                if prevBase.rawValue > RMBBaseValue.Ten.rawValue{
                    finalChars.append(RMBChar.Zero.rawValue)
                }
            }
        }
        
        if jiaoCount > 0 {
            finalChars.append(RMBBaseValue(rawValue: jiaoCount)!.unitChar)
            finalChars.append(RMBChar.Jiao.rawValue)
        }
        
        if fenCount > 0 {
            if jiaoCount < 1  && prevBase != nil {
                if finalChars.last != RMBChar.Zero.rawValue{
                    finalChars.append(RMBChar.Zero.rawValue)
                }
            }
            
            finalChars.append(RMBBaseValue(rawValue: fenCount)!.unitChar)
            finalChars.append(RMBChar.Fen.rawValue)
        }
        
        if jiaoCount < 1 && fenCount < 1{
            
            finalChars.append(RMBChar.Round.rawValue)
        }
        
    }
    
    return String(finalChars)
}