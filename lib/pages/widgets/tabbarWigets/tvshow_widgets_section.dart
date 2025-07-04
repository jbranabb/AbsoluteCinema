import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionTitleWidget.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/section_caraousel_slider_widget.dart';
import 'package:absolutecinema/section_title.dart';
import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TvshowWidgetsSection extends StatelessWidget {
  const TvshowWidgetsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is StateLoaded) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               //trending Tv
              SectionTitleWidget(title: SectionTitle.trendingTv),
              SectionWidget(list: state.trendingTv),
              //on the air
              SectionTitleWidget(title: SectionTitle.onTheAir),
              SectionWidget(list: state.onTheAir),
              //popular
              SectionTitleWidget(title: SectionTitle.popularTv),
              SectionCaraouselSliderWidget(list: state.popularTv),
              //aiirng today
              SectionTitleWidget(title: SectionTitle.airingToday),
              SectionWidget(list: state.airingToday),
              //toprated tv
              SectionTitleWidget(title: SectionTitle.topRatedTv),
              SectionWidget(list: state.topRatedTv),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: MyText(
                text: SectionTitle.endOfTheList,
                clors: Colors.grey.shade600,
              )),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        );
      }
      return Container();
    });
  }
}
