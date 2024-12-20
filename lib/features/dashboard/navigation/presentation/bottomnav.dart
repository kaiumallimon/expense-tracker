import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logics/navigation_cubit.dart';

class CustomBottomNavbar extends StatelessWidget {
  CustomBottomNavbar({super.key, required this.selectedIndex})
      : currentIndex = selectedIndex;
  final int currentIndex;
  final int selectedIndex;

  final List<Map<String, String>> items = [
    {'icon': 'assets/icons/home.png', 'label': 'Home'},
    {'icon': 'assets/icons/transactions.png', 'label': 'Log'},
    {'icon': 'assets/icons/add.png', 'label': 'Add'},
    {'icon': 'assets/icons/calender.png', 'label': 'History'},
    {'icon': 'assets/icons/person.png', 'label': 'Profile'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return NavigationBar(
      surfaceTintColor: theme.primary,
      indicatorColor: theme.primary,
      backgroundColor: theme.surface,
      selectedIndex: currentIndex,
      onDestinationSelected: (int index) {
        BlocProvider.of<NavigationCubit>(context).changeIndex(index);
      },
      destinations: <Widget>[
        const NavigationDestination(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Image.asset(
            'assets/icons/transaction.png',
            width: 24,
            color: selectedIndex == 1 ? theme.onPrimary : theme.onSurface,
          ),
          label: 'Txns',
        ),
        const NavigationDestination(
          icon: Icon(Icons.add),
          label: 'Add',
        ),
        const NavigationDestination(
          icon: Icon(Icons.calendar_month),
          label: 'Track',
        ),
        const NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
