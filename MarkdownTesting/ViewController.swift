//
//  ViewController.swift
//  MarkdownTesting
//
//  Created by Varinda Hart on 11/8/16.
//  Copyright © 2016 ShopKeep. All rights reserved.
//

import UIKit
import SyntaxKit

class ViewController: UIViewController {
    
    enum TmType: String {
        case Swift
        case Tomorrow = "Tomorrow-Night-Bright"
        
        var extensionType: String {
            switch self {
            case .Swift:
                return "tmLanguage"
            case .Tomorrow:
                return "tmTheme"
            }
        }
    }

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = BundleManager { (identifier, isLanguage) -> (URL?) in
            guard let type = TmType(rawValue: identifier) else { return nil }
            return Bundle.main.url(forResource: type.rawValue,
                                   withExtension: type.extensionType)
        }
        let yaml = manager.language(withIdentifier: "Swift")!
        let tomorrow = manager.theme(withIdentifier: "Tomorrow-Night-Bright")!
        let attributedParser = AttributedParser(language: yaml, theme: tomorrow)

        let input = "func do() -> String {\n    return String(format: \"EUREKA\")\n}"
        let font = UIFont.boldSystemFont(ofSize: 18.0)
        let attributes = [NSFontAttributeName: font]
        let attText = attributedParser.attributedString(for: input, base: attributes)
        let mutAtt = NSMutableAttributedString(attributedString: attText)
        mutAtt.beginEditing()
        let fullRange = NSMakeRange(0, mutAtt.length)
        mutAtt.removeAttribute(NSFontAttributeName, range: fullRange)
        mutAtt.addAttributes(attributes, range: fullRange)
        mutAtt.endEditing()
        textView.attributedText = mutAtt
    }
}

extension ViewController {
    func themeFromBundle() -> [String: AnyObject]? {
        guard let path = Bundle.main.path(forResource: "Tommorow-Night-Bright", ofType: "tmTheme"),
        let myDict = NSDictionary(contentsOfFile: path) as? [String: AnyObject]
            else { return nil }
        return myDict
    }
    /*
    func languageFromBundle() -> Language? {
        guard let path = Bundle.main.path(forResource: "Swift", ofType: "tmLanguage"),
        let plist = NSDictionary(contentsOfFile: path)! as? [String: AnyObject]
            else { return nil }
        return Language(dictionary: plist)
    }
 */
}
