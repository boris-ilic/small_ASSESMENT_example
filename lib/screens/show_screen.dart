import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maka_assessment/blocs/show_bloc/show_bloc.dart';
import 'package:maka_assessment/components/item_tile.dart';
import 'package:maka_assessment/constants/font_sizes.dart';
import 'package:maka_assessment/models/bloc_progress.dart';
import 'package:maka_assessment/repositories/api_repository.dart';

class ShowScreen extends StatelessWidget {
  const ShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowBloc(context.read<ApiRepository>())..getShowItems(222),
      child: BlocConsumer<ShowBloc, ShowState>(
        listener: (context, state) {
          if (state.blocProgress == BlocProgress.FAILED) {
            BotToast.showText(text: state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state.blocProgress == BlocProgress.IS_LOADING) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.blocProgress == BlocProgress.FAILED) {
            return const Center(child: Text("Please try again later"));
          }

          if (state.blocProgress == BlocProgress.IS_SUCCESS) {
            BotToast.showText(text: "You purchased item successfully!!!");
            context.read<ShowBloc>().getShowItems(222);
            context.read<ShowBloc>().updateProgress();
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "All items Sold in Show",
                    style: TextStyle(
                      fontSize: FontSizes.fontSize24,
                    ),
                  ),
                ),
                ...state.items
                    .map(
                      (item) => ItemTile(
                        item: item,
                        buyMe: () async {
                          int response = await context.read<ShowBloc>().buyItem(222, item.itemID);

                          if (response == 409) {
                            BotToast.showText(text: "There is no available items!!!");
                          }
                        },
                      ),
                    )
                    .toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
