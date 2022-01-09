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
