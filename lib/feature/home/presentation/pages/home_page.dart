import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:star_wars/core/di/service_locator.dart';
import 'package:star_wars/core/theme/app_colors.dart';
import 'package:star_wars/core/theme/assets.dart';
import 'package:star_wars/core/theme/text_style.dart';
import 'package:star_wars/feature/home/domain/entities/people_model.dart';
import 'package:star_wars/feature/home/presentation/manager/detail_home_cubit/detail_home_cubit.dart';
import 'package:star_wars/feature/home/presentation/manager/home_manager_cubit.dart';
import 'package:star_wars/feature/home/presentation/pages/detail_home_page.dart';
import 'package:star_wars/feature/home/presentation/widgets/data_home_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 12.h,
              ),
              Text(
                "Star Wars Character",
                style: AppTextStyle.headingBold24(),
              ),
              SizedBox(
                height: 12.h,
              ),
              searchWidget(),
              SizedBox(
                height: 12.h,
              ),
              const ListDataHomeWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchWidget() {
    return TextFormField(
      onFieldSubmitted: (value) {
        print(value);
        getIt<HomeManagerCubit>().searchCharacter(value ?? "");
      },
      style: AppTextStyle.detailMedium14(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        hintText: 'Search Character...',
        prefixIcon: Padding(
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
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        hintStyle: AppTextStyle.bodyRegular14(AppColors.textSecondary),
      ),
    );
  }

}
