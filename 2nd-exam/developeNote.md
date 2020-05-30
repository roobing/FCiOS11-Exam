문제점 1

딕셔너리에서 키값 자체에 접근하는법을 몰라서 키값 접근을 위한 배열을 하나 더 만듬

```swift
let productListImages: [String:[String]] = [
    "사이드디시": ["딸기 슈크림", "슈퍼곡물 치킨", "애플 크러스트 디저트", "치킨퐁듀 그라탕", "퀴노아 치킨 샐러드","포테이토 순살치킨"],
    "슈퍼시드": ["글램핑 바비큐", "알로하 하와이안", "우리 고구마", "콰트로 치즈 퐁듀"],
    "음료": ["미닛메이드 스파클링 청포도","스프라이트", "코카콜라 제로", "코카콜라"],
    "클래식": ["베이컨체더치즈", "불고기", "슈퍼디럭스", "슈퍼슈프림", "페퍼로니", "포테이토"],
    "프리미엄": ["더블크러스트 이베리코", "블랙앵거스 스테이크", "블랙타이거 슈림프", "와규 앤 비스테카", "직화 스테이크"],
    "피클소스": ["갈릭 디핑 소스", "스위트 칠리소스", "우리 피클 L", "우리 피클 M", "핫소스"]
  ]
let categoryListImages: [String] = [
    "사이드디시",
    "슈퍼시드",
    "음료",
    "클래식",
    "프리미엄",
    "피클소스"
]
```

해결방법



<br>

문제점 2

AppDelegate에 만들어놓은 전역변수에 접근하기위해 거의 20군데에 AppDelegate의 인스턴스를 생성함

```swift
guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
itemList = ad.orderItemsList
// 이런게 전체적으로 한 20개 있음
```

해결방법



<br>

문제점 3

로고사진 어거지로 끼워넣음

```swift
//스토리보드로 로고 이미지 사이즈로 UIView 만들고 위치 적당히 잡아서 거기에 이미지를 addSubView 해벌임...
let imageHeader = UIImageView(frame: CGRect(x: 87, y: 0, width: 220, height: 220))
imageHeader.image = UIImage(named: "logo")

logoView.addSubview(imageHeader)
categoryListTable.tableHeaderView = logoView

view.addSubview(categoryListTable)
```

해결방법

<br>

문제점 4

DetailViewController에서 각 상품의 갯수를 저장한 카운트 변수를 WishListViewController에서 초기화할 방법을 모름

```swift
// DetailVC
@IBAction func plusItem(_ sender: UIButton) {
    guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
    itemCount += 1 // +버튼 누를때마다 올라감.
    numOfItemLabel.text = "\(itemCount) 개"
    if ad.orderItemsList.contains(productName) {
        ad.orderNumInfo[productName] = itemCount
    }
    else {
        ad.orderItemsList.append(productName)
        ad.orderNumInfo[productName] = itemCount
    }
    
}

// WishListVC
func resetList() { // 결제 및 목록 지우기하면 실행되는 초기화 함수
    guard let ad = UIApplication.shared.delegate as? AppDelegate else { return }
    ad.orderItemsList.removeAll()
    ad.orderNumInfo.removeAll()
    itemList.removeAll()
    let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC")
    detailVC. // 이렇게해서는 접근이 안됨.
    wishListTable.reloadData()
}
```

해결방법



<br>

문제점 5

커스텀 셀 못만듬

