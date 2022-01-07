import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bussiness_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/charater.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 700,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.nickname,
          style: TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.img,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: TextStyle(
            color: MyColors.myWhite,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        TextSpan(
          text: value,
          style: TextStyle(
            color: MyColors.myWhite,
            fontSize: 16,
          ),
        ),
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuotesCharactersLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomIndexItem = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            color: MyColors.myWhite,
            fontSize: 20,
            shadows: [
              Shadow(
                  blurRadius: 7,
                  color: MyColors.myYellow,
                  offset: Offset(0, 0)),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomIndexItem].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context)
        .getQuoteCharacters(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                color: MyColors.myGrey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo('Jobs : ', character.occupation.join(' / ')),
                    buildDivider(310),
                    characterInfo('Appeared In : ', character.category),
                    buildDivider(250),
                    characterInfo(
                        'Seasons : ', character.appearance.join(' / ')),
                    buildDivider(280),
                    characterInfo('Status : ', character.status),
                    buildDivider(300),
                    character.betterCallSaulAppearance.isEmpty
                        ? Container()
                        : characterInfo('Better Call Saul Season : ',
                            character.betterCallSaulAppearance.join(' / ')),
                    character.betterCallSaulAppearance.isEmpty
                        ? Container()
                        : buildDivider(160),
                    characterInfo('Actor/Actress : ', character.name),
                    buildDivider(235),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                      return checkIfQuotesAreLoaded(state);
                    })
                  ],
                ),
              ),
              SizedBox(
                height: 500,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
