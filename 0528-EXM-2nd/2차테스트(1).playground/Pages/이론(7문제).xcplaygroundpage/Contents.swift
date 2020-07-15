//: [Previous](@previous)
import Foundation


/*
 1) 업캐스팅과 다운캐스팅에 대하여 설명하고,
 2) 업캐스팅과 다운캐스팅을 시도할 때 사용하는 키워드에 대해 각각 설명
 */

//업캐스팅: 해당 인스턴스를 동일한 클래스 혹은 상위 클래스로 타입 캐스팅하는 경우
//다운캐스팅: 해당 인스턴스를 하위 클래스로 타입 캐스팅하는 경우
//
//업캐스팅의 as: 반환 타입이 논옵셔널
//다운캐스팅의 as?: 반환 타입이 옵셔널. 따라서 옵셔널 바인딩 해줘야한다.
//다운캐스팅의 as!: 반환 타입이 옵셔널이지만 강제적으로 옵셔널 해제한다.



/*
 TableView에서 셀을 재사용할 때 사용되는 아래의 두 메서드가 각각
 1) 언제 사용되고  2) 차이점은 무엇인지에 대하여 작성
 - dequeueReusableCell(withIdentifier:)
 - dequeueReusableCell(withIdentifier:for:)

 1) 테이블뷰에서 셀을 생성할때 화면상에서 사라진 셀에 대해서는 큐에 저장하고 있다가 이 메소드를 이용해 셀을 재사용한다.
 2) 차이점
  dequeueReusableCell(withIdentifier:) : 재사용될 셀 ID를 이용해 미리 등록(register)한 경우에 사용
  dequeueReusableCell(withIdentifier:for:) : 재사용될 셀 ID를 미리 등록(register)하지 않은 경우에 사용
 */



/*
 safeAreaInsets  /  safeAreaLayoutGuide 의 차이점에 대해 작성
 */




/*
 Strong Reference Cycle 에 대해 1) 설명하고 2) 예시 코드 작성
1) 참조 카운터가 0가 되지 않아서 순환 참조가 일어나는 상황
2)
 
 */




/*
 Strong, Unowned, Weak 각각의 특징과 차이점에 대해 설명
 
 Strong: 참조될때마다 카운트(ARC)가 하나씩 올리간다.
 Unowned, Weak: 참조되더라도 카운트(ARC)가 올라가지 않는다.
 */





/*
 Intrinsic Content Size란 무엇이고 어떤 특징을 가지는지 설명
 */




/*
 A, B, C 3개의 ViewController가 다음과 같은 상황일 때
 ============================
 A ---------> B ---------> C
    present      present
 ============================
 A, B, C 각각의 presentingViewController, presentedViewController의 상태는?
 A
 presentingViewController - 없음
 presentedViewController - B
 
 B
 presentingViewController - C
 presentedViewController - A
 
 C
 presentingViewController - B
 presentedViewController - 없음
 */



//: [Next](@next)
