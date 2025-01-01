
# Choolsuk Check

## 목차 
- [요약](#요약)
- [진행 상황](#진행-상황)
- [구현 결과](#구현-결과)
- [트러블 슈팅](#트러블-슈팅)
- [학습한 내용](#학습한-내용)
- [느낀 점](#느낀-점)

-------------

## 요약

|Index|Detail|
|------|---|
|기여|100% ( 1인 개발 진행 ) |
|앱의 목적 및 특징|회사 출근 위치를 기반으로 간단히 출석 체크를 도와주는 앱|
|구현 기간| **2024.12.22 ~ 2024.12.31**|
|기술 스택|Flutter / Dart / Google Maps API / Geolocator |
|Pain Point|기존 출근 관리 방식이 번거롭고 사용자 친화적이지 않음  |
|해결 방법|Google Maps와 GPS 기반 위치 검증을 통해 직관적이고 간편한 출근 체크 기능 구현|
|아쉬운점|iOS Simulator에서 GPS 설정 과정이 번거로웠으며, UI 최적화 시간이 부족 |

-------------

## 진행 상황

## 진행 상황

| 날짜                     | 내용                            |
|--------------------------|---------------------------------|
| **2024.12.22 ~ 2024.12.24** | 앱 전체적인 기능 및 디자인 구상  |
| **2024.12.24 ~ 2024.12.27** | 구글 API 연결 및 맵 UI 구현     |
| **2024.12.27 ~ 2024.12.31** | 근방 표시 및 내 위치 시뮬레이터 연결 |


-------------

# 구현 결과

## 구현

|지도 띄우기(android)|지도 띄우기(apple)|
|:----:|:----:|
|<img src="https://github.com/user-attachments/assets/f9bfe9c7-a350-4aec-94f3-b7ffdaf29750" width="300">| <img src="https://github.com/user-attachments/assets/de1f099c-cda0-413c-b8bb-3ca0b8614f38" width="300">|

|근방에 회사가 없는 경우(android)|근방에 회사가 없는 경우(apple)|
|:----:|:----:|
|<img src="https://github.com/user-attachments/assets/598af660-1c19-4eb3-af16-76e32fe8f18a" width="300">| <img src="https://github.com/user-attachments/assets/de1f099c-cda0-413c-b8bb-3ca0b8614f38" width="300">||<img src="https://github.com/user-attachments/assets/f9bfe9c7-a350-4aec-94f3-b7ffdaf29750" width="300">| <img src="https://github.com/user-attachments/assets/d8754e6d-63e5-4c1d-aa42-b8e929300044" width="300">|

|출석체크 (apple)|
|:----:|
|<img src="https://github.com/user-attachments/assets/b3486d60-654f-4c1f-a1f8-52609c841801" width="300">| 
-------------

## **트러블 슈팅**

### **문제 1: Google Maps API 키 미설정으로 지도가 표시되지 않음**
- **원인**: API 키를 설정하지 않았거나 잘못된 키를 사용함.
- **해결 방법**:
  1. Google Cloud Console에서 새로운 API 키 생성.
  2. `android/app/src/main/AndroidManifest.xml` 및 `ios/Runner/AppDelegate.swift`에 키를 올바르게 입력.

---

### **문제 2: iOS 시뮬레이터에서 GPS 좌표 설정 문제**
- **원인**: iOS 시뮬레이터는 GPS 좌표를 기본적으로 지원하지 않음.
- **해결 방법**:
  1. 시뮬레이터 메뉴에서 `Features > Location > Custom Location` 선택.
  2. 원하는 위도와 경도를 입력하여 테스트 진행.

---

### **문제 3: Geolocator 권한 요청 실패**
- **원인**: 위치 권한 요청 로직에서 `LocationPermission.deniedForever` 상태를 제대로 처리하지 않음.
- **해결 방법**:
  ```dart
  if (permission == LocationPermission.deniedForever) {
    AppSettings.openAppSettings();
  }


-------------

## **학습한 내용**

### **1. Google Maps API 사용법**
- Flutter에서 Google Maps 위젯을 사용하여 지도 표시 및 마커 추가 구현.
- `circles` 속성을 사용해 특정 반경을 표시하는 방법 학습.

### **2. Geolocator 패키지 활용**
- 현재 위치 가져오기 및 두 지점 간 거리 계산 구현.
- 위치 권한 요청 및 예외 처리.

### **3. Flutter UI 구성**
- `FutureBuilder`로 비동기 작업 결과를 처리하며, 작업 상태에 따라 UI를 동적으로 업데이트하는 방법 학습.
- `AlertDialog`를 활용해 다이얼로그 창 구현 및 사용자 인터랙션 처리.

### **4. Platform 차이점**
- Android와 iOS에서 위치 서비스 설정 및 에뮬레이터 활용 방식의 차이점을 파악.

------

## **느낀 점**

- 이번 프로젝트를 통해 Flutter의 위치 기반 기능과 Google Maps API 통합 경험을 쌓을 수 있었습니다.
- 비동기 작업(`Future`) 처리와 권한 요청 로직을 깊이 이해하게 되었으며, 실제 앱에서 발생 가능한 문제를 예상하고 해결하는 능력이 향상되었습니다.
- 하지만 프로젝트 기간 동안 UI/UX 최적화에 충분히 집중하지 못한 점이 아쉬웠습니다. 다음 프로젝트에서는 더 정교한 사용자 경험을 제공할 수 있도록 노력해야겠습니다.
- 전반적으로 Flutter의 강력한 기능과 플랫폼 간 호환성 덕분에 효율적으로 앱을 개발할 수 있었습니다. 앞으로 더 많은 Flutter 프로젝트에 도전하고 싶습니다!


