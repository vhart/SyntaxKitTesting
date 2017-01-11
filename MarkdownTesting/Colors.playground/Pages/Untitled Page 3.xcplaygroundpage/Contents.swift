import UIKit#Nimport Foundation#N#Nstruct StringLayoutHandler {#N#N#Tprivate static var monospacedMenloFontName = "Menlo-Regular"#N#N#Tenum SerializationTokens: String {#N#T#Tcase tab = "#T"#N#T#Tcase newline = "#N"#N#T}#N#N#Tenum TabLength: Int {#N#T#Tcase short = 2#N#T#Tcase regular = 4#N#N#T#Tfunc padding() -> String {#N#T#T#Treturn "".padding(toLength: rawValue, withPad: " ", startingAt: 0)#N#T#T}#N#T}#N#N#Tprivate var tabLength: TabLength#N#Tprivate var font: UIFont#N#N#Tinit(tabLength: TabLength, font: UIFont) {#N#T#Tself.tabLength = tabLength#N#T#Tself.font = font#N#T}#N#N#Tfunc deserializedString(input: String) -> String {#N#T#Tvar formatted = input#N#T#Tformatted = formatted.replacingOccurrences(of: SerializationTokens.tab.rawValue, with: tabLength.padding())#N#T#Tformatted = formatted.replacingOccurrences(of: SerializationTokens.newline.rawValue, with: "\\n")#N#T#Treturn formatted#N#T}#N#N#Tfunc applyFont(to input: NSAttributedString) -> NSAttributedString {#N#T#Tlet attributes = [NSFontAttributeName: font]#N#T#Tlet styledString = NSMutableAttributedString(attributedString: input)#N#T#TstyledString.beginEditing()#N#T#Tlet fullRange = NSMakeRange(0, styledString.length)#N#T#TstyledString.removeAttribute(NSFontAttributeName, range: fullRange)#N#T#TstyledString.addAttributes(attributes, range: fullRange)#N#T#TstyledString.endEditing()#N#T#Treturn styledString#N#T}#N}#N