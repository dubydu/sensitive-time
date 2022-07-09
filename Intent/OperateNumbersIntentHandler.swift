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

class OperateNumbersIntentHandler: NSObject,
                                   OperateNumbersIntentHandling {
    func operate(with operation: Operation,
                 firstNumber: Int,
                 secondNumber: Int) -> Int {
        switch operation {
        case .addition:
            return firstNumber + secondNumber
        case .substraction:
            return firstNumber - secondNumber
        case .unknown:
            fatalError("Invalid operation")
        }
    }

    func handle(intent: OperateNumbersIntent,
                completion: @escaping (OperateNumbersIntentResponse) -> Void) {
        let operateResult = operate(with: intent.operation,
                              firstNumber: intent.firstNumber!.intValue,
                              secondNumber: intent.secondNumber!.intValue)
        let result = OperateNumbersIntentResponse
            .success(addition: NSNumber(value: operateResult))
        completion(result)
    }

    func resolveFirstNumber(for intent: OperateNumbersIntent,
                            with completion: @escaping (OperateNumbersFirstNumberResolutionResult) -> Void) {
        var result: OperateNumbersFirstNumberResolutionResult = .unsupported()
        defer { completion(result) }
        if let number = intent.firstNumber?.intValue {
          result = OperateNumbersFirstNumberResolutionResult.success(with: number)
        }
    }

    func resolveSecondNumber(for intent: OperateNumbersIntent,
                             with completion: @escaping (OperateNumbersSecondNumberResolutionResult) -> Void) {
        var result: OperateNumbersSecondNumberResolutionResult = .unsupported()
        defer { completion(result) }
        if let number = intent.secondNumber?.intValue {
          result = OperateNumbersSecondNumberResolutionResult.success(with: number)
        }
    }

    func resolveOperation(for intent: OperateNumbersIntent,
                          with completion: @escaping (OperationResolutionResult) -> Void) {
        var result: OperationResolutionResult = .unsupported()
        defer { completion(result) }
        let operation = intent.operation
        if operation != .unknown {
          result = .success(with: operation)
        }
    }
}
