import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'startup_page.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingPage extends StatefulWidget {
  static const routeName = 'onBoarding';

  final sharedPreferences = GetIt.instance<SharedPreferences>();

  OnBoardingPage({
    super.key,
  });

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  var boardController = PageController();

  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/purchase_online.png',
        title: 'Purchase Online !!',
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing, sed do eiusmod tempor ut labore'),
    BoardingModel(
        image: 'assets/images/track_order_screen.png',
        title: 'Track order !!',
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing, sed do eiusmod tempor ut labore'),
    BoardingModel(
        image: 'assets/images/get_order_screen.png',
        title: 'Get your order !!',
        body: 'Lorem ipsum dolor sit amet, consectetur adipiscing, sed do eiusmod tempor ut labore'),
  ];
  void submit() {
    widget.sharedPreferences.setBool(K_OnBoarding, true).then((value) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        StartupPage.routeName,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  submit();
                },
                child: const Text('SKIP')),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              // App logo and name
              Image.asset(
                'assets/images/logo.png',
                height: 45,
              ),
              Expanded(
                child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (int index) {
                      if (index == boarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      }
                    },
                    controller: boardController,
                    itemCount: boarding.length,
                    itemBuilder: (context, index) => buildBoardingItem(boarding[index])),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: AppColors.dotColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      // spacing between dots
                      expansionFactor: 3.5,
                      spacing: 5.0,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: AppColors.primaryColor[300],
                    onPressed: () {
                      if (isLast) submit();
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Image(
          image: AssetImage(model.image),
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 24.0,
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 14.0,
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
    ]);
