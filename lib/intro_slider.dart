import 'dart:async';

import 'package:flutter/material.dart';

enum TypeIndicatorAnimation { sizeTransition, sliding }

enum ScrollbarBehavior { hide, show, alwaysShow }

enum NavPosition { top, bottom }

abstract class IntroSliderConfig {
  IntroSliderConfig._();

  static const List<String> rtlLanguages = <String>[
    'ar', // Arabic
    'fa', // Farsi
    'he', // Hebrew
    'ps', // Pashto
    'ur', // Urdu
  ];
}

class PairIndicatorMargin<T1, T2> {
  final double left;
  final double right;

  PairIndicatorMargin(this.left, this.right);
}

class TripIndicatorDecoration<T1, T2, T3> {
  final List<double> sizes;
  final List<double> opacities;
  final List<bool> isActives;

  TripIndicatorDecoration(this.sizes, this.opacities, this.isActives);
}

class IndicatorConfig {
  /// Show or hide indicator
  final bool? isShowIndicator;

  /// Color indicator when passive
  final Color? colorIndicator;

  /// Color indicator when active (focusing)
  final Color? colorActiveIndicator;

  /// Size of each indicator
  final double? sizeIndicator;

  /// Space between every indicator
  final double? spaceBetweenIndicator;

  /// Type indicator animation
  final TypeIndicatorAnimation? typeIndicatorAnimation;

  /// Custom indicator
  final Widget? indicatorWidget;

  /// Custom active (focusing) indicator
  final Widget? activeIndicatorWidget;

  const IndicatorConfig({
    this.isShowIndicator,
    this.colorIndicator,
    this.colorActiveIndicator,
    this.sizeIndicator,
    this.spaceBetweenIndicator,
    this.typeIndicatorAnimation,
    this.indicatorWidget,
    this.activeIndicatorWidget,
  })  : assert(sizeIndicator == null || sizeIndicator >= 0),
        assert(spaceBetweenIndicator == null || spaceBetweenIndicator >= 0);
}

class ContentConfig {
  // ---------- Title ----------
  /// Change text title at top
  final String? title;

  /// Set a custom widget as the title (ignore `title` if define both)
  final Widget? widgetTitle;

  /// Change max number of lines title at top
  final int? maxLineTitle;

  /// Style for text title
  final TextStyle? styleTitle;

  /// TextAlign for text title
  final TextAlign? textAlignTitle;

  /// TextOverflow for text title
  final TextOverflow? textOverFlowTitle;

  /// Margin for text title
  final EdgeInsets? marginTitle;

  // ---------- Image ----------
  /// Path to your local image
  final String? pathImage;

  /// Width of image
  final double? widthImage;

  /// Height of image
  final double? heightImage;

  /// Foreground image fit
  final BoxFit? foregroundImageFit;

  // ---------- Center Widget ----------
  /// Your custom's widget
  final Widget? centerWidget;

  /// Fire when press center image/widge
  final void Function()? onCenterItemPress;

  // ---------- Description ----------
  /// Change text description at bottom
  final String? description;

  ///  Set a custom widget as the description (ignore `description` if define both)
  final Widget? widgetDescription;

  /// Maximum line of text description
  final int? maxLineTextDescription;

  /// Style for text description
  final TextStyle? styleDescription;

  /// TextAlign for text description
  final TextAlign? textAlignDescription;

  /// TextOverflow for text description
  final TextOverflow? textOverFlowDescription;

  /// Margin for text description
  final EdgeInsets? marginDescription;

  // ---------- Background color ----------
  /// Background tab color (if set, will ignore gradient properties below)
  final Color? backgroundColor;

  /// Gradient tab color begin
  final Color? colorBegin;

  /// Gradient tab color end
  final Color? colorEnd;

  /// Direction color begin
  final AlignmentGeometry? directionColorBegin;

  /// Direction color end
  final AlignmentGeometry? directionColorEnd;

  // ---------- Background image ----------
  /// Set image for background (if set, will ignore all parameter at `Background Color` above)
  final String? backgroundImage;

  /// Set image (from network) for background
  final String? backgroundNetworkImage;

  /// Background image fit
  final BoxFit? backgroundImageFit;

  /// A color filter to apply to the image background before painting it
  final Color? backgroundFilterColor;

  /// Opacity for `backgroundFilterColor`
  final double? backgroundFilterOpacity;

  /// Background blend mode
  final BlendMode? backgroundBlendMode;

  /// Allow to specify how the vertical scrollbar should behave
  /// (scroll enable when content length is greater than screen length)
  final ScrollbarBehavior? verticalScrollbarBehavior;

  const ContentConfig({
    // ---------- Title ----------
    this.widgetTitle,
    this.title,
    this.maxLineTitle,
    this.styleTitle,
    this.textAlignTitle,
    this.textOverFlowTitle,
    this.marginTitle,

    // ---------- Image ----------
    this.pathImage,
    this.widthImage,
    this.heightImage,
    this.foregroundImageFit,

    // ---------- Center Widget ----------
    this.centerWidget,
    this.onCenterItemPress,

    // ---------- Description ----------
    this.widgetDescription,
    this.description,
    this.maxLineTextDescription,
    this.styleDescription,
    this.textAlignDescription,
    this.textOverFlowDescription,
    this.marginDescription,

    // ---------- Background color ----------
    this.backgroundColor,
    this.colorBegin,
    this.colorEnd,
    this.directionColorBegin,
    this.directionColorEnd,

    // ---------- Background image ----------
    this.backgroundImage,
    this.backgroundImageFit,
    this.backgroundNetworkImage,
    this.backgroundFilterOpacity,
    this.backgroundFilterColor,
    this.backgroundBlendMode,
    this.verticalScrollbarBehavior,
  });
}

class NavigationBarConfig {
  /// Padding
  EdgeInsets padding;

  /// Move navigation bar to top or bottom page
  NavPosition navPosition;

  /// Background color
  Color backgroundColor;

  NavigationBarConfig({
    this.padding = const EdgeInsets.symmetric(vertical: 10),
    this.navPosition = NavPosition.bottom,
    this.backgroundColor = Colors.transparent,
  });
}

class IntroSliderTab extends StatelessWidget {
  const IntroSliderTab({
    super.key,
    required this.navigationBarConfig,
    this.contentConfig,
  });

  final NavigationBarConfig navigationBarConfig;
  final ContentConfig? contentConfig;

  @override
  Widget build(BuildContext context) {
    final listView = ListView(
      children: <Widget>[
        Container(
          // Title
          margin: contentConfig?.marginTitle ??
              const EdgeInsets.only(
                  top: 70.0, bottom: 50.0, left: 20.0, right: 20.0,),
          child: contentConfig?.widgetTitle ??
              Text(
                contentConfig?.title ?? '',
                style: contentConfig?.styleTitle ??
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                maxLines: contentConfig?.maxLineTitle ?? 1,
                textAlign: contentConfig?.textAlignTitle ?? TextAlign.center,
                overflow:
                    contentConfig?.textOverFlowTitle ?? TextOverflow.ellipsis,
              ),
        ),

        // Image or Center widget
        GestureDetector(
          onTap: contentConfig?.onCenterItemPress,
          child: contentConfig?.pathImage != null
              ? Image.asset(
                  (contentConfig?.pathImage)!,
                  width: contentConfig?.widthImage ?? 200.0,
                  height: contentConfig?.heightImage ?? 200.0,
                  fit: contentConfig?.foregroundImageFit ?? BoxFit.contain,
                )
              : Center(
                  child:
                      contentConfig?.centerWidget ?? const SizedBox.shrink()),
        ),

        // Description
        Container(
          margin: contentConfig?.marginDescription ??
              const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
          child: contentConfig?.widgetDescription ??
              Text(
                contentConfig?.description ?? '',
                style: contentConfig?.styleDescription ??
                    const TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign:
                    contentConfig?.textAlignDescription ?? TextAlign.center,
                maxLines: contentConfig?.maxLineTextDescription ?? 100,
                overflow: contentConfig?.textOverFlowDescription ??
                    TextOverflow.ellipsis,
              ),
        ),
      ],
    );
    Color? backgroundColor = contentConfig?.backgroundColor;
    String? backgroundImage = contentConfig?.backgroundImage;
    String? backgroundNetworkImage = contentConfig?.backgroundNetworkImage;
    Color? backgroundFilterColor = contentConfig?.backgroundFilterColor;
    ScrollbarBehavior? verticalScrollbarBehavior =
        contentConfig?.verticalScrollbarBehavior;
    double safeMarginContent =
        navigationBarConfig.padding.along(Axis.vertical) + 50;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: backgroundImage == null && backgroundNetworkImage == null
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: backgroundColor != null
                    ? [backgroundColor, backgroundColor]
                    : [
                        contentConfig?.colorBegin ?? Colors.transparent,
                        contentConfig?.colorEnd ?? Colors.transparent,
                      ],
                begin: contentConfig?.directionColorBegin ?? Alignment.topLeft,
                end: contentConfig?.directionColorEnd ?? Alignment.bottomRight,
              ),
            )
          : BoxDecoration(
              image: DecorationImage(
              image: backgroundImage != null
                  ? AssetImage(backgroundImage)
                  : NetworkImage(backgroundNetworkImage!) as ImageProvider,
              fit: contentConfig?.backgroundImageFit ?? BoxFit.cover,
              colorFilter: ColorFilter.mode(
                backgroundFilterColor != null
                    ? backgroundFilterColor.withOpacity(
                        contentConfig?.backgroundFilterOpacity ?? 0.5)
                    : Colors.black.withOpacity(
                        contentConfig?.backgroundFilterOpacity ?? 0.5),
                contentConfig?.backgroundBlendMode ?? BlendMode.darken,
              ),
            )),
      child: Container(
        margin: EdgeInsets.only(
          top: navigationBarConfig.navPosition == NavPosition.top
              ? safeMarginContent
              : 0,
          bottom: navigationBarConfig.navPosition == NavPosition.bottom
              ? safeMarginContent
              : 0,
        ),
        child: verticalScrollbarBehavior != ScrollbarBehavior.hide
            ? Scrollbar(
                thumbVisibility:
                    verticalScrollbarBehavior == ScrollbarBehavior.alwaysShow,
                child: listView,
              )
            : listView,
      ),
    );
  }
}
class IntroSlider extends StatefulWidget {
  // ---------- Tabs ----------
  /// An array of ContentConfig
  final List<ContentConfig>? listContentConfig;

  /// Render your own widget list tabs
  final List<Widget>? listCustomTabs;

  /// Notify when tab change completed
  final void Function(int index)? onTabChangeCompleted;

  /// Ref function go to specific tab index
  final void Function(Function function)? refFuncGoToTab;

  /// Background color for all tabs
  final Color? backgroundColorAllTabs;

  // ---------- SKIP button ----------
  /// Render your own widget SKIP button
  final Widget? renderSkipBtn;

  /// Render your own style SKIP button
  final ButtonStyle? skipButtonStyle;

  /// Fire when press SKIP button
  final void Function()? onSkipPress;

  /// Show or hide SKIP button
  final bool? isShowSkipBtn;

  /// Assign key to SKIP button
  final Key? skipButtonKey;

  // ---------- PREV button ----------
  /// Render your own widget PREV button
  final Widget? renderPrevBtn;

  /// Render your own style PREV button
  final ButtonStyle? prevButtonStyle;

  /// Show or hide PREV button (only visible if skip is hidden)
  final bool? isShowPrevBtn;

  /// Assign key to PREV button
  final Key? prevButtonKey;

  // ---------- NEXT button ----------
  /// Render your own widget NEXT button
  final Widget? renderNextBtn;

  /// Render your own style NEXT button
  final ButtonStyle? nextButtonStyle;

  /// Show or hide NEXT button
  final bool? isShowNextBtn;

  /// Fire when press NEXT button
  final Function()? onNextPress;

  /// Assign key to NEXT button
  final Key? nextButtonKey;

  // ---------- DONE button ----------
  /// Render your own widget DONE button
  final Widget? renderDoneBtn;

  /// Render your own style NEXT button
  final ButtonStyle? doneButtonStyle;

  /// Fire when press DONE button
  final void Function()? onDonePress;

  /// Show or hide DONE button
  final bool? isShowDoneBtn;

  /// Assign key to DONE button
  final Key? doneButtonKey;

  // ---------- Indicator ----------
  /// Custom indicators
  final IndicatorConfig? indicatorConfig;

  // ---------- Navigation bar ----------
  /// Custom the position of navigation bar
  final NavigationBarConfig? navigationBarConfig;

  // ---------- Scroll behavior ----------
  /// Whether or not the slider is scrollable (or controlled only by buttons)
  final bool? isScrollable;

  /// Determines the physics horizontal scroll for the slides
  final ScrollPhysics? scrollPhysics;

  /// Set transition animation curves (also effect to indicator when it's sliding)
  final Curve? curveScroll;

  /// Enable auto scroll slides
  final bool? isAutoScroll;

  /// Loop transition by go to first slide when reach the end
  final bool? isLoopAutoScroll;

  /// Auto scroll will be paused if user touch to slide
  final bool? isPauseAutoPlayOnTouch;

  /// Sets duration to determine the frequency of slides
  final Duration? autoScrollInterval;

  // Constructor
  const IntroSlider({
    super.key,
    // Tabs
    this.listContentConfig,
    this.backgroundColorAllTabs,
    this.listCustomTabs,
    this.onTabChangeCompleted,
    this.refFuncGoToTab,

    // Skip
    this.renderSkipBtn,
    this.skipButtonStyle,
    this.onSkipPress,
    this.isShowSkipBtn,
    this.skipButtonKey,

    // Prev
    this.renderPrevBtn,
    this.prevButtonStyle,
    this.isShowPrevBtn,
    this.prevButtonKey,

    // Done
    this.renderDoneBtn,
    this.onDonePress,
    this.doneButtonStyle,
    this.isShowDoneBtn,
    this.doneButtonKey,

    // Next
    this.renderNextBtn,
    this.nextButtonStyle,
    this.isShowNextBtn,
    this.onNextPress,
    this.nextButtonKey,

    // Indicator
    this.indicatorConfig,

    // Navigation bar
    this.navigationBarConfig,

    // Scroll behavior
    this.isScrollable,
    this.isAutoScroll,
    this.isLoopAutoScroll,
    this.isPauseAutoPlayOnTouch,
    this.autoScrollInterval,
    this.curveScroll,
    this.scrollPhysics,
  }) : assert(
          (listContentConfig?.length ?? 0) > 0 || (listCustomTabs?.length ?? 0) > 0,
          "You must define at least listContentConfig or listCustomTabs",
        );

  @override
  IntroSliderState createState() => IntroSliderState();
}

class IntroSliderState extends State<IntroSlider> with SingleTickerProviderStateMixin {
  // ---------- Tabs ----------
  List<Widget>? listCustomTabs;
  Function? onTabChangeCompleted;

  // ---------- SKIP button ----------
  late final Widget renderSkipBtn;
  late final void Function()? onSkipPress;
  late final ButtonStyle skipButtonStyle;
  late final bool isShowSkipBtn;
  late final Key? skipButtonKey;

  // ---------- PREV button ----------
  late final Widget renderPrevBtn;
  late final ButtonStyle prevButtonStyle;
  late final bool isShowPrevBtn;
  late final Key? prevButtonKey;

  // ---------- DONE button ----------
  late final Widget renderDoneBtn;
  late final void Function()? onDonePress;
  late final ButtonStyle doneButtonStyle;
  late final bool isShowDoneBtn;
  late final Key? doneButtonKey;

  // ---------- NEXT button ----------
  late final Widget renderNextBtn;
  late final ButtonStyle nextButtonStyle;
  late final bool isShowNextBtn;
  late final void Function()? onNextPress;
  late final Key? nextButtonKey;

  // ---------- Indicator ----------
  late final bool isShowIndicator;
  late final Color colorIndicator;
  late final Color colorActiveIndicator;
  late final double sizeIndicator;
  late final double spaceBetweenIndicator;
  late final TypeIndicatorAnimation typeIndicatorAnimation;
  late final Widget? indicatorWidget;
  late final Widget? activeIndicatorWidget;

  // ---------- Scroll behavior ----------
  late final bool isScrollable;
  late final ScrollPhysics scrollPhysics;
  late final bool isAutoScroll;
  late final bool isLoopAutoScroll;
  late final bool isPauseAutoPlayOnTouch;
  late final Duration autoScrollInterval;
  late final Curve curveScroll;

  // ---------- Navigation bar ----------
  late final NavigationBarConfig navigationBarConfig;

  // ---------- Internal variable  ----------
  late TabController tabController;

  List<Widget> tabs = [];

  final streamDecoIndicator = StreamController<TripIndicatorDecoration>();
  final streamMarginIndicatorFocusing = StreamController<PairIndicatorMargin>();
  final streamCurrentTabIndex = StreamController<int>.broadcast();

  double currentAnimationValue = 0;
  int currentTabIndex = 0;

  late final int lengthSlide;
  late double widthDevice;
  Timer? timerAutoScroll;

  @override
  void initState() {
    super.initState();
    skipButtonKey = widget.skipButtonKey;
    prevButtonKey = widget.prevButtonKey;
    doneButtonKey = widget.doneButtonKey;
    nextButtonKey = widget.nextButtonKey;

    lengthSlide = widget.listContentConfig?.length ?? widget.listCustomTabs?.length ?? 0;
    isAutoScroll = widget.isAutoScroll ?? false;
    isLoopAutoScroll = widget.isLoopAutoScroll ?? false;
    isPauseAutoPlayOnTouch = widget.isPauseAutoPlayOnTouch ?? true;
    autoScrollInterval = widget.autoScrollInterval ?? const Duration(seconds: 4);
    curveScroll = widget.curveScroll ?? Curves.ease;

    streamCurrentTabIndex.add(0);
    onTabChangeCompleted = widget.onTabChangeCompleted;
    tabController = TabController(length: lengthSlide, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentTabIndex = tabController.index;
        streamCurrentTabIndex.add(currentTabIndex);
        onTabChangeCompleted?.call(tabController.index);
      }
      currentAnimationValue = tabController.animation?.value ?? 0;
    });

    if (isAutoScroll) {
      _startTimerAutoScroll();
    }

    // Send reference function goToTab to parent
    widget.refFuncGoToTab?.call(_goToTab);

    // Indicator
    isShowIndicator = widget.indicatorConfig?.isShowIndicator ?? true;
    colorIndicator = widget.indicatorConfig?.colorIndicator ?? Colors.black54;
    colorActiveIndicator = widget.indicatorConfig?.colorActiveIndicator ?? colorIndicator;
    sizeIndicator = widget.indicatorConfig?.sizeIndicator ?? 8;
    spaceBetweenIndicator = widget.indicatorConfig?.spaceBetweenIndicator ?? sizeIndicator;
    typeIndicatorAnimation = widget.indicatorConfig?.typeIndicatorAnimation ?? TypeIndicatorAnimation.sliding;
    indicatorWidget = widget.indicatorConfig?.indicatorWidget;
    activeIndicatorWidget = widget.indicatorConfig?.activeIndicatorWidget;

    // Navigation bar
    NavigationBarConfig? tempNavigationBarConfig = widget.navigationBarConfig;
    if (tempNavigationBarConfig != null) {
      navigationBarConfig = tempNavigationBarConfig;
    } else {
      navigationBarConfig = NavigationBarConfig();
    }

    double initValueMarginRight = (sizeIndicator + spaceBetweenIndicator) * (lengthSlide - 1);
    List<double> sizeIndicators = [];
    List<double> opacityIndicators = [];
    List<bool> isActives = [];

    switch (typeIndicatorAnimation) {
      case TypeIndicatorAnimation.sliding:
        for (var i = 0; i < lengthSlide; i++) {
          sizeIndicators.add(sizeIndicator);
          opacityIndicators.add(1);
          isActives.add(false);
        }
        streamMarginIndicatorFocusing.add(PairIndicatorMargin(0.0, initValueMarginRight));
        break;
      case TypeIndicatorAnimation.sizeTransition:
        for (var i = 0; i < lengthSlide; i++) {
          if (i == 0) {
            sizeIndicators.add(sizeIndicator * 1.5);
            opacityIndicators.add(1);
            isActives.add(true);
          } else {
            sizeIndicators.add(sizeIndicator);
            opacityIndicators.add(0.5);
            isActives.add(false);
          }
        }
        break;
    }
    streamDecoIndicator.add(TripIndicatorDecoration(sizeIndicators, opacityIndicators, isActives));

    tabController.animation?.addListener(() {
      if (tabController.animation == null) return;
      double animationValue = tabController.animation!.value;
      switch (typeIndicatorAnimation) {
        case TypeIndicatorAnimation.sliding:
          double spaceAvg = (sizeIndicator + spaceBetweenIndicator) / 2;
          double marginLeft = animationValue * spaceAvg * 2;
          double marginRight = initValueMarginRight - (animationValue * spaceAvg * 2);
          streamMarginIndicatorFocusing.add(PairIndicatorMargin(marginLeft, marginRight));
          break;
        case TypeIndicatorAnimation.sizeTransition:
          if (animationValue == currentAnimationValue) {
            break;
          }
          double diffValueAnimation = (animationValue - currentAnimationValue).abs();
          final diffValueIndex = (currentTabIndex - tabController.index).abs();
          if (tabController.indexIsChanging && (tabController.index - tabController.previousIndex).abs() > 1) {
            // When press skip button
            if (diffValueAnimation < 1) {
              diffValueAnimation = 1;
            }
            sizeIndicators[currentTabIndex] =
                sizeIndicator * 1.5 - (sizeIndicator / 2) * (1 - (diffValueIndex - diffValueAnimation));
            sizeIndicators[tabController.index] =
                sizeIndicator + (sizeIndicator / 2) * (1 - (diffValueIndex - diffValueAnimation));
            opacityIndicators[currentTabIndex] = 1 - (diffValueAnimation / diffValueIndex) / 2;
            opacityIndicators[tabController.index] = 0.5 + (diffValueAnimation / diffValueIndex) / 2;
            isActives[currentTabIndex] = false;
            isActives[tabController.index] = true;
          } else {
            if (animationValue > currentAnimationValue) {
              // Swipe left
              sizeIndicators[currentTabIndex] = sizeIndicator * 1.5 - (sizeIndicator / 2) * diffValueAnimation;
              sizeIndicators[currentTabIndex + 1] = sizeIndicator + (sizeIndicator / 2) * diffValueAnimation;
              opacityIndicators[currentTabIndex] = 1 - diffValueAnimation / 2;
              opacityIndicators[currentTabIndex + 1] = 0.5 + diffValueAnimation / 2;
              isActives[currentTabIndex] = false;
              isActives[tabController.index] = true;
            } else {
              // Swipe right
              sizeIndicators[currentTabIndex] = sizeIndicator * 1.5 - (sizeIndicator / 2) * diffValueAnimation;
              sizeIndicators[currentTabIndex - 1] = sizeIndicator + (sizeIndicator / 2) * diffValueAnimation;
              opacityIndicators[currentTabIndex] = 1 - diffValueAnimation / 2;
              opacityIndicators[currentTabIndex - 1] = 0.5 + diffValueAnimation / 2;
              isActives[currentTabIndex] = false;
              isActives[tabController.index] = true;
            }
          }
          streamDecoIndicator.add(TripIndicatorDecoration(sizeIndicators, opacityIndicators, isActives));
          break;
      }
    });

    isScrollable = widget.isScrollable ?? true;
    scrollPhysics = widget.scrollPhysics ?? const ScrollPhysics();

    _setupButtonDefaultValues();

    tabs = widget.listCustomTabs ?? _renderTabsFromContentConfig(widget.listContentConfig!);
  }

  @override
  void dispose() {
    tabController.dispose();
    streamDecoIndicator.close();
    streamMarginIndicatorFocusing.close();
    streamCurrentTabIndex.close();
    _clearTimerAutoScroll();
    super.dispose();
  }

  List<Widget> _renderTabsFromContentConfig(List<ContentConfig> listContentConfig) {
    List<Widget> tempTabs = [];
    for (var element in listContentConfig) {
      tempTabs.add(
        IntroSliderTab(
          navigationBarConfig: navigationBarConfig,
          contentConfig: element,
        ),
      );
    }
    return tempTabs;
  }

  void _startTimerAutoScroll() {
    timerAutoScroll = Timer.periodic(autoScrollInterval, (Timer timer) {
      if (tabController.index < lengthSlide - 1) {
        if (!_checkIsAnimating()) {
          tabController.animateTo(tabController.index + 1, curve: curveScroll);
        }
      } else {
        if (isLoopAutoScroll) {
          if (!_checkIsAnimating()) {
            tabController.animateTo(0, curve: curveScroll);
          }
        }
      }
    });
  }

  void _clearTimerAutoScroll() {
    timerAutoScroll?.cancel();
    timerAutoScroll = null;
  }

  void _setupButtonDefaultValues() {
    // Skip button
    onSkipPress = widget.onSkipPress ??
        () {
          if (!_checkIsAnimating()) {
            if (lengthSlide > 0) {
              tabController.animateTo(lengthSlide - 1, curve: curveScroll);
            }
          }
        };
    isShowSkipBtn = widget.isShowSkipBtn ?? true;
    renderSkipBtn = widget.renderSkipBtn ?? const Text("SKIP");
    skipButtonStyle = widget.skipButtonStyle ?? const ButtonStyle();

    // Prev button
    if (isShowSkipBtn) {
      isShowPrevBtn = false;
    } else {
      isShowPrevBtn = widget.isShowPrevBtn ?? true;
    }

    renderPrevBtn = widget.renderPrevBtn ?? const Text("PREV");
    prevButtonStyle = widget.prevButtonStyle ?? const ButtonStyle();

    isShowNextBtn = widget.isShowNextBtn ?? true;

    // Done button
    onDonePress = widget.onDonePress ?? () {};
    renderDoneBtn = widget.renderDoneBtn ?? const Text("DONE");
    doneButtonStyle = widget.doneButtonStyle ?? const ButtonStyle();
    isShowDoneBtn = widget.isShowDoneBtn ?? true;

    // Next button
    onNextPress = widget.onNextPress ?? () {};
    renderNextBtn = widget.renderNextBtn ?? const Text("NEXT");
    nextButtonStyle = widget.nextButtonStyle ?? const ButtonStyle();
  }

  void _goToTab(int index) {
    if (index < tabController.length) {
      tabController.animateTo(index, curve: curveScroll);
    }
  }

  bool _checkIsAnimating() {
    Animation<double>? animation = tabController.animation;
    if (animation != null) {
      return animation.value - animation.value.truncate() != 0;
    } else {
      return false;
    }
  }

  bool _checkIsRTLLanguage(String language) {
    return IntroSliderConfig.rtlLanguages.contains(language);
  }

  @override
  Widget build(BuildContext context) {
    widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      body: DefaultTabController(
        length: lengthSlide,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTapDown: (a) {
                _clearTimerAutoScroll();
              },
              onTapUp: (a) {
                if (isAutoScroll) {
                  _startTimerAutoScroll();
                }
              },
              onTapCancel: () {
                if (isAutoScroll) {
                  _startTimerAutoScroll();
                }
              },
              child: TabBarView(
                controller: tabController,
                physics: isScrollable ? scrollPhysics : const NeverScrollableScrollPhysics(),
                children: tabs,
              ),
            ),
            _buildNavigationBar(),
          ],
        ),
      ),
      backgroundColor: widget.backgroundColorAllTabs ?? Colors.transparent,
    );
  }

  Widget _buildNavigationBar() {
    return Positioned(
      top: navigationBarConfig.navPosition == NavPosition.top ? 0 : null,
      bottom: navigationBarConfig.navPosition == NavPosition.bottom ? 0 : null,
      left: 0,
      right: 0,
      child: Container(
        padding: navigationBarConfig.padding,
        color: navigationBarConfig.backgroundColor,
        child: Row(
          children: <Widget>[
            // Skip button
            StreamBuilder<int>(
                stream: streamCurrentTabIndex.stream,
                builder: (context, snapshot) {
                  int currentTabIndex = snapshot.data ?? 0;
                  return Container(
                    alignment: Alignment.center,
                    width: widthDevice / 4,
                    child: isShowSkipBtn
                        ? _buildSkipButton(currentTabIndex)
                        : (isShowPrevBtn ? _buildPrevButton(currentTabIndex) : const SizedBox.shrink()),
                  );
                }),

            // Indicator
            Flexible(
              child: isShowIndicator
                  ? Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        _buildListIndicator(),
                        typeIndicatorAnimation == TypeIndicatorAnimation.sliding
                            ? _buildActiveIndicator()
                            : const SizedBox.shrink()
                      ],
                    )
                  : const SizedBox.shrink(),
            ),

            // Next, Done button
            StreamBuilder<int>(
                stream: streamCurrentTabIndex.stream,
                builder: (context, snapshot) {
                  int currentTabIndex = snapshot.data ?? 0;
                  return Container(
                    alignment: Alignment.center,
                    width: widthDevice / 4,
                    height: 50,
                    child: currentTabIndex + 1 == lengthSlide
                        ? isShowDoneBtn
                            ? _buildDoneButton()
                            : const SizedBox.shrink()
                        : isShowNextBtn
                            ? _buildNextButton()
                            : const SizedBox.shrink(),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipButton(currentTabIndex) {
    if (currentTabIndex + 1 == lengthSlide) {
      return Container(width: widthDevice / 4);
    } else {
      return TextButton(
        key: skipButtonKey,
        onPressed: onSkipPress,
        style: skipButtonStyle,
        child: renderSkipBtn,
      );
    }
  }

  Widget _buildPrevButton(currentTabIndex) {
    if (currentTabIndex == 0) {
      return Container(width: widthDevice / 4);
    } else {
      return TextButton(
        key: prevButtonKey,
        onPressed: () {
          if (!_checkIsAnimating()) {
            tabController.animateTo(tabController.index - 1, curve: curveScroll);
          }
        },
        style: prevButtonStyle,
        child: renderPrevBtn,
      );
    }
  }

  Widget _buildDoneButton() {
    return TextButton(
      key: doneButtonKey,
      onPressed: onDonePress,
      style: doneButtonStyle,
      child: renderDoneBtn,
    );
  }

  Widget _buildNextButton() {
    return TextButton(
      key: nextButtonKey,
      onPressed: () {
        onNextPress?.call();
        if (!_checkIsAnimating()) {
          tabController.animateTo(tabController.index + 1, curve: curveScroll);
        }
      },
      style: nextButtonStyle,
      child: renderNextBtn,
    );
  }

  Widget _buildActiveIndicator() {
    return StreamBuilder<PairIndicatorMargin>(
      stream: streamMarginIndicatorFocusing.stream,
      builder: (context, snapshot) {
        var pairIndicatorMargin = snapshot.data;
        if (pairIndicatorMargin == null) return const SizedBox.shrink();
        return Container(
          margin: EdgeInsets.only(
            left: _checkIsRTLLanguage(Localizations.localeOf(context).languageCode)
                ? pairIndicatorMargin.right
                : pairIndicatorMargin.left,
            right: _checkIsRTLLanguage(Localizations.localeOf(context).languageCode)
                ? pairIndicatorMargin.left
                : pairIndicatorMargin.right,
          ),
          child: activeIndicatorWidget ??
              indicatorWidget ??
              _buildDefaultDot(size: sizeIndicator, color: colorActiveIndicator),
        );
      },
    );
  }

  Widget _buildListIndicator() {
    return StreamBuilder<TripIndicatorDecoration>(
      stream: streamDecoIndicator.stream,
      builder: (context, snapshot) {
        var tripIndicatorDecoration = snapshot.data;
        if (tripIndicatorDecoration == null) return const SizedBox.shrink();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _generateListIndicator(
            tripIndicatorDecoration.opacities,
            tripIndicatorDecoration.sizes,
            tripIndicatorDecoration.isActives,
          ),
        );
      },
    );
  }

  List<Widget> _generateListIndicator(
    List<double> opacityIndicators,
    List<double> sizeIndicators,
    List<bool> isActiveIndicators,
  ) {
    List<Widget> indicators = [];
    for (var i = 0; i < lengthSlide; i++) {
      double opacityCurrentIndicator = opacityIndicators[i];
      if (opacityCurrentIndicator >= 0 && opacityCurrentIndicator <= 1 && colorActiveIndicator == colorIndicator) {
        indicators.add(
          _buildOpacityIndicator(
            size: sizeIndicators[i],
            color: colorIndicator,
            opacity: opacityIndicators[i],
            index: i,
          ),
        );
      } else {
        indicators.add(
          _buildIndicator(
            size: sizeIndicators[i],
            color: colorIndicator,
            colorActive: colorActiveIndicator,
            isActive: isActiveIndicators[i],
            index: i,
          ),
        );
      }
    }
    return indicators;
  }

  Widget _buildIndicator({
    required double size,
    required Color color,
    required Color colorActive,
    required bool isActive,
    required int index,
  }) {
    double space = spaceBetweenIndicator / 2;
    return Container(
      margin: EdgeInsets.only(left: space, right: space),
      child: GestureDetector(
        onTap: () {
          tabController.animateTo(index, curve: curveScroll);
        },
        child: indicatorWidget != null
            ? _buildCustomIndicator(currentSize: size, originSize: sizeIndicator, child: indicatorWidget!)
            : _buildDefaultDot(size: size, color: isActive ? colorActive : color),
      ),
    );
  }

  Widget _buildOpacityIndicator({
    required double size,
    required Color color,
    required double opacity,
    required int index,
  }) {
    double space = spaceBetweenIndicator / 2;
    return Container(
      margin: EdgeInsets.only(left: space, right: space),
      child: GestureDetector(
        onTap: () {
          tabController.animateTo(index, curve: curveScroll);
        },
        child: Opacity(
          opacity: opacity,
          child: indicatorWidget != null
              ? _buildCustomIndicator(currentSize: size, originSize: sizeIndicator, child: indicatorWidget!)
              : _buildDefaultDot(size: size, color: color),
        ),
      ),
    );
  }

  Widget _buildCustomIndicator({required double currentSize, required double originSize, required Widget child}) {
    return Transform.scale(
      scale: currentSize / originSize,
      child: child,
    );
  }

  Widget _buildDefaultDot({required double size, Color? color}) {
    return Container(
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(size / 2)),
      width: size,
      height: size,
    );
  }
}