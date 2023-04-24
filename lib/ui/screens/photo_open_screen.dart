import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass/glass.dart';
import 'package:photos/data/model/photos_modil/photo_modil.dart';
import 'package:photos/data/model/photos_modil/src_modil.dart';
import 'package:photos/ui/widget/loding_widget.dart';
import '../../core/size.dart';
import '../../cubt/photo/open_photo/open_photo_cubit.dart';
import '../widget/custom_error_server_widget.dart';
import '../widget/custom_grid_view.dart';
import '../widget/custom_no_internt_widget.dart';

class PhotoOpenScreen extends StatefulWidget {
  final PhotoModil photo;
  PhotoOpenScreen({super.key, required this.photo});

  @override
  State<PhotoOpenScreen> createState() => _PhotoOpenScreenState();
}

class _PhotoOpenScreenState extends State<PhotoOpenScreen> {
  Set<PhotoModil> data = {};
  @override
  void initState() {
    BlocProvider.of<OpenPhotoCubit>(context).allPhotos.clear();
    BlocProvider.of<OpenPhotoCubit>(context).pages.clear();
    data.clear();
    BlocProvider.of<OpenPhotoCubit>(context).getSpecificPhoto(
        page: 1,
        per_page: 10,
        categore: widget.photo.url
            .substring(29, widget.photo.url.length - 10)
            .replaceAll("-", " "),
        color: null);
    print(widget.photo.url
        .substring(29, widget.photo.url.length - 10)
        .replaceAll("-", " "));
    print(data.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: FadeInImage(
                      image: NetworkImage(widget.photo.src.large),
                      placeholder: const AssetImage(
                        "assets/images/logo.png",
                      ),
                      fit: BoxFit.fill,
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Image.asset(
                            "assets/images/sad.png",
                            height: 50,
                            width: 50,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buttonArrwr(context),
                        // saveBottom(widget.photo.src, context)
                      ],
                    ),
                  )
                ],
              ),
              photographerName(context),
              saveBottom(widget.photo.src, context),
              Divider(),
              Text(
                "More items similar to this picture",
                style: Theme.of(context).textTheme.headline2,
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MySize.customSize.gitSize(context, 15)),
                child: buildBody(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  photographerName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MySize.customSize.gitSize(context, 30),
          top: MySize.customSize.gitSize(context, 10),
          left: MySize.customSize.gitSize(context, 10)),
      child: Row(
        children: [
          CircleAvatar(
              radius: MySize.customSize.gitSize(context, 20),
              child: Text(widget.photo.photographer.substring(0, 1)),
              backgroundColor: hexToColor(widget.photo.avg_color)),
          SizedBox(
            width: MySize.customSize.gitSize(context, 20),
          ),
          SizedBox(
            width: MySize.customSize.gitSize(context, 200),
            child: Text(
              widget.photo.photographer,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style:
                  Theme.of(context).textTheme.headline1!.copyWith(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  buildBody(BuildContext context) {
    return BlocConsumer<OpenPhotoCubit, OpenPhotoState>(
      listener: (context, state) {
        if (state is InterntErrorState) {
          scaffoldMessenger(context, state.error);
        } else if (state is ServerErrorState) {
          scaffoldMessenger(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is LodingState &&
            BlocProvider.of<OpenPhotoCubit>(context).allPhotos.isEmpty) {
          return const LoadingWidget();
        } else if (state is DoneState) {
          data.addAll(BlocProvider.of<OpenPhotoCubit>(context).allPhotos);

          return buildDoneStat();
        } else if (state is InterntErrorState &&
            BlocProvider.of<OpenPhotoCubit>(context).allPhotos.isEmpty) {
          return CustomOffLineInterntWidget(
            onTap: () {
              BlocProvider.of<OpenPhotoCubit>(context).allPhotos.clear();
              BlocProvider.of<OpenPhotoCubit>(context).pages.clear();
              BlocProvider.of<OpenPhotoCubit>(context).getSpecificPhoto(
                  page: 1,
                  per_page: 20,
                  categore: widget.photo.alt,
                  color: widget.photo.avg_color);
            },
          );
        } else if (state is ServerErrorState &&
            BlocProvider.of<OpenPhotoCubit>(context).allPhotos.isEmpty) {
          return const CustomErrorServerWidget();
        } else {
          data.addAll(BlocProvider.of<OpenPhotoCubit>(context).allPhotos);
          return buildDoneStat();
        }
      },
    );
  }

  buttonArrwr(BuildContext context) {
    return InkWell(
      onTap: () {
        print(hexToColor(widget.photo.avg_color).toString());

       
        data.clear();
        Navigator.pop(context);
      },
      child: Container(
              height: MySize.customSize.gitSize(context, 50) ,
              width: MySize.customSize.gitSize(context, 50) ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
              ),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ))
          .asGlass(
              tintColor: Colors.grey,
              clipBorderRadius: BorderRadius.circular(70)),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  buildDoneStat() {
    return CustomGridView(
      naxtPage:
          BlocProvider.of<OpenPhotoCubit>(context).pages.last.next_page == null
              ? ""
              : BlocProvider.of<OpenPhotoCubit>(context).pages.last.next_page!,
      photos: data.toList(),
      onTap: () {
        BlocProvider.of<OpenPhotoCubit>(context).getDatawithScroll();
      },
      loding: BlocProvider.of<OpenPhotoCubit>(context).loding,
    );
  }

  saveBottom(SrcModil src, BuildContext context) {
    return BlocBuilder<OpenPhotoCubit, OpenPhotoState>(
      // bloc: bloc1,
      builder: (context, state) {
        bool value1 = true;
        if (state is LodingState) {
          return const LoadingWidget(
            color: Colors.greenAccent,
          );
        } else {
          return InkWell(
            onTap: () async {
              BlocProvider.of<OpenPhotoCubit>(context)
                  .savePhoto(src.original, context);
            },
            child: Container(
                height: MySize.customSize.gitSize(context, 40),
                width: MySize.customSize.gitSize(context, 300),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    color: Colors.greenAccent),
                child: const Icon(
                  Icons.download,
                  color: Colors.white,
                )),
          );
        }
      },
    );
  }
}
