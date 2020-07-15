//: [Previous](@previous)
import UIKit

/***************************************************
 1. Array, Set, Dictionary 의 차이점에 대해 설명하고 예시 코드 작성
 ***************************************************/
/*Array: index 값을 가진다. 배열요소와 index가 1:1 매칭되지 않고 새로운 배열이 추가되거나 삭제되면 맨마지막 인덱스가 삭제되고 다시 배정된다. 요소간에 순서가 있다.*/
var array: [Int] = []
for i in 1...10 {
    array.append(i)
}
array.index(of: 6) // 요소 6의 index는 5
array.remove(at: 4) // 요소 5 삭제
array.index(of: 6) // 요소 6의 index는 4
print(array)
/*Set: 요소간에 순서가 없다.*/

/*Dictionary: key-value가 하나의 요소이다. 요소간에 순서가 없다. key값을 통해 value(optinal 타입)을 찾을 수 있다. */
var cheon: [String: String] = ["name": "woboin", "age": "34"]
print("my name is \(cheon["name"]!). I'm \(cheon["age"]!) years old.")

/***************************************************
 2. Value Type, Reference Type 에 대한 예시와 그 차이점에 대해 설명
 ***************************************************/
//Value type: 값이 할당 될때, 복사된 값이 전달된다
//Reference type: 값이 할당 될때, 값의 주소가 전달(참조)된다.


/***************************************************
 3. Application의 LifeCycle의 각 상태에 대해 설명
 ***************************************************/
/*
 active: 메모리에 로드되며, 앱 시작
 background: 메모리에 존재하며, 앱 실행 중
 suspend: 메모리에 존재하며, 앱 실행 중지
 inactive: 메모리에서 삭제되며, 앱 종료
 */


/***************************************************
 4. ViewController LifeCycle의 각 상태에 대해 설명
 ***************************************************/
/*viewload: 뷰가 메모리에 로드 될 것이다.
viewDidload: 뷰가 메모리에 로드 되었다.
 viewwillappear: 뷰가 나타날거다.
 viewdidappear: 뷰가 다 나타났다.
 viewwilldisappear: 뷰가 없어질거다.
 viewdiddisappear: 뷰가 다 없어졌다.
 
 뷰 modal 방식에 따라 차이가 난다.
 fullscreen:
 - present
 presenting(viewWillDisappear)->presented(viewWillAppear)->presented(viewDidAppear)->presenting(viewDidDisappear)
 - dismiss
 presented(viewWillDisappear)->presenting(viewWillAppear)->presenting(viewDidAppear)->presented(viewDidDisappear)
 
 sheet:
 - present
 presented(viewWillAppear)->presented(viewDidAppear)
 - dismiss
 presented(viewWillDisappear)->presented(viewDidDisappear)
*/

/***************************************************
 5. 다음 4개의 키워드 (continue, break, return, fallthrough)가 쓰이는 위치와 역할에 대해 각각 설명
 ***************************************************/
//continue: switch 문에서 실행된 case 다음 case 도 실행하고자 할때 사용된다.
//break:


/***************************************************
 6. Init 메서드가 필요한 경우와 그렇지 않은 경우의 차이점에 대해 설명
 ***************************************************/
// 필요한 경우: 클래스 선언시 프로퍼티를 초기화 하지 않은 경우
// 불필요한 경우: 클래스 선언시 프로퍼티를 초기화한 경우


/***************************************************
 7. Access Level 을 각 단계별로 나열하고 그 차이점에 대해 설명
 ***************************************************/
//private: {}내에서만 접근 가능
//file-private: 같은 파일 내에서 접근 가능
//normal: @import로 연결된 관계 내에서 접근 가능
//free: 프레임워크 생성에 쓰임
//open: 프레임워크 생성에 쓰임


/***************************************************
 8. OOP 4대 특성에 대해 나열하고 각 특성에 대해 아는 만큼 설명 및 예시 코드 작성
 ***************************************************/
//추상화:
//캡슐화:
//상속:
//다형성:


/***************************************************
 9. Frame 과 Bounds가 무엇이고, 둘의 차이점은 어떤 것이 있는지 설명
 ***************************************************/
//Frame: 요소 위치 기준이 화면 전체임
//Bounds: 요소 위치 기준이 요소 본인임



/***************************************************
 위 개념들은 아직 익숙치 않아서 답변하지 못한 분들이 많을 수 있지만
 중요한 내용들이니 답하지 못한 질문들은 체크해두었다가 천천히 공부하세요.
 ***************************************************/


//: [Next](@next)
