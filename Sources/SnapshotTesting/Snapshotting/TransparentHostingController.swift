import SwiftUI

/// A UIHostingController subclass that sets its view's background to transparent.
@available(iOS 13.0, tvOS 13.0, *)
final class TransparentHostingController<Content: View>: UIHostingController<Content> {
  override init(rootView: Content) {
    super.init(rootView: rootView)
    view.backgroundColor = .clear
    view.isOpaque = false
  }

  @objc required dynamic init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
