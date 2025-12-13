import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_new/features/feature_bookmark/presentation/blocs/delete_all_bloc/delete_all_bloc.dart';
import '../../features/feature_bookmark/presentation/blocs/delete_city_byname_bloc/delete_city_bloc.dart';
import '../../features/feature_bookmark/presentation/blocs/find_city_byname_bloc/find_city_bloc.dart';
import '../../features/feature_bookmark/presentation/blocs/get_all_bloc/get_all_bloc.dart';
import '../../features/feature_bookmark/presentation/blocs/save_city_byname_bloc/save_city_bloc.dart';
import '../../features/feature_bookmark/presentation/screens/bookmark_screen.dart';
import '../../features/feature_weather/presentation/bloc/forecast_bloc/forecast_bloc.dart';
import '../../features/feature_weather/presentation/bloc/home_bloc.dart';
import '../../features/feature_weather/presentation/bloc/location_bloc/location_bloc.dart';
import '../../features/feature_weather/presentation/screens/home_screen.dart';

import '../../locator.dart';
import 'app_background.dart';
import 'glass_bottom_bar.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});

  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // important
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark, // for iOS
    ));
    List<Widget> pageViewScreens = [
      HomeScreen(),
      BookmarkScreen(pageController: pageController),
    ];

    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned.fill(child: Image(image: AppBackground.getBackGroundImage(),fit: BoxFit.cover,),),
        MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => locator<HomeBloc>()),
            BlocProvider(create: (_) => locator<ForecastBloc>()),
            BlocProvider(create: (_) => locator<LocationBloc>()),
            BlocProvider(create: (_) => locator<SaveCityBloc>()),
            BlocProvider(create: (_) => locator<GetAllBloc>()),
            BlocProvider(create: (_) => locator<DeleteCityBloc>()),
            BlocProvider(create: (_) => locator<FindCityBloc>()),
            BlocProvider(create: (_) => locator<DeleteAllBloc>()),
          ],
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Stack(
                children: [
                  SizedBox(
                    height: height,
                    child: PageView(
                      controller: pageController,
                      children: pageViewScreens,
                    ),
                  ),
                  GlassBottomNav(controller: pageController),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
