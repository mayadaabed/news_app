import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';

import '../shared/components/main_app_bar.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        listener: (BuildContext context, NewsState state) {},
        builder: (BuildContext context, NewsState state) {
          var cubit = NewsCubit.get(context);
          return SafeArea(
            child: Scaffold(
              appBar: MainAppBar(
                  title: 'News App',
                  onPress: () {
                    cubit.changeAppMode();
                  }),
              body: cubit.screens[cubit.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                items: cubit.bottomItems,
                onTap: (index) {
                  cubit.changeBottomNavBar(index);
                },
              ),
            ),
          );
        });
  }
}
