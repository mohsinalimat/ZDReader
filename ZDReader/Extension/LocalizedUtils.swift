-e import Foundation

extension String {
  var localized: String { return NSLocalizedString(self, comment: self) }
/* 
  Localizable.strings
  ZDReader

  Created by Noah on 2017/8/10.
  Copyright © 2017年 ZD. All rights reserved.
*/

  static var localized_login: String { return "Login".localized }
  static var localized_logout: String { return "Logout".localized }
-e 
}
