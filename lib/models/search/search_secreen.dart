import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  onSubmit: (value) {print(value);},
                  onTap: (){},
                  label: 'Search',
                  hint: 'Search',
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Search Must Not Be Empty';
                    }
                    return null;
                  },
                  prefix: Icons.search,
                ),
              ),
              articleBuilder(list, context , isSearch: true,),
            ],
          ),
        );
      },
    );
  }
}
