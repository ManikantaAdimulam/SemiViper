//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 colors.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 2 files.
  struct file {
    /// Resource file `.swiftlint.yml`.
    static let swiftlintYml = Rswift.FileResource(bundle: R.hostingBundle, name: ".swiftlint", pathExtension: "yml")
    /// Resource file `README.md`.
    static let readmeMd = Rswift.FileResource(bundle: R.hostingBundle, name: "README", pathExtension: "md")
    
    /// `bundle.url(forResource: ".swiftlint", withExtension: "yml")`
    static func swiftlintYml(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.swiftlintYml
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "README", withExtension: "md")`
    static func readmeMd(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.readmeMd
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 1 images.
  struct image {
    /// Image `back`.
    static let back = Rswift.ImageResource(bundle: R.hostingBundle, name: "back")
    
    /// `UIImage(named: "back", bundle: ..., traitCollection: ...)`
    static func back(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.back, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 1 nibs.
  struct nib {
    /// Nib `CustomAlertVC`.
    static let customAlertVC = _R.nib._CustomAlertVC()
    
    /// `UINib(name: "CustomAlertVC", in: bundle)`
    static func customAlertVC(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.customAlertVC)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 0 reuse identifiers.
  struct reuseIdentifier {
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 4 storyboards.
  struct storyboard {
    /// Storyboard `ExampleModule`.
    static let exampleModule = _R.storyboard.exampleModule()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Onboarding`.
    static let onboarding = _R.storyboard.onboarding()
    /// Storyboard `UserManagement`.
    static let userManagement = _R.storyboard.userManagement()
    
    /// `UIStoryboard(name: "ExampleModule", bundle: ...)`
    static func exampleModule(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.exampleModule)
    }
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Onboarding", bundle: ...)`
    static func onboarding(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.onboarding)
    }
    
    /// `UIStoryboard(name: "UserManagement", bundle: ...)`
    static func userManagement(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.userManagement)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 0 localization keys.
    struct localizable {
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    struct _CustomAlertVC: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "CustomAlertVC"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try exampleModule.validate()
      try userManagement.validate()
      try onboarding.validate()
    }
    
    struct exampleModule: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = ExampleModuleViewController
      
      let bundle = R.hostingBundle
      let exampleModuleStoryboard = StoryboardViewControllerResource<ExampleModuleViewController>(identifier: "ExampleModuleStoryboard")
      let name = "ExampleModule"
      
      func exampleModuleStoryboard(_: Void = ()) -> ExampleModuleViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: exampleModuleStoryboard)
      }
      
      static func validate() throws {
        if _R.storyboard.exampleModule().exampleModuleStoryboard() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'exampleModuleStoryboard' could not be loaded from storyboard 'ExampleModule' as 'ExampleModuleViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    struct onboarding: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = OnboardingViewController
      
      let bundle = R.hostingBundle
      let name = "Onboarding"
      let onboardingViewController = StoryboardViewControllerResource<OnboardingViewController>(identifier: "OnboardingViewController")
      
      func onboardingViewController(_: Void = ()) -> OnboardingViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: onboardingViewController)
      }
      
      static func validate() throws {
        if _R.storyboard.onboarding().onboardingViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'onboardingViewController' could not be loaded from storyboard 'Onboarding' as 'OnboardingViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct userManagement: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let forgetPasswordViewController = StoryboardViewControllerResource<ForgetPasswordViewController>(identifier: "ForgetPasswordViewController")
      let loginViewController = StoryboardViewControllerResource<LoginViewController>(identifier: "LoginViewController")
      let name = "UserManagement"
      let signUpViewController = StoryboardViewControllerResource<SignUpViewController>(identifier: "SignUpViewController")
      
      func forgetPasswordViewController(_: Void = ()) -> ForgetPasswordViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: forgetPasswordViewController)
      }
      
      func loginViewController(_: Void = ()) -> LoginViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: loginViewController)
      }
      
      func signUpViewController(_: Void = ()) -> SignUpViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: signUpViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "back") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'back' is used in storyboard 'UserManagement', but couldn't be loaded.") }
        if _R.storyboard.userManagement().forgetPasswordViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'forgetPasswordViewController' could not be loaded from storyboard 'UserManagement' as 'ForgetPasswordViewController'.") }
        if _R.storyboard.userManagement().signUpViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'signUpViewController' could not be loaded from storyboard 'UserManagement' as 'SignUpViewController'.") }
        if _R.storyboard.userManagement().loginViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'loginViewController' could not be loaded from storyboard 'UserManagement' as 'LoginViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}