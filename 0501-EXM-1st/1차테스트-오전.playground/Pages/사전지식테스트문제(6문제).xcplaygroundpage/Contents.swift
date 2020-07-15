//: [Previous](@previous)

/*
 "Hello, World!" 문자열을 출력하기 위한 코드 작성
 */

print("Hello, World!")

/*
 2개의 정수를 입력 받아서 그 숫자들을 더한 뒤 결과를 정수로 반환하는 함수 작성
 */
func intSum(num1: Int, num2: Int) -> Int {
    return num1 + num2
}
intSum(num1: 1, num2: 1)

/*
 2개의 정수를 입력 받아 그 숫자들을 곱한 뒤 결과값을 문자열로 반환하는 함수 작성
 */
func intMulit(num1: Int, num2: Int) -> String {
    return String(num1 * num2)
}
intMulit(num1: 2, num2: 3)

/*
 주어진 숫자가 짝수인지 홀수인지 판단하는 함수 작성 (switch 문으로 해결)
 */
func 홀짝(input: Int) -> String {
    let result: Int = input % 2
    switch result {
    case 0:
        return "짝"
    default:
        return "홀"
    }
}
홀짝(input: 13)

/*
 Swift 3가지 다른 반복문 방식별로 각각 1부터 10까지 값을 더한 결과를 출력하는 코드 작성
 */
func tenSum() {
    var count: Int = 0
    var num: Int = 0
    
    while count <= 10 {
        num = num + count
        count += 1
    }
    print("while: \(num)")
    
    num = 0
    count = 0
    
    repeat {
        num = num + count
        count += 1
    } while count <= 10
    
    print("repeat-while: \(num)")
    
    num = 0
    count = 0
    
    for n in 1...10 {
        num = num + n
    }
    print("for: \(num)")
    
    
}
tenSum()
/*
 Swift 에서 사용하는 네이밍 컨벤션의 종류를 나열하고 그것이 언제 사용되는지,
 그리고 그 특징에 대해 설명
 */
//small camel case: 함수, 변수 명
//big camel case: 구조체, 클래스, 열거형, 타입 명




/*
 사전 지식 테스트 때 위 내용들을 제대로 푸신 분이 거의 없었는데
 지금은 대부분 많이 쉽죠?
 그만큼 많이 발전하셨습니다. :)
 */

//: [Next](@next)
