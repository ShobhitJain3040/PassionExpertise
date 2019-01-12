


import UIKit

public class ProgressHud: UIView {
  var activityIndicator: UIActivityIndicatorView!
  var textLabel: UILabel!
  weak fileprivate var parentView: UIView!
  var isProgressHudAllowed: Bool = true
  /// Use this initilizer, also initialises the MBProgressHUD
  public init(frame: CGRect, onView: UIView) {
    super.init(frame: frame)
    self.parentView = onView
    self.activityIndicator = UIActivityIndicatorView(frame: self.parentView.frame)
    self.activityIndicator.style = .white
    self.activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
    self.activityIndicator.hidesWhenStopped = true;
    self.addSubview(self.activityIndicator)
    self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    self.parentView.addSubview(self)
    self.textLabel = UILabel()
    self.textLabel.textAlignment = .center
    self.textLabel.textColor = UIColor.white
    self.addSubview(textLabel)
    self.textLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 20))
    self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 10))
    self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -10))
    self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: self.parentView.frame.height/2 + 30))
    
    //hide this initially
    self.isHidden = true
  }
  
  /// Required init
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  /// This will through assert, use `init(frame: CGRect, onView: UIView)` initializer
  public override init(frame: CGRect) {
    super.init(frame: frame)
    assertionFailure("Use init(frame: CGRect, onView: UIView) initializer.")
  }
  
  /// Sets the loading text
  public func setText(_ text: String) {
    self.textLabel.text = text
  }
  
  ///Use this when you arent sure of what message should be shown on progress hud
  public func showHud() {
    self.showHudWithLocalizedString(message: "Loading")
  }
  
  /// Use this method to show a progress hud with message
  ///
  ///
  /// - parameters:
  ///   - message: the message
  public func showHudWithLocalizedString(message: String) {
    guard isProgressHudAllowed
      else {
      return
    }
    
    self.isHidden = false

    if self.parentView != nil {
      self.parentView.bringSubviewToFront(self)
    }
    self.setText(message)
    self.activityIndicator.isHidden = false
    self.activityIndicator.startAnimating()
  }
  
  /// This method hides the progress hud
  public func hideHud() {
    self.isHidden = true
    self.activityIndicator.stopAnimating()
  }
}
