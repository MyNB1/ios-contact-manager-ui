# 연락처 관리 앱 토이 프로젝트

> **연락처 관리 앱** <br>
>
> 프로젝트 소개: SeSAC 토이 프로젝트 - 연락처 관리 앱  
> 프로젝트 기간: 2024.01.02 ~ 2024.01.19

## 팀원 소개
- **희동:** [@MyNB1](https://github.com/MyNB1)
- **Jane:** [@jane1choi](https://github.com/jane1choi) 

## 구현 요구 사항
### Step 1 : 연락처 목록 뷰 구현
**1-1. 모델타입 구현**    
아래 내용 고려하여 Model 타입을 구현합니다.     
- 연락처 관리앱은 사용자로부터 이름, 연락처, 나이에 대한 정보를 전달받습니다.    
- 연락처를 관리하기 위해 필요한 기능은 아래와 같습니다.   
    - 연락처 보기
    - 연락처 추가
    - 연락처 삭제
    - 연락처 변경(optional)

**1-2. TableView의 사용**    
Table View를 활용하여 연락처 목록을 화면에 표시합니다.  
- 각 행의 cell은 subtitle style을 사용합니다.  
    - 각 행(row)에 표시할 항목
        - 이름, 나이, 연락처
        - 이름옆에 괄호로 나이가 위치합니다.
        - 연락처는 이름(나이) 아래에 위치합니다.

### Step 2 : 연락처 추가 기능 구현
- 연락처 목록 화면의 우상단 버튼을 통해 연락처 추가 화면에 진입할 수 있습니다.
- 오토 레이아웃과 스택뷰를 활용하여 화면을 레이아웃합니다.
- 각 필드에 맞는 키보드 종류를 지정합니다.
- 취소 버튼을 선택하면 정말 취소할 것인지 묻도록합니다.
- 저장 버튼을 선택하면 입력한 정보가 올바르게 입력되었는지 확인하도록 합니다.
    - 이름
        - 사용자가 중간에 띄어쓰기를 하더라도 띄어쓰기를 제거합니다.
    - 나이
        - 숫자 입력만 가능하며, 세 자리수 이하여야 합니다.
    - 연락처
        - `-`은 사용자 입력없이 자동으로 생성 및 삭제됩니다.
        - ex) 010에서 7 입력시 010-7
        - ex) 010-7 에서 delete 한 번 입력시 010
        - 중간에 `-`로 구분하며, `-`는 두 개 존재해야 합니다.
        - `-`을 제외하고 숫자는 9자리 이상이어야 합니다.
 
### ⚠️ 제약사항
- 코드에 느낌표(!)를 사용하지 않습니다.
- Swift API Design Guidelines의 문서대로 코드를 작성합니다.
- 코드에 주석을 남기지 않습니다.
- 외부 라이브러리를 사용하지 않습니다.
- 커밋은 짝꿍과 번갈아가며 남깁니다.

## 폴더 구조
```
📱ContactManager
├── 📁Sources
│   └── 📁Global
│       ├── 📁Constants
│       ├── 📁Extension
│       ├── 📁Model
│       └── 📁Application
│           ├── AppDelegate.swift
│           └── SceneDelegate.swift
├── 📁Scene
│   ├── 📁NewContactScene
│   │   ├── 📁Model
│   │   │   └── NewContactManager.swift
│   │   ├── 📁View
│   │   │   └── NewContact.storyboard
│   │   └── 📁Controller
│   │       └── NewContactViewController.swift
│   └── 📁ContactListScene
└── 📁Resources
```
## Activity Diagram
<img width="370" alt="296785093-003c6c55-4752-48e4-9e23-5ba45622e482" src="https://github.com/MyNB1/ios-contact-manager-ui/assets/63277563/435178b3-3509-40ee-af74-26a26a1a50bf">

## 구현 사항
### MVC 아키텍처
전체 프로젝트 구조를 MVC로 설계해 역할 단위로 코드를 분리할 수 있도록 하였습니다.
- `Model`: 데이터에 관련된 처리 (비즈니스 로직)
- `View`: 사용자에게 보여지는 UI
- `Controller`: 사용자 Input에 대한 처리, 로직과 UI를 바인딩

### 정규 표현식을 이용한 연락처 형식 유효성 검사
- 정규 표현식을 이용하여 사용자가 입력한 연락처 형식을 검사했습니다.
```Swift
enum Contact {
    case normal
    case phone
    
    var regex: String {
        switch self {
        case .normal:
            return "^0(2|3[1-3]|4[1-4]|5[1-5]|6[1-4])-([0-9]{3,4})-([0-9]{4})$"
        case .phone:
            return "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$"
        }
    }
}
```
```Swift
final class NewContactManager {
  
    /// 전화번호 형식 검사 메서드
    private func validateContactFormat(text: String, format: Contact) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", format.regex)
            .evaluate(with: text)
    }
}
```

### TextField 동적 하이픈 생성
- 연락처 입력 시 `-`은 사용자 입력없이 자동으로 생성 및 삭제될 수 있도록 `TextField`에 동적 하이픈 생성 기능을 추가했습니다.
- [JSPhoneFormat](https://github.com/JeaSungLEE/JSPhoneFormat) 라이브러리 내부 코드를 참고하여 구현했습니다.
```Swift
extension NewContactManager {
    
    /// 전화번호 형식에 맞게 하이픈 추가하는 메서드
    func addHypen(at text: String) -> String {
        digits = text
        removeHypen()
        guard digits.count >= 2 else { return digits }
        
        if isFirstDigitZero {
            if isSecondDigitTwo { // 02
                if isDigitCountInRange(3, 5) {
                    insertHypen(2)
                } else if isDigitCountInRange(6, 9) {
                    insertHypen(2)
                    insertHypen(6)
                } else if digits.count == 10 {
                    insertHypen(2)
                    insertHypen(7)
                }
            } else { // 02 형식 아닐 때
                if isDigitCountInRange(4, 6) {
                    insertHypen(3)
                } else if isDigitCountInRange(7, 10) {
                    insertHypen(3)
                    insertHypen(7)
                } else if digits.count == 11 {
                    insertHypen(3)
                    insertHypen(8)
                }
            }
        }
        
        return digits
    }
}
```
### 고민한 점 
연락처의 유효성을 검사하는 `validatePhoneNumberFormat`과 `validateContactNumberFormat`이 같은 로직을 반복하고 있어서 중복되는 코드에 대한 공통화에 대해 고민했습니다.
일반전화와 연락처 두 가지 case의 `enum`으로 regex를 관리하도록 하고, 메서드의 파라미터로 `text`와 `enum`을 받아 `Bool`타입으로 반환하는 `validateContactFormat`로 연락처 유효성 검사 로직을 하나로 통합하여 기존의 코드를 보다 간결하게 개선했습니다.

## 구동 화면
![Simulator Screen Recording - iPhone 14 Pro - 2024-01-19 at 16 49 52](https://github.com/MyNB1/ios-contact-manager-ui/assets/63277563/0dde16d0-52be-4599-8887-07372e3a4d7c) ![Simulator Screen Recording - iPhone 14 Pro - 2024-01-19 at 16 50 36](https://github.com/MyNB1/ios-contact-manager-ui/assets/63277563/0951125a-0953-4099-abc3-e1f69addba34)
