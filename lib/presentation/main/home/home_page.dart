import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter_mvvm/app/di.dart';
import 'package:udemy_flutter_mvvm/domain/model/model.dart';
import 'package:udemy_flutter_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:udemy_flutter_mvvm/presentation/main/home/home_view_model.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/color_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/values_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                _getContentWidget(),
                () {
                  _viewModel.start();
                },
              ) ??
              Container();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _getSection(AppStrings.services),
        _getServices(),
        _getSection(AppStrings.stores),
        _getStores(),
      ],
    );
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p12,
        right: AppPadding.p12,
        bottom: AppPadding.p2,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displaySmall,
      ),
    );
  }

  Widget _getBannersCarousel() {
    return StreamBuilder<List<BannerAd>>(
      stream: _viewModel.outputBanners,
      builder: (context, snapshot) {
        return _getBanner(snapshot.data);
      },
    );
  }

  Widget _getBanner(List<BannerAd>? banners) {
    if (banners != null) {
      return CarouselSlider(
        items: banners
            .map(
              (banner) => SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: AppSize.s1_5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    side: BorderSide(
                      color: ColorManager.white,
                      width: AppSize.s1_5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    child: Image.network(
                      banner.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: AppSize.s190,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getServices() {
    return const Center();
  }

  Widget _getStores() {
    return const Center();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
