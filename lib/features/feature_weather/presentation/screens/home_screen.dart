import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toastification/toastification.dart';
import 'package:weather_app_new/features/feature_bookmark/presentation/blocs/find_city_byname_bloc/find_city_bloc.dart';
import 'package:weather_app_new/features/feature_weather/domain/use_cases/get_suggestion_city_usecase.dart';
import '../../../../core/params/forecast_params.dart';
import '../../../../core/widgets/app_background.dart';
import '../../../../core/widgets/bookmark_icon.dart';
import '../../../../core/widgets/dot_loading_widget.dart';
import '../../../../locator.dart';
import '../../data/models/suggest_city_model.dart';
import '../../domain/entities/current_city_entities.dart';
import '../../domain/entities/forecast_days_entity.dart';
import '../bloc/forecast_bloc/forecast_bloc.dart';
import '../bloc/home_bloc.dart';
import '../widgets/day_weather_view.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final cityName = 'babol';
final PageController _controller = PageController();
final searchFocus = FocusNode();
final GetSuggestionCityUseCase getSuggestionCityUseCase =
    GetSuggestionCityUseCase(locator());

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(cityName));
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   Future.microtask(() {
  //     textEditingController.clear();
  //   });
  // }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Search Box
                Expanded(
                  child: TypeAheadField(controller: textEditingController,
                    builder: (context, cont, focusNode) {
                      return TextField(
                        cursorColor: Colors.blue,
                        cursorOpacityAnimates: true,
                        onSubmitted: (String prefix) {
                          cont.text = prefix;
                          BlocProvider.of<HomeBloc>(
                            context,
                          ).add(LoadCwEvent(prefix));
                          FocusScope.of(context).unfocus();                        },

                        style: DefaultTextStyle.of(
                          context,
                        ).style.copyWith(fontSize: 20, color: Colors.white),
                        focusNode: focusNode,
                        controller: cont,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            PhosphorIcons.magnifyingGlass(
                              PhosphorIconsStyle.regular,
                            ),
                            color: Colors.white70,
                            size: 25.0,
                          ),
                          hintText: 'Enter a City...',
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.5,
                            ),
                          ),
                        ),
                      );
                    },
                    itemBuilder: (context, Data model) {
                      return ListTile(
                        leading: Icon(
                          PhosphorIcons.mapPin(PhosphorIconsStyle.regular),
                        ),
                        title: Text(model.name!),
                        subtitle: Text('${model.region},${model.country}'),
                      );
                    },
                    onSelected: (Data model) {
                      textEditingController.text = model.name!;
                      setState(() {

                      });
                      BlocProvider.of<HomeBloc>(
                        context,
                      ).add(LoadCwEvent(model.name!));
                      FocusScope.of(context).unfocus();
                    },
                    suggestionsCallback: (String prefix) {
                      return getSuggestionCityUseCase(prefix);
                    },
                  ),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: BlocListener<HomeBloc, HomeState>(
                      listener: (context, state) {
                        if (state is CurrentWeatherCompleted) {
                          final cityName = state.currentCityEntity.name!;
                          BlocProvider.of<FindCityBloc>(context).add(
                            FindCityByNameEvent(state.currentCityEntity.name!),
                          );
                        }
                      },
                      child: BlocBuilder<HomeBloc, HomeState>(
                        buildWhen: (previous, current) {
                          if (previous == current) {
                            return false;
                          }
                          return true;
                        },
                        builder: (context, state) {
                          /// show loading for CurrentWeather
                          if (state is CurrentWeatherLoading) {
                            return LoadingAnimationWidget.progressiveDots(
                              color: Colors.white70,
                              size: 24,
                            );
                          }
                          if (state is CurrentWeatherError) {
                            return IconButton(
                              onPressed: () {
                                Toastification().show(
                                  context: context,
                                  type: ToastificationType.error,
                                  style: ToastificationStyle.fillColored,
                                  borderRadius: BorderRadius.circular(16),
                                  alignment: Alignment.topCenter,
                                  autoCloseDuration: Duration(seconds: 4),
                                  title: Text('Error !'),
                                  description: RichText(
                                    text: const TextSpan(
                                      text: 'Please load a city ',
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                PhosphorIcons.sealWarning(
                                  PhosphorIconsStyle.regular,
                                ),
                                size: 35,
                                color: Colors.white70,
                              ),
                            );
                          }
                          if (state is CurrentWeatherCompleted) {
                            return BookmarkIcon(
                              name: state.currentCityEntity.name!,
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 7 day
          BlocConsumer<HomeBloc, HomeState>(
            listener: (BuildContext context, HomeState state) {
              if (state is CurrentWeatherCompleted) {
                final params = ForecastParams(
                  state.currentCityEntity.coord!.lat!,
                  state.currentCityEntity.coord!.lon!,
                );
                BlocProvider.of<ForecastBloc>(
                  context,
                ).add(LoadForecast(params));
              }
            },
            builder: (context, state) {
              if (state is CurrentWeatherLoading) {
                return Expanded(child: DotLoadingWidget());
              } else if (state is CurrentWeatherCompleted) {
                CurrentCityEntity currentCityEntity = state.currentCityEntity;

                return Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.02),
                        child: SizedBox(
                          height: 450,
                          width: width,
                          child: PageView.builder(
                            controller: _controller,
                            allowImplicitScrolling: true,
                            itemCount: 2,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, position) {
                              if (position == 0) {
                                return Column(
                                  children: [
                                    SizedBox(height: 50),
                                    Text(
                                      currentCityEntity.name!,
                                      style: TextStyle(
                                        fontSize: 35,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      currentCityEntity
                                          .weather![0]
                                          .description!,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    AppBackground.setIconForMain(
                                      currentCityEntity
                                          .weather![0]
                                          .description!,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      '${currentCityEntity.main!.temp!.round()}\u00B0',
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        /// max temp
                                        Column(
                                          children: [
                                            Text(
                                              'max',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '${currentCityEntity.main!.tempMax!.round()}\u00B0',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),

                                        /// divider
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Container(
                                            height: 40,
                                            width: 2,
                                            color: Colors.grey,
                                          ),
                                        ),

                                        /// min temp
                                        Column(
                                          children: [
                                            Text(
                                              'min',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Text(
                                              '${currentCityEntity.main!.tempMin!.round()}\u00B0',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              } else {
                                return Container(color: Colors.amber);
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: SmoothPageIndicator(
                          controller: _controller,
                          count: 2,
                          effect: ExpandingDotsEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 5,
                            activeDotColor: Colors.white,
                          ),
                          onDotClicked: (index) => _controller.animateToPage(
                            index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.bounceOut,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Divider(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 110,
                        width: width,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Center(
                            child: BlocBuilder<ForecastBloc, ForecastState>(
                              builder: (context, state) {
                                if (state is ForecastLoading) {
                                  return DotLoadingWidget();
                                }
                                if (state is ForecastCompleted) {
                                  final ForecastDaysEntity forecastDaysEntity =
                                      state.forecastDaysEntity;

                                  final daily = forecastDaysEntity.daily;
                                  final int daysCount =
                                      daily?.time?.length ?? 0;

                                  // if empty -> show placeholder
                                  if (daysCount == 0) {
                                    return Center(
                                      child: Text(
                                        'No forecast available',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  }

                                  return SizedBox(
                                    height: 180,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: daysCount,
                                      itemBuilder: (context, index) {
                                        return DaysWeatherView(
                                          forecastDaysEntity:
                                              forecastDaysEntity,
                                          number: index,
                                        );
                                      },
                                    ),
                                  );
                                }
                                if (state is ForecastError) {
                                  return Center(
                                    child: Text(
                                      'error ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 50,
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                        ),
                      ),
                      Divider(color: Colors.grey),
                    ],
                  ),
                );
              } else if (state is CurrentWeatherError) {
                return Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'The city you requested was not found.\n Please try again.',
                        style: TextStyle(
                          letterSpacing: 1.1,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 60),
                      Lottie.asset(
                        'assets/animations/Error 404.json',
                        width: 350,
                        height: 350,
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
