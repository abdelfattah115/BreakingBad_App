import 'package:flutter/material.dart';
import '../../constants/my_colors.dart';
import '../../constants/strings.dart';
import '../../data/models/charater.dart';

class CharacterItem extends StatelessWidget {
  final Character character;

  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: ()=> Navigator.pushNamed(context, characterDetailsScreen ,arguments: character),
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
              color: MyColors.myGrey,
              child: character.img.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: character.img,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/logo.png'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),

            color: Colors.black54,
            alignment: Alignment.bottomCenter,

            child: Text(
              '${character.name}',
              style: TextStyle(
                height: 1.5,
                color: MyColors.myWhite,
                fontSize: 16,
                fontWeight: FontWeight.bold,

              ),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
