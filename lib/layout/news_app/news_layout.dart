import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/models/search/search_secreen.dart';
import 'package:news_app/shared/components/components.dart';
//import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context ) {
    var cubit = NewsCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title:Text(
                '${cubit.titles[cubit.currentIndex]}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              actions: [
                IconButton(
                  onPressed:()
                  {
                    navigateTo(context,SearchScreen(),);
                  },
                  icon:Icon(
                    Icons.search,
                  ),
                ),
                IconButton(
                  onPressed:()
                  {
                    cubit.changeAppMode();
                  },
                  icon:Icon(
                    Icons.brightness_4_outlined,
                  ),
                ),
              ],
            ),

            // floatingActionButton: FloatingActionButton(
            //   onPressed:()
            //   {
            //     // DioHelper.getData(
            //     //   url:'v2/top-headlines',
            //     //   query: {
            //     //     'country':'eg',
            //     //     'category':'business',
            //     //     'apikey':'dddddddd54d6d54dffdsg456gd',
            //     //   },
            //     // ).then((value)
            //     // {
            //     //   print(value.data.toString());
            //     // }).catchError((error)
            //     // {
            //     //   print(error.toString());
            //     // });
            //
            //   } ,
            //   child: Icon(
            //     Icons.add,
            //   ),
            // ),

            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cubit.screens[cubit.currentIndex],
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items:cubit.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.changeBottomNavBar(index);
              },
            ),
          );
  }
}
