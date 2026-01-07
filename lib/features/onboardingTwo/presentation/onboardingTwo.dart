import 'package:flutter/material.dart';
import 'package:intake/core/theme/appPalette.dart';
import 'package:intake/features/auth/presentation/pages/signup_page.dart';

// =========================================================
// 1. THE MISSING CLASS (Copy this back!)
// This is the class your "AnimatedBtn" is trying to find.
// =========================================================
class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnboardingPagePresenter(
        pages: [
          OnboardingPageModel(
            title: 'Fast, Fluid and Secure',
            description: 'Enjoy the best of the world in the palm of your hands.',
            image: Image.asset('assets/logos/bicep.png'),
            bgColor: AppPallete.borderColor,
          ),
          OnboardingPageModel(
            title: 'Connect with your friends.',
            description: 'Connect with your friends anytime anywhere.',
            image: Image.asset('assets/logos/healthcare.png'),
            bgColor: AppPallete.gradient3,
          ),
          OnboardingPageModel(
            title: 'Bookmark your favourites',
            description: 'Bookmark your favourite quotes to read at a leisure time.',
            image: Image.asset('assets/logos/salad.png'),
            bgColor: AppPallete.borderColor,
          ),
          OnboardingPageModel(
            title: 'Follow creators',
            description: 'Follow your favourite creators to stay in the loop.',
            image: Image.asset('assets/logos/robot-assistant.png'),
            bgColor: AppPallete.gradient3,
          ),
        ],
      ),
    );
  }
}

// =========================================================
// 2. THE LOGIC (The Presenter)
// =========================================================
class OnboardingPagePresenter extends StatefulWidget {
  final List<OnboardingPageModel> pages;
  final VoidCallback? onSkip;
  final VoidCallback? onFinish;

  const OnboardingPagePresenter({
    super.key,
    required this.pages,
    this.onSkip,
    this.onFinish,
  });

  @override
  State<OnboardingPagePresenter> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPagePresenter> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void _navigateToSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: widget.pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.pages.length,
                  onPageChanged: (idx) {
                    setState(() {
                      _currentPage = idx;
                    });
                  },
                  itemBuilder: (context, idx) {
                    final item = widget.pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: item.image,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  item.title,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: item.textColor,
                                  ),
                                ),
                              ),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  item.description,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: item.textColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.pages.map((item) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: _currentPage == widget.pages.indexOf(item) ? 30 : 8,
                    height: 8,
                    margin: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  );
                }).toList(),
              ),
              // Buttons
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        widget.onSkip?.call();
                        _navigateToSignUp();
                      },
                      child: const Text("Skip", style: TextStyle(color: Colors.white)),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_currentPage == widget.pages.length - 1) {
                          widget.onFinish?.call();
                          _navigateToSignUp();
                        } else {
                          _pageController.animateToPage(
                            _currentPage + 1,
                            curve: Curves.easeInOutCubic,
                            duration: const Duration(milliseconds: 250),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            _currentPage == widget.pages.length - 1 ? "Finish" : "Next",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================
// 3. THE MODEL
// =========================================================
class OnboardingPageModel {
  final String title;
  final String description;
  final Widget image;
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel({
    required this.title,
    required this.description,
    required this.image,
    this.bgColor = Colors.blue,
    this.textColor = Colors.white,
  });
}