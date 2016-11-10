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

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let manager = BundleManager { (identifier, isLanguage) -> (URL?) in
            if identifier == "Swift" {
            return Bundle.main.url(forResource: identifier,
                                   withExtension: "tmLanguage")
            } else {
                return Bundle.main.url(forResource: identifier, withExtension: "tmTheme")
            }
        }
        let yaml = manager.language(withIdentifier: "Swift")!
        let tomorrow = manager.theme(withIdentifier: "Tomorrow-Night-Bright")!
        let attributedParser = AttributedParser(language: yaml, theme: tomorrow)

        let input = "func do() -> String {\n    return \"EUREKA\"\n}"
        textView.attributedText = attributedParser.attributedString(for: input)
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
