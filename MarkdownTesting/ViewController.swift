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
        case swift = "Swift"
        case tomorrowBright = "Tomorrow-Night-Bright"
        case tomorrow = "Tomorrow"

        var extensionType: String {
            switch self {
            case .swift:
                return "tmLanguage"
            case .tomorrowBright:
                return "tmTheme"
            case .tomorrow:
                return "tmTheme"
            }
        }
    }

    enum ThemeApplied: Int {
        case tomorrow = 0
        case tomorrowBright = 1
    }

    fileprivate var scrollView: UIScrollView?

    fileprivate var contentView = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize.zero))

    fileprivate var codeLabel: UILabel?

    fileprivate var manager = BundleManager {
        (identifier, isLanguage) -> (URL?) in
        guard let type = TmType(rawValue: identifier)
            else { return nil }
        return Bundle.main.url(forResource: type.rawValue,
                               withExtension: type.extensionType)
    }

    var code = "#Nimport Foundation#Nimport UIKit#N#Nvar str = \"Hello, playground\"#N#Nstruct StringLayoutHandler {#N#T#N#Tprivate var tabLength: TabLength#N#Tprivate var maxCharactersPerLine: Int#N#Tprivate let monoSpacedFontName = \"Menlo-Regular\"#N#Tprivate let font: UIFont#N#T#N#Tenum TabLength: Int {#N#T#Tcase short = 2#N#T#Tcase regular = 4#N#T#T#N#T#Tfunc padding() -> String {#N#T#T#Treturn \"\".padding(toLength: rawValue, withPad: \" \", startingAt: 0)#N#T#T}#N#T}#N#T#N#Tinit?(tabLength: TabLength, viewWidth: CGFloat, fontSize: CGFloat) {#N#T#Tself.tabLength = tabLength#N#T#Tguard let font = UIFont(name: monoSpacedFontName, size: fontSize)#N#T#T#Telse {  return nil }#N#T#Tself.font = font#N#T#Tlet testString = \"H31l0&GR8!\" as NSString#N#T#Tlet boundingRectWidth = testString.size(attributes: [NSFontAttributeName: font]).width#N#T#Tlet widthPerChar = boundingRectWidth / CGFloat(testString.length)#N#T#Tself.maxCharactersPerLine = Int(viewWidth / widthPerChar)#N#T}#N#T#N#Tfunc formattedString(input: String) -> String {#N#T#Tvar formatted = input#N#T#Tformatted.replacingOccurrences(of: \"#T\", with: tabLength.padding())#N#T#Tformatted.replacingOccurrences(of: \"#N\", with: \"\n\")#N#T#Treturn formatted#N#T}#N}#N#N"

    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollView()
        updateViews(for: .tomorrow)
    }

    @IBAction func themeChanged(_ sender: UISegmentedControl) {
        guard let theme = ThemeApplied(rawValue: sender.selectedSegmentIndex) else { return }

        updateViews(for: theme)
    }

    fileprivate func setUpScrollView() {
        scrollView = UIScrollView()
        guard let scrollView = self.scrollView else { fatalError() }
        let views: [String: UIView] = ["scrollView": scrollView, "segmented": themeSegmentedControl]
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[segmented]-[scrollView]|", options: [], metrics: nil, views: views)

        NSLayoutConstraint.activate(constraints)
    }

    fileprivate func updateViews(`for` theme: ThemeApplied) {
        switch theme {
        case .tomorrow:
            scrollView?.backgroundColor = .white
        case .tomorrowBright:
            scrollView?.backgroundColor = .black
        }
        setUpCodeLabel(with: theme)
    }

    fileprivate func setUpCodeLabel(with theme: ThemeApplied) {
        let codeString = generateCodeString(styledWith: theme)

        self.codeLabel?.removeFromSuperview()
        let codeLabel = UILabel()
        codeLabel.attributedText = codeString
        codeLabel.frame.size = codeString.size()
        codeLabel.frame.origin = CGPoint(x: 5, y: 5)
        codeLabel.numberOfLines = 0
        self.codeLabel = codeLabel
        scrollView?.contentSize = CGSize(width: codeString.size().width + 10, height: codeString.size().height + 10)
        scrollView?.addSubview(codeLabel)
    }

    fileprivate func generateCodeString(styledWith theme: ThemeApplied) -> NSAttributedString {
        let themeString: String

        switch theme {
        case .tomorrow: themeString = "Tomorrow"
        case .tomorrowBright: themeString = "Tomorrow-Night-Bright"
        }

        guard let font = UIFont(name: "Menlo-Regular", size: 14.0),
            let yaml = manager.language(withIdentifier: "Swift"),
            let themeToApply = manager.theme(withIdentifier: themeString) else { fatalError("Developer Error") }

        let layoutHandler = StringLayoutHandler(tabLength: .regular, font: font)
        let deserializedCode = layoutHandler.deserializedString(input: code)
        let attributedParser = AttributedParser(language: yaml, theme: themeToApply)
        let attributedCodeString = attributedParser.attributedString(for: deserializedCode)
        return layoutHandler.applyFont(to: attributedCodeString)
    }
}
