# 운동 기록앱,  FitnessApp

## ● 프로젝트 개요
 > 개인 운동 목표와 진행 상황을 기록할 수 있는 애플리케이션으로 SwiftUI 학습을 위해 개발하였습니다. <br> 이때, MVVM 방식의 상태관리 모듈화에 집중하여 개발을 진행했습니다.

<br>

## ●  Main Page

<img width="989" alt="total" src="https://user-images.githubusercontent.com/63043043/209429992-5306ea27-9a08-4312-94e1-82e51961cbcb.png">

## ● Demo - GIF
<img src="https://user-images.githubusercontent.com/63043043/209432630-5b946f9b-7199-4fad-9b77-307632de0c04.gif" width="30%" height="50%"/>

<!--https://velog.io/@_uchanlee/%EB%84%A4-%EB%A7%8C%EB%93%A4%EC%96%B4-%EB%93%9C%EB%A0%B8%EC%8A%B5%EB%8B%88%EB%8B%A4-->

## ● Document Structure
```
📦 ExercisePostureGuide
├─ Modeifiers
│  └─ TextFieldCustomRoundedStyle.swift
├─ Publishers
│  ├─ AuthPublisher.swift
│  └─ QuerySnapshotPublisher.swift
├─ Errors
│  └─ ExercisePostureGuideError.swift
├─ Services
│  ├─ UserService.swift
│  └─ ChallengeService.swift
├─ Models
│  ├─ AppSettings.swift
│  └─ Challenge.swift
├─ Views
│  ├─ LandingView.swift
│  ├─ PrimaryButtonStyle.swift
│  ├─ CreateView.swift
│  ├─ DropdownView.swift
│  ├─ RemindView.swift
│  ├─ TabContainerView.swift
│  ├─ ChallengeListView.swift
│  ├─ SettingsView.swift
│  └─ LoginSingnupView.swift
└─ ViewModels
   └─ ExercisePostureGuideApp.swift  
```

## ● 사용 기술 및 라이브러리

|||
|------|---|
|Language|Swift|
|Framework|SwiftUI , CoreData|
|Tool|Xcode|

