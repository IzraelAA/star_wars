import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:star_wars/core/constant/status_state.dart';
import 'package:star_wars/core/constant/transportation_type.dart';
import 'package:star_wars/core/di/service_locator.dart';
import 'package:star_wars/core/theme/app_colors.dart';
import 'package:star_wars/core/theme/text_style.dart';
import 'package:star_wars/feature/home/domain/entities/people_model.dart';
import 'package:star_wars/feature/home/domain/entities/planet_model.dart';
import 'package:star_wars/feature/home/domain/entities/transportation_model.dart';
import 'package:star_wars/feature/home/presentation/manager/detail_home_cubit/detail_home_cubit.dart';

// The DetailHomePage class represents the detailed view of a character in the Star Wars app.
class DetailHomePage extends StatefulWidget {
  final PeopleModel data;

  // Constructor for initializing with PeopleModel data.
  const DetailHomePage({super.key, required this.data});

  @override
  State<DetailHomePage> createState() => _DetailHomePageState();
}

// The _DetailHomePageState class manages the state of the DetailHomePage.
class _DetailHomePageState extends State<DetailHomePage> {
  @override
  void initState() {
    super.initState();
    // Initialize the DetailHomeCubit and fetch detailed information for the character.
    getIt<DetailHomeCubit>().getDetailPeople(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          // Applying horizontal padding using ScreenUtil.
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: BlocConsumer<DetailHomeCubit, DetailHomeState>(
            bloc: getIt<DetailHomeCubit>(),
            listener: (ctx, DetailHomeState state) {
              // Listen for state changes and trigger further actions if needed.
              // (e.g., fetching additional data based on loaded status)
              if (state.statusStarship == StatusState.loaded) {
                if (widget.data.starshipModel!.length !=
                    state.starshipModel.length) {
                  getIt<DetailHomeCubit>()
                      .starship(widget.data, state.starshipModel.length);
                }
              }
              if (state.statusVehicles == StatusState.loaded) {
                if (widget.data.vehicles!.length !=
                    state.vehiclesModel.length) {
                  getIt<DetailHomeCubit>()
                      .vehicle(widget.data, state.vehiclesModel.length);
                }
              }
            },
            builder: (ctx, DetailHomeState state) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  // Displaying character name and gender.
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.data.name!,
                        style: AppTextStyle.headingBold24(),
                      ),
                      SizedBox(
                        width: 12.h,
                      ),
                      Text(
                        widget.data.gender!,
                        style: AppTextStyle.detailRegular16(
                            AppColors.textSecondary),
                      ),
                    ],
                  ),
                  // Displaying information about starships, vehicles, and home world if available.
                  if (state.statusStarship == StatusState.loaded)
                    contentItem(
                        state.starshipModel, TransportationType.starship),
                  if (state.statusVehicles == StatusState.loaded)
                    contentItem(
                        state.vehiclesModel, TransportationType.vehicles),
                  if (state.statusHomeWorld == StatusState.loaded)
                    ...contentHomeWorld(state.homeWorld!)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Method to create widgets for displaying information about the character's home world.
  List<Widget> contentHomeWorld(PlanetModel planetModel) {
    return [
      Text(
        "HOME WORLD",
        style: AppTextStyle.headingBold16(),
      ),
      SizedBox(
        height: 12.h,
      ),
      // Container displaying details about the home world.
      Container(
        width: 1.sw,
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.border),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 6.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              planetModel.name!,
              style: AppTextStyle.headingBold20(AppColors.textPrimary),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "Population : ${planetModel.population ?? "-"}",
              style: AppTextStyle.bodyRegular12(
                AppColors.textSecondary,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "Climate : ${planetModel.climate ?? "-"}",
              style: AppTextStyle.detailMedium12(),
            ),
          ],
        ),
      ),
    ];
  }

  // Method to create widgets for displaying information about starships or vehicles.
  Widget contentItem(
    List<TransportationModel> transportation,
    TransportationType transportationType,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 12.h,
        ),
        Text(
          transportationType == TransportationType.starship
              ? "STARSHIP"
              : "VEHICLES",
          style: AppTextStyle.headingBold16(),
        ),
        SizedBox(
          height: 12.h,
        ),
        // ListView for displaying a list of starships or vehicles.
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transportation.length,
          itemBuilder: (ctx, i) => Container(
            width: 1.sw,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 6.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transportation[i].name!,
                  style: AppTextStyle.headingBold20(AppColors.textPrimary),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  "Model : ${transportation[i].model ?? "-"}",
                  style: AppTextStyle.bodyRegular12(
                    AppColors.textSecondary,
                  ),
                ),
                if (transportationType == TransportationType.starship) ...[
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    "Hyperdrive Rating : ${transportation[i].hyperdriveRating ?? "-"}",
                    style: AppTextStyle.detailMedium12(),
                  ),
                ],
                SizedBox(
                  height: 6.h,
                ),
                Text(
                  "Cost In Credits : ${transportation[i].costInCredits ?? "-"}",
                  style: AppTextStyle.detailMedium12(),
                ),
                if (transportationType == TransportationType.starship) ...[
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    "Manufacturer : ${transportation[i].manufacturer ?? "-"}",
                    style: AppTextStyle.detailMedium12(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
