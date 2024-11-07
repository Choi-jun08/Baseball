//
//  main.swift
//  Level 1 Baseball
//
//  Created by t2023-m0072 on 11/6/24.
//
import Foundation

// 정답 랜덤 생성 (세 자리 모두 1~9)
func generateAnswer() -> [Int] {
    var randomAnswer = Array(1...9).shuffled() // 첫 번째 숫자는 1-9 중에서 선택
    var remainNumbers = Array(0...9).shuffled() // Level 3 구현
    remainNumbers.removeAll { $0 == randomAnswer[0] } // 첫 번째 숫자를 제거하여 중복 방지
    
    // 각 요소를 개별적으로 추가
    randomAnswer.append(remainNumbers[0]) // 첫 번째 남은 숫자 추가
    randomAnswer.append(remainNumbers[1]) // 두 번째 남은 숫자 추가
    
    return randomAnswer
}

// 입력된 숫자가 조건에 맞는지 확인하고 readline()에 의해서 스트링으로 입력되니까 인티저로 전환
func translateInput(_ input: String) -> [Int]? {
    let inputNumber = input.compactMap { $0.wholeNumberValue }
    return inputNumber.count == 3 && Set(inputNumber).count == 3 && inputNumber[0] != 0 ? inputNumber : nil
}

// 볼과 스트라이크 개수를 계산
func countStrikeAndBall(answer: [Int], guess: [Int]) -> (strikes: Int, balls: Int) {
    var strikes = 0
    var balls = 0
    
    // 스트라이크 체크
    for i in 0..<3 {
        if guess[i] == answer[i] {
            strikes += 1
        }
    }
    // 볼 체크
    for i in 0..<3 {
        for j in 0..<3 {
            if i != j && guess[i] == answer[j] { // 자리 다르고 숫자만 같은 경우 볼
                balls += 1
                break
            }
        }
    }

    return (strikes, balls)
}

// 게임을 시작합니다
func baseBallGame() {
    let answer = generateAnswer() // 게임을 할때마다 숫자가 생성되는것이 아닌 한번 시작하면 그 숫자를 계속해서 맞출 수 있도록
    print("숫자 야구 게임을 시작합니다! 세 자리 숫자를 입력하세요 (첫 자리는 0이 될 수 없습니다.)")

    while true {
        if let input = readLine(), let guess = translateInput(input) {
                let (strikes, balls) = countStrikeAndBall(answer: answer, guess: guess)
                
                if strikes == 3 {
                    print("정답입니다!")
                    break
                    
                } else if strikes == 0 && balls == 0 {
                    print("Nothing") // 스트라이크와 볼이 모두 0인 경우
                    
                } else {
                    print("\(strikes) 스트라이크, \(balls) 볼")
                }
            } else {
                print("올바르지 않은 입력값입니다.")
            }
        }
    }

baseBallGame()

