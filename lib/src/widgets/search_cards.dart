import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:movie_login/src/constants/colors.dart';
import 'package:movie_login/src/constants/text_string.dart';
import '../screens/description.dart';

class SearchCards extends StatelessWidget {
  const SearchCards({
    Key? key,
    required this.banner, 
    required this.description, 
    required this.launch, 
    required this.name, 
    required this.poster, 
    required this.vote, 
  }) : super(key: key);

  final String banner;
  final String description;
  final String launch;
  final String name;
  final String poster;
  final double vote;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      // go to favourite clicked movie
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Description(
                  bannerurl: banner, 
                  description: description, 
                  launch_on: launch, 
                  name: name,
                  posterurl: poster, 
                  vote: vote,
                  onTab: () {
                    
                  },
                ),
              ));
        },
        // favourite card design
        child: Row(
          children: [
            Container(
              height: 182,
              width: 150,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
                child: Image.network(poster, fit: BoxFit.fill,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.red.shade900,
                      backgroundColor: Colors.grey.shade600,
                    ));
                  }
                }),
              ),
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(16),
                height: 182,
                width: 215,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  color: Colors.grey.withOpacity(0.2),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(height: tPadding10),
                      RatingBar.builder(
                        initialRating: vote / 2,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemSize: 25,
                        unratedColor: Colors.grey.withOpacity(0.3),
                        itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                        itemBuilder: (context, index) {
                          return Icon(
                            LineAwesomeIcons.star_1,
                            color: isDarkMode
                                ? tPrimaryColor
                                : tSecundaryDarkColor,
                          );
                        },
                        onRatingUpdate: (rating) {},
                      ),
                      const SizedBox(height: tPadding10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(launch,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
  );
  }
}
