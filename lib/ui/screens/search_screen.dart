import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photos/core/size.dart';
import 'package:photos/cubt/photo/search/search_cubit.dart';
import 'package:photos/ui/widget/custom_no_internt_widget.dart';
import 'package:photos/ui/widget/custom_search_widget.dart';
import 'package:photos/ui/widget/custom_text_form_fild.dart';

import '../widget/custom_error_server_widget.dart';
import '../widget/custom_grid_view.dart';
import '../widget/custom_no_data_widget.dart';
import '../widget/loding_widget.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        controller: BlocProvider.of<SearchCubit>(context).controller,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Form(
                key: key,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller:
                            BlocProvider.of<SearchCubit>(context).categore,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        label: "Search",
                        onFieldSubmitted: (p0) {
                          if (p0.isNotEmpty) {
                            key.currentState!.validate();
                            BlocProvider.of<SearchCubit>(context)
                                .allPhotos
                                .clear();
                            BlocProvider.of<SearchCubit>(context).pages.clear();
                            BlocProvider.of<SearchCubit>(context)
                                .getAllPhotoWithCategore(
                                    page: 1, per_page: 80, searchValue: p0);
                          }
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
              ),
              buildBody()
            ],
          ),
        ),
      ),
    ));
  }

  buildBody() {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state is InterntErrorState) {
          scaffoldMessenger(context, state.error);
        } else if (state is ServerErrorState) {
          scaffoldMessenger(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is LodingState &&
            BlocProvider.of<SearchCubit>(context).allPhotos.isEmpty) {
          return const LoadingWidget();
        } else if (state is SearchInitial) {
          return CustomSearchWidget();
        } else if (state is DoneState) {
          return _buildDoneStat();
        } else if (state is InterntErrorState &&
            BlocProvider.of<SearchCubit>(context).allPhotos.isEmpty) {
          return CustomOffLineInterntWidget(
            onTap: () {
              BlocProvider.of<SearchCubit>(context).allPhotos.clear();
              BlocProvider.of<SearchCubit>(context).pages.clear();
              BlocProvider.of<SearchCubit>(context).getAllPhotoWithCategore(
                  page: 1,
                  per_page: 20,
                  searchValue:
                      BlocProvider.of<SearchCubit>(context).categore.text);
            },
          );
        } else if (state is ServerErrorState &&
            BlocProvider.of<SearchCubit>(context).allPhotos.isEmpty) {
          return CustomErrorServerWidget();
        } else if (state is DataErrorState) {
          return CustomNoDataWidget();
        } else {
          return _buildDoneStat();
        }
      },
    );
  }

  _buildDoneStat() {
    print("build _buildDoneStat");
    return CustomGridView(
      naxtPage:
          BlocProvider.of<SearchCubit>(context).pages.last.next_page == null
              ? ""
              : BlocProvider.of<SearchCubit>(context).pages.last.next_page!,
      photos: BlocProvider.of<SearchCubit>(context).allPhotos.toList(),
      onTap: () {
        BlocProvider.of<SearchCubit>(context).getDatawithScroll();
      },
      loding: BlocProvider.of<SearchCubit>(context).loding,
    );
  }
}
