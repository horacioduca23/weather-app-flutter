import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/selected_city_controller.dart';
import '../../constants/strings.dart';
import '../../routes/app_routes.dart';

class DefaultCities extends ConsumerWidget {
  const DefaultCities({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const List<String> defaultCities = Strings.defaultCities;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: defaultCities.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          child: SizedBox(
            height: 60.0,
            child: Card(
              color: Colors.black38,
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Text(
                      defaultCities[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                        height: 0.02,
                        letterSpacing: 0.37,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      Strings.cFindOut,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                        height: 0.02,
                        letterSpacing: 0.37,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          onTap: () {
            final cityName = defaultCities[index];

            ref
                .read(selectedCityControllerProvider.notifier)
                .setCityName(cityName);

            context.go('/${AppRoutes.details.path}');
          },
        );
      },
    );
  }
}
