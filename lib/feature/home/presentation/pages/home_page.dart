import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_wars/core/di/service_locator.dart';
import 'package:star_wars/core/theme/app_colors.dart';
import 'package:star_wars/core/theme/assets.dart';
import 'package:star_wars/core/theme/text_style.dart';
import 'package:star_wars/feature/home/presentation/manager/home_manager_cubit.dart';
import 'package:star_wars/feature/home/presentation/widgets/data_home_widget.dart';

// The HomePage class represents the main screen of the Star Wars app.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Build method for constructing the widget tree.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Setting the background color using AppColors.
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          // Applying horizontal padding using ScreenUtil.
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.h,
              ),
              // Displaying the title "Star Wars Character" with a specific text style.
              Text(
                "Star Wars Character",
                style: AppTextStyle.headingBold24(),
              ),
              SizedBox(
                height: 12.h,
              ),
              // Displaying the search widget.
              searchWidget(),
              SizedBox(
                height: 12.h,
              ),
              // Displaying the ListDataHomeWidget.
              const ListDataHomeWidget(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for the search input field.
  Widget searchWidget() {
    return TextFormField(
      // Handling the onFieldSubmitted event to trigger character search.
      onFieldSubmitted: (value) {
        getIt<HomeManagerCubit>().searchCharacter(value ?? "");
      },
      style: AppTextStyle.detailMedium14(),
      decoration: InputDecoration(
        // Configuring input field decoration.
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        hintText: 'Search Character...',
        prefixIcon: Padding(
          // Adding a prefix icon using SvgPicture.
          padding: EdgeInsets.only(right: 8.w, left: 16.w),
          child: SvgPicture.asset(
            Asset.search,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 17,
        ),
        filled: true,
        fillColor: const Color(0xFF2F2C44),
        border: OutlineInputBorder(
          // Configuring the border with rounded corners.
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        hintStyle: AppTextStyle.bodyRegular14(AppColors.textSecondary),
      ),
    );
  }
}
