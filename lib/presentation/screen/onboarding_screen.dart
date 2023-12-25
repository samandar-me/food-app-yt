import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_yt/data/model/on_board.dart';
import 'package:food_app_yt/presentation/bloc/auth/auth_bloc.dart';
import 'package:food_app_yt/presentation/bloc/auth/auth_event.dart';
import 'package:food_app_yt/presentation/bloc/auth/auth_state.dart';
import 'package:food_app_yt/presentation/screen/main_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../widget/loading.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child:  PageView.builder(
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildBody(onboardList[_currentIndex]);
              },
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                AnimatedOpacity(
                  opacity: _currentIndex != 2 ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _dot(_currentIndex == 0),
                        _dot(_currentIndex == 1),
                        _dot(_currentIndex == 2),
                      ],
                    ),
                  ),
                ),
                  Center(
                    child: AnimatedOpacity(opacity: _currentIndex == 2 ? 1 : 0, duration: const Duration(milliseconds: 500), child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: BlocConsumer<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if(state is LoadingState) {
                            return const Loading();
                          }
                          return ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context).add(OnLogin());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.onBackground,
                                foregroundColor: Colors.white
                            ),
                            child: const Text("Get started"),
                          );
                        },
                        listener: (context, state) {
                          if(state is SuccessState) {
                            context.go('/');
                          } else if(state is ErrorState) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(state.message)));
                          }
                        },
                      )
                    ),),
                  )
              ],
            ),
            )
        ],
      ),
    );
  }
  Widget _buildBody(OnBoard onBoard) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/anim/${onBoard.anim}.json'),
            Text(onBoard.title, style: GoogleFonts.baloo2(fontSize: 24)),
            Text(onBoard.desc, style: GoogleFonts.baloo2(fontSize: 15)),
          ],
        ),
      ),
    );
  }
  Widget _dot(bool isSelected) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 9,
      height: 9,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Colors.black : Colors.black38
      ),
    );
  }
}
