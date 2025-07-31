
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionTitleWidget.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/section_caraousel_slider_widget.dart';
import 'package:absolutecinema/state/bloc/movandtv/home_bloc.dart';
import 'package:absolutecinema/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllWidgetSection extends StatelessWidget {
  const AllWidgetSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      var height = MediaQuery.of(context).size.height;
      if (state is StateLoaded) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // trending all
              SectionTitleWidget(title: SectionTitle.trendingAll),
              SectionWidget(initialpage: 0, list: state.allShows, isreverse: false,),
              // trending movies
              SectionTitleWidget(title: SectionTitle.trendingMovies),
              SectionWidget(initialpage: 5, list: state.trending,isreverse: false,),
              //now streaming
              SectionTitleWidget(title: SectionTitle.streaming),
              SectionWidget(initialpage: 0, list: state.streaming,isreverse: true,),
              //upcoming
              SectionTitleWidget(title: SectionTitle.upcoming),
              SectionCaraouselSliderWidget(list: state.upcoming),
              // in theaters
              SectionTitleWidget(title: SectionTitle.inTheaters),
              SectionWidget(initialpage: 0, list: state.inTheaters,isreverse: false,),
              //trending tv
              SectionTitleWidget(title: SectionTitle.trendingTv),
              SectionWidget(initialpage: 0, list: state.trendingTv, isreverse: false,),
              // on the air
              SectionTitleWidget(title: SectionTitle.onTheAir),
              SectionWidget(initialpage: 0, list: state.onTheAir, isreverse: false,),
              //popularTv
              SectionTitleWidget(title: SectionTitle.popularTv),
              SectionCaraouselSliderWidget(list: state.popularTv),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: MyText(
                text: SectionTitle.endOfTheList,
                clors: Colors.grey.shade600,
                maxlines: 2,
              )),
               SizedBox(
                height: height * 0.04,
              ),
            ],
          ),
        );
      } else if (state is StateLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Container();
    });
  }
}
