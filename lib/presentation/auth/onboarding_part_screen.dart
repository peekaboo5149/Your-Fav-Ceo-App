part of 'login_screen.dart';

class _OnBoardingScreen extends StatefulWidget {
  final Config config;
  final ThemeData themeData;

  const _OnBoardingScreen({
    @required this.config,
    @required this.themeData,
  });

  @override
  __OnBoardingScreenState createState() => __OnBoardingScreenState();
}

class __OnBoardingScreenState extends State<_OnBoardingScreen> {
  Config get config => widget.config;
  ThemeData get theme => widget.themeData;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            onPageChanged: (val) {
              setState(() {
                currentIndex = val;
              });
            },
            itemCount: 3,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.all(config.width * 0.03),
              child: buildLottie(index),
            ),
          ),
        ),
        Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  3,
                  (index) => buildDots(
                        index: index,
                        currentPage: index == currentIndex,
                      ))),
        ),
        SizedBox(
          height: config.height * 0.02,
        ),
        // const Spacer(),
      ],
    );
  }

  AnimatedContainer buildDots({@required int index, bool currentPage = false}) {
    return AnimatedContainer(
      duration: animationDuration,
      margin: EdgeInsets.only(
        right: config.width * 0.01,
      ),
      width: !currentPage ? config.height * 0.013 : config.height * 0.023,
      height: config.height * 0.013,
      decoration: BoxDecoration(
        color: !currentPage ? theme.primaryColor : theme.accentColor,
        border: Border.all(
          color: theme.accentColor,
          width: config.width * 0.004,
        ),
        borderRadius: BorderRadius.all(Radius.circular(config.height * 0.1)),
      ),
    );
  }

  Widget buildLottie(int index) {
    return Align(
      alignment: Alignment.center,
      child: Lottie.asset(
        'assets/animation/lottie/lottie${index + 1}.json',
        width: config.width,
      ),
    );
  }
}
