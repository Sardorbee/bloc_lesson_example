import 'package:bloc_lesson_example/data/bloc/cubits/navbar_cubit/navbar_cubit_cubit.dart';
import 'package:bloc_lesson_example/ui/number_multiply_screen/number_multiply.dart';
import 'package:bloc_lesson_example/ui/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTabBar extends StatelessWidget {
  const MyTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavbarCubit, int>(
        builder: (context, screenIndex) {
          return IndexedStack(
            index: context.watch<NavbarCubit>().state,
            children: const [
              NumberScreen(),
              ProfileScreen(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<NavbarCubit>().state,
        onTap: (index) {
          context.read<NavbarCubit>().updateScreen(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered_outlined),
            label: 'First',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Second',
          ),
        ],
      ),
    );
  }
}
