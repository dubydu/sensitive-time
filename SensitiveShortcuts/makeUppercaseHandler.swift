//
//  makeUppercaseHandler.swift
//  Sensitive
//
//  Created by DU on 08/07/2022.
//

import Intents

class MakeUppercaseIntentHandler: NSObject, SensitiveIntentsIntentHandling {
    func provideTextOptionsCollection(for intent: SensitiveIntentsIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<NSString>?, Error?) -> Void) {
        
    }

    func handle(intent: SensitiveIntentsIntent, completion: @escaping (SensitiveIntentsIntentResponse) -> Void) {
        if let inputText = intent.text {
                let uppercaseText = inputText.uppercased()
                completion(SensitiveIntentsIntentResponse.success(result: uppercaseText))
            } else {
                completion(SensitiveIntentsIntentResponse.failure(error: "The entered text was invalid"))
            }
    }

    func resolveText(for intent: SensitiveIntentsIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let text = intent.text, !text.isEmpty {
            completion(INStringResolutionResult.success(with: text))
        } else {
            completion(INStringResolutionResult.unsupported())
        }
    }

}
