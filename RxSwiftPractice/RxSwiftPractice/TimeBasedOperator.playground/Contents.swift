import RxSwift

let disposeBag = DisposeBag()

print("---------replay---------")
let 인사말 = PublishSubject<String>()
let 반복하는앵무새 = 인사말.replay(1) // 구족하기 이전의 값을 버퍼의 범위만큼 저장했다 방출할 수 있다.

반복하는앵무새.connect()

인사말.onNext("1. Hello")
인사말.onNext("2. Hi")

반복하는앵무새
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

인사말.onNext("3. 안녕하세요")

print("---------replayAll---------")
let 닥터스트레인지 = PublishSubject<String>()
let 타임스톤 = 닥터스트레인지.replayAll()
타임스톤.connect()

닥터스트레인지.onNext("도르마무")
닥터스트레인지.onNext("거래를 하러왔다.")

타임스톤
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("---------buffer---------")
//let source = PublishSubject<String>()
//
//var count = 0
//let timer = DispatchSource.makeTimerSource()
//
//timer.schedule(deadline: .now() + 2, repeating: .seconds(1))
//timer.setEventHandler {
//    count += 1
//    source.onNext("\(count)")
//}
//timer.resume()
//source
//    .buffer(
//        timeSpan: .seconds(2),
//        count: 2,
//        scheduler: MainScheduler.instance
//    )
//    .subscribe(onNext: {
//        print($0)
//    })
//    .disposed(by: disposeBag)

print("---------window---------") // buffer와 같지만 return 값이 Observable이다.
//let 만들어낼최대Observable수 = 5
//let 만들시간 = RxTimeInterval.seconds(2)
//
//let window = PublishSubject<String>()
//
//var windowCount = 0
//let windowTimeSource = DispatchSource.makeTimerSource()
//windowTimeSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
//windowTimeSource.setEventHandler {
//    windowCount += 1
//    window.onNext("\(windowCount)")
//}
//windowTimeSource.resume()
//
//window
//    .window(
//        timeSpan: 만들시간,
//        count: 만들어낼최대Observable수,
//        scheduler: MainScheduler.instance
//    )
//    .flatMap { windowObservable -> Observable<(index: Int, element: String)> in
//        return windowObservable.enumerated()
//    }
//    .subscribe(onNext: {
//        print("\($0.index)번째 Observable의 요소 \($0.element)")
//    })
//    .disposed(by: disposeBag)

print("---------delaySubscription---------")
let delaySource = PublishSubject<String>()

var delayCount = 0
let delayTimerSource = DispatchSource.makeTimerSource()
delayTimerSource.schedule(deadline: .now() + 2, repeating: .seconds(1))
delayTimerSource.setEventHandler {
    delayCount += 1
    delaySource.onNext("\(delayCount)")
}
delayTimerSource.resume()

delaySource
    .delaySubscription(.seconds(5), scheduler: MainScheduler.instance)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)
