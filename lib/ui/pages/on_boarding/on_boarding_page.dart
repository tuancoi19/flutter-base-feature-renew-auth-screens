import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_images.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/ui/pages/on_boarding/on_boarding_cubit.dart';
import 'package:flutter_base/ui/pages/on_boarding/on_boarding_navigator.dart';
import 'package:flutter_base/ui/pages/on_boarding/widgets/on_boarding_sub_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingPage extends StatelessWidget {
  static const router = 'onBoarding';

  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return OnBoardingCubit(
          navigator: OnBoardingNavigator(context: context),
        );
      },
      child: const OnBoardingChildPage(),
    );
  }
}

class OnBoardingChildPage extends StatefulWidget {
  const OnBoardingChildPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OnBoardingChildPageState();
  }
}

class _OnBoardingChildPageState extends State<OnBoardingChildPage> {
  late OnBoardingCubit _cubit;
  final PageController _pageViewController = PageController(initialPage: 0);
  List<Widget> _onBoardingPages = [];

  @override
  void initState() {
    super.initState();
    _onBoardingPages = [
      OnBoardingSubPage(
        title: S.current.onboarding_title_01,
        description: S.current.onboarding_description_01,
        image: AppImages.bgImagePlaceholder,
      ),
      OnBoardingSubPage(
        title: S.current.onboarding_title_02,
        description: S.current.onboarding_description_02,
        image: AppImages.bgImagePlaceholder,
      ),
      OnBoardingSubPage(
        title: S.current.onboarding_title_03,
        description: S.current.onboarding_description_03,
        image: AppImages.bgImagePlaceholder,
      ),
    ];
    _cubit = BlocProvider.of<OnBoardingCubit>(context);
    _cubit.setTotalPage(totalPage: _onBoardingPages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Stack(
          children: [
            BlocBuilder<OnBoardingCubit, OnBoardingState>(
              bloc: _cubit,
              buildWhen: (previous, current) =>
                  previous.activePage != current.activePage,
              builder: (context, state) {
                return PageView.builder(
                    controller: _pageViewController,
                    onPageChanged: (index) {
                      debugPrint(index.toString());
                      _cubit.onPageChanged(index);
                    },
                    itemCount: _onBoardingPages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _onBoardingPages[state.activePage];
                    });
              },
            ),
            Positioned(
              bottom: 70,
              left: 0,
              right: 0,
              height: 28,
              child: SizedBox(
                width: double.infinity,
                child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
                  bloc: _cubit,
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            _cubit.navigator.openSignInPage();
                          },
                          child: Text(S.of(context).button_skip),
                        ),
                        const Spacer(),
                        ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: _onBoardingPages.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 5,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                _pageViewController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: state.activePage == index
                                    ? Colors.black
                                    : Colors.black.withOpacity(0.3),
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            int nextPage = state.activePage + 1;
                            _pageViewController.animateToPage(nextPage,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.linear);
                            _cubit.onNextPage(
                              nextPage: nextPage,
                              context: context,
                            );
                          },
                          child: state.activePage == _onBoardingPages.length - 1
                              ? Text(S.of(context).lets_go)
                              : Text(S.of(context).button_next),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _cubit.close();
    super.dispose(); // dispose the PageController
  }
}
