import Foundation

/*
 다음의 클로져를 FullSyntax 로부터 Optimized Syntax 로 차근차근 줄여보세요.
 그리고 그 과정에 일어나는 변화를 주석으로 설명하세요.
 
 func performClosure(param: (String) -> Int) {
   param("Swift")
 }
 */

func performClosure(param: (String) -> Int) {
  param("Swift")
}
//
//(param: (String) -> Int) { // 함수명 삭제
//    param("Swift")
//}



/*
 자연수 하나를 입력받아 1년부터 그 해까지의 모든 윤년의 개수를 출력하는 함수
 (공식 : 매 4년 마다 윤년. 매 100년 째에는 윤년이 아님. 매 400년 째에는 윤년)
 윤년O 예시 - 160, 204, 400, 1996, 2000, 2800
 윤년X 예시 - 200, 300, 500, 600, 1900, 2100
 
 Intput : 2019
 Output : 윤년에 속하는 해는 총 489회입니다.
 */




/*
 주어진 문자 배열에서 중복되지 않는 문자만을 뽑아내 배열로 반환해주는 함수
 e.g.
 > Input : ["a", "b", "c", "a", "e", "d", "c"]
 > Output : ["b", "e" ,"d"]
 */

func selector(input: [String]) -> [String] {
    var resultArry: [String] = []
    for i in input {
        if input.firstIndex(of: i) == input.lastIndex(of: i) {
            resultArry.append(i)
        }
    }
    return resultArry
}
let inputArry: [String] = ["a", "b", "c", "a", "e", "d", "c"]
selector(input: inputArry)


/*
 자연수를 입력받아 그 숫자보다 작거나 같은 모든 소수와 그 개수를 출력하는 함수를 정의
 
 e.g.
 func checkPrimeNumbers(number: Int)
 > Input : 10
 > Output : 10보다 작거나 같은 소수는 [2, 3, 5, 7]이고, 총 4개입니다.
 */

func checkPrimeNumbers(number: Int) {
}

checkPrimeNumbers(number: 1)
checkPrimeNumbers(number: 10)
checkPrimeNumbers(number: 100)



/*
 구글(google), 카카오(kakao), 네이버(naver) 로그인을 위해 Site라는 이름의 Enum 타입을 만들고자 합니다.
 각 case는 사용자의 아이디(String)와 비밀번호(String)를 위한 연관 값(associated value)을  가집니다.
 그리고 Site 타입 내부에는 signIn()이라는 이름의 메서드를 만들어 다음과 같이 문자열을 출력하는 기능을 구현해보세요.
 
 e.g.
 enum Site {}
 > Input
 let google = Site.google("google@gmail.com", "0000")
 google.signIn()
 
 > Output
 구글에 로그인하였습니다. (아이디 - google@gmail.com, 비밀번호 - 0000)
 */

enum Site {
    case google(email: String, pw: String)
    case kakao(email: String, pw: String)
    case naver(email: String, pw: String)
    
    func signIn(useremail: String, userpw: String) {
        switch self {
        case .google(email: useremail, pw: userpw):
            print("아이디 - \(useremail), 비밀번호 - \(userpw)")
        case .kakao(email: useremail, pw: userpw):
            print("아이디 - \(useremail), 비밀번호 - \(userpw)")
        case .naver(email: useremail, pw: userpw):
            print("아이디 - \(useremail), 비밀번호 - \(userpw)")
        default:
            print("Error")
        }
    }
}

let google = Site.google(email: "google@gmail.net", pw: "0000")
google.signIn(useremail: <#T##String#>, userpw: <#T##String#>)









/*
 수고하셨습니다!
 */

