import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/models/business/business_screen.dart';
import 'package:news_app/models/science/science_screen.dart';
import 'package:news_app/models/settings_screen/settings_screen.dart';
import 'package:news_app/models/sports/sports_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialStates());
  
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  bool isDark = false;
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    SciencesScreen(),
    //SettingsScreen(),
  ];

  List<Widget> titles = [
    BusinessScreen(),
    SportsScreen(),
    SciencesScreen(),
    //SettingsScreen(),
  ];

  List <dynamic> business = [];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'eg',
        'category':'business',
        'apikey':'525f635890d140759bcf53a367f6ad71',
      },
    ).then((value)
    {
      //print(value.data.toString());
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.length == 0)
    {
      DioHelper.getData(
        url:'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'sports',
          'apikey':'525f635890d140759bcf53a367f6ad71',
        },
      ).then((value)
      {
        //print(value.data.toString());
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length ==0)
    {
      DioHelper.getData(
        url:'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'science',
          'apikey':'525f635890d140759bcf53a367f6ad71',
        },
      ).then((value)
      {
        //print(value.data.toString());
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error)
      {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    }else{
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(
      url:'v2/everything',
      query: {
        'q':'$value',
        'apikey':'525f635890d140759bcf53a367f6ad71',
      },
    ).then((value)
    {
      //print(value.data.toString());
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  List <BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon:Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon:Icon(
        Icons.science,
      ),
      label: 'Science',
    ),

    // BottomNavigationBarItem(
    //   icon:Icon(
    //     Icons.settings,
    //   ),
    //   label: 'Settings',
    // ),
  ];
  void changeBottomNavBar(int index) {
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    currentIndex = index;
    emit(NewsBottomNavStates());
  }

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsChangeModeState());
    }
    else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
      {
        emit(NewsChangeModeState());
      });
    }
  }
}