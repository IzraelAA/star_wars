import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:star_wars/core/constant/status_state.dart';
import 'package:star_wars/core/di/service_locator.dart';
import 'package:star_wars/core/theme/app_colors.dart';
import 'package:star_wars/core/theme/text_style.dart';
import 'package:star_wars/feature/home/domain/entities/people_model.dart';
import 'package:star_wars/feature/home/presentation/manager/home_manager_cubit.dart';
import 'package:star_wars/feature/home/presentation/pages/detail_home_page.dart';

class ListDataHomeWidget extends StatefulWidget {
  const ListDataHomeWidget({super.key});

  @override
  State<ListDataHomeWidget> createState() => _ListDataHomeWidgetState();
}

class _ListDataHomeWidgetState extends State<ListDataHomeWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        var state = getIt<HomeManagerCubit>().state;
        if (state.statusState == StatusState.loaded) {
          getIt<HomeManagerCubit>().loadData(state.data ?? []);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeManagerCubit, HomeState>(
        listener: (ctx, HomeState state) {
      if (state.statusState == StatusState.error) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Internet Connection Error',
                style: AppTextStyle.headingBold16(Colors.black),
              ),
              content: Text(
                'Please check your internet connection.',
                style: AppTextStyle.detailRegular14(Colors.black),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    getIt<HomeManagerCubit>().initialData();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: AppTextStyle.headingBold16(Colors.black),
                  ),
                ),
              ],
            );
          },
        );
      }
    }, builder: (ctx, HomeState state) {
      return Expanded(
        child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(children: [
              ListView.builder(
                itemCount: state.data?.length ?? 0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, i) => contentData(state.data![i], ctx),
              ),
              if (state.statusState == StatusState.loading)
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      return Shimmer.fromColors(
                        enabled: true,
                        period: Duration(seconds: 1),
                        direction: ShimmerDirection.ltr,
                        baseColor: Color(0xFF242424),
                        highlightColor: Color(0xFF393939),
                        child: Container(
                          width: double.infinity,
                          height: 32,
                          margin: EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                      );
                    })
            ])),
      );
    });
  }

  Widget contentData(PeopleModel peopleModel, ctx) {
    return InkWell(
      onTap: () {
        Navigator.push(
            ctx,
            MaterialPageRoute(
                builder: (context) => DetailHomePage(data: peopleModel)));
      },
      child: Container(
          width: 1.sw,
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border)),
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                peopleModel.name ?? '-',
                style: AppTextStyle.headingBold16(AppColors.textPrimary),
              ),
              Text(
                peopleModel.gender ?? "-",
                style: AppTextStyle.bodyRegular12(
                  AppColors.textSecondary,
                ),
              ),
            ],
          )),
    );
  }
}
