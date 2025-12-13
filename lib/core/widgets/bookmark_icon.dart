import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toastification/toastification.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:weather_app_new/features/feature_bookmark/presentation/blocs/find_city_byname_bloc/find_city_bloc.dart';

import '../../features/feature_bookmark/presentation/blocs/save_city_byname_bloc/save_city_bloc.dart';

class BookmarkIcon extends StatefulWidget {
  final String name;

  const BookmarkIcon({super.key, required this.name});

  @override
  State<BookmarkIcon> createState() => _BookmarkIconState();
}

class _BookmarkIconState extends State<BookmarkIcon> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FindCityBloc>(
        context,
      ).add(FindCityByNameEvent(widget.name));
    });
  }

  @override
  void didUpdateWidget(covariant BookmarkIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name) {
      BlocProvider.of<FindCityBloc>(
        context,
      ).add(FindCityByNameEvent(widget.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FindCityBloc, FindCityState>(
      listener: (context, state) {
        if (state is FindCityCompleted) {
          setState(() {
            isBookmarked = state.cityIsExist;
          });
        }
      },
      builder: (context, state) {
        if (state is FindCityLoading) {
          return LoadingAnimationWidget.progressiveDots(
            color: Colors.white70,
            size: 35,
          );
        }
        if (state is FindCityCompleted) {
          return BlocConsumer<SaveCityBloc, SaveCityState>(
            listenWhen: (previous, current) => (previous != current),
            buildWhen: (previous, current) => (previous != current),

            builder: (context, saveCityState) {
              if (saveCityState is SaveCityLoading) {
                return LoadingAnimationWidget.progressiveDots(
                  color: Colors.white70,
                  size: 35,
                );
              }

              return IconButton(
                onPressed: isBookmarked
                    ? null
                    : () {
                        BlocProvider.of<SaveCityBloc>(
                          context,
                        ).add(LoadSaveCityEvent(widget.name));
                      },
                icon: Icon(
                  isBookmarked
                      ? PhosphorIcons.star(PhosphorIconsStyle.fill)
                      : PhosphorIcons.star(PhosphorIconsStyle.regular),

                  color: Color.fromARGB( 255, 203, 200, 3),
                  size: 40,
                ),
              );
            },

            listener: (context, saveCityState) {
              if (saveCityState is SaveCityError) {
                SaveCityError saveCityError = saveCityState;
                Toastification().show(
                  context: context,
                  type: ToastificationType.error,
                  style: ToastificationStyle.fillColored,
                  borderRadius: BorderRadius.circular(16),
                  alignment: Alignment.topCenter,
                  autoCloseDuration: Duration(seconds: 4),
                  title: Text('Error !'),
                  description: RichText(
                    text: TextSpan(text: saveCityError.message),
                  ),
                );
              }

              if (saveCityState is SaveCitySuccess) {
                setState(() {
                  isBookmarked = true;
                });
                Toastification().show(
                  context: context,
                  type: ToastificationType.success,
                  style: ToastificationStyle.fillColored,
                  borderRadius: BorderRadius.circular(16),
                  alignment: Alignment.topCenter,
                  autoCloseDuration: Duration(seconds: 4),
                  title: Text('Success full !'),
                  description: RichText(
                    text: TextSpan(
                      text: '${saveCityState.city.name} Added to BookMark',
                    ),
                  ),
                );
                BlocProvider.of<FindCityBloc>(
                  context,
                ).add(FindCityByNameEvent(widget.name));
                //
              }
            },
          );
        }
        if (state is FindCityError) {
          return Icon(
            PhosphorIcons.sealWarning(PhosphorIconsStyle.regular),
            color: Colors.white,
            size: 35,
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
