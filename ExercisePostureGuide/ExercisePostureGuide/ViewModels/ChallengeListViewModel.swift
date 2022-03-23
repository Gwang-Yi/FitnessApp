//
//  ChallengeViewModel.swift
//  ExercisePostureGuide
//
//  Created by 박광이 on 2022/03/23.
//

import Combine

final class ChallengeListViewModel: ObservableObject{
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    @Published private(set) var itemViewModels: [ChallengeItemViewModel] = []
    @Published private(set) var error: ExcerisePostureGuideError?
    @Published private(set) var isLoading = false
    @Published var showingCreateModel = false
    let title = "진행중인 운동목록"
    
    enum Action{
        case retry
        case create
    }
    
    init(
        userService: UserServiceProtocol = UserService(),
        challengeService: ChallengeServiceProtocol = ChallengeService()
    ){
        self.userService = userService
        self.challengeService = challengeService
        observeChallenges()
    }
    
    func send(action: Action) {
        switch action {
        case .retry:
            observeChallenges()
        case .create:
            showingCreateModel = true
//        case .timeChange:
//            cancellables.removeAll()
//            observeChallenges()
        }
    }
    
    private func observeChallenges(){
        isLoading = true
        userService.currentUser()
            .compactMap{ $0?.uid }
            .flatMap{ [weak self] userId -> AnyPublisher<[Challenge],ExcerisePostureGuideError> in
                guard let self = self else {return Fail(error:  .default()).eraseToAnyPublisher() }
                return self.challengeService.observeChallenges(userId: userId)
            }.sink { [weak self]completion in
                guard let self = self else {return}
                self.isLoading = false
                switch completion{
                case let .failure(error):
                    self.error = error
                case .finished:
                    print("finished")
                }
            } receiveValue: { [weak self] challenges in
                guard let self = self else {return}
                self.isLoading = false
                self.error = nil
                self.showingCreateModel = false
                self.itemViewModels = challenges.map{.init($0)}
            }.store(in: &cancellables)

    }
}
