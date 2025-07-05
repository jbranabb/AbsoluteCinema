
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

class MoviesWidgetsSection extends StatelessWidget {
  const MoviesWidgetsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context,state ) {
        if(state is StateLoaded){
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //trending
              SectionTitleWidget(title: SectionTitle.trendingMovies),
              SectionWidget(initialpage: 5, list: state.trending, isreverse: false, ),
              //Streaming
              SectionTitleWidget(title: SectionTitle.streaming),
              SectionWidget(initialpage: 0, list: state.streaming, isreverse: true,) ,
              //Upcoming
              SectionTitleWidget(title: SectionTitle.upcoming),
              SectionCaraouselSliderWidget(list: state.upcoming),
              //theaters
              SectionTitleWidget(title: SectionTitle.inTheaters),
              SectionWidget(initialpage: 0, list: state.inTheaters, isreverse: false, ),
              //toprated
              SectionTitleWidget(title: SectionTitle.topRatedMov),
              SectionWidget(initialpage: 0, list: state.movieTopRated,isreverse: false, ),

             const SizedBox(height: 20,),
            Center(child: MyText(text: SectionTitle.endOfTheList, clors: Colors.grey.shade600,)),
              const SizedBox(height: 80,),
            ],
                    ),
          );
        }
        return Container(); 
      }
    );
  }
}
