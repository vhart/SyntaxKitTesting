
import Foundation
import UIKit

var str = "Hello, playground"

struct StringLayoutHandler {

    private var tabLength: TabLength
    private var maxCharactersPerLine: Int
    private let monoSpacedFontName = "Menlo-Regular"
    private let font: UIFont

    enum TabLength: Int {
        case short = 2
        case regular = 4

        func padding() -> String {
            return "".padding(toLength: rawValue, withPad: " ", startingAt: 0)
        }
    }

    init?(tabLength: TabLength, viewWidth: CGFloat, fontSize: CGFloat) {
        self.tabLength = tabLength
        guard let font = UIFont(name: monoSpacedFontName, size: fontSize)
            else {  return nil }
        self.font = font
        let testString = "H31l0&GR8!" as NSString
        let boundingRectWidth = testString.size(attributes: [NSFontAttributeName: font]).width
        let widthPerChar = boundingRectWidth / CGFloat(testString.length)
        self.maxCharactersPerLine = Int(viewWidth / widthPerChar)
    }

    func formattedString(input: String) -> String {
        var formatted = input
        formatted = formatted.replacingOccurrences(of: "#T", with: tabLength.padding())
        formatted = formatted.replacingOccurrences(of: "#N", with: "\n")
        return formatted
    }
}

let slh = StringLayoutHandler(tabLength: .regular, viewWidth: 200, fontSize: 12)
print(slh?.formattedString(input: "#Nimport Foundation#Nimport UIKit#N#Nvar str = \"Hello, playground\"#N#Nstruct StringLayoutHandler {#N#T#N#Tprivate var tabLength: TabLength#N#Tprivate var maxCharactersPerLine: Int#N#Tprivate let monoSpacedFontName = \"Menlo-Regular\"#N#Tprivate let font: UIFont#N#T#N#Tenum TabLength: Int {#N#T#Tcase short = 2#N#T#Tcase regular = 4#N#T#T#N#T#Tfunc padding() -> String {#N#T#T#Treturn \"\".padding(toLength: rawValue, withPad: \" \", startingAt: 0)#N#T#T}#N#T}#N#T#N#Tinit?(tabLength: TabLength, viewWidth: CGFloat, fontSize: CGFloat) {#N#T#Tself.tabLength = tabLength#N#T#Tguard let font = UIFont(name: monoSpacedFontName, size: fontSize)#N#T#T#Telse {  return nil }#N#T#Tself.font = font#N#T#Tlet testString = \"H31l0&GR8!\" as NSString#N#T#Tlet boundingRectWidth = testString.size(attributes: [NSFontAttributeName: font]).width#N#T#Tlet widthPerChar = boundingRectWidth / CGFloat(testString.length)#N#T#Tself.maxCharactersPerLine = Int(viewWidth / widthPerChar)#N#T}#N#T#N#Tfunc formattedString(input: String) -> String {#N#T#Tvar formatted = input#N#T#Tformatted.replacingOccurrences(of: \"#T\", with: tabLength.padding())#N#T#Tformatted.replacingOccurrences(of: \"#N\", with: \"\n\")#N#T#Treturn formatted#N#T}#N}#N#N"))

//: [Next](@next)
