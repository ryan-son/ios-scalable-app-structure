# Change History

변경 이력은 개별 PR에서 상세히 다룹니다. [PR 목록 보기](https://github.com/ryan-son/ios-scalable-app-structure/pulls?q=is%3Apr+is%3Aclosed)

# Following Best Practices

| | Description |
|--|--|
| Low Coupling and High Cohesion |  코드 간 응집도를 높이면서 요소 간 결합을 낮추어 재사용성을 높이고 향후 유지보수를 용이하게 합니다. |
| Proper code structure | 코드를 개념적인 계층으로 나누어 각 코드의 목적을 쉽게 이해할 수 있도록 하고, 다른 요소들과 관계를 파악하기 용이하게 하며 향후 앱 구현에 사용되는 방법을 이해하게 합니다. |
| Persistence | 기기에 네트워크에서 받아온 데이터를 저장하여 앱이 해당 데이터를 반복적으로 네트워크에 요청하는 것을 방지하여 사용자 데이터 사용량을 절약할 수 있도록 합니다. |
| Modular App Features | 기능을 메인 앱과 별도로 테스트하고 유지보수할 수 있는 모듈로 분리하여 재사용성을 높이고 버그 발생률을 낮춥니다. |
| Animations and Custom Controls | 적절한 애니메이션과 커스텀 컨트롤을 통해 사용자 경험을 향상시킨다. 이를 통해 앱이 사용자의 기억에 남게 만들어 향후 앱 재사용을 유도합니다. |
| Accessibility | 동적 텍스트와 적절한 색상을 사용하고 VoiceOver를 지원하여 더 많은 사용자가 앱을 사용할 수 있도록 합니다. |
| Localization | 전 세계 다양한 사용자를 위해 앱을 출시한 지역에 맞게 앱을 준비합니다. |
| App Privacy | 특정 기능을 사용하기 위해 사용자에게 권한을 요청하고 앱에서 수집하는 사용자 데이터를 안내합니다. |

# Feature Grouping
- Core: 모든 기능에서 활용되는 공유 코드. 앱 내의 각 파트에서 사용되는 뷰, 비즈니스 로직, 데이터가 포함될 수 있습니다.
- Screen 또는 탭과 같은 기능 단위 폴더: 기본적으로 각 기능을 구현하기 위한 View와 ViewModel이 있으며, 개별 기능을 위한 Model을 포함하는 경우도 있습니다.

이러한 방식을 통해 vertical layer 형태로 구조화하면 기능에서 필요한 대부분의 코드를 가지게 할 수 있으므로 코드를 독립적이게 구성할 수 있습니다.
반대로 코드의 유사성을 기준으로 기능을 구조화하는 방식을 horizontal layer 형태의 구조라 부르며, model layer, network layer와 같은 방식으로 나눕니다.

Vertical layer 형태로 기능을 구조화하면 아래와 같은 이점이 있습니다.
- 그룹 이름이 이미 기능 자체를 의미하기 때문에 코드를 찾기 용이합니다.
- 동일한 목적과 관련된 코드를 가지고 있기에 그룹 내 코드 응집도가 강합니다.
- 모듈화를 하기 용이합니다.

프로젝트가 성장할수록 코드를 유지보수하고 찾기 어려워지므로 프로젝트 초기에 이러한 기능 구조화를 논의하여 높은 응집도와 낮은 결합도를 유지할 수 있게끔 만드는 것이 바람직합니다.

# 소프트웨어 요구사항은 명확하게 정해질 수 없다
요구사항은 개발 중이나 출시 후에도 변경될 수 있습니다. 그러므로 요구사항의 변경에 유연한 코드를 만드는 것이 중요합니다.

## High Cohesion
높은 응집도는 관련된 코드를 모아두는 것을 의미합니다. 

API path를 책임지는 열거형을 고려해보겠습니다.

```swift
enum APIRouter {
    case animalsNearYou
    case search
    
    var path: String {
      return "v2/animals"
    }
}
```

`APIRouter`는 두 개의 endpoint에 대해 하나의 path만을 가지고 있습니다.

이제 token을 생성하는 API를 추가한다고 생각하면 아래와 같이 작업해야할 것입니다.

```swift
enum APIRouter {
    case animalsNearYou
    case search
    
    // New route
    case token
    
    var path: String {
      switch self {
      case .animalsNearYou,
        .search:
        return "v2/animals"
      // New path
      case .token:
        return "/v2/token"
    }
}
```

`APIRouter`는 이제 다른 목적으로 두 개의 다른 path를 처리하게 되었습니다.

이 열거형은 새로운 기능의 개수에 비례하여 증가할 것입니다. 이렇게되면 유지보수하기가 쉽지 않게 됩니다.

모든 path를 처리하는 하나의 열거형을 두기보다 하나의 도메인으로 두 개의 열거형을 분할하면 각각의 책임을 변경하거나 이해하기가 더 쉬워집니다.

```swift
enum AnimalsRouter {
  case animalsNearYou
  case search
  
  var path: String {
    return "/v2/animals"
  }
}

enum AuthRouter {
  case token
  
  var path: String {
    return "/v2/token"
  }
}
```

이제 각 열거형은 열거형마다 목적이 명확해졌습니다. 코드를 더 응집되게 정리한 것이죠.
이와 같이 코드의 응집도를 높게 유지하면 복잡도가 낮아져 유지보수성과 재사용성이 증가합니다.

## Low coupling
낮은 결합도를 가진 코드 또는 완전히 분리된 코드는 다른 구성 요소에 의존하지 않고 어떤 상황에서도 자체적으로 기능을 수행할 수 있습니다.

```swift
class AnimalsNearYouViewModel {
  let service = Service()
  
  func fetchAnimals() {
    service.fetchAnimals()
  }
}
```

`AnimalsNearYouViewModel`은 서비스로부터 동물들을 가져와 목록에 보여주는데 사용됩니다. 이 클래스는 `Service`에 의존하고 있죠.

하지만 요구사항이 변경되어 동물들의 정보를 가져오기 위해 사용자의 위치를 이용해야한다면 어떻게될까요? 아마도 기능을 추가하기 위해 `Service`를 다시 작성하거나 새로운 `Service`를 만들 것입니다. 그렇더라도 `AnimalsNearYouViewModel`은 여전히 구체적인 타입을 의존하고 있는 것은 변함 없습니다.

이렇게 하는것보다 `AnimalsNearYouViewModel`이 해당 Protocol을 준수하는 어떤 타입이든 받아들일 수 있도록 Protocol을 통해 추상화할 수 있습니다.

```swift
protocol AnimalFetcher {
  func fetchAnimals()
}

class AnimalsNearYouViewModel {
  let service: AnimalFetcher
  
  init(service: AnimalFetcher) {
    self.service = service
  }
  
  func fetchAnimals() {
    service.fetchAnimals()
  }
}
```

`AnimalsNearYouViewModel`은 이제 `AnimalFetcher`에 의존하고 있으믈호 구체적인 타입 대신 프로토콜을 준수하는 어떤 타입이든 받아들일 수 있게 되었습니다.
이러한 방식을 따르는 것을 Protocol Oriented Programming (POP)라고 합니다. 이제 `AnimalsFetcher`를 준수하는 Mock이나 Spy를 만들어 `AnimalsNearYouViewModel`을 쉽게 테스트할 수 있습니다.

# The app's domain
어떤 기능을 코딩하기 전에 만들고자하는 앱의 목적, 기능과 사용자를 명확하게 이해해야합니다. 도메인은 만들고자 하는 앱을 정의합니다.

도메인은 앱이 따르는 비즈니스 로직과 규칙들의 모음입니다.

소프트웨어 개발 사이클 초기에 앱의 요구사항을 모을겁니다. 프로젝트 관계자들과 요구사항을 정의하고 기능으로 변환하는 것이죠.

앱의 도메인을 이해하는 것은 성공적인 앱을 만드는데 중요한 역할을 합니다. 사용자의 문제를 이해하면 그 문제를 해결하는 기능을 만들기 훨씬 쉬운 것과 같은 이치죠. 사용자들이 이해받고 있다고 이해하면, 앱이 가치있게 느껴질 것이고 다시 사용하게 될 것입니다.

# Modeling domain models
## Value types vs reference types
이 앱의 대부분의 모델들은 구조체로 정의되어 있습니다. 구조체는 값 타입이기 때문입니다.

구조체는 매우 가벼워서 적은 메모리를 사용해 값을 전달할 수 있습니다. 값 타입의 각 인스턴스들은 데이터의 고유한 사본이고, Swift는 이를 수정할 때 값의 사본을 만듭니다.

반면에 클래스는 참조 타입입니다. 클래스 인스턴스는 데이터를 메모리에 참조 형식으로 유지하여 데이터의 변경 사항을 다른 참조로 전파합니다.

모델들은 데이터의 단순한 표현 방식이기 때문에 대부분 구조체를 사용합니다.


# API Documentation
- [Pet finder API Documentation](https://www.petfinder.com/developers/v2/docs/)
