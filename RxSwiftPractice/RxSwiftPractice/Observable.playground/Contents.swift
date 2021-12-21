import Foundation
import RxSwift

print("----JUST----")
Observable<Int>.just(1)
    .subscribe(onNext: {
        print($0)
    })

print("----OF1----")
Observable<Int>.of(1, 2, 3, 4, 5)
    .subscribe(onNext: {
        print($0)
    })

print("----OF2----")
Observable.of([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })

print("----FROM----")
Observable.from([1, 2, 3, 4, 5])
    .subscribe(onNext: {
        print($0)
    })


print("----subscribe1----")
Observable.of(1, 2, 3)
    .subscribe{
        print($0)
    }

print("----subscribe2----")
Observable.of(1, 2, 3)
    .subscribe{
        if let element = $0.element{
            print(element)
        }
    }

print("----subscribe1----")
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })

print("-----empty-----")
Observable<Void>.empty()
    .subscribe{
        print($0)
    }

print("-----never-----")
Observable<Void>.never()
    .debug("never")
    .subscribe(onNext: {
            print($0)
        },
        onCompleted: {
            print("Completed")
        }
    )

print("-----range-----")
Observable.range(start: 1, count: 9)
    .subscribe(onNext: {
        print("2 * \($0) = \(2*$0)")
    })

print("-----dispose-----")
// ()에 값들이 무한하게 많다면 꼭 dispose를 해야 Completed가 출력된다.
Observable.of(1, 2, 3)
    .subscribe(onNext: {
        print($0)
    })
    .dispose()

print("-----disposeBag-----")
//효율적으로 관리 하기 위해
let disposeBag = DisposeBag()
Observable.of(1, 2, 3)
    .subscribe{
        print($0)
    }
    .disposed(by: disposeBag)

print("-----create1-----")
Observable.create { observable -> Disposable in
    observable.onNext(1)
//    observable.on(.next(1))
    observable.onCompleted()
//    observable.on(.completed)
    observable.onNext(2)
    return Disposables.create()
}
.subscribe{
    print($0)
}
.disposed(by: disposeBag)

print("-----create2-----")
enum MyError: Error {
    case anError
}

Observable<Int>.create { observable -> Disposable in
    observable.onNext(1)
    observable.onError(MyError.anError)
    observable.onCompleted()
    observable.onNext(2)
    return Disposables.create()
}
.subscribe(
    onNext: {
        print($0)
    },
    onError: {
        print($0.localizedDescription)
    },
    onCompleted: {
        print("Completed")
    },
    onDisposed: {
        print("Disposed")
    }
)
.disposed(by: disposeBag)


print("-----deferred1-----")
Observable.deferred {
    Observable.of(1, 2, 3)
}
.subscribe{
    print($0)
}
.disposed(by: disposeBag)

print("-----deferred2-----")
var 뒤집기: Bool = false
let factory: Observable<String> = Observable.deferred {
    뒤집기 = !뒤집기
    
    if 뒤집기 {
        return Observable.of("🔥")
    } else {
        return Observable.of("❌")
    }
}

for _ in 0...3 {
    factory.subscribe(onNext: {
        print($0)
    })
        .disposed(by: disposeBag)
}
