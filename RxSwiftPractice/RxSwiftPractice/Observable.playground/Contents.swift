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

