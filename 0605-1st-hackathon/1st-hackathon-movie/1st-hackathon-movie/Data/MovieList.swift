//
//  MovieList.swift
//  1st-hackathon-movie
//
//  Created by Woobin Cheon on 2020/06/03.
//  Copyright © 2020 Woobin Cheon. All rights reserved.
//

import Foundation

//struct movie {
//    let title: String
//    let info: movieInfo
//}
//
//struct movieInfo {
//    let price: Int
//    let time: String
//}
//let movieList: [movie] = [
//movie(title: "마블", info: movieInfo(price: 12000, time: "2020-06-06")),
//movie(title: "조커", info: movieInfo(price: 10000, time: "2020-06-07")),
//movie(title: "토이스토리", info: movieInfo(price: 8000, time: "2020-06-08")),
//movie(title: "겨울왕국", info: movieInfo(price: 6000, time: "2020-06-09"))
//]
//
struct Movie {
  let poster: String   //이미지

  let title: String
  let subtitle: String
  let genre: String
  let runningTime: String
  let viewingRating: String

  let releaseDate: String

  let director: String
  let cast: [Cast]    //출연진: 배열

  let synopsis: String
}

struct Cast {
  let actorName: String
  let role: String
  let roleName: String
}


let movieList: [Movie] = [
  Movie(
    poster: "침입자_포스터",
    title: "침입자",
    subtitle: "Intruder, 2019",
    genre: "미스터리, 스릴러",
    runningTime: "102분",
    viewingRating: "15세 관람가",
    releaseDate: "2020.06.04 개봉",
    director: "손원평",
    cast: [
      Cast(actorName: "송지효", role: "주연", roleName: "유진 역"),
      Cast(actorName: "김무열", role: "주연", roleName: "서진 역"),
      Cast(actorName: "예수정", role: "조연", roleName: "윤희 역"),
      Cast(actorName: "최상훈", role: "조연", roleName: "성철 역"),
      Cast(actorName: "박민하", role: "조연", roleName: "예나 역"),
    ],
    synopsis: """
    25년만에 돌아온 동생,
    나는 그녀가 의심스럽다!
    얼마 전 사고로 아내를 잃고 실의에 빠져 있는 건축가 ‘서진’에게
    25년 전 실종된 동생을 찾았다는 연락이 온다
    처음 본 자신을 친근하게 “오빠”라고 부르는 ‘유진’이 어딘가 불편한 ‘서진’과 달리
    가족들은 금세 그녀를 받아들인다

    그런데 ‘유진’이 돌아온 후 가족들에게 이상한 일들이 벌어지기 시작하고,
    이를 의심스럽게 여긴 ‘서진’은 동생의 비밀을 쫓다 자신의 일상을 송두리째 뒤흔든 사건에
    그녀가 연관되어 있음을 알게 되는데...

    추적 끝에 드러나는 충격적인 진실!
    """
  ),

  Movie(
    poster: "매드맥스_분노의 도로_포스터",
    title: "매드맥스-분노의 도로",
    subtitle: "Mad Max: Fury Road, 2015",
    genre: "액션, 스릴러",
    runningTime: "120분",
    viewingRating: "15세 관람가",
    releaseDate: "2020.06.04 재개봉",
    director: "조지 밀러",
    cast: [
      Cast(actorName: "톰 하디", role: "주연", roleName: "맥스 로켓탄스키 역"),
      Cast(actorName: "샤를리즈 테론", role: "주연", roleName: "임페라토르 퓨리오사 역"),
      Cast(actorName: "니콜라스 홀트", role: "주연", roleName: "눅스 역"),
      Cast(actorName: "휴 키스-번", role: "조연", roleName: "임모탄 조 역"),
      Cast(actorName: "조 크라비츠", role: "조연", roleName: "토스트 역"),
    ],
    synopsis: """
    “세상이 멸망하면서 누가 미친 건지 알 수 없어졌다. 나인지 이 세상인지..”
    핵전쟁으로 멸망한 22세기. 얼마 남지 않은 물과 기름을 차지한 독재자 임모탄 조가 살아남은 인류를 지배한다.
    한편, 아내와 딸을 잃고 살아남기 위해 사막을 떠돌던 맥스(톰 하디)는
    임모탄의 부하들에게 납치되어 노예로 끌려가고, 폭정에 반발한 사령관 퓨리오사(샤를리즈 테론)는
    인류 생존의 열쇠를 쥔 임모탄의 여인들을 탈취해 분노의 도로로 폭주한다.
    이에 임모탄의 전사들과 신인류 눅스(니콜라스 홀트)는 맥스를 이끌고 퓨리오사의 뒤를 쫓는데...
    끝내주는 날, 끝내주는 액션이 폭렬한다!
    """
  ),

  Movie(
    poster: "위대한 쇼맨_포스터",
    title: "위대한 쇼맨",
    subtitle: "The Greatest Showman, 2017",
    genre: "드라마, 뮤지컬",
    runningTime: "104분",
    viewingRating: "12세 관람가",
    releaseDate: "2020.05.21 재개봉",
    director: "마이클 그레이시",
    cast: [
      Cast(actorName: "휴 잭맨", role: "주연", roleName: "P.T. 바넘 역"),
      Cast(actorName: "잭 에프론", role: "주연", roleName: "필립 칼라일 역"),
      Cast(actorName: "미셸 윌리엄스", role: "주연", roleName: "채러티 바넘 역"),
      Cast(actorName: "레베카 퍼거슨", role: "주연", roleName: "제니 린드 역"),
      Cast(actorName: "오스틴 존슨", role: "조연", roleName: "캐롤라인 바넘 역"),
    ],
    synopsis: """
    불가능한 꿈, 그 이상의 쇼!
    쇼 비즈니스의 창시자이자, 꿈의 무대로 전세계를 매료시킨 남자
    ‘바넘’의 이야기에서 영감을 받아 탄생한 오리지널 뮤지컬 영화 <위대한 쇼맨>.
    <레미제라블> 이후 다시 뮤지컬 영화로 돌아온 휴 잭맨부터 잭 에프론, 미셸 윌리엄스, 레베카 퍼거슨, 젠다야까지
    할리우드 최고의 배우들이 합류해 환상적인 앙상블을 선보인다.
    여기에 <미녀와 야수> 제작진과 <라라랜드> 작사팀의 합류로
    더욱 풍성해진 비주얼과 스토리, 음악까지 선보일 <위대한 쇼맨>은
    ‘우리는 누구나 특별하다’는 메시지로 관객들에게 재미는 물론, 감동까지 선사할 것이다.

    THIS IS ME! 우리는 누구나 특별하다!
    """
  ),

]
