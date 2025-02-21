import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewWidget extends StatelessWidget {
  final String urlImage;
  final List<Map<String, dynamic>> reviews = [
    {
      'title': 'Excellent concert!',
      'description': 'The artist was amazing, the atmosphere was electric!',
      'rating': 5,
    },
    {
      'title': 'Good performance',
      'description': 'Enjoyed the show, but the sound could be better.',
      'rating': 4,
    },
    {
      'title': 'Average experience',
      'description': 'It was okay, but I expected more from the artist.',
      'rating': 3,
    },
    {
      'title': 'Disappointing',
      'description': 'The performance was not up to the mark, felt bored.',
      'rating': 2,
    },
    {
      'title': 'Worst experience',
      'description': 'Did not enjoy it at all, will not recommend.',
      'rating': 1,
    },
  ];

  ReviewWidget({required this.urlImage, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: reviews.map((review) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(urlImage),
            radius: 30,
          ),
          title: Text(
            review['title'],
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          subtitle: Text(review['description']),
          trailing: RatingBarIndicator(
            rating: review['rating'].toDouble(),
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 20.0,
            direction: Axis.horizontal,
          ),
        );
      }).toList(),
    );
  }
}
