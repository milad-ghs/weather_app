import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:toastification/toastification.dart';
import 'package:weather_app_new/features/feature_bookmark/domain/entities/bookmarked_city_entity.dart';
import 'package:weather_app_new/features/feature_bookmark/presentation/blocs/delete_all_bloc/delete_all_bloc.dart';
import 'package:weather_app_new/features/feature_bookmark/presentation/blocs/delete_city_byname_bloc/delete_city_bloc.dart';
import 'package:weather_app_new/features/feature_bookmark/presentation/blocs/get_all_bloc/get_all_bloc.dart';

import '../../../feature_weather/presentation/screens/home_screen.dart';
import '../widgets/city_cart.dart';

class BookmarkScreen extends StatefulWidget {
  final PageController pageController;

  const BookmarkScreen({super.key, required this.pageController});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAllBloc>(context).add(LoadedAllCitiesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllBloc, GetAllState>(
      buildWhen: (previous, current) => previous != current,

      builder: (context, state) {
        /// show Loading for allCityStatus
        if (state is GetAllLoading) {
          return Center(
            child: LoadingAnimationWidget.progressiveDots(
              color: Colors.white70,
              size: 80,
            ),
          );
        }

        /// show error for allCityStatus
        if (state is GetAllError) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        /// show Completed  for allCityStatus
        if (state is GetAllSuccess) {
          List<BookmarkedCity?> cities = state.cities;

          return BlocListener<DeleteCityBloc, DeleteCityState>(
            listener: (context, state) {
              if (state is DeleteCityCompleted) {
                final cityName = state.cityName;
                BlocProvider.of<GetAllBloc>(
                  context,
                ).add(LoadedAllCitiesEvent());
                Toastification().show(
                  context: context,
                  type: ToastificationType.custom(
                    'Delete',
                    Colors.green,
                    PhosphorIcons.checkFat(PhosphorIconsStyle.regular),
                  ),
                  style: ToastificationStyle.fillColored,
                  borderRadius: BorderRadius.circular(16),
                  alignment: Alignment.topCenter,
                  autoCloseDuration: Duration(seconds: 4),
                  title: Text('Delete city'),
                  description: RichText(
                    text: TextSpan(text: '$cityName successfully deleted.'),
                  ),
                );
              } else if (state is DeleteCityError) {
                Toastification().show(
                  context: context,
                  type: ToastificationType.error,
                  style: ToastificationStyle.fillColored,
                  borderRadius: BorderRadius.circular(16),
                  alignment: Alignment.topCenter,
                  autoCloseDuration: Duration(seconds: 4),
                  title: Text('Error !'),
                  description: RichText(
                    text: TextSpan(
                      text: 'Failed to delete $cityName: ${state.message}',
                    ),
                  ),
                );
              }
            },
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                        ),

                        Expanded(
                          child: Text(
                            'Bookmarks',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: BlocListener<DeleteAllBloc, DeleteAllState>(
                            listener: (context, state) {
                              if (state is DeleteAllCompleted) {
                                BlocProvider.of<GetAllBloc>(
                                  context,
                                ).add(LoadedAllCitiesEvent());
                              }
                            },
                            /// delete all cities
                            child: BlocSelector<GetAllBloc, GetAllState, bool>(
                              selector: (state) {
                                if (state is GetAllSuccess) {
                                  return state.cities.isNotEmpty;
                                }
                                return false;
                              },
                              builder: (context, hasCities) {
                                if (hasCities == true) {return IconButton(
                                  onPressed: () async {
                                    final deleteAllBloc =
                                    BlocProvider.of<DeleteAllBloc>(context);
                                    final confirmed = await showDialog<bool>(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (ctx) => Dialog(
                                        backgroundColor: Colors.white70,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          child: Container(
                                            color: Colors.white.withOpacity(
                                              0.3,
                                            ),
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Delete All?',
                                                  style: TextStyle(
                                                    color: Colors.redAccent,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                const SizedBox(height: 15),
                                                Text(
                                                  'Are you sure you want to delete all cities?',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const SizedBox(height: 25),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  children: [
                                                    Expanded(
                                                      child: TextButton(
                                                        style: TextButton.styleFrom(
                                                          backgroundColor:
                                                          Colors
                                                              .grey
                                                              .shade300,
                                                          padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 12,
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.of(
                                                              ctx,
                                                            ).pop(false),
                                                        child: const Text(
                                                          'No',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15),
                                                    Expanded(
                                                      child: TextButton(
                                                        style: TextButton.styleFrom(
                                                          backgroundColor:
                                                          Colors.redAccent,
                                                          padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: 12,
                                                          ),
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.of(
                                                              ctx,
                                                            ).pop(true),
                                                        child: const Text(
                                                          'Yes',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );

                                    if (confirmed == true) {
                                      deleteAllBloc.add(DeleteAllCityEvent());
                                    }
                                  },
                                  icon: Icon(
                                    PhosphorIcons.trashSimple(
                                      PhosphorIconsStyle.regular,
                                    ),
                                    size: 25,
                                    color: Colors.redAccent,
                                  ),
                                );}else{
                                  return Container();
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: (cities.isEmpty)
                        ? Padding(
                          padding: const EdgeInsets.only(bottom: 100.0),
                          child: Center(
                              child: Text(
                                'No cities bookmarked yet!',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                                ),
                              ),
                            ),
                        )
                        : RefreshIndicator(
                            color: Colors.cyan,
                            /// show list of cities
                            child: ListView.builder(
                              itemCount: cities.length,
                              itemBuilder: (context, index) {
                                BookmarkedCity? city = cities[index];
                                return CityCart(
                                  city: city!.name,
                                  index: index,
                                  pageController: widget.pageController,
                                );
                              },
                            ),
                            onRefresh: () async => context
                                .read<GetAllBloc>()
                                .add(LoadedAllCitiesEvent()),
                          ),
                  ),
                ],
              ),
            ),
          );
        }

        /// show default value
        return Container();
      },
    );
  }
}
