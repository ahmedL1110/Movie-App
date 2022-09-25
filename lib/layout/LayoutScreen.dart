import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/styles/icon_broken.dart';
import 'Cubit/CubitBloc.dart';
import 'Cubit/StateBloc.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        //LayoutCubit.get(context).getUserData();
        return BlocConsumer<LayoutCubit,LayoutState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = LayoutCubit.get(context);
            return Scaffold(
              body: cubit.screen[cubit.currenIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currenIndex,
                onTap: (index) {
                  cubit.changeBottomNac(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Home,
                    ),
                    label: 'HOME',
                    activeIcon: Icon(
                      IconBroken.Home,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Search,
                    ),
                    label: 'SEARCH',
                    activeIcon: Icon(
                      IconBroken.Search,
                    ),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      IconBroken.Profile,
                    ),
                    label: 'Profile',
                    activeIcon: Icon(
                      IconBroken.Profile,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    );
  }
}
