import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:weather_app_new/features/feature_bookmark/presentation/blocs/delete_city_byname_bloc/delete_city_bloc.dart';

import '../../../feature_weather/presentation/bloc/home_bloc.dart';

class CityCart extends StatelessWidget {
  final PageController pageController;
  final String city;
  final int index;

  const CityCart({
    super.key,
    required this.city,
    required this.index,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) async {
                final deleteBloc = BlocProvider.of<DeleteCityBloc>(context);
                final confirmed = await showDialog<bool>(
                  context: context,
                  barrierDismissible: false,
                  builder: (ctx) => Dialog(
                    backgroundColor: Colors.white70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.white.withOpacity(0.3),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Are you sure ?',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Do you want to remove $city from the list ?',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey.shade300,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () => Navigator.of(ctx).pop(false),
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
                                      backgroundColor: Colors.redAccent,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () => Navigator.of(ctx).pop(true),
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
                  deleteBloc.add(DeleteCityByNameEvent(city: city));
                }
              },
              backgroundColor: Colors.red.withOpacity(0.5),
              foregroundColor: Colors.white,
              icon: PhosphorIcons.trash(PhosphorIconsStyle.regular),
              label: 'Delete',
              borderRadius: BorderRadius.only(
               topLeft: Radius.circular(16),
               bottomLeft: Radius.circular(16)
                ),
            ),
            SlidableAction(
              onPressed: (_) => (),
              backgroundColor: Colors.blue.withOpacity(0.5),
              foregroundColor: Colors.white,
              icon: PhosphorIcons.x(PhosphorIconsStyle.regular),
              label: 'Close',
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16)
              ),
            ),
          ],
        ),

        child: GestureDetector(
          onTap: () {
            BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(city));
            pageController.animateToPage(
              0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: height * 0.08,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(
                          PhosphorIcons.mapPinSimple(PhosphorIconsStyle.regular),
                          size: 25,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            city,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 24,
                              letterSpacing: 1.1,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
