import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../cubit/appCubit.dart';
import '../cubit/states.dart';
import 'categoryDetail.dart';

class Categorys extends StatelessWidget {
  const Categorys({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => cubit.categoriesModel != null,
          widgetBuilder: (context) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: AnimationLimiter(
              child: GridView.count(
                childAspectRatio: .6,
                crossAxisSpacing: 30,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.symmetric(vertical: 20),
                crossAxisCount: 2,
                children: List.generate(
                  cubit.categoriesModel!.result!.length,
                  (int index) {
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      columnCount: 2,
                      child: ScaleAnimation(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        child: FadeInAnimation(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            child: GestureDetector(
                              onTap: () {
                                cubit.getCategoriesDetailData(
                                    cubit.categoriesModel!.result![index].sId);
                                cubit.getActivityData(
                                    cubit.categoriesModel!.result![index].sId);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Category(),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 10.0,
                                        offset: const Offset(0.0, 5.0),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            '${cubit.categoriesModel!.result![index].coverImage}',
                                        width: 160,
                                        height: 200,
                                        fit: BoxFit.contain,
                                      ),
                                      const Divider(
                                          color: Colors.grey, thickness: .3),
                                      Text(
                                        '${cubit.categoriesModel!.result![index].titleAr}',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          fallbackBuilder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}




// GridView.builder(
// physics: const BouncingScrollPhysics(),
// itemCount: cubit.categoriesModel!.result!.length,
// gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// childAspectRatio: .6,
// crossAxisCount: 2,
// crossAxisSpacing: 30,
// ),
// itemBuilder: (context, index) {
// return GestureDetector(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => Category(),
// ),
// );
// },
// child: Padding(
// padding: const EdgeInsets.symmetric(vertical: 10),
// child: Container(
// padding: const EdgeInsets.symmetric(horizontal: 0),
// decoration: BoxDecoration(
// color: Colors.white,
// boxShadow: [
// BoxShadow(
// color: Colors.grey.shade300,
// blurRadius: 10.0,
// offset: const Offset(0.0, 10.0),
// ),
// ],
// ),
// child: Column(
// children: [
// Image.network(
// width: 160,
// height: 200,
// fit: BoxFit.contain,
// '${cubit.categoriesModel!.result![index].coverImage}',
// ),
// const Divider(color: Colors.grey, thickness: .3),
// Text(
// '${cubit.categoriesModel!.result![index].titleAr}',
// textAlign: TextAlign.center,
// ),
// ],
// ),
// ),
// ),
// );
// },
// ),