//: Playground - noun: a place where people can play

import UIKit
import Foundation

extension UIColor {
    convenience init? (fromHex hex: String) {
        let hexPattern = try! NSRegularExpression(pattern: "^[0-9a-fA-F]{6}$",
                                                  options: [.anchorsMatchLines])
        let range =  NSRange(location: 0, length: hex.characters.count)

        guard hexPattern.matches(in: hex,
                                         options: [],
                                         range: range).count == 1
            else { return nil }

        let positionR = hex.index(hex.startIndex, offsetBy: 2)
        let positionG = hex.index(hex.startIndex, offsetBy: 4)

        guard let r = Double("0x" + hex.substring(to: positionR)),
            let g = Double("0x" + hex.substring(with: positionR..<positionG)),
            let b = Double("0x" + hex.substring(from: positionG)) else { return nil }

        self.init(red: CGFloat(r / 255), green: CGFloat(g / 255), blue: CGFloat(b / 255), alpha: 1)
    }
}

let white = UIColor(fromHex: "FFFFFF")

let jungleGreen = UIColor(fromHex: "26A195")

let rebeccaPurple = UIColor(fromHex: "633799")

let dingyDungeon = UIColor(fromHex: "C13A4A")

let spiroDiscoBall = UIColor(fromHex: "30C3FF")

let charcoal = UIColor(fromHex: "2F404E")

let gunmetal = UIColor(fromHex: "232F39")

let granite = UIColor(fromHex: "626868")

let emerald = UIColor(fromHex: "2D936C")

let deepViolet = UIColor(fromHex: "391463")

let arsenic = UIColor(fromHex: "3A4454")

let payneGray = UIColor(fromHex: "53687E")

let egyptianBlue = UIColor(fromHex: "0E34A0")

let fuzzyWuzzy = UIColor(fromHex: "C1666B")

let deepKaomaru = UIColor(fromHex: "2B4570")

let sapphire = UIColor(fromHex: "006BA6")

let azure = UIColor(fromHex: "0496FF")

let raspberry = UIColor(fromHex: "8F2D56")

let debianRed = UIColor(fromHex: "D81159")

let spaceCadetPurple = UIColor(fromHex: "241E4E")

let rand1 = UIColor(fromHex: "D54E53")

let rand2 = UIColor(fromHex: "E78C45")

let rand3 = UIColor(fromHex: "E7C547")

let rand4 = UIColor(fromHex: "B9CA4A")

let rand5 = UIColor(fromHex: "70C0B1")

let rand6 = UIColor(fromHex: "7AA6DA")

let rand7 = UIColor(fromHex: "82A3BF")

let rand8 = UIColor(fromHex: "CED2CF")

let rand9 = UIColor(fromHex: "C397D8")


"#Nimport Foundation#Nimport UIKit#N#Nvar str = \"Hello, playground\"#N#Nstruct StringLayoutHandler {#N#T#N#Tprivate var tabLength: TabLength#N#Tprivate var maxCharactersPerLine: Int#N#Tprivate let monoSpacedFontName = \"Menlo-Regular\"#N#Tprivate let font: UIFont#N#T#N#Tenum TabLength: Int {#N#T#Tcase short = 2#N#T#Tcase regular = 4#N#T#T#N#T#Tfunc padding() -> String {#N#T#T#Treturn \"\".padding(toLength: rawValue, withPad: \" \", startingAt: 0)#N#T#T}#N#T}#N#T#N#Tinit?(tabLength: TabLength, viewWidth: CGFloat, fontSize: CGFloat) {#N#T#Tself.tabLength = tabLength#N#T#Tguard let font = UIFont(name: monoSpacedFontName, size: fontSize)#N#T#T#Telse {  return nil }#N#T#Tself.font = font#N#T#Tlet testString = \"H31l0&GR8!\" as NSString#N#T#Tlet boundingRectWidth = testString.size(attributes: [NSFontAttributeName: font]).width#N#T#Tlet widthPerChar = boundingRectWidth / CGFloat(testString.length)#N#T#Tself.maxCharactersPerLine = Int(viewWidth / widthPerChar)#N#T}#N#T#N#Tfunc formattedString(input: String) -> String {#N#T#Tvar formatted = input#N#T#Tformatted.replacingOccurrences(of: \"#T\", with: tabLength.padding())#N#T#Tformatted.replacingOccurrences(of: \"#N\", with: \"\n\")#N#T#Treturn formatted#N#T}#N}#N#N"