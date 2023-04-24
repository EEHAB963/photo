import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photos/ui/widget/custom_list_collction.dart';
import 'package:photos/ui/widget/custom_no_internt_widget.dart';
import 'package:photos/ui/widget/loding_widget.dart';
import '../../core/size.dart';
import '../../cubt/photo/photo_categore/photo_categore_cubit.dart';

class CategoreScreen extends StatefulWidget {
  CategoreScreen({
    super.key,
    this.name,
  });
  final String? name;

  @override
  State<CategoreScreen> createState() => _CategoreScreenState();
}

class _CategoreScreenState extends State<CategoreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MySize.customSize.gitSize(context, 15)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(MySize.customSize.gitSize(context, 10)),
              child: Text(
                "Collction",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: _bulidBody(context),
              ),
            )
          ],
        ),
      )),
    );
  }

  _bulidBody(BuildContext context) {
    return BlocConsumer<PhotoCategoreCubit, PhotoCategoreState>(
      listener: (context, state) {
        if (state is InterntErrorState) {
          scaffoldMessenger(context, state.error);
        } else if (state is ServerErrorState) {
          scaffoldMessenger(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is LodingState &&
            BlocProvider.of<PhotoCategoreCubit>(context).allCollction.isEmpty) {
          return const LoadingWidget();
        } else if (state is DoneState) {
          return _buildDoneStat();
        } else if (state is InterntErrorState &&
            BlocProvider.of<PhotoCategoreCubit>(context).allCollction.isEmpty) {
          return CustomOffLineInterntWidget(
            onTap: () {
              BlocProvider.of<PhotoCategoreCubit>(context).allCollction.clear();
              BlocProvider.of<PhotoCategoreCubit>(context).pages.clear();
              BlocProvider.of<PhotoCategoreCubit>(context).getAllCollctions();
            },
          );
        } else if (state is ServerErrorState &&
            BlocProvider.of<PhotoCategoreCubit>(context).allCollction.isEmpty) {
          return const Center(
            child: Icon(Icons.dangerous),
          );
        } else if (state is DataErrorState) {
          return const Center(
            child: Icon(Icons.search),
          );
        } else {
          return _buildDoneStat();
        }
      },
    );
  }

  _buildDoneStat() {
    return CustomListCollciton(
      collections:
          BlocProvider.of<PhotoCategoreCubit>(context).allCollction.toList(),
      loding: BlocProvider.of<PhotoCategoreCubit>(context).loding,
      onTap: () {
        BlocProvider.of<PhotoCategoreCubit>(context).getDatawithScroll(
            naxt_page: BlocProvider.of<PhotoCategoreCubit>(context)
                .pages
                .last
                .next_page);
      },
    );
  }
}
