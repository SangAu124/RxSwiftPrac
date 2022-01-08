import RxSwift

let disposeBag = DisposeBag()

print("---------amb---------")
let 🚌버스1 = PublishSubject<String>()
let 🚌버스2 = PublishSubject<String>()

let 버스정류장 = 🚌버스1.amb(🚌버스2) // 둘다 구독하긴 하지만 어느 하나가 방출하면 다른 하나의 구독을 취소한다.

버스정류장
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

🚌버스2.onNext("👩🏽")
🚌버스1.onNext("👨🏼")
🚌버스1.onNext("👱🏼‍♀️")
🚌버스2.onNext("🧑🏻")
🚌버스1.onNext("🧔🏿‍♂️")
🚌버스2.onNext("👩🏻‍🦱")

print("---------switchLatest---------")
let 학생1 = PublishSubject<String>()
let 학생2 = PublishSubject<String>()
let 학생3 = PublishSubject<String>()

let 손들기 = PublishSubject<Observable<String>>()

let 손든사람만말할수있는교실 = 손들기.switchLatest() // 소스에 들어온 마지막 시퀀스의 아이템만 방출한다.

손든사람만말할수있는교실
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

손들기.onNext(학생1)
학생1.onNext("학생1: 안녕하세요 저는 1번 학생입니다.")
학생2.onNext("학생2: 저요 저요 !!!")

손들기.onNext(학생2)
학생2.onNext("학생2: 저는 2번이에요!!")
학생1.onNext("학생1: 어... 나 아직 할말 있는데..")

손들기.onNext(학생3)
학생2.onNext("학생2: 아니 잠깐만 내가!")
학생1.onNext("학생1: 언제 말할 수 있죠..?")
학생3.onNext("학생3: 저는 3번입니다. 아무래도 제가 이긴 것 같네요.")

손들기.onNext(학생1)
학생1.onNext("학생1: 아니.. 틀렸어 승자는 나야!")
학생2.onNext("학생1: ㅠㅠ")
학생3.onNext("학생3: 이긴 줄 알았는데")
학생2.onNext("학생1: 이거 이기고 지는 손들기였나요?")

print("---------reduce---------")
Observable.from((1...10))
//    .reduce(0, accumulator: { summary, newValue in    이것들
//        return summary + newValue
//    })

//    .reduce(0) { summary, newValue in                 모두
//        return summary + newValue
//    }

    .reduce(0, accumulator: +)//                        같은 의미

    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------scan---------")
Observable.from((1...10))
    .scan(0, accumulator: +) // 매번 값이 들어올 때 마다 방출해준다.
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
