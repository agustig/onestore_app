import 'package:flutter/material.dart';
import 'package:flutter_store_fic7/presentation/pages/auth/widgets/sign_in_widget.dart';
import 'package:flutter_store_fic7/presentation/pages/auth/widgets/sign_up_widget.dart';
import 'package:flutter_store_fic7/utils/color_resource.dart';
import 'package:flutter_store_fic7/utils/custom_theme.dart';
import 'package:flutter_store_fic7/utils/dimensions.dart';
import 'package:flutter_store_fic7/utils/images.dart';

class AuthPage extends StatefulWidget {
  final int initialPage;
  const AuthPage({super.key, this.initialPage = 0});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late bool isLoginPage;
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.initialPage);
    isLoginPage = widget.initialPage == 0;
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            Images.background,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: Dimensions.topSpace),
                Image.asset(
                  Images.logoWithNameImage,
                  height: 150.0,
                  width: 200.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.marginSizeLarge),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: 0,
                        right: Dimensions.marginSizeExtraSmall,
                        left: 0,
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 1,
                          color: ColorResources.getGainsboro(context),
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => pageController.animateToPage(
                              0,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Sign in',
                                  style: isLoginPage
                                      ? titilliumBold
                                      : titilliumRegular,
                                ),
                                Container(
                                  height: 1.0,
                                  width: 40.0,
                                  margin: const EdgeInsets.only(top: 8),
                                  color: isLoginPage
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: Dimensions.paddingSizeExtraLarge,
                          ),
                          InkWell(
                            onTap: () => pageController.animateToPage(
                              1,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Sign up',
                                  style: !isLoginPage
                                      ? titilliumBold
                                      : titilliumRegular,
                                ),
                                Container(
                                  height: 1.0,
                                  width: 50.0,
                                  margin: const EdgeInsets.only(top: 8),
                                  color: !isLoginPage
                                      ? Theme.of(context).primaryColor
                                      : Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    itemCount: 2,
                    controller: pageController,
                    itemBuilder: (context, index) {
                      if (isLoginPage) {
                        return const SignInWidget();
                      } else {
                        return const SignUpWidget();
                      }
                    },
                    onPageChanged: (index) {
                      setState(() {
                        isLoginPage = !isLoginPage;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
