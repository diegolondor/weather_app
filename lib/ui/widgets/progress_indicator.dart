import 'package:flutter/material.dart';
import 'package:weather_app/bloc/base_bloc.dart';
import 'package:weather_app/ui/widgets/indicator.dart';

class ProgressIndicatorSB extends StatelessWidget {
  final BaseBloc baseBloc;

  const ProgressIndicatorSB({super.key, required this.baseBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: baseBloc.isLoading,
      builder: (context, loadingSnapshot) {
        if (loadingSnapshot.hasData && loadingSnapshot.data!) {
          return const Indicator();
        } else {
          return Container();
        }
      },
    );
  }
}
