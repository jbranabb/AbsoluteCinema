
import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionTitleWidget.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/sectionWidget.dart';
import 'package:absolutecinema/pages/widgets/mywidgets/section_caraousel_slider_widget.dart';
import 'package:absolutecinema/state/bloc/home_bloc.dart';
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
      if (state is StateLoaded) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // trending all
              SectionTitleWidget(title: SectionTitle.trendingAll),
              SectionWidget(list: state.allShows,),
              // trending movies
              SectionTitleWidget(title: SectionTitle.trendingMovies),
              SectionWidget(list: state.trending,),
              //now streaming
              SectionTitleWidget(title: SectionTitle.streaming),
              SectionWidget(list: state.streaming,),
              //upcoming
              SectionTitleWidget(title: SectionTitle.upcoming),
              SectionCaraouselSliderWidget(list: state.convertedUpComingMovie),
              // in theaters
              SectionTitleWidget(title: SectionTitle.inTheaters),
              SectionWidget(list: state.inTheaters,),
              //trending tv
              SectionTitleWidget(title: SectionTitle.inTheaters),
              SectionWidget(list: state.inTheaters,),
              // on the air
              SectionTitleWidget(title: SectionTitle.popularTv),
              SectionWidget(list: state.allShows,),
              //popularTv
              SectionTitleWidget(title: SectionTitle.popularTv),
              SectionCaraouselSliderWidget(list: state.convertedUpComingMovie),
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
      } else if (state is StateLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Container();
    });
  }
}
