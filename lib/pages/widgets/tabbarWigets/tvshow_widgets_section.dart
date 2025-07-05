import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionTitleWidget.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/section_caraousel_slider_widget.dart';
import 'package:absolutecinema/section_title.dart';
import 'package:absolutecinema/state/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              SectionWidget(initialpage: 0, isreverse: false, list: state.trendingTv),
              //on the air
              SectionTitleWidget(title: SectionTitle.onTheAir),
              SectionWidget(initialpage: 0, isreverse: false, list: state.onTheAir),
              //popular
              SectionTitleWidget(title: SectionTitle.popularTv),
              SectionCaraouselSliderWidget(list: state.popularTv),
              //airng today
              SectionTitleWidget(title: SectionTitle.airingToday),
              SectionWidget(initialpage: 0, isreverse: false, list: state.airingToday),
              //toprated tv
              SectionTitleWidget(title: SectionTitle.topRatedTv),
              SectionWidget(initialpage: 0, isreverse: false, list: state.topRatedTv),
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
