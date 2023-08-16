part of 'on_boarding_cubit.dart';

class OnBoardingState extends Equatable {
  final int activePage;
  final int totalPage;

  const OnBoardingState({
    this.activePage = 0,
    this.totalPage = 0,
  });

  OnBoardingState copyWith({
    int? activePage,
    int? totalPage,
  }) {
    return OnBoardingState(
      activePage: activePage ?? this.activePage,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  @override
  List<Object> get props => [
        activePage,
        totalPage,
      ];
}
