/*
  Copyright © 2022 DUBYDU

  This software is provided 'as-is', without any express or implied warranty.
  In no event will the authors be held liable for any damages arising from
  the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
  claim that you wrote the original software. If you use this software in a
  product, an acknowledgment in the product documentation would be
  appreciated but is not required.

  2. Altered source versions must be plainly marked as such, and must not be
  misrepresented as being the original software.

  3. This notice may not be removed or altered from any source distribution.
 */

import Foundation
import Intents

class MakeUppercaseIntentHandler: NSObject, SensitiveIntentsIntentHandling {
    func resolveText(for intent: SensitiveIntentsIntent, with completion: @escaping (SensitiveIntentsTextResolutionResult) -> Void) {
        print("============Resolve intent============")
        if let text = intent.text, !text.isEmpty {
            completion(
                SensitiveIntentsTextResolutionResult.success(with: text)
            )
        } else {
            completion(
                SensitiveIntentsTextResolutionResult.unsupported(forReason: .noText)
            )
        }
    }

    func handle(intent: SensitiveIntentsIntent,
                completion: @escaping (SensitiveIntentsIntentResponse) -> Void) {
        print("============Handle intent============")
        /*
        NotificationCenter
            .default
            .post(name: NSNotification.Name(rawValue: "intent"), object: intent)
         */
        if let inputText = intent.text {
            let uppercaseText = inputText.uppercased()
            completion(
                SensitiveIntentsIntentResponse.success(result: uppercaseText)
            )
        } else {
            completion(
                SensitiveIntentsIntentResponse.failure(error: "The entered text was invalid")
            )
        }
    }

    func confirm(intent: SensitiveIntentsIntent, completion: @escaping (SensitiveIntentsIntentResponse) -> Void) {
        print("============Confirm intent============")
        NotificationCenter
            .default
            .post(name: NSNotification.Name(rawValue: "intent"), object: intent)
    }

    func provideTextOptionsCollection(for intent: SensitiveIntentsIntent,
                                      searchTerm: String?,
                                      with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        print("============Search intent============")
    }
}
